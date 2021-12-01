Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 889F9464DB5
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 13:12:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235355AbhLAMPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 07:15:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349227AbhLAMPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 07:15:21 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09241C061574
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 04:12:00 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id c32so62369418lfv.4
        for <linux-kernel@vger.kernel.org>; Wed, 01 Dec 2021 04:11:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PyWtU2fTMXXHQl2zqbIUgtL5Tkpv94DiI/P26kDC3hk=;
        b=XLlJXy1PxsEMkcuRpB219lMitn3QRKjyZSMpVt3Ct/aFm5yRCJbRWtSDiw0CaUK13N
         mbqkrUAVSLFo4/phmqlNy3pl831PPQN6L8OWEOwqw55WQhlcySbr5dXCHMwY0bJArr0o
         zGnJ9kIAtlRGSa5cz0oDIHJCW4o4El5SZp3PYos3GgJsCbee+NhqHzcG82GwzE1b29ax
         5yZXjJsC3ORVpYfp+wNM72UCDrAnwytcs3nhX9FLHSUw8S4sMRzAdPqszA2JU/lFoxZK
         8ddRh35p8e6ddyJaxnole3rxumzGPPzBX2QeVauOhkQyWUf4h1/qFq9TrDVNVXx96JTt
         4WBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PyWtU2fTMXXHQl2zqbIUgtL5Tkpv94DiI/P26kDC3hk=;
        b=BRp1BtTJQGBJKlQwLwNztKD/H/QUnFdPF9lxG57aWEHtESAz16yq21j1sKC/OIdA/6
         /bLWk/9xDslrVqik4PDKd2EjcAw4es48+VR5oi9mGEJwHDc76KKsQ2XcpnP09QvdeeZb
         JeeEdDboEmjpfrbAvM+tYMbFb2V3dAt2/Zw+92FnUkaOUEsMPqlZug17ZhKhw4XzOpb6
         Kvf2ZUDBT60qERwL/sq1n5FDYqAU01O9+6DV36EeTgVGDZAR6eWtgLPYE6/h5eSTeEo2
         Z97LHAUPYTz0dgXQq08f7LkBV9WzkK75Mem4Bh5Z55JlmkuRTItS78vhl116cjzrGMJe
         D78Q==
X-Gm-Message-State: AOAM532drG2ewix8Sug5RrlCxkQ1/cWUgYMDQFO9jMUGJnR/GvXcx8VD
        yh0AtjlM5psDoWUgCtni7zxmUy3iMQejzw==
X-Google-Smtp-Source: ABdhPJzXym0WFgUHJPQg9hYat7JQh+wLc2adzBSLypueOjOP45uZ1uTXtflmUtVHjybU4xdQDEJONA==
X-Received: by 2002:a05:6512:3082:: with SMTP id z2mr5437199lfd.351.1638360718359;
        Wed, 01 Dec 2021 04:11:58 -0800 (PST)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id q26sm2078485lfa.203.2021.12.01.04.11.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Dec 2021 04:11:57 -0800 (PST)
Subject: Re: [PATCH 2/2] regulator: qcom-rpmh: Add support for PM8450
 regulators
To:     Vinod Koul <vkoul@kernel.org>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        David Collins <collinsd@codeaurora.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20211201072515.3968843-1-vkoul@kernel.org>
 <20211201072515.3968843-3-vkoul@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Message-ID: <fb4ee07b-6e91-9b74-26b4-e0368899bc20@linaro.org>
Date:   Wed, 1 Dec 2021 15:11:57 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211201072515.3968843-3-vkoul@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/12/2021 10:25, Vinod Koul wrote:
> Add the rpmh regulators found in PM8450 PMIC
> 
> Signed-off-by: Vinod Koul <vkoul@kernel.org>

Tested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


> ---
>   drivers/regulator/qcom-rpmh-regulator.c | 18 ++++++++++++++++++
>   1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/regulator/qcom-rpmh-regulator.c b/drivers/regulator/qcom-rpmh-regulator.c
> index 12425f667c00..cea6d7413864 100644
> --- a/drivers/regulator/qcom-rpmh-regulator.c
> +++ b/drivers/regulator/qcom-rpmh-regulator.c
> @@ -969,6 +969,20 @@ static const struct rpmh_vreg_init_data pm8350c_vreg_data[] = {
>   	{}
>   };
>   
> +static const struct rpmh_vreg_init_data pm8450_vreg_data[] = {
> +	RPMH_VREG("smps1",  "smp%s1",  &pmic5_ftsmps520, "vdd-s1"),
> +	RPMH_VREG("smps2",  "smp%s2",  &pmic5_ftsmps520, "vdd-s2"),
> +	RPMH_VREG("smps3",  "smp%s3",  &pmic5_ftsmps520, "vdd-s3"),
> +	RPMH_VREG("smps4",  "smp%s4",  &pmic5_ftsmps520, "vdd-s4"),
> +	RPMH_VREG("smps5",  "smp%s5",  &pmic5_ftsmps520, "vdd-s5"),
> +	RPMH_VREG("smps6",  "smp%s6",  &pmic5_ftsmps520, "vdd-s6"),
> +	RPMH_VREG("ldo1",   "ldo%s1",  &pmic5_nldo,      "vdd-l1"),
> +	RPMH_VREG("ldo2",   "ldo%s2",  &pmic5_nldo,      "vdd-l2"),
> +	RPMH_VREG("ldo3",   "ldo%s3",  &pmic5_nldo,      "vdd-l3"),
> +	RPMH_VREG("ldo4",   "ldo%s4",  &pmic5_pldo_lv,   "vdd-l4"),
> +	{}
> +};
> +
>   static const struct rpmh_vreg_init_data pm8009_vreg_data[] = {
>   	RPMH_VREG("smps1",  "smp%s1",  &pmic5_hfsmps510, "vdd-s1"),
>   	RPMH_VREG("smps2",  "smp%s2",  &pmic5_hfsmps515, "vdd-s2"),
> @@ -1213,6 +1227,10 @@ static const struct of_device_id __maybe_unused rpmh_regulator_match_table[] = {
>   		.compatible = "qcom,pm8350c-rpmh-regulators",
>   		.data = pm8350c_vreg_data,
>   	},
> +	{
> +		.compatible = "qcom,pm8450-rpmh-regulators",
> +		.data = pm8450_vreg_data,
> +	},
>   	{
>   		.compatible = "qcom,pm8998-rpmh-regulators",
>   		.data = pm8998_vreg_data,
> 


-- 
With best wishes
Dmitry
