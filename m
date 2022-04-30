Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C30B6515FE9
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 20:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244219AbiD3Sv4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 14:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242565AbiD3Svx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 14:51:53 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF3365D16;
        Sat, 30 Apr 2022 11:48:30 -0700 (PDT)
Received: from mail-yw1-f181.google.com ([209.85.128.181]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MCbMx-1ncNwt2WNX-009jiN; Sat, 30 Apr 2022 20:48:28 +0200
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-2f16645872fso114804677b3.4;
        Sat, 30 Apr 2022 11:48:28 -0700 (PDT)
X-Gm-Message-State: AOAM531T5DuulTu1OgLm6O9hTfZZwe7AWw1dZF+hraCuYrm++rJhGfO0
        B9aoN48xAyE+uXG7WndIoJkSua0X+4lemCj49DE=
X-Google-Smtp-Source: ABdhPJw5Ufu73NQqjQznRHFKAzqDqei6NH3iC7AzVn9WUXDhjxTHyVlDQu80ZwapZtPjmhVQSPDsX50LuZep76uZYyA=
X-Received: by 2002:a81:1dd1:0:b0:2ea:c38b:65a8 with SMTP id
 d200-20020a811dd1000000b002eac38b65a8mr4901410ywd.135.1651344507310; Sat, 30
 Apr 2022 11:48:27 -0700 (PDT)
MIME-Version: 1.0
References: <FA654A0D-29B7-4B6B-B613-73598A92ADA8@goldelico.com>
 <YmkBAsa+fKlp/GcV@atomide.com> <CAK8P3a3N9WBWC_ECB0pSRHUCT4iz=tdT+Dt9Cyd5Wh3qEaVqqA@mail.gmail.com>
 <4CE23DC3-B3E5-45C1-91F3-B88E5444AE7C@goldelico.com> <CAK8P3a3EFfF0gr5kFkboRfJifrY-D+NgHFekBfSePWuY2c8PMA@mail.gmail.com>
 <11504A17-6B50-4D6C-A9E1-CA943C157C93@goldelico.com>
In-Reply-To: <11504A17-6B50-4D6C-A9E1-CA943C157C93@goldelico.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sat, 30 Apr 2022 20:48:11 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2RN77ajZD4xRhKsqozPizneLcLYhm0rTE6qX25-4cJsw@mail.gmail.com>
Message-ID: <CAK8P3a2RN77ajZD4xRhKsqozPizneLcLYhm0rTE6qX25-4cJsw@mail.gmail.com>
Subject: Re: kernel panic with v5.18-rc1 on OpenPandora (only)
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:zeN/PKquNR1GJDuLkOYaMOXotY8+6RjGYU412xuiz2+MNzw1Hem
 dTMCkr1XVHk899imNGbFmoE+Kxtq+u9JsCIVC3eTuMcD2htA8HgOTzDxC4ZhyAt6delkaEM
 tidDtInhAZPKxlXxZTlEM+XwxE1sQ7DtsoQVpcXxWBQT7Jgcc054FfEas9m+gr2e5hychOb
 nGbUCoDkByMPtQJIJUAuA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jBpIgykTDMQ=:xqSzseJLUvs2x5r5I5gkDT
 U5zRsdViPWc3EJEttDDLZVhGuEhSHJbKID9ePjgdQ4mpVJRE4s12zqgU7u0d544b7gp4OO2le
 8nP7VYBG3JkNYB18vHb0mcDNLPtWft4t2LVRn12JCvmn9cJop2KpeJGicjM2zjU/1utiU84uU
 h/7Kj5AG0Fmkc5Hct/MBRnYmKzaG4KKRtG5OmhR2UxWptUzyBIr/Yj4AURSXSTCjW6FIa3rNW
 cVMZqmHc71tK6eWLrPjQAK+qApdOfZ54hae/+pXKu1DusNj687FYswcvH00Lf1S+JxjYKw3xR
 JizLgJHmHaRavVeGClFUiqe2HJR1mGH+Od41V1N9h5IiFNjpV92KcfBCrOzWzACQWV52pJk6G
 dtxQTsq0Zf7cjOJ2ZhvbWziP3sJ/+D4i22BvNz4IRRdonDaFAyGCNW8DlK/oVGjIamMnIh7Ny
 pV0xY3OVf5hehxmmgGsrpIqT2qRhf37GypSj0pd6yOIOI55kzyI3kBRMaUvEBxNrh77R9o24h
 4zhxY4cAUqPxYzhhLqFLCRELOM5+Jd45WE3Sm+x+J8YQl4Tq2QBtpN0illofKS3e/s0e3lLMM
 95TPGlQ77OR8uyToOfW6usB+z2Frbi+bEyLMpaLoIViIMQOe8n/Z9d0VEsINAPi+Q+bKS9Du1
 Fohn3qQoSp7s/O+S6BjUQzYBGOT7rO8AKVHRozzAR+UUc1+PDYSETxx8kdan89A7nWfA=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 30, 2022 at 7:18 PM H. Nikolaus Schaller <hns@goldelico.com> wrote:
> > Am 30.04.2022 um 17:36 schrieb Arnd Bergmann <arnd@arndb.de>:
> >
> >
> > I suppose this could be anywhere then. The backtrace seems to point
> > to re-enabling interupts in do_work_pending, so something probably
> > accessed DMA memory asynchronously.
>
> Yes. I now (or still) sometimes see the same omap l3 irq issue when plugging in/out the USB/OTG
> cable. Not with a kernel panic, but in the same driver omap_l3_smx.c.
> This happens even if the wl1251 driver is removed.

Is this also a regression, or did it happen before the vmap-stack
change? If this only
appeared now, then this points to another bug somewhere that you
should find using
CONFIG_DMA_API_DEBUG.

I think what is going on here is that your platform is able to detect
the broken DMA
because of the l3 interrupt handler telling the kernel about it, when
on other platforms
we would see either silent data corruption or a DMA that never reaches
its target.

       Arnd
