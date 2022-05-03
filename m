Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E95E517F33
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 09:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232509AbiECHzu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 03:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232473AbiECHzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 03:55:45 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB8571FCE0
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 00:52:13 -0700 (PDT)
Received: from mail-yw1-f176.google.com ([209.85.128.176]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MxmFk-1o2bcz2H6s-00zHBi for <linux-kernel@vger.kernel.org>; Tue, 03 May
 2022 09:52:11 +0200
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-2ebf4b91212so171465817b3.8;
        Tue, 03 May 2022 00:52:11 -0700 (PDT)
X-Gm-Message-State: AOAM530lAbT0p7sa+dRpcU4mzLt0WgSB7SLjEWtlCytqcbpiuk2RmdSp
        191B0DlXqa66UB9/Ox5EHPquTWlK8DLeMQnyFZE=
X-Google-Smtp-Source: ABdhPJy9R7zCTI6Aw7C6jGQ+pq3KbkGI+32nQsK+YuLq9Y0CUx+axnAMLXKfzAkG+VRohcKoFtwX2TBaxszBE6C0NQU=
X-Received: by 2002:a81:1697:0:b0:2fa:32f9:78c8 with SMTP id
 145-20020a811697000000b002fa32f978c8mr3738925yww.135.1651564330419; Tue, 03
 May 2022 00:52:10 -0700 (PDT)
MIME-Version: 1.0
References: <FA654A0D-29B7-4B6B-B613-73598A92ADA8@goldelico.com>
 <YmkBAsa+fKlp/GcV@atomide.com> <CAK8P3a3N9WBWC_ECB0pSRHUCT4iz=tdT+Dt9Cyd5Wh3qEaVqqA@mail.gmail.com>
 <4CE23DC3-B3E5-45C1-91F3-B88E5444AE7C@goldelico.com> <CAK8P3a3EFfF0gr5kFkboRfJifrY-D+NgHFekBfSePWuY2c8PMA@mail.gmail.com>
 <11504A17-6B50-4D6C-A9E1-CA943C157C93@goldelico.com> <CAK8P3a2RN77ajZD4xRhKsqozPizneLcLYhm0rTE6qX25-4cJsw@mail.gmail.com>
 <CAMj1kXHqHCt9G+HEawsWmba2Z=WVbp6wRrivAQvQCn2iph9kXg@mail.gmail.com>
In-Reply-To: <CAMj1kXHqHCt9G+HEawsWmba2Z=WVbp6wRrivAQvQCn2iph9kXg@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 3 May 2022 09:51:54 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2gxnrY=gnv+e2Ey4bPE30wYtMkqC--Z0X-ZjZT=B9VaA@mail.gmail.com>
Message-ID: <CAK8P3a2gxnrY=gnv+e2Ey4bPE30wYtMkqC--Z0X-ZjZT=B9VaA@mail.gmail.com>
Subject: Re: kernel panic with v5.18-rc1 on OpenPandora (only)
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        Tony Lindgren <tony@atomide.com>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:q4596kitnW8xbAvjo4GnHPeAh23Okl2WjFqcrkXALunK3DID6wz
 UUrYKX0jt0azzdGSCC0jdLoT8TaDY8Yf9mVx3ocnSo8I1Gdx5rKc7I+Ck9lZt4UJoc0RanZ
 6lt0thg2ElufEfvcyY5uHpcz5Yb6RLoxnCA9f62ZYTlzHRvuVU6qXfHrdqcMq2LASYu7t/0
 IVckQQ6L9hdEAB6NiCi6g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:GE9Dm6wwpqs=:OWjpCq3J6+sTPQGL0MRZMs
 zDaGimHnlybx01b1lGP7vw7vGpSfWjwhJPCMUd3XCKICIbQGKKQg0aZmduJCdKVAiFEd9b1PD
 uAOKWY/FGUNECi1Uv8IrKnOZNFJnePMUgeC1+206xRoQbdnisA+Ozww/J7znYx2MK0JQC7l/9
 TJWqAJL8wn7c6vydqAKLOeQsFuZK6R0KGLTzPUJRDreKTrheLw9Lo64xmAvYaeQIKGsUMtRNM
 d8xejuKv/A/eeY7gPgPsrDGoksdDwoi6PJqDiftSgcpHN3x3VkNTOFQsZUNnon8Nre1KIpcrA
 ubmES5Z4f+HOV0ogNDft/6DAgzR/+tElHPBqhZgBM4gjlw5JrUDr6YLPrzG5qn//HfC/qYzIH
 KWXKu7T8cUqzx1Payrc/wOsEG3GFIFM7xgNSvHQTBzh6ZndrAt6+7xCqlx3R32pB/OAodUfo9
 yk4gJQoct/RhZDqgg5ZHOPbjH9UryaLZ8aLxGxbAOMaiNSFyO3CIYyLi2nB3F6qQlEF9WjLdc
 Da+zF1OIpxzAUXW0OaUqY2H2Ycv9A07IzE8bqvQ11ghwFH6C7iiUPd57sO6W7PsLTmiTFLQJp
 9FDxuq61kiw6Oa7NgElsHw/p6GeqJ3Qe6n5BHabIyBFqiyAkueMQ8jDyqlf9mfUusdkH2lSyQ
 Hhf4giXlX7VWxNKS5sNUiT/X6wChvFOpE87nJJC6n4pO8/dtr7jX0/J7S3Mxc6/OLzp5aKZQl
 c5iu+VWVxHwVZCBEntCtfWht8/KTQpBShOqe/gEPm0rq+fGZKEwfnO6QQdTbehXz5Sep70Cus
 mMFGlcBY5bDi6pDFyYTmg8IcADlNCqEQvWurXlm69+j8hXiiGQ=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 3, 2022 at 9:28 AM Ard Biesheuvel <ardb@kernel.org> wrote:
> On Sat, 30 Apr 2022 at 20:48, Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > I think what is going on here is that your platform is able to detect
> > the broken DMA because of the l3 interrupt handler telling the kernel
> > about it, when on other platforms we would see either silent data corruption
> > or a DMA that never reaches its target.
> >
>
> I wonder if we could narrow this down by adding the possibility to use
> IRQ stacks in the linear map, while using vmap'ed task stacks.

I don't think we have actual DMA attempts to the IRQ stack, so this should
not make a difference. What might help is to print some more information
in omap3_l3_app_irq() that is likely provided by the hardware. The BUG_ON()
happens for any timeout error, and that is most of the possible errors.

Simply dumping the L3 registers should at least show the exact type of
timeout, and maybe the DMA master ID and physical address that can
be traced back into a virtual address.
Setting CONFIG_DMA_API_DEBUG=y should get the same information
I think, but it can't hurt to do both.

        Arnd
