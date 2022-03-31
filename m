Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66D834ED89D
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 13:40:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235250AbiCaLlp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 07:41:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbiCaLlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 07:41:44 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A816D9B;
        Thu, 31 Mar 2022 04:39:57 -0700 (PDT)
Received: from mail-ej1-f41.google.com ([209.85.218.41]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MODeL-1nOfpa3AYD-00OTx0; Thu, 31 Mar 2022 13:39:55 +0200
Received: by mail-ej1-f41.google.com with SMTP id bi12so47569244ejb.3;
        Thu, 31 Mar 2022 04:39:55 -0700 (PDT)
X-Gm-Message-State: AOAM530QE4AKPtAC0vv54I4CEfehPscaI4Z1aHLtE+4r40BpAL0ce+de
        y4xd33Ut/gnOdbOuqPtAEFBjhbIVOXkWECFoEV0=
X-Google-Smtp-Source: ABdhPJwfRFXUt4OqOk81tKu7LM5gxC4c3u5ZlWSR5HmES53I0aChYbGQncx+2OGAT9B1zXjl61ywA7U1ZfgbuUggEKw=
X-Received: by 2002:adf:e54e:0:b0:205:a9be:c66e with SMTP id
 z14-20020adfe54e000000b00205a9bec66emr3308561wrm.192.1648717132578; Thu, 31
 Mar 2022 01:58:52 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1648714851.git.qinjian@cqplus1.com> <6abf8de01fa2f24e13e9b78b3dc3b206ea551c9c.1648714851.git.qinjian@cqplus1.com>
In-Reply-To: <6abf8de01fa2f24e13e9b78b3dc3b206ea551c9c.1648714851.git.qinjian@cqplus1.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 31 Mar 2022 10:58:36 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1APzs74YTcZ=m43G3zrmwJZKcYSTvV5eDDQX-37UY7Tw@mail.gmail.com>
Message-ID: <CAK8P3a1APzs74YTcZ=m43G3zrmwJZKcYSTvV5eDDQX-37UY7Tw@mail.gmail.com>
Subject: Re: [PATCH v12 2/9] dt-bindings: reset: Add bindings for SP7021 reset driver
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
X-Provags-ID: V03:K1:xb1nwe6pZUMj7SqipxY2qwYa302nWoQUEarEMdwC9tLY7AUD4YA
 pzxTeNO9EH5MEJjlsdLObXI4TlhiF6159X+058Z5ChoaVq3AstNIYxEoyS2hr5V2QOjx6kl
 Vowdo1QgrJl2MIggFw4Sr5uMIC5LZF9uztTYYOpRNmDEOcy1KdbUEvEVHnjHeHi8hcenNUa
 DUVKDYYcfXBAE0TC1DYGA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Yh7e+nE09wQ=:ITjTAe7s+PDrwX8B7qWaLz
 JoaAbrov4WBAt4xlN/tlggRqmCRguIsVyNgj+zaLd6D0Zvf7gzlEauKxLqF2d3wYrLracTbyj
 jIUxz8ASS2LBjwyP9DPZrK157LvEA5SqapdN5qjmSyakkRtiBXIVTeewueiEE6++VVAtrJO/u
 KMap1i2mhWjwhb+7W3nBXFkhZP1D1pWiFhk0YRR1kS11Nj2SXyECG0ZrNX9Q4ix0e1OR0Ta+8
 X9ty2qzTZILwhqU2rRz/7aJwf38JhxXpUvtLkSV5ORNuPbH9Ly40aKxR4v/V9+2BtpKme4uRF
 3zcv5u3ffj2aLckXMSaF8+PSyyZ1enIaWgs/MGbQWzKiy6V5Q5AAPc7xFIcplkFyT4oHxn5xh
 jFSfq6EF4TpS3BLVUx/dPuKw3Xgfi1mUV3odFWYcMqDhHG97Hg2EJIR7UAIaVJjmKB76PKE/T
 YHgxyWPtEyunmWnKR+BFtW5tBtSK9VqceryRdv88u0jHizr3zKFbImee0RI745z93Q8Niuc8L
 jzYpke4DaMllXMdlGfR6yKwz47Yw5uhhyfb4yswaD76PDT8t3OLjcSEki7Pn2Pq2K/iXoGNsK
 FxMwOWDgPzC7PMWGEjU7Yf00SUo/EO6iTpKf9av2H9cH3XHRd6cd6FsvwzGLL91nxnkOX8Mxx
 mbOUfpu2N7jJs2ThCvb08ImVyOokeCYP3qkxJAo6dHhI2bK0PGjpUiEi1yCsb1gn1JZeOoHbf
 rdReOnaqjhVG7hml26a6pi4UabQj9TNiYJ5HdpoU2qlkwlz6QewmaN6oQ34IJfRf/a7NZJ47m
 5uIglpyMxYjTQ4PXl2uP8s7gHpnN1FvQpXFjxCkUkhLF8SASDA=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2022 at 10:29 AM Qin Jian <qinjian@cqplus1.com> wrote:

> +/* mo_reset0 ~ mo_reset9 */
> +#define RST_SYSTEM             0x00
> +#define RST_RTC                        0x02
> +#define RST_IOCTL              0x03
> +#define RST_IOP                        0x04
> +#define RST_OTPRX              0x05
> +#define RST_NOC                        0x06
> +#define RST_BR                 0x07
> +#define RST_RBUS_L00           0x08
> +#define RST_SPIFL              0x09
> +#define RST_SDCTRL0            0x0a
> +#define RST_PERI0              0x0b
> +#define RST_A926               0x0d
> +#define RST_UMCTL2             0x0e
> +#define RST_PERI1              0x0f
> +
> +#define RST_DDR_PHY0           0x10
> +#define RST_ACHIP              0x12
> +#define RST_STC0               0x14
> +#define RST_STC_AV0            0x15
> +#define RST_STC_AV1            0x16
> +#define RST_STC_AV2            0x17

The list looks like these definitions just match the hardware, which means you
don't have to define them as a binding at all, just use the hardware numbers
directly in the dt, as you do for interrupts or gpio numbers.

If the hardware does not have a sane way of mapping reset lines to a particular
hardware number, then you may have to define a binding, but in that case just
use consecutive integer numbers, not hexadecimal numbers.

       Arnd
