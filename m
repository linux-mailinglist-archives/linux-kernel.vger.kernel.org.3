Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E559A4F018C
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 14:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354723AbiDBMoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 08:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243665AbiDBMoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 08:44:15 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECDB42AE0D;
        Sat,  2 Apr 2022 05:42:23 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 5C4A05C00F8;
        Sat,  2 Apr 2022 08:42:23 -0400 (EDT)
Received: from imap47 ([10.202.2.97])
  by compute2.internal (MEProxy); Sat, 02 Apr 2022 08:42:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; bh=Fq6OlkR1JyeKwG1oXeMgLhHRDuFwun
        H+WFbnOc6UEYQ=; b=enaTxtMNAA+TV0gxVEIisr6CmEACW12Eo/0ABrfCmny2Fj
        ZIeHi2L/dAbiX4mv0TMr1vDiru2ByoRsWOLI9r1wJsu1nEGqnBm507jDGCqDOBc6
        Ad65gwSZSkwG9uGlbpaDkT0NjWQpc5mICPY/gzcUbQqTT/7AkmArZKsMvIxVBGZz
        rgRRz1DR8R2uOjt5xwKXflhoC3oSWtMF6ddLV8ea/S2qTGmKniimGf9EmZSROmot
        k17xWFuQFs9eTTuveihDIbqqbc+xlpGL7ObqDEK8LNE4DZPy0MFYZ1ZIt/lDs7A/
        srkmfdqbeBUtLTA8aSrcelQSJyb/KgHDIMZpClpg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=Fq6OlkR1JyeKwG1oX
        eMgLhHRDuFwunH+WFbnOc6UEYQ=; b=mELN1tGTgF9LOMsfmMVwbHxs6NqwibF84
        bE4W56hzHQ3b2wA1gx1+scSM1HK7/SUCvjQEyVMHzW8bLG0kjujcjdroD8RBG6jd
        8S8IUegVPj0IbeAcLb6KaZQKE44D0zH5z0KLsLZSi4te/hnRyDdg6Oapyzm958qy
        9uFqf73oXY5id5GC2TELZDfkQMoZ009EvSgzHqKxQepMASGyOsKGJbHcd7Fy6VFa
        eQiYspeKxoNbl7m7VnmivQoNaW12LCwU6lLlTt7p6moSIOx095VGHKxpgsMEX419
        5ZFGDN9s972nfeTgj7Myc53U3CafY8tdPI75si2rAs93MMGrsuvOA==
X-ME-Sender: <xms:rkRIYgaaBDcORLkGKrn-117x9d_DPTZmCiyIP2DhcOiE6OQO3K5x3g>
    <xme:rkRIYrYU1QiBQ5pcv6B-mE0MAvTA8CkvH7mbfznAg4dPd9UcgKYabWH8fXgfEMbXz
    pMQiY0OXBbmxNBAPe8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudeikedgheeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdfuvhgv
    nhcurfgvthgvrhdfuceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrg
    htthgvrhhnpefgieegieffuefhtedtjefgteejteefleefgfefgfdvvddtgffhffduhedv
    feekffenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsvhgvnhesshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:rkRIYq-tfRaI5F3KUE7lG_GUqynuFAOncMffTs6TvcI0IvPX3RShKA>
    <xmx:rkRIYqqZxaEeDfxf2tQz5GAtjYIDEfnBxVvRSQ4nsNO--1PlEATq6Q>
    <xmx:rkRIYrrtLLqBhzBL73ItSwTkvbN9gSWn8F26pMuapw0PHTavrcMZFQ>
    <xmx:r0RIYkQsmEBZftHq6AuIO19kfBzZtbg2Km9lgYENm6Wa94dQdH1D4w>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id DABFB27402C7; Sat,  2 Apr 2022 08:42:22 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-382-g88b93171a9-fm-20220330.001-g88b93171
Mime-Version: 1.0
Message-Id: <292b8bf3-80e5-49f0-86c0-b68cca335717@www.fastmail.com>
In-Reply-To: <20220324061650.GB12330@lst.de>
References: <20220321165049.35985-1-sven@svenpeter.dev>
 <20220321165049.35985-8-sven@svenpeter.dev> <20220324061650.GB12330@lst.de>
Date:   Sat, 02 Apr 2022 14:42:01 +0200
From:   "Sven Peter" <sven@svenpeter.dev>
To:     "hch@lst.de" <hch@lst.de>
Cc:     "Keith Busch" <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "Hector Martin" <marcan@marcan.st>,
        "Alyssa Rosenzweig" <alyssa@rosenzweig.io>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Arnd Bergmann" <arnd@arndb.de>, "Marc Zyngier" <maz@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        "Jens Axboe" <axboe@kernel.dk>
Subject: Re: [PATCH 7/9] nvme-apple: Serialize command issue
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24, 2022, at 07:16, Christoph Hellwig wrote:
> On Mon, Mar 21, 2022 at 05:50:47PM +0100, Sven Peter wrote:
>> From: Jens Axboe <axboe@kernel.dk>
>> 
>> This controller shouldn't need serialization of command issue since
>> the SQ is replaced by a simple array and commands are issued by writing
>> the array index to a MMIO register.
>> Without serialization however sometimes commands are still executed
>> correctly and appear in the CQ but never trigger an interrupt.
>> 
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>> [sven: added our best guess why this needs to be done]
>> Signed-off-by: Sven Peter <sven@svenpeter.dev>
>
> This really should go into the previous patch.

Ok, I'll squash it (and the following two patches) into the previous one.

Sven
