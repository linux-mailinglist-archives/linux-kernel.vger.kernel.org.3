Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16238569367
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 22:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233716AbiGFUg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 16:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233824AbiGFUgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 16:36:46 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C4722494D;
        Wed,  6 Jul 2022 13:36:45 -0700 (PDT)
Received: from mail-yb1-f182.google.com ([209.85.219.182]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1Mspu2-1nKOWZ2Lpg-00tBS9; Wed, 06 Jul 2022 22:36:43 +0200
Received: by mail-yb1-f182.google.com with SMTP id 64so19923300ybt.12;
        Wed, 06 Jul 2022 13:36:43 -0700 (PDT)
X-Gm-Message-State: AJIora+ZHllB0IKw7KRjlFHkfLYo1gKyky/CmHkEAC2R1W/h9LS4hLEB
        rMxYmoz8FdL3WFuZRMIw74LUfG71UJEk20xvUMs=
X-Google-Smtp-Source: AGRyM1sqECDY6Ty2JVXKP7IDdD1y1TQ6Py0CtljndDWu3dH5J2zxLu0EXVa9MU25ZG+FhT8oJ3JCsFYoCYm6EiiYqo0=
X-Received: by 2002:a5b:b47:0:b0:66e:3617:d262 with SMTP id
 b7-20020a5b0b47000000b0066e3617d262mr23033810ybr.106.1657139802201; Wed, 06
 Jul 2022 13:36:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220706163754.33064-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220706163754.33064-1-krzysztof.kozlowski@linaro.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 6 Jul 2022 22:36:25 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3rwOBA=Pp+jin7PF4YifoihEyGAUsfuyBy1jFBnhPakg@mail.gmail.com>
Message-ID: <CAK8P3a3rwOBA=Pp+jin7PF4YifoihEyGAUsfuyBy1jFBnhPakg@mail.gmail.com>
Subject: Re: [GIT PULL 1/2] arm64: dts: cleanup for v5.20, second round
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm-soc <arm@kernel.org>, SoC Team <soc@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/SAMSUNG EXYNOS ARM ARCHITECTURES" 
        <linux-samsung-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:8ruQVGNm+VxjZ8MbBOCepMoviXtGeqC82khoiTKZ9njXvvzB0KH
 wJT/4ekUupME0Lo7Ptbm4JaJ+sPm6CVBSxmo9VwicXtItKYRQ6xMSH9QP0r3kEdIaN6vyYx
 DfpZEz7hGDU25hn1G1tQQThrHsnEjuhe30EtB4gYmXoIFAf3Z7a5FCU5PDcGZe4VFBW9S3j
 C5LNB1f3a1+s4R2YHmtxg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DNRUZ/ik4ek=:qjU2BibOog/3xpY/NNSzfN
 k5/0fmV93VeB1SXCoSN/SlvSGNgWKLPFl9NsjJT1bhCyA7WocyJTTpnOpkcgDdoqhAfiQYrfV
 OspTDzE/Sof+YNz/vMzLX6KZLPX3eEiiA0Wz0yg40ZrLiIn5zGe6m7vzuRjdtH57HHdrdOlIR
 tJehsuy+IhwrIFeADQRI1ra7oCB30ka6Fz4PewysujJcdR1TqDdPZJkh9m/cBJ/Q2p7N+FeD+
 Y3TGx46LjbYIFSKF7x+/Yhj4RjkNmSVuTcnmCin8zkVRHlPOXpFtYBZ3CmUkCCUnypRJdzpF9
 1F7HFS+bLRPrudREgPeBWCwfHshqvxZYWX5OOCFuY62FnAXbvJYYk0x7AAAyu5GFjSArexa7J
 gAgJTeJwHUhqWdh7uYfZ85bmPBGXnUTzulb38cvZujA78ay7Yb35+pFVA8bJ9sde6VOeH0eps
 tx5pi5WilXX6tYNUhkpidMAL526kSD4NCs5CNrJUGHU3q+DVbZiLyVwS7bYJ0IFkELKRA/B8U
 u/NnWrcf3sY1l/huWxgvFnc5c5s9Im87KcG3aES1NjGDwdB/x624n5LBaojPKyR/LilavR/ti
 z/6KWREj4QjARXmvkiHjejrIcgkvRcv1gzFi2I7KO+h4G/aK4CUofNQp38BlodnUen50pqq5b
 IQwvNMJfP2XgyejyH4t+hBTrG/RvzXtZveL1+H/shR9QoAb+ALQvtS3dvTNvxEA3kcDmmMICo
 q2XmMIcfcBo2CTyXDzZTysV5if6uQXn91DEMyA==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 6, 2022 at 6:37 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> Hi,
>
> This should conclude my cleanup session for ARM/ARM64.
>
> On top of previous pull request.

Pulled both, thanks!

        Arnd
