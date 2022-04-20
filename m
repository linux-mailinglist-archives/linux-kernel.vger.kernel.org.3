Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4595B5082D1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 09:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376542AbiDTHyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 03:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376528AbiDTHyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 03:54:16 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E8DA3C72C;
        Wed, 20 Apr 2022 00:50:56 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id r13so1781230ejd.5;
        Wed, 20 Apr 2022 00:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=WDOmznVTGpuyRf8JPO4KeeV2K+InAOBH1aW10w6PSKo=;
        b=ayQRw5TgVKCPgQ/cwo+/0/jY5yM6YJ72McMieTnB9lAYcY/H4re59nA+P7BFHkgTAS
         ffFOktzOIONWggk3zlt15e7FHbbHuNlnFItn5547uYvgbAdlRsbNFHS0/puQjsCM5v/b
         OHJQIJ2RRIdjf4qBFax2vUindWIdyhM+NmsxRBlc9HMxi1R9+aRU5bgv5qe+TxoqYVFY
         Z9ejy337C89+JOLCUXt/0izInwrOJF+05DAXLeGW7Gd4T0CtwKQP9CkR57PoP7Hs1zeM
         pMsbKenvkGbHvHdj3K/SY24QtOpGEhsSyYTwDuVb5CfZykMB89F9YtPC16JqeW6kqIos
         oifw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=WDOmznVTGpuyRf8JPO4KeeV2K+InAOBH1aW10w6PSKo=;
        b=nZWyHgZLAxllrqR0Q3F892V7DOLEKBubxIvln8s5DGKreIYXTxSLvIbs2rK9B5r8wq
         gbOLILrGHjyF59AK44Grq3BpGPJbdhH36u2sj0/Eb0W3N0JnOpif68JWYBlFzjww100R
         oPmcMqIa4ny+o7xTmrRklN42Ud1fqdsS7NGSOU9KzPP7No63iTnN1E7bN5nLUGYbbqK5
         rSQu+MReKgPAhmG7hobXgEbeya/qYl11pWtPBjWKWsECmkN13QDLoeIVED1+RhPHa8Ir
         ECZBmOP934Ei/t09C58YBWMMjpxpA6S3VbOT/2xVGeFE/hlg+VWpM6G8x5YBRliAMnF7
         R/jA==
X-Gm-Message-State: AOAM532dQ+RwkeWbmHm3R2KeMtlsyBbRRB8sX/YW0SRFPiMXqlNFkWxH
        d7YEnivTRLpoInXHXYdQf4w=
X-Google-Smtp-Source: ABdhPJwl3Ynk/89xAjx9zMo4T5c4J6mHpS9JYqi4KuS1ZAatDNb/JBJLJyP/888mfPPhfwm3Y/VxEA==
X-Received: by 2002:a17:907:1c85:b0:6e8:da11:85cb with SMTP id nb5-20020a1709071c8500b006e8da1185cbmr16843152ejc.678.1650441054404;
        Wed, 20 Apr 2022 00:50:54 -0700 (PDT)
Received: from Saturn.fritz.box ([194.191.225.82])
        by smtp.googlemail.com with ESMTPSA id j4-20020a170906278400b006e99f136c78sm6440246ejc.23.2022.04.20.00.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 00:50:53 -0700 (PDT)
Message-ID: <9eb0c1a4f805a75e3e9f24dfcae3077b772a06c0.camel@gmail.com>
Subject: Re: [next] arm: boot failed - PC is at cpu_ca15_set_pte_ext
From:   Max Krummenacher <max.oss.09@gmail.com>
To:     Ard Biesheuvel <ardb@kernel.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        max.krummenacher@toradex.com, Shawn Guo <shawnguo@kernel.org>,
        Stefano Stabellini <stefano.stabellini@xilinx.com>,
        Christoph Hellwig <hch@lst.de>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Russell King (Oracle)" <linux@armlinux.org.uk>
Date:   Wed, 20 Apr 2022 09:50:52 +0200
In-Reply-To: <CAMj1kXFKzi14UCoiDOMwS5jyNz61_UzxGXm+ke0EWEt4nn6E1g@mail.gmail.com>
References: <CA+G9fYuACgY2hcAgh_LwVb9AURjodMJbV6SsJb90wj-0aJKUOw@mail.gmail.com>
         <CAMj1kXFKzi14UCoiDOMwS5jyNz61_UzxGXm+ke0EWEt4nn6E1g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, den 20.04.2022, 09:31 +0200 schrieb Ard Biesheuvel:
> On Tue, 19 Apr 2022 at 12:59, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> > Linux next 20220419 boot failed on arm architecture qemu_arm and BeagleBoard
> > x15 device.
> > 
> > kernel crash log from x15:
> > -----------------
> > [    6.866516] 8<--- cut here ---
> > [    6.869598] Unable to handle kernel paging request at virtual
> > address f000e62c
> > [    6.876861] [f000e62c] *pgd=82935811, *pte=00000000, *ppte=00000000
> > [    6.883209] Internal error: Oops: 807 [#3] SMP ARM
> > [    6.888000] Modules linked in:
> > [    6.891082] CPU: 1 PID: 1 Comm: swapper/0 Tainted: G      D W
> >   5.18.0-rc3-next-20220419 #1
> > [    6.899993] Hardware name: Generic DRA74X (Flattened Device Tree)
> > [    6.906127] PC is at cpu_ca15_set_pte_ext+0x4c/0x58
> > [    6.911041] LR is at handle_mm_fault+0x60c/0xed0
> > [    6.915679] pc : [<c031f26c>]    lr : [<c04cfeb8>]    psr: 40000013
> > [    6.921966] sp : f000dde8  ip : f000de44  fp : a0000013
> > [    6.927215] r10: 00000000  r9 : 00000000  r8 : c1e95194
> > [    6.932464] r7 : c3c95000  r6 : befffff1  r5 : 00000081  r4 : c29d8000
> > [    6.939025] r3 : 00000000  r2 : 00000000  r1 : 00000040  r0 : f000de2c
> > [    6.945587] Flags: nZcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
> > [    6.952758] Control: 10c5387d  Table: 8020406a  DAC: 00000051
> > [    6.958526] Register r0 information: 2-page vmalloc region starting
> > at 0xf000c000 allocated at kernel_clone+0x94/0x3b0
> > [    6.969299] Register r1 information: non-paged memory
> > [    6.974365] Register r2 information: NULL pointer
> > [    6.979095] Register r3 information: NULL pointer
> > [    6.983825] Register r4 information: slab task_struct start
> > c29d8000 pointer offset 0
> > [    6.991729] Register r5 information: non-paged memory
> > [    6.996795] Register r6 information: non-paged memory
> > [    7.001861] Register r7 information: slab vm_area_struct start
> > c3c95000 pointer offset 0
> > [    7.010009] Register r8 information: non-slab/vmalloc memory
> > [    7.015716] Register r9 information: NULL pointer
> > [    7.020446] Register r10 information: NULL pointer
> > [    7.025238] Register r11 information: non-paged memory
> > [    7.030426] Register r12 information: 2-page vmalloc region
> > starting at 0xf000c000 allocated at kernel_clone+0x94/0x3b0
> > [    7.041259] Process swapper/0 (pid: 1, stack limit = 0xfaff0077)
> > [    7.047302] Stack: (0xf000dde8 to 0xf000e000)
> > [    7.051696] dde0:                   c29d8000 00000cc0 c20a1108
> > c2065fa0 c1e09f50 b6db6db7
> > [    7.059906] de00: c195bf0c 17c0f572 c29d8000 c3c95000 00000cc0
> > 000befff befff000 befffff1
> > [    7.068115] de20: 00000081 c3c3afb8 c3c3afb8 00000000 00000000
> > 00000000 00000000 00000000
> > [    7.076324] de40: 00000000 17c0f572 befff000 c3c95000 00002017
> > befffff1 00002017 00002fb8
> > [    7.084564] de60: c2d04000 00000081 c29d8000 c04c6790 c20d01d4
> > 00000000 00000001 c20ce440
> > [    7.092773] de80: c1e10bcc fffff000 00000000 c2a45680 eeb33cc0
> > c29d8000 00000000 c2d04000
> > [    7.100982] dea0: befffff1 f000df18 00000000 00002017 c20661a0
> > c04c77e8 f000df18 00000000
> > [    7.109222] dec0: 00000000 c1d95c40 00000002 c20661e0 00000000
> > 00000001 00000000 c04c7ad0
> > [    7.117431] dee0: 00000011 c2d02a00 00000001 befffff1 c29d8000
> > 00000000 00000011 c2a30010
> > [    7.125640] df00: c29d8000 c0524c24 f000df18 00000000 00000000
> > 2cd9e000 c1d95c40 17c0f572
> > [    7.133850] df20: 00000000 c2d02a00 0000000b 00000ffc 00000000
> > befffff1 00000000 c0524f74
> > [    7.142089] df40: c1e0e394 c2d02a00 c209a71c 38e38e39 c29d8000
> > bee00008 c2d02a00 c2a30000
> > [    7.150299] df60: c1e0e394 c1e0e420 00000000 00000000 00000000
> > c05266bc c209a000 c1944c60
> > [    7.158508] df80: 00000000 00000000 00000000 c129d2b4 c209a000
> > c1e0e394 00000000 c12b5600
> > [    7.166748] dfa0: 00000000 c12b5518 00000000 c0300168 00000000
> > 00000000 00000000 00000000
> > [    7.174957] dfc0: 00000000 00000000 00000000 00000000 00000000
> > 00000000 00000000 00000000
> > [    7.183166] dfe0: 00000000 00000000 00000000 00000000 00000013
> > 00000000 00000000 00000000
> > [    7.191406] Code: 13110001 12211b02 13110b02 03a03000 (e5a03800)
> 
> This decodes to
> 
>    0: 13110001 tstne r1, #1
>    4: 12211b02 eorne r1, r1, #2048 ; 0x800
>    8: 13110b02 tstne r1, #2048 ; 0x800
>    c: 03a03000 moveq r3, #0
>   10:* e5a03800 str r3, [r0, #2048]! ; 0x800 <-- trapping instruction
> 
> and R0 points into the stack. So we are updating a PTE that is located
> on the stack rather than in a page table somewhere, which seems very
> odd. However, this could be a latent bug that got uncovered by the
> VMAP stacks changes.
> 
> Unfortunately, the vmlinux.xz file I downloaded from the link below
> seems to be different from the one that produced the crash, given that
> the LR address of c04cfeb8 does not seem to correspond with
> handle_mm_fault+0x60c/0xed0.
> 
> Can you please double check the artifacts?

Commit "mm: check against orig_pte for finish_fault()" introduced this,
i.e. on yesterdays next reverting a066bab3c0eb made a i.MX6 boot again.
A fix is discussed here:

https://lore.kernel.org/all/YliNP7ADcdc4Puvs@xz-m1.local/

Max

> 
> 
> 
> > metadata:
> >   git_ref: master
> >   git_repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
> >   git_sha: 634de1db0e9bbeb90d7b01020e59ec3dab4d38a1
> >   git_describe: next-20220419
> >   kernel-config: https://builds.tuxbuild.com/280TXP6P7tIBfnowvFY4wobXp3R/config
> >   System.map:  https://builds.tuxbuild.com/280TXP6P7tIBfnowvFY4wobXp3R/System.map
> >   vmlinux.xz: https://builds.tuxbuild.com/280TXP6P7tIBfnowvFY4wobXp3R/vmlinux.xz
> >   build-url: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next/-/pipelines/519362851
> >   build: https://builds.tuxbuild.com/280TXP6P7tIBfnowvFY4wobXp3R
> >   toolchain: gcc-10
> > 
> > --
> > Linaro LKFT
> > https://lkft.linaro.org
> > 
> > [1] https://lkft.validation.linaro.org/scheduler/job/4921995#L2616
> > [2] https://lkft.validation.linaro.org/scheduler/job/4922061#L552
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

