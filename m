Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8945556663E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 11:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbiGEJgZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 05:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiGEJgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 05:36:23 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22771CEA
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 02:36:22 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id a5so1993419wrx.12
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 02:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=GzW+31XOr7tekRHyeYaRdcSCFDvKv8RZIUXRCCGfGc0=;
        b=bfcw4OPtvHHa3yk5hbz1LpQBs64ebuLyPzEwfAOFAZZDY5peorEtlbRotarhEnev35
         fo5Zjjs4OB62zinngJHT6Af8xQWwXB14lEMUv9z5LyzIDNWQjf65nQUTSOjeMtRCfNf3
         oBb8wF+MIChD25EaXnDHkUCyk5KmpVuRxyUM6SE6JF2zdCufoeoTSVb9SCeNDlctU39j
         ZWijWzuxsX5esuxJUMpDbu5jlV9d8zFL3iG/9vz/XXobZILDMhd/hwW5R5Cp4xOfHnaD
         vf3qzHZpQAVMsR2CuTZmUsNf1HHDAl9v1VSx12y0qTpfFYS6SRENQd2ciW5hhZRfZ0Mb
         b9qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=GzW+31XOr7tekRHyeYaRdcSCFDvKv8RZIUXRCCGfGc0=;
        b=7npKiJxZ36prZrr12Rqj7Y/lN+mz+dj5J4XZqECOCK0mw0ztpxOoTz7VmXeFDhHUgI
         +1c/dhzQkVjyfA3/eWRtjJleQz6g9c5U34lDUJoisPPJ4CyOBFbQak04Wsc4fd/Mh/jj
         owQ9hD0GKud5TOCpLd8nmeL+T93V+wp7Qp+7/u9gofgorgLFaFhWNTmXZRDPOS1O2CWe
         YRglZiRefzFuZUMVQ2+LwgXzpAnQFPDHZFKSx94ujEH/npBjRh4Pb7AtSz8KaOtwjaEQ
         1VCeyoXo1vu6fcVuS17Tn3wgZTXpVt6h7zfk2m7jDefSrGhLXS/VmV/T/fEKgtulWuHn
         BAOw==
X-Gm-Message-State: AJIora+EzDmevNdKPiwpkylIDrsH1SEAHeAhSIT0jWm9X1Jh8wosFxtZ
        /Rz0mhMol+bbtN5FLn5dCU/4Pg==
X-Google-Smtp-Source: AGRyM1t82j3S0MTOueXuQgkLVCCapClPqBbI2A1LlAX9vcXNB0vdAWm6Uxt2ethDn5Mt7eNT4D3zrw==
X-Received: by 2002:adf:dfc7:0:b0:21d:6be0:f7e9 with SMTP id q7-20020adfdfc7000000b0021d6be0f7e9mr8829244wrn.359.1657013780717;
        Tue, 05 Jul 2022 02:36:20 -0700 (PDT)
Received: from [192.168.86.238] (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.googlemail.com with ESMTPSA id q7-20020a05600000c700b0021d76985929sm516412wrx.80.2022.07.05.02.36.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Jul 2022 02:36:20 -0700 (PDT)
Message-ID: <108746cd-8186-6f9b-ab56-a45b153def1c@linaro.org>
Date:   Tue, 5 Jul 2022 10:36:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] dt-bindings: nvmem: mediatek: efuse: add support for
 mt8186
Content-Language: en-US
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Lala Lin <lala.lin@mediatek.com>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Chen-Yu Tsai <wenst@chromium.org>
References: <20220701103428.22099-1-allen-kh.cheng@mediatek.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20220701103428.22099-1-allen-kh.cheng@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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



On 01/07/2022 11:34, Allen-KH Cheng wrote:
> Add compatible for mt8186 SoC.
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> ---

Applied thanks,

--srini
>   Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml b/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml
> index 7c7233e29ecf..b5a1109f2ee1 100644
> --- a/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml
> +++ b/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml
> @@ -29,6 +29,7 @@ properties:
>                 - mediatek,mt7623-efuse
>                 - mediatek,mt8173-efuse
>                 - mediatek,mt8183-efuse
> +              - mediatek,mt8186-efuse
>                 - mediatek,mt8192-efuse
>                 - mediatek,mt8195-efuse
>                 - mediatek,mt8516-efuse
