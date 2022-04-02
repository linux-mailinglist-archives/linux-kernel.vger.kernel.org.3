Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D10464F01CF
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 14:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354826AbiDBNAV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 09:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349733AbiDBNAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 09:00:17 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECF86E93;
        Sat,  2 Apr 2022 05:58:23 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 5F01D5C0143;
        Sat,  2 Apr 2022 08:58:23 -0400 (EDT)
Received: from imap47 ([10.202.2.97])
  by compute2.internal (MEProxy); Sat, 02 Apr 2022 08:58:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; bh=e72bX3p4b48wpbYJ/u6Hs+Uz3FIweL
        zhnqtPOQPMPjM=; b=SJwtH7IQ/BxZxuwom9tizbP2N+RQW8uL17YE5OF//JiVVe
        cLilGzTSKohekRmUXFU7VltAHtTqKkz8im8q3zbV84T9C3rRJmWoNYbCXaEoen4a
        fnimMZXOFjcNTwZXn9lOaMSPGAfOYpCZYRYd5eHIbDRvLUgfr7GBHaQ/vvMTgASj
        0CliNzPO/ASRsjOkKgVxgR4zp3rlUKVmSJbW2nZu3d8YQFqpZyrarYwn5CRfx6Vc
        WbFiI4WX3yKNfFv42LIHwUGymAeSTmIl8R2beeqUhEOVoj2N2W0N8HpyWhUeH1Cg
        Vfe1PdCMDiwlK53Yd3cPTNUT8ZDSs3FkLlsSFaTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=e72bX3p4b48wpbYJ/
        u6Hs+Uz3FIweLzhnqtPOQPMPjM=; b=k8hPoDsiwXAQxi3pWhyRQKJznH3xEShQZ
        IYwqTWouxkaiOeQ3ChYl8nP7gse1DKbNsPbHB58UuZXvX2A8ucrc9nPPCr5Bl62U
        fJLcnqNutSRDtEZT5DgFBmMULg94wAzIRGybaq6U4LvTKmbuo+xAwWHsys5EbffY
        GKrVZPTMURcJwqsXQ0S9FY/OKawTIovSdfV4NCT1yCZ15vgfsRBqGaTG//BFXKOW
        6Fngvo0HVyLCWI0goaBd2NClyho2p0nkl3e0JepihUOqgIOJa3CJMfxhy7VILHSQ
        M188UTqKwN6/E4s2cVc0IN64t9dkWplYohDeaV8ScgvKqwIYVNSkw==
X-ME-Sender: <xms:b0hIYklJIM0pX0JCJbnUbgE9TXJFFEoKY8FYPh4i3B_7xKssGG3ukQ>
    <xme:b0hIYj3m2H0a6GkAiIVaW1HiXktpnzt59XqO6FdnRcifGJInw8kZAvPOzNlDd6gU7
    zWZknAfDUDX7XG0Ixo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudeikedgheelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdfuvhgv
    nhcurfgvthgvrhdfuceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrg
    htthgvrhhnpefgieegieffuefhtedtjefgteejteefleefgfefgfdvvddtgffhffduhedv
    feekffenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsvhgvnhesshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:b0hIYiou0ZEGp6VP7aorJi682Sz8P-MSYgSoI1ZDF98DcJKTqz7Ohg>
    <xmx:b0hIYgnQJUVedkTs5RTHn7YwpiTpx_fwKJQA4SxMqxHXVd4PkBCB1A>
    <xmx:b0hIYi1ukTyTo3BRzPeTX1Cx4OmVtRInRnvwpdN4lBprihjaZRrIiQ>
    <xmx:b0hIYrvlk-Do-LciSK47g_WhX_h0Jq8Wnf3rg7-OUfZYgFomO4a5kg>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 2514527402C7; Sat,  2 Apr 2022 08:58:23 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-382-g88b93171a9-fm-20220330.001-g88b93171
Mime-Version: 1.0
Message-Id: <076879ce-242e-4c24-9052-003de63d3f63@www.fastmail.com>
In-Reply-To: <YkYbubNBD+J2XUCg@robh.at.kernel.org>
References: <20220321165049.35985-1-sven@svenpeter.dev>
 <20220321165049.35985-2-sven@svenpeter.dev>
 <YkYbubNBD+J2XUCg@robh.at.kernel.org>
Date:   Sat, 02 Apr 2022 14:58:01 +0200
From:   "Sven Peter" <sven@svenpeter.dev>
To:     "Rob Herring" <robh@kernel.org>
Cc:     "Hector Martin" <marcan@marcan.st>,
        "Alyssa Rosenzweig" <alyssa@rosenzweig.io>,
        "Arnd Bergmann" <arnd@arndb.de>, "Keith Busch" <kbusch@kernel.org>,
        "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "Marc Zyngier" <maz@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/9] dt-bindings: soc: apple: Add Apple SART
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

On Thu, Mar 31, 2022, at 23:23, Rob Herring wrote:
> On Mon, Mar 21, 2022 at 05:50:41PM +0100, Sven Peter wrote:
>> Apple SoCs such as the M1 come with a simple DMA address filter called
>> SART. Unlike a real IOMMU no pagetables can be configured but instead
>> DMA transactions can be allowed for up to 16 paddr regions.
>> 
>> Signed-off-by: Sven Peter <sven@svenpeter.dev>
>> ---
>>  .../bindings/soc/apple/apple,sart.yaml        | 52 +++++++++++++++++++
>
> Close enough to an IOMMU in terms of its purpose, so put in 
> bindings/iommu/

Ok, will put it there. I guess I can also use iommu for the node name
then, e.g.

    iommu@7bc50000 {
      compatible = "apple,t8103-sart";
      reg = <0x7bc50000 0x4000>;
    };


Thanks,


Sven
