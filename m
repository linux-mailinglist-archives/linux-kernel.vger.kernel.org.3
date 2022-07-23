Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E5EF57EEB2
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 12:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239506AbiGWK0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 06:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239463AbiGWKZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 06:25:56 -0400
Received: from smtp.smtpout.orange.fr (smtp-25.smtpout.orange.fr [80.12.242.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B83C1558F1
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 03:15:47 -0700 (PDT)
Received: from [192.168.1.18] ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id FCAfojRi96UQiFCAfo9DSp; Sat, 23 Jul 2022 12:15:45 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sat, 23 Jul 2022 12:15:45 +0200
X-ME-IP: 90.11.190.129
Message-ID: <a7096e65-14e3-5a99-e34d-fe924a753591@wanadoo.fr>
Date:   Sat, 23 Jul 2022 12:15:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3 3/3] clk: qcom: Add global clock controller driver for
 SM6375
Content-Language: fr
To:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        ~postmarketos/upstreaming@lists.sr.ht
Cc:     martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org
References: <20220723100135.91784-1-konrad.dybcio@somainline.org>
 <20220723100135.91784-3-konrad.dybcio@somainline.org>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20220723100135.91784-3-konrad.dybcio@somainline.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 23/07/2022 à 12:01, Konrad Dybcio a écrit :
> Add support for the global clock controller found on SM6375.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> ---
> Changes since v2:
> - use parent_hws where applicable
> 
>   drivers/clk/qcom/Kconfig      |    8 +
>   drivers/clk/qcom/Makefile     |    1 +
>   drivers/clk/qcom/gcc-sm6375.c | 3931 +++++++++++++++++++++++++++++++++
>   3 files changed, 3940 insertions(+)
>   create mode 100644 drivers/clk/qcom/gcc-sm6375.c
> 
> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
> index 415ae4ffab48..ef81eda01649 100644
> --- a/drivers/clk/qcom/Kconfig
> +++ b/drivers/clk/qcom/Kconfig
> @@ -672,6 +672,14 @@ config SM_GCC_6350
>   	  Say Y if you want to use peripheral devices such as UART,
>   	  SPI, I2C, USB, SD/UFS, PCIe etc.
>   
> +config SM_GCC_6375
> +	tristate "SM6350 Global Clock Controller"

Nit: SM6375?

> +	select QCOM_GDSC
> +	help
> +	  Support for the global clock controller on SM6375 devices.
> +	  Say Y if you want to use peripheral devices such as UART,
> +	  SPI, I2C, USB, SD/UFS etc.
> +
