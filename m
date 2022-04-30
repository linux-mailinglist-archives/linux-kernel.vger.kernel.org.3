Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E377515D9D
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 15:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356565AbiD3Nfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 09:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345995AbiD3Nfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 09:35:50 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2D66A94DF;
        Sat, 30 Apr 2022 06:32:28 -0700 (PDT)
Received: from mail-yw1-f169.google.com ([209.85.128.169]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1M3lLh-1nl4Bt3v99-000pQ0; Sat, 30 Apr 2022 15:32:27 +0200
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-2f83983782fso110504427b3.6;
        Sat, 30 Apr 2022 06:32:25 -0700 (PDT)
X-Gm-Message-State: AOAM532+Srrgfiw+FMH9tlUhJmPawAp7fSUOMuowkUD0m+2hzILf+VGA
        3SX9eAJFkKXpTnIP2py6rcLslPlJiNft3XmNYKw=
X-Google-Smtp-Source: ABdhPJyQsAuOXuwqNSnE+0RumiMVY+a1YoHyKhCVHMghGQo3frV3I1QOJWPIvakdR8DFKer+m5ZGRHZJ5RFDwaJx/vI=
X-Received: by 2002:a81:1dd1:0:b0:2ea:c38b:65a8 with SMTP id
 d200-20020a811dd1000000b002eac38b65a8mr3834670ywd.135.1651325544544; Sat, 30
 Apr 2022 06:32:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220419163810.2118169-1-arnd@kernel.org> <20220422170530.GA2338209@roeck-us.net>
 <CAK8P3a3V=qxUqYT3Yt=dpXVv58-Y+HVi952wO6D4LPN5NNphGA@mail.gmail.com>
 <8b36d3a4-ec85-2f9f-e4b7-734d8ddd3d8f@roeck-us.net> <CAK8P3a0R9cpEb1d2=e9KnGSbi_uRv48RWfCu_J4DDak_cGZSuw@mail.gmail.com>
 <20220422234150.GA3442771@roeck-us.net> <CAK8P3a3qZdEqnJ2nTOKwDMossngOgCpEvZq4cQMPQjSsUoU=6g@mail.gmail.com>
 <3b4046ed-fd75-13ea-fac3-06469172806c@roeck-us.net> <CAK8P3a1LzEG1vo+5nMrnL3TOMcbSKJ3u=StcfY8dajV2raUBjA@mail.gmail.com>
 <3df135a2-17f5-d6c6-b4a8-e1a60e254297@roeck-us.net> <CAK8P3a2EHMQPN4ny9sXXuReFG0jN0hyRV7h9v_AR_0pqpOU41w@mail.gmail.com>
 <CAK8P3a09+nFS3g1rgvTW9da3tMiAhHjkjZVs1QOJOj8TJ-9MDg@mail.gmail.com>
 <6f1b27fa-96d1-4be7-ac6a-762610314f2a@roeck-us.net> <8d6d453a-e6fc-439b-2f34-e60c22fc9e98@roeck-us.net>
 <CAK8P3a2Ekvis1YcrJZtuga+XQdbeTC98PkOszCpS2DiZri7VMQ@mail.gmail.com>
 <149509dd-f43d-1b27-4395-81eab4ff3455@roeck-us.net> <CAK8P3a05vFdBnXXAMPVS82xX29+uinvWPcWxAgvj0TfoOk+1kg@mail.gmail.com>
 <b13783aa-9225-d52a-3800-c97ad772688b@roeck-us.net>
In-Reply-To: <b13783aa-9225-d52a-3800-c97ad772688b@roeck-us.net>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sat, 30 Apr 2022 15:32:08 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3S5OjkKq_u5FpnwzYv+0+typya6Z4MzTez5ZH+do00xQ@mail.gmail.com>
Message-ID: <CAK8P3a3S5OjkKq_u5FpnwzYv+0+typya6Z4MzTez5ZH+do00xQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/48] ARM: PXA multiplatform support
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Philipp Zabel <philipp.zabel@gmail.com>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Paul Parsons <lost.distance@yahoo.com>,
        Sergey Lapin <slapin@ossfans.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Helge Deller <deller@gmx.de>, Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        IDE-ML <linux-ide@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        patches@opensource.cirrus.com, linux-leds@vger.kernel.org,
        linux-mmc <linux-mmc@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-rtc@vger.kernel.org, USB list <linux-usb@vger.kernel.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:6ozNYDqoMexS7pdW43hedMtqIfcc4hU1ADSq42DWDp+Xgq1NNm2
 FSEQTiSyd0J98c4LVD7VXFQz1yk3PEhqiSyZtjRAPSFG2O75JYZMaxEiq6NQ0W+f2ozEs8u
 ovYliqNX06/xtOt91Mr/MQrvYWigJrVoOnR2IQxMG4T/GHpL8lDY9Eo4TtYCC4WcZiN5jDK
 FJ7BFUPWjwygAAJjoRsXQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:nH0TOiOvIm8=:K4+xRin4M7FvWVCctlGgzj
 tieVqWIZ40XKn48G7IIChifQHzDcJsTFhNOy3acd3dRNGPrU/f9uoxu+c/xUTWHKz1Ttlx7xn
 3HB+4HoNTYGE9BCaw383DjD0ZEsPXepdJz6iJMer9KWcXVYfVKJY20m6/pE0vIokXPUJHsMo+
 fwk4HyQji4KDyMAl0voLVenJnQkYFjW84VZNJrq/BXuaxVF/jyvk4WSQR+rHP3renkmKGivmU
 cAX8aabd7wiC7KvIe+8w8SjrGyzFbR6KNDFyfiYnAvpTlVQkdsl3ImaVbMY1gvXr1Q0Znm4+v
 3C1FTGhqa3RB/ebkPhV8XHcf+n2+aHvCj41AlkyzIq6+Lldm0VVas+92BcWKpU5zQQTi3zhQP
 bPBt3p4paoWviZ9sQ+I6mpGJss0XR4a3XKh4yZ9AvbdLXQk0gIixsYmsT2jofEwM5wJEEuqIr
 9HtxDuhA08c0WzhP5Z4CvD50MKxVeaYQ+PiTTUI+HS2EoZ9Dda84lF6K7pbwhjRxUXOCDI2Nb
 uahtYWfPKeFEj2el//jJx1JLYW/Fsc8q4DsiTD+vt7CcCdIZ4vVArfKPNP+Z/PCrbw4hwM5qQ
 IQIsRv56KNOykk+fxppJDSvGXkhYCLa5SpdlfjtA74XREnR4haTnrje2G3CAce4sC4xYrK8mW
 +OTl9s6A5iciP15nGEdl//QglsVNujFeFQC9VHIDyVuxQrQQG4tnQg/Bv69Bmm3fXnQwMyuCT
 EMALR1JT9/6m8FRd+mtzNKyILyupr9g6HkAoIlE5gkkCptkuVe51uTWuMnIB5uSbpmIIIuNXA
 jernuKbbiwnLgYwzABjQNdT9rokW3DOBC6sPuHDFF3jKRzYREQ=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 30, 2022 at 2:41 PM Guenter Roeck <linux@roeck-us.net> wrote:
> On 4/30/22 01:04, Arnd Bergmann wrote:
> > and concluded that it must have done this for a long time. In my own qemu
> > instance, I see a crash from iWMMXt, but that works fine on your machine.
> > OTOH, your failed instances all look like they either time out or
> > failed to find a
> > rootfs. I tried passing an MMC device as root, and that works here.
> >
>
> Booting from mmc works for me as well. Booting from pcmcia worked before,
> so I assume that there must be some regression.

Ok, got it, and managed to reproduce the hang now. My "ARM: pxa/sa1100: move
I/O space to PCI_IOBASE" patch managed to get it to the point of detecting
the pcmcia device instead of crashing, so I assumed it was enough when it
clearly was not. Before that patch, it still works, afterwards it hangs with
"pata_pcmcia: probe of 0.0 failed with error -12" as mentioned above. I'll
have another look.

       Arnd
