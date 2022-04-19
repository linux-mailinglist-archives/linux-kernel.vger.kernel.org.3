Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74E27507231
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 17:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354067AbiDSPyt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 11:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354062AbiDSPyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 11:54:47 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 106621E3D0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 08:52:03 -0700 (PDT)
Received: from mail-wr1-f41.google.com ([209.85.221.41]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MoNu2-1oI6lm0cbg-00omkK; Tue, 19 Apr 2022 17:52:02 +0200
Received: by mail-wr1-f41.google.com with SMTP id q3so22402428wrj.7;
        Tue, 19 Apr 2022 08:52:02 -0700 (PDT)
X-Gm-Message-State: AOAM532RhodXEZhbBz4IT2UDAdzoCnyWt3q/3yEuIaL2+QGoT/+lVLGn
        fJTPRGEPeAXSDMOq+bzG24dQBLepeTJ5FpmFGZA=
X-Google-Smtp-Source: ABdhPJxprta94GGTRggzdNaK+Ebzz+38bj4lMNTvLRapjJIb5gsqgg6f1i2QroIG0V1Waa/9seZrEzqeMzsaSpxaM0g=
X-Received: by 2002:a5d:6da5:0:b0:20a:8805:6988 with SMTP id
 u5-20020a5d6da5000000b0020a88056988mr11128970wrs.317.1650383521805; Tue, 19
 Apr 2022 08:52:01 -0700 (PDT)
MIME-Version: 1.0
References: <20191018154052.1276506-1-arnd@arndb.de> <20191018154201.1276638-28-arnd@arndb.de>
 <87tv7sk0ph.fsf@belgarion.home>
In-Reply-To: <87tv7sk0ph.fsf@belgarion.home>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 19 Apr 2022 17:51:45 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3nFB2N7sRrS90eTECxXtwwo8EJdPvHRjnp-G5HGEt3aw@mail.gmail.com>
Message-ID: <CAK8P3a3nFB2N7sRrS90eTECxXtwwo8EJdPvHRjnp-G5HGEt3aw@mail.gmail.com>
Subject: Re: [PATCH 28/46] input: touchscreen: mainstone: sync with zylonite driver
To:     Robert Jarzmik <robert.jarzmik@free.fr>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Daniel Mack <daniel@zonque.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:eneU2avD34ZziM4Dzhuxd3ES0LC3AGZBjJoEx5pjNbSuTRUNlva
 XZcj0lJDyuatZKXBHRY5dde4tgfqFbrww7MZlssDkHoHaTyQ1d2/XyMk6JXPU/afGPytPc/
 t8J43KI9OHC/iWbyZmNBzukskGiLAUcRdlM0E6lhlPimWTE0Qet3ev+HpLRcRp14KL7uJU2
 xuyOadnRNvOIcuGaprSNA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:KkHXGxbjZ7E=:WVEZkAiYOcqhDlAXE2ZN/d
 mLr+UON2zPVvP9odvDx16oCY/JdsEjjdmXfGmv6BaaWtkeEIUvvyki1mHbj5Zluc2LDWrCGGZ
 yVGZ5O9AYVqE6/KNtIVCFC9GvP9CWl47aAFnr6gr3M4uqfckJ+tGWwNRvoe1+RB/dEJ5Bh9Ge
 SpTWbeMreIT5Y0uX/Do19V8C/EYf6T2E9lsiM2jYmiMUxyd1kEHjdEnU+fP7VB6f6fK8V3mG4
 /NI134JQbcftmmTW65ixKNwwBMERkxRB39sQ7xYnHgMXxYF1iUH3hvE2BC5ZagRmoLEprobjn
 /ZIctBCd4MfD7tmaafn6N1LRldZzk9XRFSK+tkd340A3HSN/FNHflZcEJTgq9bks5AnXFP62z
 9BICJacAeioAhuZZG0d8B+Qe/XezHTgh/vsvKXkh6cH8R7yNGaQWX5gkFaqmvtjYl4W5l5gZP
 tWieoC5e2f9FQ90s1vCHhEVRBehwu/Q3bdJMvAYK9E7LGRJXLHjzAn1pYWqW8D7rcE+Q8crCb
 8VBSrd15IVpijRM0WJ/y5ptqo3fhoaXnUdXLqcacNx4CVhkgzo22QDOBvfwrPkm7IpyNHKF2b
 3uRjv5tegXLi0RpL2n78SUuOSbLXKSSOZ4uggvFB64Lz9kuYweoP+Na2FEus1Ysl+Jd9jKfM3
 c4MnSf9D/s87zak4lKhSP3rtSEbHCUN0+/cge6KzACv7YnIIUmZ/IYTrugCezAZkcmKGxrCJa
 PJijP5MdylJGmCojjQJZF8T8Px7VbI3ZmLlcNwJCl73bdxNGZlCRfSNYAGahQ7Kl15L8mgEEW
 FpYe8lWo64b6f5scyPZVvWd8VJJ3Is07WrMSnYum3qbNowd5ho=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 28, 2019 at 10:41 PM Robert Jarzmik <robert.jarzmik@free.fr> wrote:
>
> Arnd Bergmann <arnd@arndb.de> writes:
>
> > +     } else if (machine_is_zylonite()) {
> > +             pen_int = 1;
> >       }
> I don't understand that part, why do you check for a zylonite board in this file
> ?
>

Revisiting another old patch. The reason here is that both the zylonite and
mainstone drivers are for the same hardware, using the same "wm97xx-touch"
platform_driver name, which means that we cannot have them both built
in the same kernel on a multiplatform machine.

By making the mainstone driver deal with zylonite hardware, we can
ensure that this driver works on all the relevant machines. I'm fairly sure
my plan was to later remove the zylonite driver entirely, but for some reason
I did not include a patch for that in my series.

We can probably do that as a follow-up later.

       Arnd
