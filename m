Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DFE64F7613
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 08:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241284AbiDGGdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 02:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241237AbiDGGdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 02:33:03 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41C41B57;
        Wed,  6 Apr 2022 23:31:01 -0700 (PDT)
Received: from mail-wr1-f42.google.com ([209.85.221.42]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1M7JvO-1ndTCa0PRk-007inq; Thu, 07 Apr 2022 08:31:00 +0200
Received: by mail-wr1-f42.google.com with SMTP id d3so6293631wrb.7;
        Wed, 06 Apr 2022 23:30:59 -0700 (PDT)
X-Gm-Message-State: AOAM531mvRP+YU0Ma1WSLPxsQoAwx+cMBs5z+r9nbD38NqjP8feQ/rj5
        e5qQLgdq3mc4ISiC77+AmUFK9RnkQLtEiRaiSE8=
X-Google-Smtp-Source: ABdhPJyKRyRW3k/cQmPVF80spQCMRGb5SVS98DqNmPx2g8IW88njX3uUl4iA4i0AVSL8t67eZnNZkGCEOKSOf5l4kho=
X-Received: by 2002:a5d:6505:0:b0:205:9a98:e184 with SMTP id
 x5-20020a5d6505000000b002059a98e184mr8803769wru.317.1649313059590; Wed, 06
 Apr 2022 23:30:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220406233648.21644-1-brad@pensando.io> <20220406233648.21644-4-brad@pensando.io>
In-Reply-To: <20220406233648.21644-4-brad@pensando.io>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 7 Apr 2022 08:30:43 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2wZwza=tUzxpHTHTnahf-bUS2-e80rW-wzN3aWodD1vQ@mail.gmail.com>
Message-ID: <CAK8P3a2wZwza=tUzxpHTHTnahf-bUS2-e80rW-wzN3aWodD1vQ@mail.gmail.com>
Subject: Re: [PATCH 03/11] dt-bindings: mmc: Add Pensando Elba SoC binding
To:     Brad Larson <brad@pensando.io>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Mark Brown <broonie@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Olof Johansson <olof@lixom.net>, dac2@pensando.io,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:L1k9lwuF84IUYFFiRBIy1y9YRO/zDLweXc/0M4LdGijxfIFw9tc
 uhWCJ5iCNpeSZY5AKy4xxUeM4Wong5Tg7ALVzPdKQPCUMJJAcJtcpStGanwP1SUr0Bt4OUF
 zuTEsc/MN1WkvfT9lVoeshnnoUV7pC6yTjLkFyLC2SYctOWFZ/CZh6Y9d1ihtZIDHUtVTXH
 YqTqVULdun1tWZ8WAFiRQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:L92u0FhEV/M=:4ckcr4vHSN8nZ/BuLXu0U0
 VgEajCa4He4/5g6iP1UDFWjIyNYOlCij2e1hvTyaJ32aE3Lg93MVMnDn1bJmiSHU3xBaQbHsf
 pkHg5HoLJ1iIwKS0SRrDx67MgqM67aB0dm8Oshuupr4ZMqZFG14FHqkU0yOkcV3RlM1HxIdpk
 mEXOJVh5ZDH06xbV1wBI6D14w1i4eppXJnGlUsHkwIltJ0F+hOe6sJD6y5HsjKuU5wvH5u0/K
 kYMY9cF8c/41FarVV1i/ffZgGqa+OW2m7q3GOWs4pl10iH8P8FkQlu8QqPOzF9YKgfhMOvzM9
 mxYvq09vFBrk0I/j6suvN2B4Z4jJ7l1hdHpr4cT8mFKINst5cVR+bDb9KipMGWaVP8kg+Jupp
 XnVEFeeWXhxj4LuJcVZv7t2TgiVgbKsdRrjOzjjj+G3VO0RgxT3Msbd8KAOJUA0jq3bWquFZC
 HdSZpb07ltwRlOyguEzGLRePMPFaSaO8u+YwLnag9UZ0wnnfCR9ldag4YtJ8gauu3d0oNfhSF
 Z6Vg3CNFY9P5E+s5Z6ONiD04y21Vz4fh2cggNCZmF1iCONu6X9HxoLN6vFT9bRd0KiNWVG7K9
 K/qrStWZqBhhe8h8k0Lv95GMQqCIp1UYq0KvO0+fU+YHhwpAH1y56TMZ3r6VrQQ5P55UW3Buu
 v/YGKwXlMQGXoWxjBdq7TYtcB27df5zlbdh0U7ZtIRbus8A3PFVgTJ3oKtEFXjTxdL8lyBbk2
 1uIxG0ra8by+fDj+0zORF8eU/aLGQENdGpZV8FxzSBQw41ESfHRh7oHGtTyts/Z4LN7bIwfxE
 4SP5DBUZ4qs5lVeA5qZBcJa9Et54IG3LTbDgbC230KzJIndKL8=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 7, 2022 at 1:36 AM Brad Larson <brad@pensando.io> wrote:
>
> Pensando Elba ARM 64-bit SoC is integrated with this IP and
> explicitly controls byte-lane enables resulting in an additional
> reg property resource.
>
> Signed-off-by: Brad Larson <brad@pensando.io>
> ---
> Change from V3:
> - Change from elba-emmc to elba-sd4hc to match file convention
> - Use minItems: 1 and maxItems: 2 to pass schema check
>
>  Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
> index 4207fed62dfe..278a71b27488 100644
> --- a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
> +++ b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
> @@ -19,10 +19,12 @@ properties:
>        - enum:
>            - microchip,mpfs-sd4hc
>            - socionext,uniphier-sd4hc
> +          - pensando,elba-sd4hc
>        - const: cdns,sd4hc
>
>    reg:
> -    maxItems: 1
> +    minItems: 1
> +    maxItems: 2
>

Shouldn't the binding describe what the register areas are? If there
is only one of them, it is fairly clear, but when you have the choice
between one and two, it gets ambiguous, and there is a risk that
another SoC might have a different register area in the second entry,
making it incompatible.

        Arnd
