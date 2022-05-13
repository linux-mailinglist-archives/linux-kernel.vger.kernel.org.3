Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93471525FFD
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 12:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379295AbiEMKOL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 06:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379289AbiEMKN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 06:13:59 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5E2C73558;
        Fri, 13 May 2022 03:13:56 -0700 (PDT)
Received: from mail-yw1-f173.google.com ([209.85.128.173]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1McXwD-1oLkit3Rc5-00d1qr; Fri, 13 May 2022 12:13:55 +0200
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-2ebf4b91212so85086017b3.8;
        Fri, 13 May 2022 03:13:54 -0700 (PDT)
X-Gm-Message-State: AOAM531e/C9z589683ylCZmLM5jmLPzhh1custAobbsiq+3+K/2bIoRs
        coKUZTCOm6gSRwhXWD9T3rh3V9sytvwDp13XSmM=
X-Google-Smtp-Source: ABdhPJyHEUP1cRPCzvCwXdPdUSFS+Voh0iZfVi5t4LZi15vwg6YIdcUM0F8JfOUB45yvtXzHOEpnm/S+mdBFUW/UN8c=
X-Received: by 2002:a0d:cd06:0:b0:2f8:f39c:4cfc with SMTP id
 p6-20020a0dcd06000000b002f8f39c4cfcmr4713890ywd.495.1652436833571; Fri, 13
 May 2022 03:13:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220511062113.2645747-1-hasegawa-hitomi@fujitsu.com>
 <20220511062113.2645747-2-hasegawa-hitomi@fujitsu.com> <Yntcn4esjJRS50Am@kroah.com>
In-Reply-To: <Yntcn4esjJRS50Am@kroah.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 13 May 2022 12:13:36 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3rF7Y27UiGyk34b0KTfvU30rkuoN5GyuNuwcA-V61_-w@mail.gmail.com>
Message-ID: <CAK8P3a3rF7Y27UiGyk34b0KTfvU30rkuoN5GyuNuwcA-V61_-w@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] soc: fujitsu: Add A64FX diagnostic interrupt driver
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        SoC Team <soc@kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Doug Anderson <dianders@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kgdb-bugreport@lists.sourceforge.net,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:bu9JyNKneSWzrsddBhuHB16iJ1Y2zAOiNp0tzUZEDeaqBuZbgFg
 LLSPmXrTH9T7fL+uOu7RDTzLzyBHkJ7fbEcTfFctS0FmjVimyARkSsNHwKaE7r2lRq5rHwI
 MyhQWKD2pXckztgfWwIxj0Qo1poTFh1Uv9zaclT+oOpv7bDIJwtYjLJqguvdT9uuFn3/Egf
 CPw6bj8t8gurCzs4q0JhQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:eMDiuowy8GM=:1ABPjuWJbY1AZDHcaaDzBn
 ZQr3ie3w/mZIInn8K+wR/mTuzzMI1ks478YUGpCZ+nF8ndWBvkZY5eqL+/Ugt4v3RmQowcflp
 +lrom/WMMOzEeJm3k5YfYRG5kwOn7ij9Lif/0+1fBWV6feJqt42DmwmoKFCyDTRC93T/ihP/0
 cVryLVbR6rujllFpmAjTHfeQHncppRiZ3ZxZu4BpL68WbR2vE4K/sVG51uxh3ifsogK6vgouE
 ibNtypS+MhuI8eAKwvUjAZqqfDoPJMQLJNvZYdXRnQle6AGUuvhkPjanZbru+8luvBJfCthDt
 G9hac32tw2cPfqZZWDp604cQs+ogEp8ubq4/9ddceNZJh596mSHY1dhQjaRVscMZuPT1l/3Pi
 YMMhfpV6ZdFuySjk8TjzQLkw6fuBlmL3xPL5KTAeaR8rVKfZEvjKZDl31TxQHstDchqWgqgAu
 bUZM8CsTmVWry0uCl4L2HJmxSlKb0ZasP0j6dorpVN4g3rl/B4eb3FDexsno2defe5c7s4/aO
 YFxPeXQzfuKORMi2i7lS9lRery4Z/krEvzEtG/5fvfNCwDCsZNhREe6TdDvI9+woxrbhp92GZ
 GQ33gxTZjgV84Dnb5NLEmIc/r7OHcrEWxH3AueWp0lnJqolgV3LyvzJtt2cUDF9BM1zK9q7Zu
 3l/8jyeFAHMamrseS7Yocs+XGaQc3fztl52eZRk6mtlejSisZZleVy+jv0KA0gAJFWYQkdjHn
 HR5QEjYfPPbTOnAROQ9IAOad+QGs8/jzBN3JMuq9D6cZH8SgbbMG96Cl07iZpn+LfS4exPYEp
 IRsYLWoe331mfF1RAoIOnxahDF2vdjpkFFM8ssOew5LTgXko7w=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 8:50 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> > --- a/drivers/soc/Makefile
> > +++ b/drivers/soc/Makefile
> > @@ -12,6 +12,7 @@ obj-$(CONFIG_SOC_CANAAN)    += canaan/
> >  obj-$(CONFIG_ARCH_DOVE)              += dove/
> >  obj-$(CONFIG_MACH_DOVE)              += dove/
> >  obj-y                                += fsl/
> > +obj-y                                += fujitsu/
>
> Why a sub directory for just one .c file?

All the other drivers/soc/ contents are in subdirectories, so I think
I'd keep it like this.
There are also other drivers that have been proposed for fujitsu a64fx.

        Arnd
