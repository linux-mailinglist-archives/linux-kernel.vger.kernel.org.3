Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC9356C27F
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 01:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239959AbiGHUEb convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 8 Jul 2022 16:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238564AbiGHUEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 16:04:30 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC8C315817
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 13:04:28 -0700 (PDT)
Received: from mail-yb1-f182.google.com ([209.85.219.182]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MK3eC-1nroYu3Bsc-00LXkx for <linux-kernel@vger.kernel.org>; Fri, 08 Jul
 2022 22:04:26 +0200
Received: by mail-yb1-f182.google.com with SMTP id h132so8804614ybb.4
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 13:04:26 -0700 (PDT)
X-Gm-Message-State: AJIora+mvlUh37pWQdA/TtdPkD8+t6ZLpz2x4ZRCyNPQtHF3vclrsayQ
        KWKCukCFuyECn+ARiMW6qn9f42IrGLMVxhkwlek=
X-Google-Smtp-Source: AGRyM1savU/Qw4Umj3pyp2adCxX0XYcdGWhZpyJOvSwo6AcbUz+MBNyDLd6G6BSJJDRVleS8AnJ0WO3o2LAilMgwrYM=
X-Received: by 2002:a5b:b47:0:b0:66e:3617:d262 with SMTP id
 b7-20020a5b0b47000000b0066e3617d262mr5273482ybr.106.1657310665592; Fri, 08
 Jul 2022 13:04:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220524093939.30927-1-pali@kernel.org> <20220702094405.tp7eo4df7fjvn2ng@pali>
 <8D562851-304F-4153-9194-426CC22B7FF2@ellerman.id.au> <20220704103951.nm4m4kpgnus3ucqo@pali>
 <CAK8P3a2tdny8SA7jcqhUZT13iq1mYqjFueC-gnTUZA1JKCtfgg@mail.gmail.com> <20220708171227.74nbcgsk63y4bdna@pali>
In-Reply-To: <20220708171227.74nbcgsk63y4bdna@pali>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 8 Jul 2022 22:04:08 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3YMqGEjRr+ZD4Enm4pnuNNZOaeXqpY=PDXAP7w3P7y4A@mail.gmail.com>
Message-ID: <CAK8P3a3YMqGEjRr+ZD4Enm4pnuNNZOaeXqpY=PDXAP7w3P7y4A@mail.gmail.com>
Subject: Re: [PATCH] powerpc: e500: Fix compilation with gcc e500 compiler
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Michael Ellerman <michael@ellerman.id.au>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:YjtXZ4WSmWX9jKUxjdS3jZ9wOHyp0zzRNLlBkRST/UBGYPYJzET
 Rp3cbUkaywPjfo1REmUKLFD3aUowGbxx1InHTzAOMYAYAVMZVvwicFqcTi72bVR6CnQxaZW
 n1dSetfGjzvMaSzjUimR/YdHNhz61k2Ck1+4NvzWLXz6G199GIFjjHtsfW03b1hMFeL7NVm
 ln5fdOfRseyvU6v4prPVw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:X+0oUCDcVIk=:7Dhk8PA75E/bdq2WAGWn8P
 3RWSZ8WbSrVMvbvDWM3CR7HCEbbIr5D9W8p9xNUTB1SrqBxoX9paeyeADY1t+Vo2qJcwDjwrn
 pZFCST0iGZy6tmUFuoTJA7BX79oPCS6SrgDb4DS6weZz56zICqBOXXAKisw6MLDbCsT8W9oa3
 iSoBH1Dwm2oLvNCw2DBDXEtHLZXGJ4DRGR7As4ITFO4uqfrK6tdf0reBn0DaQ2rmllzPbqimw
 FeAflHy0aLIXlgQsS7S1XV7+ysBok3UTYS9QGbVqcXbvlQAnP2sKvG7rN/wYXt+NKhCsxGFk8
 sVDL8PJ+Uhnr/S21lRgq1l7vzf0N9DgAZiJafm9j76p5FsGpsQ/c8pDSawAgg8ogw+3T3+uJ4
 skrSGTJp6SGQ+AxcxTqBjYsVxZ1MP5pWl/YPqMSPKl0M/o9uG3PUUX/rNw3GI3adpVybpGLqi
 Epn0hKQvg3TrGODoTHEa669N/9lFDhOmDScB+xRSMfPEnroe+7U/UZ1Jlz/+QU0vmWMdTjLjc
 fUaqO2BqrCOQA8MWet4FqSiM1QQGofg3FIv0LXI+5J5vzCD1MQTzG7MmZgQahk24unt1gFX73
 yNdmu86ai5fNsAuN9IPhiXXQQWivoMJWss+74O8ILMQ4vT5EvtZPVcthMWnpkGNMr2VcS4A72
 GUXZO/CZ8OhyykQ8vFaK3bE8bQ2shooRZbeAj8kqwjnxAw4oOTCLKJ/L0Oi4YrzOn9lFsM2VT
 8wifmixscE/gEdEBFNuByUrE4S55QTjTgbfwwmSkWE401TPvfxA9xc4VCaMM68QsBt2T3cF4e
 4nrp5Cz8wtW74p14mu/TU5ufk3mjJm1vIKbX+AVA5KzeLIkcUpG8Alxaqzm/5AVI+Hcyc54Bv
 duwTK9V5Og9fhKryQePQ==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 8, 2022 at 7:12 PM Pali Rohár <pali@kernel.org> wrote:
>
> On Monday 04 July 2022 14:07:10 Arnd Bergmann wrote:
> > Another problem I see is that a kernel that is built for both E500 and E500MC
> > uses -mcpu=e500mc and may not actually work on the older ones either
> > (even with your patch).
>
> Such configuration is not supported, see arch/powerpc/platforms/Kconfig.cputype:
>
> config PPC_E500MC
>         bool "e500mc Support"
>         select PPC_FPU
>         select COMMON_CLK
>         depends on E500
>         help
>           This must be enabled for running on e500mc (and derivatives
>           such as e5500/e6500), and must be disabled for running on
>           e500v1 or e500v2.
>
> Based on this option you can enable either support for e500v1/e500v2 or
> for e500mc. But not both.

This looks like a bad decision in Kconfig though, as there is nothing
enforcing the rule: If you want support for E500MC, you have to select
PPC_85xx, which implies E500 and allows selecting any combination
of E500v1, E500v2 and E500MC based machines, but enabling
any E500MC based one breaks all the others.

If this is a hard dependency, I think it should be enforced by making
E500MC a separate top-level option in the "Processor Type" choice
statement. However, if they can actually coexist, the help text and
the Makefile need to be fixed.

       Arnd
