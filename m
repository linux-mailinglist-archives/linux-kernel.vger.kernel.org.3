Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F30E44E3C55
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 11:19:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232868AbiCVKVZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 06:21:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231332AbiCVKVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 06:21:22 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C8380200;
        Tue, 22 Mar 2022 03:19:54 -0700 (PDT)
Received: from mail-wm1-f49.google.com ([209.85.128.49]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MElhb-1nHTL12vUZ-00GIYs; Tue, 22 Mar 2022 11:19:52 +0100
Received: by mail-wm1-f49.google.com with SMTP id bi13-20020a05600c3d8d00b0038c2c33d8f3so1343400wmb.4;
        Tue, 22 Mar 2022 03:19:52 -0700 (PDT)
X-Gm-Message-State: AOAM530bWBvWM9ntC+bk90KgEoU8vsTGK3oVOEBvt806WgJBRUacvlrj
        /4+8G1L1DsaCMnBE+EerggpSBUXDTUyULmxxe94=
X-Google-Smtp-Source: ABdhPJwdbflMTyfO6uATl5GHFZmF+z0lbORSOicvJ4H+deKlIBq4ori/SM7/sEXZTmFU6gY9Y+GGeD1FNpnfFY/4qso=
X-Received: by 2002:a1c:f219:0:b0:38c:782c:3bb with SMTP id
 s25-20020a1cf219000000b0038c782c03bbmr3017415wmc.94.1647944392359; Tue, 22
 Mar 2022 03:19:52 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1647928315.git.qinjian@cqplus1.com> <8372ee2fcf361a3af7233450c4403178052ceee2.1647928316.git.qinjian@cqplus1.com>
In-Reply-To: <8372ee2fcf361a3af7233450c4403178052ceee2.1647928316.git.qinjian@cqplus1.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 22 Mar 2022 11:19:36 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1H2xM1PdDwKPWHD0fqZ0q_o-KZTLvSXdm9jjqTWcX-hA@mail.gmail.com>
Message-ID: <CAK8P3a1H2xM1PdDwKPWHD0fqZ0q_o-KZTLvSXdm9jjqTWcX-hA@mail.gmail.com>
Subject: Re: [PATCH v11 9/9] ARM: sp7021_defconfig: Add Sunplus SP7021 defconfig
To:     Qin Jian <qinjian@cqplus1.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:gWRO82PyVIBo4zOziSihvLnl+yjPW9/rb7xLTq+m/nDIRNqKye9
 o0yskHKYwmDbSwBnHRa70PSr1Qn+UxzgmwEp+c5AcSi8zUVTPnCCkuoIGfXBpN5GY8X4OMb
 w5CsflLLjocAmHiSowux7FguSySuTCFlUt7q0Le2H21juIzdoixo7Alh7rNAd/qfFR0dxA+
 /dw1Vmy1B2PMHosR0YJdQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hX8OBEP4Flk=:Y/IP4ybCl1z6sT8txeV9HB
 JBaVvamnBYvEweoouc9QuOfJsloIypQgWTQIwv/zG0YETigOa0g/Qlw40uWD24Hi0g+LU9waS
 cxAcCiHSKNrPKZSG7RF2JQWZFaFsOkG/H1HGbZUA+739AOd5BEJX74j8OYyTEYzUO9e9JP2ki
 FPvETNP8vwliTEhyDGMLYZL5liy99vbl/OJ4rH/fXIKL1aGf2/aN5KaNIGkn3Wtvx6uCIxbi2
 pMvxeUb3WTKi/0CxxJkczYgpe313kTXsQ+4+3zwWOa6u1UbS1YqjeAzZbY1rBryBNCDxY/Uei
 fALp8eWSYVpFAQPWIxz+BW6ZAWMK8K+OtfiOO8/UzYR3sIoFyfUahO2WKCfbC9JA1IRUPvkwV
 +w/hVTJ8e3k21Xh6sPiuJbmpcODtrRAws4N5HRhMNKBrCWfjetlNESiZtCtp7gH/hV5QqFTq4
 PW8NhoBN90pepBvRcb1bZVixUIYTOhbt/vDQB0t/STHgT1YCSxh0ltaYGMQeJZj84W7mDgWVc
 T+F2+VZC+11pDAg3vkGAQqRtTLN3LFZEt8uSs9XmLkRTTx1r3CLdatjhdUZ0fDg5Fo9U12mho
 ugqLeEramYXg9dFg5B1PkZ9WcCZb/IeoDcjdYYXg2Im2aKxmDIVc45EGP7JETgtfD3wOPRrSh
 ekKTWYAts9cKt6sonKDnvBGXNL8+QIE5s7wDa/GNP/gh4wJ22EYSUSxkRowoBRNtqsLvhMqVJ
 qEng4rCRPCdNfjS+fUz/oZMjGRITBFZcMkQe8zA4Is+tRDpeytANo6O+Knn1FRXq+hFDSM30u
 Tr6R/Zdocp+l78ibTeui179ACyrWpDcErz4I3kmW4Rhp41irOo=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 22, 2022 at 7:17 AM Qin Jian <qinjian@cqplus1.com> wrote:
>
> Add generic Sunplus SP7021 based board defconfig
>
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Qin Jian <qinjian@cqplus1.com>

I don't think I ever replied with 'Reviewed-by: Arnd Bergmann <arnd@arndb.de>'
to this patch. While I did review it in version 5, you never seem to have
replied to my questions there.

It was a while ago though, so I don't remember the details, if we did
conclude the review, can you link to the lore.kernel.org thread in
the next version? Please also check the other patches on which
you added a 'Reviewed-by' tag from someone to ensure that they
actually provided that tag, rather than just providing review comments.

       Arnd
