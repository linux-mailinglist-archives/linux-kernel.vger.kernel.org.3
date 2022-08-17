Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6320597597
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 20:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240504AbiHQSOI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 14:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240315AbiHQSOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 14:14:04 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C020491D6;
        Wed, 17 Aug 2022 11:14:01 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id q19so12708509pfg.8;
        Wed, 17 Aug 2022 11:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=C+LRh514xAgghnbM53Ih8/rWC6o67HTiLHP6ISPuX7M=;
        b=HaK3ifiErBTWoytLjtrwqSGX3TYvwsziEjcP6RjUeKZX+STDholBFvcDp/b1l7CH3U
         v5SJw2vkIu0KFW3wfTvfgSI8q0cat9uKw0rEHjnopv7RHVyScHadplcyPu5EicxJv0bu
         9jcDQViNxIcDgnXxAqJwUU3OnqNTBXRmT53XFH8qv/X8O2VMptpNS2jcRU31iOjnd2mk
         NzJLgyRWo7EuXglvfRWChVhZ+aWd0JDNjU3O3LB+6tVFVD8Z64EURBajuH0ZCYIPojK9
         EORYFcef8mE05JPP8dVqKM5CTHs6QBDND35z8HBaYJBPTzGa0VBShDOiyPtVr8Ltthjq
         53Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=C+LRh514xAgghnbM53Ih8/rWC6o67HTiLHP6ISPuX7M=;
        b=eoRupf1yvbYmRSR0dkeHqM2RYieEI5zr5YWM161j5XUOoTOtseb+Tmi1ithHRVQ+Hl
         /2GTO6m3JvIbasxff2Lh5vqM5xT9hrtRKxYCBRN+LM4fN6JmQ+z0s1+NfKkYNpG0c8II
         H9k697NPEXhwepvrVCGaJDXNolKss3v6BfYCbSmISHguvY7nkYsi+Q/9BmLSpBtXyAMy
         9Nk1HM/imk36UUJ6M4Tjr2oM+nm5T2Es82T6bEcvtCCCOpkhpcp3u4X56LUIvDPi1mK8
         y2NcB1/KTbg3/XUyjdzoJgGU16meyaf7AVve2yLjWxvd2fYSPfDFxjMPuz9/EU7uFMge
         4Y8g==
X-Gm-Message-State: ACgBeo3o28Qllx+qOAwlL125KE7W20uSsjfSkemwoPpI0gyJ/Zov2Dm6
        pptH/gTCmFFcNPbTbQ8QLeU=
X-Google-Smtp-Source: AA6agR7r4R7jWoe61ZA4c3SNlsnN6puEn0xdpwFSyip2WMlyn2hTLqk4IthsEQOVLxJbFTccCYtXXA==
X-Received: by 2002:a05:6a00:27a0:b0:52f:8947:4cc5 with SMTP id bd32-20020a056a0027a000b0052f89474cc5mr26810917pfb.16.1660760040966;
        Wed, 17 Aug 2022 11:14:00 -0700 (PDT)
Received: from [172.30.1.52] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id d2-20020a631d02000000b0041b823d4179sm9637023pgd.22.2022.08.17.11.13.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Aug 2022 11:13:55 -0700 (PDT)
Message-ID: <ee63ca8c-28f4-bee6-77c3-ba38494005af@gmail.com>
Date:   Thu, 18 Aug 2022 03:13:48 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 4/9] clk: samsung: exynos850: Style fixes
Content-Language: en-US
To:     Sam Protsenko <semen.protsenko@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        Chanho Park <chanho61.park@samsung.com>,
        David Virag <virag.david003@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
References: <20220809113323.29965-1-semen.protsenko@linaro.org>
 <20220809113323.29965-5-semen.protsenko@linaro.org>
From:   Chanwoo Choi <cwchoi00@gmail.com>
In-Reply-To: <20220809113323.29965-5-semen.protsenko@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22. 8. 9. 20:33, Sam Protsenko wrote:
> Fix some typos in comments and do small coding style improvements.
> 
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---
> Changes in v2:
>   - (none)
> 
>  drivers/clk/samsung/clk-exynos850.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/clk/samsung/clk-exynos850.c b/drivers/clk/samsung/clk-exynos850.c
> index cd9725f1dbf7..ef32546d3090 100644
> --- a/drivers/clk/samsung/clk-exynos850.c
> +++ b/drivers/clk/samsung/clk-exynos850.c
> @@ -173,7 +173,6 @@ PNAME(mout_peri_uart_p)		= { "oscclk", "dout_shared0_div4",
>  				    "dout_shared1_div4", "oscclk" };
>  PNAME(mout_peri_ip_p)		= { "oscclk", "dout_shared0_div4",
>  				    "dout_shared1_div4", "oscclk" };
> -
>  /* List of parent clocks for Muxes in CMU_TOP: for CMU_DPU */
>  PNAME(mout_dpu_p)		= { "dout_shared0_div3", "dout_shared1_div3",
>  				    "dout_shared0_div4", "dout_shared1_div4" };
> @@ -599,7 +598,7 @@ static const unsigned long hsi_clk_regs[] __initconst = {
>  	CLK_CON_GAT_GOUT_HSI_USB20DRD_TOP_BUS_CLK_EARLY,
>  };
>  
> -/* List of parent clocks for Muxes in CMU_PERI */
> +/* List of parent clocks for Muxes in CMU_HSI */
>  PNAME(mout_hsi_bus_user_p)	= { "oscclk", "dout_hsi_bus" };
>  PNAME(mout_hsi_mmc_card_user_p)	= { "oscclk", "dout_hsi_mmc_card" };
>  PNAME(mout_hsi_usb20drd_user_p)	= { "oscclk", "dout_hsi_usb20drd" };
> @@ -963,7 +962,7 @@ static const unsigned long dpu_clk_regs[] __initconst = {
>  	CLK_CON_GAT_GOUT_DPU_SYSREG_PCLK,
>  };
>  
> -/* List of parent clocks for Muxes in CMU_CORE */
> +/* List of parent clocks for Muxes in CMU_DPU */
>  PNAME(mout_dpu_user_p)		= { "oscclk", "dout_dpu" };
>  
>  static const struct samsung_mux_clock dpu_mux_clks[] __initconst = {

Acked-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi
