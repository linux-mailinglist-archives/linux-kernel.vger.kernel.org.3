Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5F805784D7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 16:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235717AbiGROIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 10:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235708AbiGROIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 10:08:51 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29EC7FEC
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 07:08:49 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id y11so19524664lfs.6
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 07:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=8CqAs9Ua7Pm8Q2XSJh/dswnbeNdXHzd1llWNOHbIuD0=;
        b=AZP+58llLmJC3ISGeRpqLe8S5SU5cyj1U9du0bCtxTz57c1auuFp1bdrqbtDZqmdH+
         jsoBPRqy9ceu6SiyC5bv8BCTvN4fTtcQb8pUA+539DHYzGFvk2FHHXWj+uTKBRwiUPkX
         yJd8kYfdlgQPDkA8rODq9IlHRtUkLX8P68eCbpivN4Cm3n+cCeIJfX9WggoGOe22Kyau
         Crn2aYQ21U+SKMhrcO+5y5LpZNWp+DhgS8aibz/SYGLlQzPHDvDpda+v7VDtly9UEXzO
         kJ8/IWI2xzQqXN+XzeRacveJoDw6jox0hBhtkS76wku+21Ff2wzlcHu2opjhZXXljR1J
         SnbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=8CqAs9Ua7Pm8Q2XSJh/dswnbeNdXHzd1llWNOHbIuD0=;
        b=wHaifIcPJOAOvU1AQHfpJDwDBvNxA/zIHFdKXan1GQEjFczDgQ6n388amFh8ZvMhss
         6g5snRij2eRe4nBeppggdfeFqVGmo+6t9QZgXnkqljNCYmV0Gn+tn49uP9v9qMXn3FhO
         e8yH2mU9P3JzIgHsw42WbGtmtJam2S/lnsNUmyy39FFWLXVhH4j/zfdVdphs3udklWMk
         IAKhfLu+V2xHMqkUyC++zd/S3a/o0PZ/Hvf4mohUSvB2JWzfBrma9f911SCwLSVz8w+N
         0XESdWfUN86uR4HVxeg2VqixgwdYyh4RmRgmbljn1WauJTybx30yNVDt04D2jUBaffVs
         lk3A==
X-Gm-Message-State: AJIora+vEQuXzHLiVTE/4N1CEoshKnWTyBKKgfTHoOeuYt7TnNTS/mot
        FOeSNPk0aa1enjfFM5JrAx9ADQ==
X-Google-Smtp-Source: AGRyM1tMdIUR9jHUwbcEC9/NAS7p2+/gpqVLsPo9FDRHsddDPnRJMiUKece0HNK6p14XKK1PqS1IrA==
X-Received: by 2002:a05:6512:1684:b0:47f:5f27:b006 with SMTP id bu4-20020a056512168400b0047f5f27b006mr15108397lfb.225.1658153327547;
        Mon, 18 Jul 2022 07:08:47 -0700 (PDT)
Received: from [192.168.115.193] (89-162-31-138.fiber.signal.no. [89.162.31.138])
        by smtp.gmail.com with ESMTPSA id p26-20020ac246da000000b0048a256f50b3sm2016576lfo.102.2022.07.18.07.08.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jul 2022 07:08:47 -0700 (PDT)
Message-ID: <67c5ed4a-022a-e2b4-cbbb-ca6818bf4881@linaro.org>
Date:   Mon, 18 Jul 2022 16:08:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/3] dt-bindings: pinctrl: mt8188: add pinmux definition
Content-Language: en-US
To:     Hui Liu <hui.liu@mediatek.com>, linus.walleij@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com
Cc:     srv_heupstream@mediatek.com, johnson.wang@mediatek.com,
        zhiyong.tao@mediatek.com, sean.wang@mediatek.com,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220718113813.23787-1-hui.liu@mediatek.com>
 <20220718113813.23787-3-hui.liu@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220718113813.23787-3-hui.liu@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/07/2022 13:38, Hui Liu wrote:
> From: "Hui.Liu" <hui.liu@mediatek.com>
> 
> This commit adds pinmux definition for mt8188 platform.
> 
> Signed-off-by: Hui.Liu <hui.liu@mediatek.com>
> ---
>  include/dt-bindings/pinctrl/mt8188-pinfunc.h | 1280 ++++++++++++++++++
>  1 file changed, 1280 insertions(+)
>  create mode 100644 include/dt-bindings/pinctrl/mt8188-pinfunc.h
> 
> diff --git a/include/dt-bindings/pinctrl/mt8188-pinfunc.h b/include/dt-bindings/pinctrl/mt8188-pinfunc.h
> new file mode 100644
> index 000000000000..bb764b67159b
> --- /dev/null
> +++ b/include/dt-bindings/pinctrl/mt8188-pinfunc.h

Vendor,name
mediatek,mt8188-pinfunct.h

> @@ -0,0 +1,1280 @@
> +/* SPDX-License-Identifier: GPL-2.0 */

Dual license.

Best regards,
Krzysztof
