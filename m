Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B58D6510B8F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 23:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355587AbiDZV66 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 17:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355575AbiDZV6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 17:58:54 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FAEF3E5DD
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 14:55:44 -0700 (PDT)
Received: from mail-yw1-f171.google.com ([209.85.128.171]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1Mo73N-1oD0Hl2snL-00pbtm for <linux-kernel@vger.kernel.org>; Tue, 26 Apr
 2022 23:55:42 +0200
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-2f7ca2ce255so97938347b3.7
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 14:55:42 -0700 (PDT)
X-Gm-Message-State: AOAM533h707AcDM6gNoqKAaopHFQRvwPfHcVv9WJV3LqIZF1JgdYFVdR
        wHEZzNahnVUMjD8dSw1QeTcvt/D2iiZ0wU+MC8A=
X-Google-Smtp-Source: ABdhPJzeumDGKLqJzcKg47ARK8lAlqpYUoFrKMyKmxeuoEH8hFAe5PMV5ifJ7oJAZSTkd0LFQvHtD1zrKZjB2727L1E=
X-Received: by 2002:a0d:d101:0:b0:2eb:4bd7:bcc1 with SMTP id
 t1-20020a0dd101000000b002eb4bd7bcc1mr24608932ywd.495.1651010141538; Tue, 26
 Apr 2022 14:55:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220421192132.109954-1-nick.hawkins@hpe.com> <20220421192132.109954-5-nick.hawkins@hpe.com>
 <CAK8P3a0nQ1BrtfBJ7sUSaLkA=pbVwx83bEUpZczvLOSOHDR=dw@mail.gmail.com>
 <CACRpkdbJ1N7VOgoBzGS+cOaErFcYiOVDeWRmhPyHA7=9W0CGhA@mail.gmail.com>
 <CAK8P3a2ie8kFYstCYr6FO6+yFw7VxyJjWYyy9b+rUHu_u0YXPg@mail.gmail.com> <YmhmXl5IWHmKzAyG@robh.at.kernel.org>
In-Reply-To: <YmhmXl5IWHmKzAyG@robh.at.kernel.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 26 Apr 2022 23:55:25 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3+TGSJgJ2-mgj+NjT3k8uuUpesLErwqZ2M_dkNqbMXXQ@mail.gmail.com>
Message-ID: <CAK8P3a3+TGSJgJ2-mgj+NjT3k8uuUpesLErwqZ2M_dkNqbMXXQ@mail.gmail.com>
Subject: Re: [PATCH v5 04/11] clocksource/drivers: Add HPE GXP timer
To:     Rob Herring <robh@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        "Hawkins, Nick" <nick.hawkins@hpe.com>,
        "Verdun, Jean-Marie" <verdun@hpe.com>,
        Joel Stanley <joel@jms.id.au>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:yLURDzudXHJMraciQUvSb24xVyKH/AGd/RIoLfkaAXFYNa8zyKr
 ANzRc35ssf7MP6LoeSMCaiaT1xD3fXRDapXXsLB0j/IPVwgmEpePP7LoF2sgPs1xtXNCCRx
 v/3+ZoLzYPtxZfi6tQAM6CzMnAGbvhAFYwz2hRH37/DOhE68igSWDsesDcW1TFbF7E7dPL+
 Wjg1Av65AJCjrp7lovuQA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:a7nudyXYi74=:2uwlCm/+lN28AaDNq8ThKy
 lxCit7SLxjkUvnx4rrZBTn1wgG1gtF3Kn3fN6S/tsMAViderK8KeEBA7YMhPJxMJPoYSbReiE
 ZOVN11CMr2uSproi8QjnBIOkyIVwcD+p0gDcoSU629RsreCRHMkSX2lTpdyvSyOlU5YHyWtWo
 t5T5IdK7RvSgINqU5XRKs0VpNYh8g2feh/NVlf3Ouru8IVEmiklEYOaQefucv1lLzPRdghtoP
 a54JAwtXR/xyAkQOTaIK+xtBLUVJ14dhqGBkk2DtaI5YaBJ9+6R4TSsXM+7XUa4tr2O5pRRI4
 XPPYSdEsWO+S4pGjsbrG32ZTUv1xbjGWLx57N42juentn/UquWJBzI/roCsPOhLx9bEoXDPYV
 YkFz3Ym62hK4spwtdxStWucXzCOAYiNyLCfQlsT/n+M6zPBIisY9j7SxW8USCRTDa2wZbh69h
 7eO7fd/6n3RlBkHsnnKL7XFFeIh+WT4NQyvMPin6qNsRbpu5DZ/OnvPyFxI5YGFUCihEvKD/8
 3Qw8pxbBqUDlzHxEx+7Oh+YwjS+eEEmki6Oz37QNbpacrn4BRn11N/2tXX1mHF/ldWl81vSNe
 kGbzHvVOtBjRpXJpgEbe6mjSSz7wRWPo3xtdImSEU/y9wFIZalCLw6kVRM0Gk97XctQczdgdX
 TQ3+a8EM46m/xgD3PvSPPOdBIt95KIzTVk1quJdkL2n0DahDKD+if+sUbiPYZ2BcktHEZm0gA
 HWw7as4dbiEcYrUkRR92wLEXZmLQ5pVMX/pUq5UOojErFxTYX6aOee5V9J86tegDEW4vAseo8
 7ob4gkUL0MlJ5KEwYV7IJVwwnbD0Apb0KPXD10F+PxuuUEyO8I=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 11:38 PM Rob Herring <robh@kernel.org> wrote:
> On Tue, Apr 26, 2022 at 08:00:20AM +0200, Arnd Bergmann wrote:
> > On Mon, Apr 25, 2022 at 10:38 PM Linus Walleij <linus.walleij@linaro.org> wrote:

> > There are multiple ways of doing this that we already discussed
> > in the thread. The easiest is probably to have a child node without
> > custom registers in the DT and then use the DT helpers to
> > populate the linux devices with the correct data.
>
> I think that's what the wdt binding is doing, but I don't like that.
> Maybe it's not a child node, I can't tell.
>
> Bindings should not be decided on the *current* driver split on one
> particular OS. This looks like 1 block, so 1 node.

Fair enough.

> If that doesn't work well or easy for Linux, then we should fix Linux.

Doing a simple platform_device_create_pdata() should work fine here,
the only problem that might exist is if the wdt driver needs access to
DT properties, as we can't have both devices refer to the same of_node
pointer, which would cause them to be picked up by the timer driver
again.

      Arnd
