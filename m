Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57C004E8992
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 21:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236461AbiC0TOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 15:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231214AbiC0TN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 15:13:56 -0400
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26F29340C9;
        Sun, 27 Mar 2022 12:12:17 -0700 (PDT)
Received: by mail-wm1-f42.google.com with SMTP id r7so7179004wmq.2;
        Sun, 27 Mar 2022 12:12:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=n3bwU1bJAcV9BPDZv4hrQrplN/wyo06SzBsnNMfVQPU=;
        b=uFq9MJakfOUviQ5j8xW2sseZUm+EzUtRxnaz9uIBs1AoK+zHb8JMDHFhUrT/2jYLPU
         pRKvT4yyIhWeWcx6S5cv32K4qnTBj4H3U9AFyou97KEImD6rDgP+RdtL6CaLM+hzZYcg
         rW34+X0hbwAFMN0YZRP8MsqlubQQIaPjKm6RA1toAm8plATIyKsrJZEplxv6FuqYgGCP
         ggbpuZ/WX3Zq2hLqwaOEH7rzXyacaabC4zJd5mpWk4bHOrpez1MKzN3Dg9acyTjQ1UG8
         gQpaPwc8Svo+fZ5qeDfzq4YSuSFpmVV7DumI95/76PS2Img49mcHo+Akxm/IXATx8FE/
         tKKw==
X-Gm-Message-State: AOAM530FuHPPz2G5AZgT/D5SonRGA7CmdQaKYt88OwBHwKxbcocgSuaO
        SVkD8doLohLroR+GzNuMKJA=
X-Google-Smtp-Source: ABdhPJxyiNqZfifLY42W3G4xiGzRnBg+OY+Fe6c4P7ZzawiMiaTLtqZorCZiFKuNaPPkLqbTbOISYw==
X-Received: by 2002:a7b:c5cd:0:b0:38c:8b1b:d220 with SMTP id n13-20020a7bc5cd000000b0038c8b1bd220mr20639807wmk.118.1648408335713;
        Sun, 27 Mar 2022 12:12:15 -0700 (PDT)
Received: from [192.168.0.162] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.googlemail.com with ESMTPSA id j8-20020a05600c404800b0038cc9c7670bsm9776860wmm.3.2022.03.27.12.12.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Mar 2022 12:12:14 -0700 (PDT)
Message-ID: <84c2886e-1a75-1c65-4eb4-737588fcd497@kernel.org>
Date:   Sun, 27 Mar 2022 21:12:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v1 04/12] dt-bindings: clock: imx: Add documentation for
 i.MXRT1170 clock
Content-Language: en-US
To:     Jesse Taube <mr.bossman075@gmail.com>, linux-imx@nxp.com
Cc:     robh+dt@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, aisheng.dong@nxp.com, stefan@agner.ch,
        linus.walleij@linaro.org, daniel.lezcano@linaro.org,
        tglx@linutronix.de, arnd@arndb.de, olof@lixom.net, soc@kernel.org,
        linux@armlinux.org.uk, abel.vesa@nxp.com, dev@lynxeye.de,
        marcel.ziswiler@toradex.com, tharvey@gateworks.com,
        leoyang.li@nxp.com, sebastian.reichel@collabora.com,
        cniedermaier@dh-electronics.com, clin@suse.com,
        giulio.benetti@benettiengineering.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org
References: <20220326144313.673549-1-Mr.Bossman075@gmail.com>
 <20220326144313.673549-5-Mr.Bossman075@gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220326144313.673549-5-Mr.Bossman075@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/03/2022 15:43, Jesse Taube wrote:
> Add DT binding documentation for i.MXRT1170 clock driver.
> 
> Cc: Giulio Benetti <giulio.benetti@benettiengineering.com>
> Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
> ---
>  .../bindings/clock/imxrt1170-clock.yaml       | 59 +++++++++++++++++++
>  1 file changed, 59 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/imxrt1170-clock.yaml

Missing vendor prefix in file name. Add "fsl,"

> 
> diff --git a/Documentation/devicetree/bindings/clock/imxrt1170-clock.yaml b/Documentation/devicetree/bindings/clock/imxrt1170-clock.yaml
> new file mode 100644
> index 000000000000..ca0f9ba8b3da
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/imxrt1170-clock.yaml
> @@ -0,0 +1,59 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/imxrt1170-clock.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Clock bindings for Freescale i.MXRT

Really wrong name. This is name of hardware, not "bindings". It's not
for every i.MXRT, is it?

Just like you did in patch #3, so this could be:
Freescale i.MXRT1170 Clock Controller



Best regards,
Krzysztof
