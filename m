Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EBBD5667B5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 12:20:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbiGEKUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 06:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230381AbiGEKUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 06:20:41 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24E0E140A7
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 03:20:39 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id y16so19714630lfb.9
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 03:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=T2FSykbTV2E4OHdBjXQOKH96xW/Wt4fBDyh12Wd4k0U=;
        b=wriOUSl810ShuxxSrmpXg72RcW7CIYjuLYB0dvgRwI+U69FYJmuMslaW4rYL3GHg4Z
         J3zs9cDmjFc9/2FQZ0BU54XJebEjC84K99kAmuZr7EbEBtysf0K4D3ZtHjg80VhwLx6H
         okKUK0/FI6+s8VSRnxsJmGvWBY2RLGCtWBofMEnzjGyjz2vYmoL36Nb8heAkjiDApg+u
         T/rcc1sTBs/Dpd7HW54gl52ciTbrxsw5IfH6GeDfDAJ6sVo6H1aK3qt/gm7mfYn5NMf8
         FGvLDkg7/tMlmIdAzJnlTtWeIxZxCuqlHqgVLhugVIRBqh8nyzNLk3sGdLNuS2cwzbn9
         eJ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=T2FSykbTV2E4OHdBjXQOKH96xW/Wt4fBDyh12Wd4k0U=;
        b=gAhj2lr+ggiM5UMTG3+XM5jkEguuZilhZHLsgqeZmmXUcGB5nM1q2DqtAOu3OAckvd
         vemQtohXdqYFJ3OD/SCi6qWWwIL7nU1wY+o10n8X3Ecl3GfgHdHPl+erwMOdpNMfbHC5
         X2LpxfF/XSPgs4jd3IHZJJkTGSs4+WsqG2mujIuEOtTcaRUTTeR0s/WsTxvF2CnqZviZ
         Tiy0Y9/rh47N3n3xehQaWFG6hZhyH1XGIShfzsL9B/JfNKl6yQB0DYqJHXiAleaDHeuA
         iaEjbIz/FyACvn1x1wUqtyokbjtLAv7x/oQLb9aAPZgTcJPWOGfwNYT00cZOzgJ2FxU2
         Ftfw==
X-Gm-Message-State: AJIora8bUc6ZpTLdNqVgPMcYzbiUZcHffmrSuJ7+2WT8mCZAhOinNpxY
        nVkAEX+QqQPhztYrIBrQykB4Jg==
X-Google-Smtp-Source: AGRyM1uAPURNjrcuseQ0j/CUQyF5c4qfoAV1p4sqrmYV21cGEiBcc1Zm6ftiO1WnF/1n6HZsiau38A==
X-Received: by 2002:ac2:5dfb:0:b0:47f:9dac:3bd7 with SMTP id z27-20020ac25dfb000000b0047f9dac3bd7mr21230732lfq.501.1657016437533;
        Tue, 05 Jul 2022 03:20:37 -0700 (PDT)
Received: from [192.168.1.52] ([84.20.121.239])
        by smtp.gmail.com with ESMTPSA id v9-20020a05651203a900b0047f74e4ade2sm5640015lfp.21.2022.07.05.03.20.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Jul 2022 03:20:36 -0700 (PDT)
Message-ID: <dcff330c-92ec-2302-8e2a-4ac124e72942@linaro.org>
Date:   Tue, 5 Jul 2022 12:20:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 38/43] phy: qcom-qmp-pcie: drop pipe clock lane suffix
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
 <20220705094239.17174-39-johan+linaro@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220705094239.17174-39-johan+linaro@kernel.org>
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
>  drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> index 385ea3d8de08..254ad25591b9 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> @@ -2210,8 +2210,12 @@ int qcom_qmp_phy_pcie_create(struct device *dev, struct device_node *np, int id,
>  	if (!qphy->pcs_misc)
>  		dev_vdbg(dev, "PHY pcs_misc-reg not used\n");
>  
> -	snprintf(prop_name, sizeof(prop_name), "pipe%d", id);
> -	qphy->pipe_clk = devm_get_clk_from_child(dev, np, prop_name);
> +	qphy->pipe_clk = devm_get_clk_from_child(dev, np, "pipe");

Just get first clock and no need for handling any deprecation.

Best regards,
Krzysztof
