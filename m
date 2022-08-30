Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED9A5A6B26
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 19:48:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232184AbiH3Rr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 13:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232040AbiH3Rre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 13:47:34 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC0225F9B5
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 10:43:58 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id m2so12776847lfp.11
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 10:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=gNZdcqkFwpNa2I0ZP3eEeP6iX1q8vNso/HI+NR+Wx8E=;
        b=K8NWIl4eTtxKMgxcHr0MIzPzdVgYSCUCp81ghSu7meddtK3chMXIKr+qwyWbPJGzmG
         8W3xXxN/B51i//ogBN8MeRMD1mToPV2S7fIdmrWGHthGbGQQVaE+LvCi9YmHAnelefy/
         TmfXzAeyUnlChV7q9cYDO5sL8XsU6HiMfyNLN7Vo0YHxcj6trabCeHTss65VulL76M9b
         X1p+mVUnZBCMN6lTnUa7SR14LqISxxeEJmj7dw0rlWcmMdHUNK0fp4q8qHoSTtokjWOV
         8WLvrLA3MTAMEb/eFPgmmQfnlWXo1Z9B//6B2lGFbGKsX96lem68ssvamyYoeJNlBmZs
         uQ/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=gNZdcqkFwpNa2I0ZP3eEeP6iX1q8vNso/HI+NR+Wx8E=;
        b=DTgIS4W/jizg4cgSDxO0NUez5HDMWAzMW5yuH5QkWRp+2/UVTVdcJbG+vqo2roCfyI
         kRG3I3xhj8sn0zOG0XuKF0E+YuYryEqSZ0KkC+Kkef7gp6DC8a0OhuMbz85vkvxyBPnO
         uRnX/X2OAbnqLw414cxM30UyrIyjaO7aH6qb9AqUt80rqQRm9NiPMYoxITF/FM/qdPE1
         lpr3QF7PUTfxDXeh8EKeFUPQtQU6my/pNkIFAE1N550u6GzrkAg6esQL9dlqlTMDU3nP
         bMHxYhu+Xu3yTQ6ArmMpblF9PxTa5pCCy/Rwinpu444RWYIk2fWXOmWhTm9AatOGEJzF
         ySBQ==
X-Gm-Message-State: ACgBeo0ixolqm6NPddJF7rWjEpM2eKrxzdTy0ki0cEXp9PO28xzfGL3T
        P62rJSfUPEEl/YOahBqAzSMMYwUzPqnRhgFA
X-Google-Smtp-Source: AA6agR6TqO5OOu79KvMsRgImLRyvGwihNJE/dbXQVJ4Zf+PE3vnSCPfDI1eQNKvWu0egoLgfX/vldA==
X-Received: by 2002:a05:6512:1686:b0:491:3199:d407 with SMTP id bu6-20020a056512168600b004913199d407mr8192887lfb.476.1661880911305;
        Tue, 30 Aug 2022 10:35:11 -0700 (PDT)
Received: from [192.168.28.124] (balticom-73-99-134.balticom.lv. [109.73.99.134])
        by smtp.gmail.com with ESMTPSA id m6-20020a056512114600b0048b12c4c7e6sm636622lfg.12.2022.08.30.10.35.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 10:35:10 -0700 (PDT)
Message-ID: <25072fba-64e2-df11-c8f0-a274037141f0@linaro.org>
Date:   Tue, 30 Aug 2022 20:35:09 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v9 2/2] ASoC: sun50i-dmic: dt-bindings: add DT bindings
 for DMIC controller
Content-Language: en-US
To:     Ban Tao <fengzheng923@gmail.com>, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wens@csie.org,
        jernej.skrabec@gmail.com, samuel@sholland.org,
        alsa-devel@alsa-project.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
References: <1661872039-40174-1-git-send-email-fengzheng923@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1661872039-40174-1-git-send-email-fengzheng923@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/08/2022 18:07, Ban Tao wrote:
> DT binding documentation for this new ASoC driver.

Thank you for your patch. There is something to discuss/improve.

> 

>  .../bindings/sound/allwinner,sun50i-h6-dmic.yaml   | 79 ++++++++++++++++++++++
>  1 file changed, 79 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/allwinner,sun50i-h6-dmic.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/allwinner,sun50i-h6-dmic.yaml b/Documentation/devicetree/bindings/sound/allwinner,sun50i-h6-dmic.yaml
> new file mode 100644
> index 0000000..0cfc07f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/allwinner,sun50i-h6-dmic.yaml
> @@ -0,0 +1,79 @@
> +# SPDX-License-Identifier: (GPL-2.0+ OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/allwinner,sun50i-h6-dmic.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Allwinner H6 DMIC Device Tree Bindings

s/Device Tree Bindings//

> +
> +maintainers:
> +  - Ban Tao <fengzheng923@gmail.com>
> +
> +properties:
> +  "#sound-dai-cells":
> +    const: 0
> +
> +  compatible:
> +    const: allwinner,sun50i-h6-dmic

Put compatible first in the list of properties (also in required:).

Rest is ok, so keep the Rb-tags you already got.

Best regards,
Krzysztof
