Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0A90599545
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 08:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234482AbiHSGRv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 02:17:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245709AbiHSGRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 02:17:48 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66C5165242
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 23:17:47 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id l19so478428ljg.8
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 23:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=LJ6Y1/P/3NgrZFk4V8Ks7FUqbnAKX/c9IhrAriRyk6U=;
        b=Z0w5qpy0S5WF+Jsw5u2J+pjK95+pFKjYVL4sGfE+yR1hQ1MoPmPz49Rd6+OB6mS3+Y
         QPLvSsihCnXsLWWB0KszmzbJbdOLSljlZEXhaxTRzEPltEtY2VfT6d26dB1zEJHvJzkB
         32f8Ue/R2OHXzjX3ZvmU5OqvJFVZ0HA1XWA9sY+HIa011NmNSlQOnQcmhTZLWeDcc84V
         FtissL+7XWGXrjJyoVA3UqQay6veJiU3CPrxmzL3nktYWB9DgrzlDaqIai0Cy+twNIwh
         E6Qkx+188IEKWu8s8VXzj3QQvdrpXLMqDzcMh1RAORSzj0CENMhaAnxfd1co8MbHyH0h
         oj2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=LJ6Y1/P/3NgrZFk4V8Ks7FUqbnAKX/c9IhrAriRyk6U=;
        b=0mfaGvjPET2BZeoJH58uG92NQxRJ9tBdP2Mic6bIbT/qCXsv1EE1SuuMmLX1cPfDgH
         SWSYR/F4dbDA0XMWSqdtHb4/jbJ5MZtOyDfQMvOoPy6TOtmh33i4BdSx3qjGYR104SvX
         O/2y8DPNGxkvRiS9X6UvwQ5srlc0ht6qTLhLB0lERjQSfMq3T0feEi9crrGQUTA+XyQp
         h2VZ4L1Ijo4UHrCg+4ky/1fyHGoFVl/ISqAOQM36J2cRXe5AsARM9JQ5wErMxBZYyuKu
         zyYjS6wfoVDSDuJ+veSNhmrYrnVusoJsovlidUvWk4I6pOUcnmCFuLyx7YWuDoqZ/r8V
         QPxw==
X-Gm-Message-State: ACgBeo2Q6RovnjXNUfKU8gazzjHBTzWr1PKlLu5xjeKgL/nv8Q62l4cT
        JwkKS9hE3095zWEv3bSmWTQxBw==
X-Google-Smtp-Source: AA6agR7DCy6FxvZFYRuBMsWwcqPT29FISCRST1z/IxE7dY3YeTj9ewMGRqgvtt9uK0rRYfOeb2FacA==
X-Received: by 2002:a2e:978f:0:b0:25e:4847:530a with SMTP id y15-20020a2e978f000000b0025e4847530amr1794081lji.279.1660889865666;
        Thu, 18 Aug 2022 23:17:45 -0700 (PDT)
Received: from ?IPV6:2001:14bb:ac:e5a8:ef73:73ed:75b3:8ed5? (d1xw6v77xrs23np8r6z-4.rev.dnainternet.fi. [2001:14bb:ac:e5a8:ef73:73ed:75b3:8ed5])
        by smtp.gmail.com with ESMTPSA id w17-20020a19c511000000b0048af85f6581sm509957lfe.154.2022.08.18.23.17.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Aug 2022 23:17:45 -0700 (PDT)
Message-ID: <0cdca889-1193-1595-e524-5a0cfc633d14@linaro.org>
Date:   Fri, 19 Aug 2022 09:17:43 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v3 5/5] arm64: dts: qcom: sc7280: Add Reset support for
 gpu
Content-Language: en-US
To:     Akhil P Oommen <quic_akhilpo@quicinc.com>,
        freedreno <freedreno@lists.freedesktop.org>,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1660853919-987-1-git-send-email-quic_akhilpo@quicinc.com>
 <20220819014758.v3.5.I6a1fca5d53c886c05ea3e24cd4282d31c9c0cd0b@changeid>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220819014758.v3.5.I6a1fca5d53c886c05ea3e24cd4282d31c9c0cd0b@changeid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/08/2022 23:18, Akhil P Oommen wrote:
> Add support for Reset using GPUCC driver for GPU. This helps to ensure
> that GPU state is reset by making sure that CX head switch is collapsed.
> 
> Signed-off-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
> ---
> 
> (no changes since v1)
> 
>  arch/arm64/boot/dts/qcom/sc7280.dtsi | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> index e66fc67..f5257d6 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> @@ -2243,6 +2243,9 @@
>  			nvmem-cells = <&gpu_speed_bin>;
>  			nvmem-cell-names = "speed_bin";
>  
> +			resets = <&gpucc GPU_CX_COLLAPSE>;
> +			reset-names = "cx_collapse";
> +

I think this is not allowed by bindings. Did you test your change with
dtbs_check?

Best regards,
Krzysztof
