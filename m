Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7F85B21F1
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 17:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232305AbiIHPWZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 11:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232148AbiIHPWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 11:22:21 -0400
Received: from new4-smtp.messagingengine.com (new4-smtp.messagingengine.com [66.111.4.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F70F9133;
        Thu,  8 Sep 2022 08:22:16 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 73104580CA1;
        Thu,  8 Sep 2022 11:22:15 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Thu, 08 Sep 2022 11:22:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1662650535; x=1662654135; bh=kC7+ylBuxz
        7d2bUcPE2qQ6TKqn7ANl3Ger2SvB6Lr70=; b=AFDoBjy3RS4b6YPkV7qnjD/AlC
        ftszlirLCdkWhfghBa0PhHCp5ZwS4NJCbTazgEJ5YCIzxne2PaJFIAypDlE9B1mX
        5BHASLphoVrdLs1YTnvk34ONiwX5RnT+GGtfhtfF+qOehseQ6MM/VRGHzKt05v+5
        d8OQwp6mKQGhJDVLm/Xwgn46qKlvtxh5o9wTsNzxEdQUQF7vsppgWw9IMv31FoB2
        rZDIj36ZUK/ki1IGdQLvmj1/Jz7agUyVWYnJBcToHa0ZRk2/6J9O3+pCPAFfaV4J
        iX3zRVeJNow5yVAF54GAAIv6JtG2o/I93qsfNQdaU/H+hAVBDY9C+Oh7oHvQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1662650535; x=1662654135; bh=kC7+ylBuxz7d2bUcPE2qQ6TKqn7A
        Nl3Ger2SvB6Lr70=; b=Ia6C89wvzfO2D3QEcMRhjyjZpPS57joZaaPfl4Oxjmbq
        g1bHe+5SlutEWhXz9THjPkxXkhIdSNSkwKfjCoTIdCwB+t0I7ZCtXgl9FG44UPf+
        SovjdaiXO5glAW5kgvX1uavzuZKaJk224JbRm6jClOmM7CSJdCFR4YSCt9ghPg1o
        H30ii1YlNf/etoVvvSyptUE3Xpi5j0NiNV3Kdcbff9Zl46EFDq2PxeyHWn8728K+
        d2Cr/Gd0azumpETzdaBgMQY1ZbJ1JKA+nT/hAlNtHkbimsVxBsLFIrxKVsNTXbqo
        eU4/2FbqetbU1oHhzALOhX2pRizVaFrwPuCVakPMwA==
X-ME-Sender: <xms:pggaY6psuV0qF0eXGK6fe8gfllyXQKrDgHQ65YMJ5PW3iLzZ8I-IVg>
    <xme:pggaY4ocQmB0k6yhCHL3RbOE3NQM1rMWueYdxu-a6xEwY7W0DPm7hYx3qQnPT0f8K
    I7u5ZMf1hyyNLDN93E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfedtfedgvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:pggaY_N6YlReyOnYzR-zt63N4kx5FNrpKKxzpP0PQJszdjgvAaav7g>
    <xmx:pggaY54XTL8c3Hm3tMTZEb3j6v2WQqywOado5g3KD7gDcNEc7yjWTw>
    <xmx:pggaY57GidZ2eM6JkNbkcJP0co7wPMB14mX0Fmeo5IFGfAOutnWBlw>
    <xmx:pwgaY6PyoY4G4z6uiB0oD7BXBVrRzjWXLDB7DWW9zShUhXMy1JrkTQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 4F46CB60083; Thu,  8 Sep 2022 11:22:14 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-927-gf4c98c8499-fm-20220826.002-gf4c98c84
Mime-Version: 1.0
Message-Id: <5c5caaa7-d062-466e-9761-2e3083c0dcd6@www.fastmail.com>
In-Reply-To: <20220908104337.11940-1-lukas.bulwahn@gmail.com>
References: <20220908104337.11940-1-lukas.bulwahn@gmail.com>
Date:   Thu, 08 Sep 2022 17:21:53 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Lukas Bulwahn" <lukas.bulwahn@gmail.com>,
        "Russell King" <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "Dave Hansen" <dave.hansen@linux.intel.com>, x86@kernel.org,
        "Mauro Carvalho Chehab" <mchehab@kernel.org>,
        linux-media@vger.kernel.org, "Peter Chen" <peter.chen@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Mike Rapoport" <rppt@linux.ibm.com>, linux-mm@kvack.org,
        "Masahiro Yamada" <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] Remove CONFIG_EMBEDDED
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 8, 2022, at 12:43 PM, Lukas Bulwahn wrote:
>
> For these minor changes in a few subsystems, I would hope that:
>
>   Patch "arm: make config ARM_PATCH_PHYS_VIRT visible with EXPERT"
>     is picked by arm architecture maintainer Russell King.
>
>   Patch "x86: make config X86_FEATURE_NAMES visible with EXPERT"
>     is picked by x86 architecture maintainers.
>
>   Patch "media: remove reference to CONFIG_EMBEDDED in MEDIA_SUPPORT_FILTER"
>     is picked by media maintainer Mauro Carvalho Chehab.
>
>   Patch "usb: chipidea: make configs for glue drivers visible with EXPERT"
>     is picked by Peter Chen or usb maintainer Greg Kroah-Hartman.
>
>   Patch "mm: Kconfig: make config SECRETMEM visible with EXPERT"
>     is acked by Mike Rapoport, and
>     is picked by mm maintainer Andrew Morton.
>
> Once all of these patches above have been merged to mainline:
>
>   Patch "init/Kconfig: remove confusing config EMBEDDED"
>     can probably just be picked by the kbuild maintainer Masahiro

Nice series!

Acked-by: Arnd Bergmann <arnd@arndb.de>
