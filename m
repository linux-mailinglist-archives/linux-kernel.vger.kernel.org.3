Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA6955849D7
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 04:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231598AbiG2CiE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 22:38:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232173AbiG2CiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 22:38:02 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A25C463912;
        Thu, 28 Jul 2022 19:38:01 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 210843200947;
        Thu, 28 Jul 2022 22:38:00 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
  by compute3.internal (MEProxy); Thu, 28 Jul 2022 22:38:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1659062279; x=1659148679; bh=aaUG1mcxXt
        LJd6pJT4Mmr22bhPN8UW3nBoduqUAhorI=; b=mImxyGLELzdD7jJHUUBF3Gj4qh
        rlz5Fhm0uibFRRSfzHRTQ/FaY2LhJOcl5WMYVDlApzE6hDzSxn3GIISPHcZLN47b
        s8JNtNip7qccGKCFznnQuP1W6fGnefsD/gcrRH8OqPZsj/6gUI/6LWB090LOOXj1
        ElFvtCpqzDcFAJl1E2I1NFglXACoyviYzJj1WCFwpcPCz/9fqaiZ9AMfTfRpYayD
        +bG38jRDEzHgcpCtc98Qs9t9oS8HjbMS1fEpYfuUFWNU74osX02UHZXtg4f/R75Y
        NJoZvKou2GfSpytooovJTBIze4mb5c7tLzqeRTetg3/IAv+S9jsj4JF16E3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1659062279; x=1659148679; bh=aaUG1mcxXtLJd6pJT4Mmr22bhPN8
        UW3nBoduqUAhorI=; b=q/prQ8epZ9Qewn+WWlYrl+kyFsw0agNBcIPxZFs7u1zy
        u//U1XrLIGJ9cG6h22PBoiqPjGC8uGR6WJvu7ERfvk/0YoxpXtvxxY72OLHycfnf
        uMIgVyT/Hyx2O/gKTUQZievzR4BMTHqt/VtD5ck0hMianwxs9Gx+j/R6g3RGYPSJ
        SgcDnGzN9vIuCfxk0MXHW5R6wjwwMESI4es5swRsCTgVhoLUvTQ2lVsmsQ+RQL8b
        CbAkJ201vq28wSZmp9MNuZI/DzYvQQplhIJpM5zHCSD9nQShRm/Fja1VtdPZNCOw
        Hmiwj8MIp+9qwbP2LlQvDiTkyc39wyQmDAq6c3DsAQ==
X-ME-Sender: <xms:B0jjYgOrJycyyjnFZ_TTROgwG23dByHtixnqgOpiI8ASobf3FpWRiQ>
    <xme:B0jjYm-eQtjiu5dt3aHZ7a6QYsNpy0-c9z6ZDvQGK6WLdZOY3yAMpEZJi9sEDr0dw
    Qe8J0cQwI_3CzaTLg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdduiedgtdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehn
    ughrvgifucflvghffhgvrhihfdcuoegrnhgurhgvfiesrghjrdhiugdrrghuqeenucggtf
    frrghtthgvrhhnpeekvdekjeekgfejudffteetgeejkeetteduvedtffdtledutdfhheev
    feetkeeiteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpegrnhgurhgvfiesrghjrdhiugdrrghu
X-ME-Proxy: <xmx:B0jjYnSHaTZbMHBPNqDww-5R_DvrFx8qxjPSIAe19rgGzCM_vx652Q>
    <xmx:B0jjYotQdLac_0ijgykjgG14Z7LXmDWDRb5PxitBO3We8F0yaoQ92Q>
    <xmx:B0jjYofxSjZrzSfq-iWb7SZwZiM91VECDoyNKvULkHxQwQPsM8Yg8w>
    <xmx:B0jjYmui3MpcCVacr6fDqnUO71MaaMQOiNRD2Iy_5z5kk-9Fpj9bHw>
Feedback-ID: idfb84289:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 647541700083; Thu, 28 Jul 2022 22:37:59 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-758-ge0d20a54e1-fm-20220729.001-ge0d20a54
Mime-Version: 1.0
Message-Id: <62143648-8a90-4ff4-bfe1-f311b40cd50c@www.fastmail.com>
In-Reply-To: <20220501105644.355062-1-zhangjian.3032@bytedance.com>
References: <20220501105644.355062-1-zhangjian.3032@bytedance.com>
Date:   Fri, 29 Jul 2022 12:07:39 +0930
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Jian Zhang" <zhangjian.3032@bytedance.com>,
        openbmc@lists.ozlabs.org, "Joel Stanley" <joel@jms.id.au>,
        =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc:     zhangjian_linux@163.com, "Mark Brown" <broonie@kernel.org>,
        "open list" <linux-kernel@vger.kernel.org>,
        "open list:SPI SUBSYSTEM" <linux-spi@vger.kernel.org>,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-aspeed@lists.ozlabs.org>
Subject: Re: [PATCH linux dev-5.15] soc: aspeed: abr: Add sysfs attrs for flash toggle
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jian Zhang,

On Sun, 1 May 2022, at 20:26, Jian Zhang wrote:
> Implement the flash toggle function in soc ast2600.
> Add two sysfs attrs named "access_primary" and "access_backup"

If you're proposing this patch for upstream then it needs to be based on
an upstream kernel tree, not the OpenBMC kernel tree. You also should
not use e.g. `linux dev-5.15` in the patch subject prefix, as that would
be inappropriate for an upstream patch.

As you're adding sysfs attributes you'll also need to add the
corresponding ABI documentation.

Cheers,

Andrew
