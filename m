Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3530E5667C2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 12:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232258AbiGEKVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 06:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231939AbiGEKVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 06:21:34 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8773A140E9
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 03:21:30 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id j21so19814511lfe.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 03:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=XGMtHoXKFHUOtxQpfPNqwVcBdt9ZrEo/gnmcHvqCdpI=;
        b=YNIrcUD68JSfz4ua0vARsk6TgaoUKlrYjTEdQgmnEkSPT76AAHI5ScSd5BhLUmQncP
         PxSqZQd4Zf7wk3YVjh02mUkxWED4hzjK/aG7I10YER2lfp1uyNaZG1BEcfhuzoPjE2/z
         vRjqLIi1n6RYKa1eeIA5BsRohf6ay2qEclz6eNybodcy0wz52Y7Nze0/SBZwRMsu0K5w
         efqEkr8ZXj8k0TG1lyR9loiPGH8zky0K/+mwc6976hi6BesBYSy69NCwF8gZJZpwVkf+
         hkuIDVWNtGpBikqAJ9EO+xlDL0JXMqBoOJn+SHOVRLRTWfp5+5C0Rn65RCLhu9wl1BQ+
         I3aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=XGMtHoXKFHUOtxQpfPNqwVcBdt9ZrEo/gnmcHvqCdpI=;
        b=hnnZDFi8owjvbTMa4c1mpuOmrxhbdm8rzMc/GOldy0aGuNIJ7Nfcem64riL+udrXeH
         TgEqNjtxWY351iUg8eGFps01zCPCBf4akLYoaBqnE+b6MJXfmIpIZT4YofDoEdxTdxnd
         AcPt6vm9IiSA7a+Juk9aK77XYZeM3CNGw0hVa4ci/84+A4T8VZOdmlPEI0zxrwcysPr5
         PKRaj4Jrq/1SWk2m4WO7e3ySnwkNjbyoOCbDR7Kciaooe6agEHvV8pgJvmBcxzkcoxQ6
         fSiQShH+671jtUjBGOGTACw117l3ujGIe/uVb7GVx3aYl6Ddhb06+9lgi66T7V0yKlVM
         p4PQ==
X-Gm-Message-State: AJIora+q3SNbIF80Odp/Zm5flDT7Pe0fMeC4cG3jOeDbfSHUwylJzJoP
        42qxNaj+oSsTv5Ruc8Nywt2C/A==
X-Google-Smtp-Source: AGRyM1t/KkEuOwtyTNFstSAVsdiyHggD1Bgiz4900nTcmTdD0yCoOwliE6uS35rh/DkDuzlfnTKIIQ==
X-Received: by 2002:a05:6512:3503:b0:481:4470:4128 with SMTP id h3-20020a056512350300b0048144704128mr20257291lfs.303.1657016488650;
        Tue, 05 Jul 2022 03:21:28 -0700 (PDT)
Received: from [192.168.1.52] ([84.20.121.239])
        by smtp.gmail.com with ESMTPSA id z7-20020ac24187000000b0047f943112e3sm5601954lfh.285.2022.07.05.03.21.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Jul 2022 03:21:28 -0700 (PDT)
Message-ID: <1fc88380-1960-6ed7-0933-d97bfa820dcb@linaro.org>
Date:   Tue, 5 Jul 2022 12:21:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 42/43] phy: qcom-qmp-pcie-msm8996: drop reset lane suffix
Content-Language: en-US
To:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220705094239.17174-1-johan+linaro@kernel.org>
 <20220705094239.17174-43-johan+linaro@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220705094239.17174-43-johan+linaro@kernel.org>
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

On 05/07/2022 11:42, Johan Hovold wrote:
> The lane reset is defined in the "lane" node so there's no need to keep
> adding a redundant lane-number suffix to the reset name.
> 
> Drop the lane-number suffix from the lane reset name, but continue
> supporting the legacy name as a fall back.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c
> index b8481dab54db..9ddb42fa5f7a 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c
> @@ -915,9 +915,12 @@ int qcom_qmp_phy_pcie_msm8996_create(struct device *dev, struct device_node *np,
>  				     "failed to get lane%d pipe clock\n", id);
>  	}
>  
> -	/* Get lane reset, if any */
> -	snprintf(prop_name, sizeof(prop_name), "lane%d", id);
> -	qphy->lane_rst = of_reset_control_get_exclusive(np, prop_name);
> +	qphy->lane_rst = of_reset_control_get_exclusive(np, "lane");

As well, just grab first entry and ABI is kept stable.

Best regards,
Krzysztof
