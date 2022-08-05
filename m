Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50E8C58A8A0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 11:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240474AbiHEJSy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 05:18:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235698AbiHEJSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 05:18:52 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7976074E2C
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 02:18:51 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id z20so2440944ljq.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Aug 2022 02:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=GTjcoqI8Zy27Jjru/d59SIQfAPUV+r8g0eBDkIE396k=;
        b=lKhJRkSEw51vKDVAn2VeUUsFqN2x/2Od3nB1tmiYf6aGDUh/wZ0B+lDEho5FuKYvyr
         Fantq8i5HJb/ZXuQzQ770l6rOlhAJNk+Zx+EhJpn5mT75AToQhQfOQzIyPF053hvOOOf
         n4Mg0txMOKJBUZRIgNk9sj1/Ci3RUqtMf+QnYEBF85ngVA5KzK13/Dc+Cr7mO/XKnIvW
         aBVXwo4/3ztNXMMq98gtV/6zvdrWXk3FOMc7di6PWYLTDo3RzMd5w5sRkCKE69lhyty3
         d0hOO52zMLIR4QiEYLpLMag0aQPUfTVCr0oclshUUKbWkkgMEKpOR/gk0wspWTsFyVO6
         co4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=GTjcoqI8Zy27Jjru/d59SIQfAPUV+r8g0eBDkIE396k=;
        b=i3f83aOEIkZ6MymL8QEJO45GoLvZF1pVc7t/nWAYl2EB26j37c4mxBcBI17fkofZtC
         DB9acdbN7Qvm0UNQ3zzJzPdQEV7ycOjJgYxWeaWb8++BI+Vj3PDSSusDME+ABzBN7aem
         uKD1UTZVtgKJVBcSQudO4aObPFsAjkmud8/wpeRuEcPW7mB8Owv9FRkCseCKGf0O8idr
         WrwswoNO/qiLNBiYYxrZRwRkeWbEWN+Ou5H3lyaTIC1lUZA0moDzZad6mBonscA6hi4D
         YKIYrZFVmW9wDCERROJ063YtG8iUksOiOHJuvIK5hPJCB/CCDNuSP4ssL9PETWYTovAC
         I75w==
X-Gm-Message-State: ACgBeo0dDo8XyLrX8/RCWI7NOLPUpLgdR05rnCXAdEm/NS24wpWm5nOU
        zz5mrBJh8LjeeccEa+wFSV3/OQ==
X-Google-Smtp-Source: AA6agR7wHuNA7a+JazzGC2jn/GP7TBwgHVZRkO2xAVt7CAJVVMAvSYiwie/Daa3N1pCyJKOHQtY0/w==
X-Received: by 2002:a2e:82c5:0:b0:25d:83d8:41b with SMTP id n5-20020a2e82c5000000b0025d83d8041bmr1705001ljh.140.1659691129869;
        Fri, 05 Aug 2022 02:18:49 -0700 (PDT)
Received: from [192.168.1.6] ([77.222.167.48])
        by smtp.gmail.com with ESMTPSA id u13-20020ac25bcd000000b0048b0062a14fsm405209lfn.144.2022.08.05.02.18.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Aug 2022 02:18:49 -0700 (PDT)
Message-ID: <106e443a-e765-51fe-b556-e4e7e2aa771c@linaro.org>
Date:   Fri, 5 Aug 2022 11:18:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 1/2] dt-bindings: cpufreq: add mt8188 cpufreq hw
 dt-bindings
Content-Language: en-US
To:     "jia-wei.chang" <jia-wei.chang@mediatek.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hector Yuan <hector.yuan@mediatek.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        hsinyi@google.com
References: <20220805091211.2791-1-jia-wei.chang@mediatek.com>
 <20220805091211.2791-2-jia-wei.chang@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220805091211.2791-2-jia-wei.chang@mediatek.com>
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

On 05/08/2022 11:12, jia-wei.chang wrote:
> From: Jia-Wei Chang <jia-wei.chang@mediatek.com>
> 
> Add mt8188 cpufreq hw compatible in dt-bindings.
> 
> Signed-off-by: Jia-Wei Chang <jia-wei.chang@mediatek.com>
> ---
>  .../devicetree/bindings/cpufreq/cpufreq-mediatek-hw.yaml      | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek-hw.yaml b/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek-hw.yaml
> index 9cd42a64b13e..b56d36224612 100644
> --- a/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek-hw.yaml
> +++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek-hw.yaml
> @@ -16,7 +16,9 @@ description:
>  
>  properties:
>    compatible:
> -    const: mediatek,cpufreq-hw
> +    enum:
> +      - mediatek,cpufreq-hw

Can you add a comment mentioning for which SoCs this is? Someone added a
generic compatible covering all MediaTek cpufreq-hw (all!) and now you
say it does not cover all?

Best regards,
Krzysztof
