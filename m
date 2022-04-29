Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 683EB51560D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 22:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381047AbiD2Utd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 16:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381138AbiD2UtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 16:49:21 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12D5080BE6
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 13:46:01 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id g20so10332091edw.6
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 13:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=ochQJGvAfnV9VCduFrexGwXrShT60JDPrJL2+ME4cQ4=;
        b=LSJ/V0b2j/fqVDcMnrT6FBN1mebxobirc9EAxiHC/FZdOkrohbioYBEybtnAnQ8cMc
         r2SjDMHDLXyypSR732Vvb71UA7FCP6q7yBXTPEIF71DZdCK7liUdGPeNyMeF3Oe7KJfO
         XP+OgECXvpkyta1sSC2EvgY8GAi0w+qdVUyd4yMb2Xw9S320MO2HELFDVxaZuAuzvl1t
         OYH5rCu8JkJWYJdRawU7tp9Qpp97LVlWncVaZVhSyG1E4GQ5f8MmVJoTiB9aV8gSWqsk
         lGRHAdA/EpQyKGxRAl0fTzlqykh82YOzsPBYOLSS5GANO8dIuPM/pGaT/cqRIbBBhDsd
         YtvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ochQJGvAfnV9VCduFrexGwXrShT60JDPrJL2+ME4cQ4=;
        b=n9LmYzILJ7/k2Qvq3p9hzuxtxMOvfWAK1a0lYu7KMQFIz3APxFp0VdqY59ao2oPwyl
         6ei0F8THLHfF1dqHWmVOxtE3KJK6x7gFe8qH35eccRhsprxHKE6BcBGoc+K31VkeQMUP
         IoV+T9Zrf4lzIi4PYu8NAKx253a6O1YCwP5+lnfoaJ9T9XA1iyjHPNYndNKRgK6xESnX
         mN2MlbIkMwwyBzzXg8g8EaTT/B5DIdrvSNYhpyG7sC7bzZUPfdfc3OvEd7RPNFZ3SEOv
         Potrc3lXtIOr7RExws0oEZzNC/nr0YkNb9Cp88qs0rBM06WAVqfA3PtrQifl3kZObAxs
         am+A==
X-Gm-Message-State: AOAM533T7Y9n/cWusB2LOi6F/KcjB04tL3qI+rY3WQ5YKk07rTRlSDMK
        fQ8VipDOfiJWoTSyMthxraZdZg==
X-Google-Smtp-Source: ABdhPJyi1MDo1zRub/Ovah2DsFuZ1Cs98xS2bAOhuo/XVUB+gAAw2pNRnHke/CISIJe1ILdOLtbb/w==
X-Received: by 2002:a05:6402:11c9:b0:425:ef56:a1dd with SMTP id j9-20020a05640211c900b00425ef56a1ddmr1099914edw.143.1651265159632;
        Fri, 29 Apr 2022 13:45:59 -0700 (PDT)
Received: from [192.168.0.176] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id jz24-20020a17090775f800b006f3ef214de1sm959183ejc.71.2022.04.29.13.45.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Apr 2022 13:45:59 -0700 (PDT)
Message-ID: <1b545fbb-eaca-fb98-f77a-15326a7a2e4e@linaro.org>
Date:   Fri, 29 Apr 2022 22:45:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 2/6] clk: qcom: Add DT bindings for IPQ8074 APSS clock
 controller
Content-Language: en-US
To:     Robert Marko <robimarko@gmail.com>, agross@kernel.org,
        bjorn.andersson@linaro.org, jassisinghbrar@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org
References: <20220429114330.59026-1-robimarko@gmail.com>
 <20220429114330.59026-2-robimarko@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220429114330.59026-2-robimarko@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/04/2022 13:43, Robert Marko wrote:
> Add DT-binding for the IPQ8074 APSS clock controller.
> 
> Signed-off-by: Robert Marko <robimarko@gmail.com>

These are dt-bindings, so prefix the title matching dt-bindings
subsystem and remove "DT bindings" words form the title. Instead "Add
clock ID headers for..."

> ---
>  include/dt-bindings/clock/qcom,apss-ipq8074.h | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>  create mode 100644 include/dt-bindings/clock/qcom,apss-ipq8074.h
> 
> diff --git a/include/dt-bindings/clock/qcom,apss-ipq8074.h b/include/dt-bindings/clock/qcom,apss-ipq8074.h
> new file mode 100644
> index 000000000000..df07766b0146
> --- /dev/null
> +++ b/include/dt-bindings/clock/qcom,apss-ipq8074.h
> @@ -0,0 +1,14 @@
> +/* SPDX-License-Identifier: GPL-2.0 */

This should be licensed the same as bindings, so GPL|BSD, unless it's a
derivative of some other work?

Best regards,
Krzysztof
