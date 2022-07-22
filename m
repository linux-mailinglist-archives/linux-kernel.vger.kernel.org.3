Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 231DC57D7F9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 03:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231500AbiGVBWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 21:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiGVBWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 21:22:41 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 547228320B
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 18:22:40 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id u9so4208721oiv.12
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 18:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kali.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=5RE2+m/uZkqrJBifkutN7/zroirdmE7/BSH0qm4Ap2Q=;
        b=Ksnwp5FmZXmJCdXwHA1M9xmzCwhnu2pMFizwZWvTJHYDGyGZTcj9yN1r8sUGLJEaUN
         S/6tYZtTC8mcGK1S809kTHVJsi2WsmSObWoZZCnC37nhoIJczGkMx2gml0lsae8oyZJz
         cS+UPRKFGLf7UE/eyol2dD2BxCsUZF6H5QFuYFxfaet1BQLd8SjT7S+NzLZuij1YU7Lr
         GQmAh401dL9cm5JSf93Z+rS9ADGvRBtlOlWdvrIlq4oJ+nVd1xFhhgPcs01bOUL6PYUS
         F6FotGkpnVhlHOkC4yd/Ds6GAGUIOOnlXSW3nOXg2hkRTG5OGffsvfKB6p0u/S7++MyH
         5//w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=5RE2+m/uZkqrJBifkutN7/zroirdmE7/BSH0qm4Ap2Q=;
        b=2OlkdHHN2Bj7ntIxGwnplgaP7KUEmMbMdMBUgSv/aifCY3kBXmxjqEzfbxaGWLEuva
         ritmHWLXe8GbTjqpsxrlVWLP4PFrgklhhwQ0uyMelU8OGP/m2LQMs65RbX01kGSHOoji
         dVsxBmy4ror26pCUp5x167+9iHTjvZf54/rspwNO72NxOiDq54lyF4bYqyfvaRVwl5si
         ZYUdnsQskqJn3DyeGpo/Q0mqZ6GB2HOFACAcmh3/TrgfXFFoO03DsR/i4QRe6ghdjvR9
         E5DxIk5LP2eY8jMh9sPjSlPdATEMvCAzv2EX44OqrInu95ku2EFnlE0Rwkvdmq9bqbgo
         DeRQ==
X-Gm-Message-State: AJIora+lTpG6yZRSRcgKPfWvAwrULM1t+n6g2olhfe3VxAGWqkevuPgb
        xRyl+UCY89P0tLgHaq+9BYDoig==
X-Google-Smtp-Source: AGRyM1ui+OWeE7ysrFkdh10FOzl4oJRSODXnbaqDF19nVJuKJZ7alAGS6QfedPBRTaSyaFyypQKYaA==
X-Received: by 2002:a05:6808:1484:b0:33a:782a:a626 with SMTP id e4-20020a056808148400b0033a782aa626mr418748oiw.145.1658452959592;
        Thu, 21 Jul 2022 18:22:39 -0700 (PDT)
Received: from [192.168.11.16] (cpe-173-173-107-246.satx.res.rr.com. [173.173.107.246])
        by smtp.gmail.com with ESMTPSA id s26-20020a05683004da00b0061cd208fadesm507394otd.71.2022.07.21.18.22.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jul 2022 18:22:38 -0700 (PDT)
Message-ID: <25673493-4171-62b0-f696-1316d115f388@kali.org>
Date:   Thu, 21 Jul 2022 20:22:34 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH 10/10] arm64: dts: qcom: sdm845: add LLCC BWMON
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rajendra Nayak <quic_rjendra@quicinc.com>
References: <20220720192807.130098-1-krzysztof.kozlowski@linaro.org>
 <20220720192807.130098-11-krzysztof.kozlowski@linaro.org>
From:   Steev Klimaszewski <steev@kali.org>
In-Reply-To: <20220720192807.130098-11-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 7/20/22 2:28 PM, Krzysztof Kozlowski wrote:
> The SDM845 comes with few instances of Bandwidth Monitor.  The already
> supported one monitors traffic between CPU and Last Level Cache
> Controller (LLCC) and in downstream sources is called BWMON v4 (or v4 of
> register layout).
>
> SDM845 also has also BWMON instance measuring traffic between LLCC and
> memory with different register layout: called v5.
>
> Cc: Rajendra Nayak <quic_rjendra@quicinc.com>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>   arch/arm64/boot/dts/qcom/sdm845.dtsi | 37 ++++++++++++++++++++++++++++
>   1 file changed, 37 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index fe14f7e7523b..4aab464e2bd6 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -2053,6 +2053,43 @@ llcc: system-cache-controller@1100000 {
>   			interrupts = <GIC_SPI 582 IRQ_TYPE_LEVEL_HIGH>;
>   		};
>   
> +		pmu@114a000 {
> +			compatible = "qcom,sdm845-llcc-bwmon";
> +			reg = <0 0x0114a000 0 0x1000>;
> +			interrupts = <GIC_SPI 580 IRQ_TYPE_LEVEL_HIGH>;
> +			interconnects = <&mem_noc MASTER_LLCC 3 &mem_noc SLAVE_EBI1 3>;
> +
> +			operating-points-v2 = <&llcc_bwmon_opp_table>;
> +
> +			llcc_bwmon_opp_table: opp-table {
> +				compatible = "operating-points-v2";
> +
> +				/*
> +				 * The interconnect path bandwidth taken from
> +				 * cpu4_opp_table bandwidth for gladiator_noc-mem_noc
> +				 * interconnect.  This also matches the
> +				 * bandwidth table of qcom,llccbw (qcom,bw-tbl,
> +				 * bus width: 4 bytes) from msm-4.9 downstream
> +				 * kernel.
> +				 */
> +				opp-0 {
> +					opp-peak-kBps = <800000>;
> +				};
> +				opp-1 {
> +					opp-peak-kBps = <1804000>;
> +				};
> +				opp-2 {
> +					opp-peak-kBps = <3072000>;
> +				};
> +				opp-3 {
> +					opp-peak-kBps = <5412000>;
> +				};
> +				opp-4 {
> +					opp-peak-kBps = <7216000>;
> +				};
> +			};
> +		};
> +
>   		pmu@1436400 {
>   			compatible = "qcom,sdm845-bwmon", "qcom,msm8998-bwmon";
>   			reg = <0 0x01436400 0 0x600>;


With this series applied, testing on a Lenovo Yoga C630, which has an 
SDM850, I see the following:

[    3.673660] qcom-bwmon 114a000.pmu: can't request region for resource 
[mem 0x0114a000-0x0114afff]
[    3.673673] qcom-bwmon 114a000.pmu: error -EBUSY: failed to map bwmon 
registers
[    3.673678] qcom-bwmon: probe of 114a000.pmu failed with error -16

