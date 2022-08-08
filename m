Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D16A58C24A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 06:14:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231739AbiHHEO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 00:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231263AbiHHEOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 00:14:24 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFF61B847
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 21:14:23 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-10ee900cce0so9325308fac.5
        for <linux-kernel@vger.kernel.org>; Sun, 07 Aug 2022 21:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=qmLBxFW+3s+rCmQcO8LAZd85qoQ4WtG1SRphg8cshdY=;
        b=aQe40ynVPeQxBTcCJez+hV9n972g8nFlngA7qNiWeuOD7UL705xTobhQf5AK4kN3jK
         zI9Wwrn475srTl53VcrJmgUpAEH73qUwwpDPzylyogm3CrhDy5U88ESEFyhOlWNiwybR
         nsb6HQO0r1MEY67ropqdZgAQjxEg9rJeK+zvwQtrVdHPcQTNyyuGuI6be0sc1T26Jy9G
         LVlJgHXpEWd72snf/DI35geV8DPBQ5GNaPMEDm0SZzIFDbTcXf3fy/NOs6/of04FYDq7
         3qLTQ1RckM8nylEw1PHbPCmNvuXRsC8iuZXU8sH0Fxzxai7hwmHbuvrsLgP3HcOUkVYI
         +jbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=qmLBxFW+3s+rCmQcO8LAZd85qoQ4WtG1SRphg8cshdY=;
        b=7QAizuJ9shPVAgz1oO/bX7YdikY4atd9vQvBaCsvmrb38hnoX+nOV8pftsY1p7ClWD
         3J2lLNlL196y+sK4g6UaaOZsGkh2sq3C44xzMJ2YBuMoZtQUkTRvMAhVW1WB7Pne968E
         9k1B+AxACA11n9pNykQ1RjhOlFzhTkWpA3h2vkjmwRthggVmehvW31cEfzFjzuaNL2aZ
         uJAIIiDSdxUwXxKBALc+uZCHOLQBwX54qB2QKcnfLZLOdpR0mrqhPKxw5kAXUMq2tSWU
         Ew0iI9l/Wz03+Ld7NnwtST1ygDRcYSJE1AkM+ZnXPxg0OtQNEjkbnwMlhiAons5Bboxs
         daUA==
X-Gm-Message-State: ACgBeo3dCATpsI/Xv5xnxDbrdHGBYiYMQVf4B0h6e5E77Eh7hpyD4NPl
        P/2Is5zrE8qFOBUJToricITt2g==
X-Google-Smtp-Source: AA6agR7eKw+LY/1AYw4Clvjj3N7KQ2qVzP8/QS88PQyLyxWL4cigwgsrj5QDPvrVAq1rFHRLHZkALA==
X-Received: by 2002:a05:6870:32cb:b0:10c:289b:76ba with SMTP id r11-20020a05687032cb00b0010c289b76bamr11677580oac.72.1659932062441;
        Sun, 07 Aug 2022 21:14:22 -0700 (PDT)
Received: from ripper (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id n21-20020a9d7115000000b00636df4fd5eesm548322otj.34.2022.08.07.21.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Aug 2022 21:14:21 -0700 (PDT)
Date:   Sun, 7 Aug 2022 21:17:02 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Molly Sophia <mollysophia379@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] pinctrl: qcom: sc8180x: Fix wrong pin numbers
Message-ID: <YvCOPn85G3tKlc/l@ripper>
References: <20220807122645.13830-1-mollysophia379@gmail.com>
 <20220807122645.13830-3-mollysophia379@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220807122645.13830-3-mollysophia379@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 07 Aug 05:26 PDT 2022, Molly Sophia wrote:

> The pin numbers for UFS_RESET and SDC2_* are not
> consistent in the pinctrl driver for sc8180x.
> So fix it.
> 
> Signed-off-by: Molly Sophia <mollysophia379@gmail.com>

Fixes: 97423113ec4b ("pinctrl: qcom: Add sc8180x TLMM driver")
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  drivers/pinctrl/qcom/pinctrl-sc8180x.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pinctrl/qcom/pinctrl-sc8180x.c b/drivers/pinctrl/qcom/pinctrl-sc8180x.c
> index b4bf009fe23e..704a99d2f93c 100644
> --- a/drivers/pinctrl/qcom/pinctrl-sc8180x.c
> +++ b/drivers/pinctrl/qcom/pinctrl-sc8180x.c
> @@ -530,10 +530,10 @@ DECLARE_MSM_GPIO_PINS(187);
>  DECLARE_MSM_GPIO_PINS(188);
>  DECLARE_MSM_GPIO_PINS(189);
>  
> -static const unsigned int sdc2_clk_pins[] = { 190 };
> -static const unsigned int sdc2_cmd_pins[] = { 191 };
> -static const unsigned int sdc2_data_pins[] = { 192 };
> -static const unsigned int ufs_reset_pins[] = { 193 };
> +static const unsigned int ufs_reset_pins[] = { 190 };
> +static const unsigned int sdc2_clk_pins[] = { 191 };
> +static const unsigned int sdc2_cmd_pins[] = { 192 };
> +static const unsigned int sdc2_data_pins[] = { 193 };
>  
>  enum sc8180x_functions {
>  	msm_mux_adsp_ext,
> -- 
> 2.25.1
> 
