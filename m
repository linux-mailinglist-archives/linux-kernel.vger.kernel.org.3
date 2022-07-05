Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 012265667BC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 12:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbiGEKVD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 06:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbiGEKU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 06:20:56 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06E5D140BF
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 03:20:55 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id q8so1471963ljj.10
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 03:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=/mmU3Wx1JlIcuJQsWUBY6wF04bFzuVZBMWftRGHu/JE=;
        b=Qr6cuvuPcBK+Fgstwz4GREMfZYaZ9mWaMh00nQJCeqbumLKuEK9eM/4lO7rrYhp5Zx
         iml30lPV8P5bSBtwsfQ+CR9so2br7r5VSgfcBTK7iyAmTRvu7QHwYO48vEn8VDUr6xFh
         Jg/V7tCUR5WliakG/O4dmZwskg9cyd8pzayQOalxlnvOtpr40tlvRiAavf6DTJcEgnIw
         H2x8j/pUnrTxWDrZE1FMOdW7W+01A/q5agf0/rpvQLhliVoCOCTPwQ1cKU3LEPGYT+xa
         aA9jkQuD+l4UOViQ0DT3vjM2izRHS/E8rkcK2aItsxH2lFEqDTOu/NTkdpisBxljZuco
         Mhag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/mmU3Wx1JlIcuJQsWUBY6wF04bFzuVZBMWftRGHu/JE=;
        b=esq/Pls6K7/LsbmtFtAP/Je6dAtntI/+Ngi/aQXg0sy5osot9iAyT6OGHcLpSKPigO
         HDylehkcU+s0U6HUhSKdHUiuuzGzl2LF2AbO9W9scLCbFbzHpr7lriGkVM3IvJPn/cjo
         1xOGh+wqpNigpfYM/qk7N/nQ4r5t+u7nuSjpzbhc4ZzbKns/DAEzB38wOuc31n2riV5U
         zxvNg1iLPDOWqBgPOrusYLa4alEapvrpKPSxpCP2ScyV/FhaeFEAOTpsGFwstoGn9BmV
         EOagcBOiJB86+L9/QGeV5Ye9vPuw5JFR6gXHRbDpls8HWCLyUCYRCDdFMTym64ri1XOy
         +VmA==
X-Gm-Message-State: AJIora+N13Ju2Iu4qHdthaLUwLCaMKYBzO7bQ0l7PfJgeYtY2V4ENk9v
        wJp04VYChTyOasyoI9DQxFzDLw==
X-Google-Smtp-Source: AGRyM1sy1BAlaJYBA70syO2cxWxY/rOzAqoPb5lkAbBJ4uTalOaHpUBxuP9res7X63bZoHG9NAbOpg==
X-Received: by 2002:a2e:9c95:0:b0:25b:b58f:6080 with SMTP id x21-20020a2e9c95000000b0025bb58f6080mr18848968lji.441.1657016453379;
        Tue, 05 Jul 2022 03:20:53 -0700 (PDT)
Received: from [192.168.1.52] ([84.20.121.239])
        by smtp.gmail.com with ESMTPSA id b7-20020a056512070700b0047255d211f7sm5608253lfs.294.2022.07.05.03.20.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Jul 2022 03:20:52 -0700 (PDT)
Message-ID: <1fed199e-0eb8-a7a5-08a4-141694081758@linaro.org>
Date:   Tue, 5 Jul 2022 12:20:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 40/43] phy: qcom-qmp-combo: drop pipe clock lane suffix
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
 <20220705094239.17174-41-johan+linaro@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220705094239.17174-41-johan+linaro@kernel.org>
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
> The pipe clock is defined in the "lane" node so there's no need to keep
> adding a redundant lane-number suffix to the clock name.
> 
> Drop the lane suffix from the pipe clock name, but continue supporting
> the legacy name as a fall back.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
> index b266514ae9ee..7b2eb234cfc2 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
> @@ -2558,8 +2558,12 @@ int qcom_qmp_phy_combo_create(struct device *dev, struct device_node *np, int id
>  	 * Otherwise, we initialize pipe clock to NULL for
>  	 * all phys that don't need this.
>  	 */
> -	snprintf(prop_name, sizeof(prop_name), "pipe%d", id);
> -	qphy->pipe_clk = devm_get_clk_from_child(dev, np, prop_name);
> +	qphy->pipe_clk = devm_get_clk_from_child(dev, np, "pipe");

Just grab first clock.

Best regards,
Krzysztof
