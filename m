Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51A3E4FE448
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 17:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356813AbiDLPDc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 11:03:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiDLPD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 11:03:28 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9830250451
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 08:01:08 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id o20-20020a05600c511400b0038ebbbb2ad8so1818518wms.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 08:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=7js1UH2M/H4XFdT/VYX4By9FNV4HBtwbQGAItNp0olE=;
        b=Z2uChZtZEb6EjRK0LBefZZB3/73zZjLJyUy8NLxgtpVI8sZBEOsYczIsK4qz/vKXJ7
         aIVS5OagmaNmz88LDX3kaGrIHNEFQIzGWFrXQGANXHDw4f+tpS1ZaMQODYuPNa4ydUvY
         9sJgUVa+aiKi1IJRtNeUo/6XnEXk8MbKk4UBCqlppIa6VCzsUJ1whX2kDlya7CKYbWSJ
         gLEMs2t5ZjVtEYCNI4r192x3vgHR4I0f+LaLnjL37RV6SsqR2ubRQfQvhRoeoD+gSqYA
         AjZflTeIBr/wXKUKDnQGKNo4p57EA/cb2Wo55A7mbjr7WDk2yhtAlX/gKPqiMd8Kdela
         RDUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7js1UH2M/H4XFdT/VYX4By9FNV4HBtwbQGAItNp0olE=;
        b=g7Xl0QApgqaqrj8FpF046F5UM2G1pudynF75v/5rHdGo5WdXsLtK0MT4FnnKPYJaGA
         u0zkHrdavgvPplyVItxMX/ZQGOmTSUUOhThXP9hHCql4pQe8pt78exzMSNYzTNVpz//I
         q79oPm9/4YmBsBa3cLiJQKcJ9fMwXxYeOD4LXuJ2M28Gx6WmkM4Y50ZBpjA/oVsibgkf
         A16BxcqXeUxzjTKFCtUKX9ZvbO4FECj6ucgjnM2MJ6rtEAzEDic6/6K6/5yLh8sd25nN
         03RulT/wF21LdRndFQulE16+vKjShBEl/+dt2hue77DfxMx5+Dn5FDsBb55+l68iQgQN
         pfcQ==
X-Gm-Message-State: AOAM531dltQztnTdSFhdfYBntiVjZzgbD/pTvNk0fNJ01ywe1SW79la+
        edslty+29jRfZMW5tS//kYjbsg==
X-Google-Smtp-Source: ABdhPJzTSHSfyrwau3xW+AehkcTP+X4MnzJII/oAmUKEdfBGnGP6TA25S/PTwJfKeSYbm/uhBORLsw==
X-Received: by 2002:a1c:44c5:0:b0:38e:abd1:d894 with SMTP id r188-20020a1c44c5000000b0038eabd1d894mr4561539wma.40.1649775667018;
        Tue, 12 Apr 2022 08:01:07 -0700 (PDT)
Received: from [192.168.86.34] (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.googlemail.com with ESMTPSA id n23-20020a05600c3b9700b0038b7c4c0803sm3026900wms.30.2022.04.12.08.01.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Apr 2022 08:01:06 -0700 (PDT)
Message-ID: <149e3140-1b9d-b864-c14c-4d2cb098ec9a@linaro.org>
Date:   Tue, 12 Apr 2022 16:01:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] slimbus: qcom: fix error check return value of
 platform_get_irq()
Content-Language: en-US
To:     cgel.zte@gmail.com, agross@kernel.org, bjorn.andersson@linaro.org
Cc:     gregkh@linuxfoundation.org, sdharia@codeaurora.org,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Lv Ruyi <lv.ruyi@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
References: <20220412090259.2533316-1-lv.ruyi@zte.com.cn>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20220412090259.2533316-1-lv.ruyi@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/04/2022 10:02, cgel.zte@gmail.com wrote:
> From: Lv Ruyi <lv.ruyi@zte.com.cn>
> 
> platform_get_irq() return negative value on failure, so null check of
> ctrl->irq is incorrect. Fix it by comparing whether it is less than zero.
> 
> Fixes: ad7fcbc308b0 ("slimbus: qcom: Add Qualcomm Slimbus controller driver")
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Lv Ruyi <lv.ruyi@zte.com.cn>


There was already a patch posted to fix this

 
https://git.kernel.org/pub/scm/linux/kernel/git/srini/slimbus.git/commit/?h=for-next&id=54bf672111eef18819fa6e562f68b2d6c449b05d

--srini
> ---
>   drivers/slimbus/qcom-ctrl.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/slimbus/qcom-ctrl.c b/drivers/slimbus/qcom-ctrl.c
> index f04b961b96cd..b2f01e155d77 100644
> --- a/drivers/slimbus/qcom-ctrl.c
> +++ b/drivers/slimbus/qcom-ctrl.c
> @@ -510,7 +510,7 @@ static int qcom_slim_probe(struct platform_device *pdev)
>   	}
>   
>   	ctrl->irq = platform_get_irq(pdev, 0);
> -	if (!ctrl->irq) {
> +	if (ctrl->irq < 0) {
>   		dev_err(&pdev->dev, "no slimbus IRQ\n");
>   		return -ENODEV;
>   	}
