Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05E52525D42
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 10:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378191AbiEMIYO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 04:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378177AbiEMIYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 04:24:09 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCF2B2A5E9D
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 01:24:07 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id a5so6586906wrp.7
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 01:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=M1lYVcvZGeJMDFjAhYStiELCM++HSwims5YjxbNozwg=;
        b=VbF5QVMtyN7wrrr73XL/TWaz7LGSC4fqPP/OtRmnRtZadMHQ6Cu4VKhLauJZphD/8P
         vD5LrRJlwxmsuT2CnGS5mQQKXg9S3i+1oa4Nf6sHTE1JJqkIWplJptcJsypElUyhJfdJ
         qlTQFyIhixS+fM0ASMshTHF8S2UFoSsTgOFG92BCWZmv3WZAJtxE4wtU6onXh2xlQQ5k
         yRSXdTTBzO0ubkXC23EXSMRh830kqZUgHGNBGaNawxdFNq50CUJw+o2k7tODZKYWzkuS
         x9ExpYkx25FzZdiFZ87M1czwbZEz7OA4k2xlQuX3xpv++wEFFqdwg3WM90Onyh2xeLYl
         pjHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=M1lYVcvZGeJMDFjAhYStiELCM++HSwims5YjxbNozwg=;
        b=Cycq/dbHFp8fK5kFrVX5Q4iPlVATUG5nTfXaceIv6AJK4vjkbYmp4HwbMTkuYpOob1
         81tY0HAGQB4ANSnJh5rpLM2/qYHTrNdcop50kvbhChrGztA8R2gXUymu3oEEJiHIvxYS
         QiVnSORdHud/awZgcMDy2TF4U1zen9zjB7cYD3SyIEgmPeTRDV+ZBclZjTRVNet6xg+e
         06Dh9bCmkpb3iHDfS1Zxo7YK19e2LrwRAoRr/98WKnAmV2B3b73XWrN1g6zs2Fp6ZI70
         eSDekolQKLdN9ESpE0FpIczUvPGGdf82jyGEqZSMqJGGqLxVztsEBRx62znQ1mK09ow4
         Cb5g==
X-Gm-Message-State: AOAM532uNpWFP2aaSOFQIje6nt+nNlR5p8PhursSP66/DLsWfuBYB+0F
        vywurseBIFauDYC9A0/h6UK3Cw==
X-Google-Smtp-Source: ABdhPJyfbJrwOl2LNY/n2Drgyva6rd+YJJxS539TxEvjRvHrgJmkirgEPK6yG1Emcsy4it1ih0jbmg==
X-Received: by 2002:a5d:58e5:0:b0:20a:e022:3f8c with SMTP id f5-20020a5d58e5000000b0020ae0223f8cmr2764714wrd.667.1652430246346;
        Fri, 13 May 2022 01:24:06 -0700 (PDT)
Received: from [192.168.0.169] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id p26-20020adfa21a000000b0020c61af5e1fsm1495820wra.51.2022.05.13.01.24.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 May 2022 01:24:05 -0700 (PDT)
Message-ID: <7c7f7036-e3ad-c9db-2c31-749e2d01e83d@linaro.org>
Date:   Fri, 13 May 2022 10:24:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 5/7] arm64: dts: qcom: Add PM6125 PMIC
Content-Language: en-US
To:     Marijn Suijten <marijn.suijten@somainline.org>,
        phone-devel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220511220613.1015472-1-marijn.suijten@somainline.org>
 <20220511220613.1015472-6-marijn.suijten@somainline.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220511220613.1015472-6-marijn.suijten@somainline.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/05/2022 00:06, Marijn Suijten wrote:
> This PMIC is commonly used on boards with an SM6125 SoC and looks very
> similar in layout to the PM6150.
> 
> Downstream declares more nodes to be available, but these have been
> omitted from this patch: the pwm/lpg block is unused on my reference
> device making it impossible to test/validate, and the spmi-clkdiv does
> not have a single device-tree binding using this driver yet, hence
> inclusion is better postponed until ie. audio which uses these clocks is
> brought up.
> 
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>

Two reviews on first patch... :)

> +
> +	pmic@1 {
> +		compatible = "qcom,pm6125", "qcom,spmi-pmic";
> +		reg = <0x1 SPMI_USID>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;

No children, so this should not be needed, I think.

> +	};
> +};


Best regards,
Krzysztof
