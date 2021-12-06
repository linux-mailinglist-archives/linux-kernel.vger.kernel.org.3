Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D37C469FC3
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 16:54:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441843AbhLFPvo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 10:51:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358844AbhLFPic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 10:38:32 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C3B6C08EB2A
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 07:24:28 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id a23-20020a9d4717000000b0056c15d6d0caso13992486otf.12
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 07:24:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4VchXGJRi71YWOB3jfH3EvBS4JbDgo7AC6aCyYRNxBo=;
        b=hRBhG4h3uAW80lbyu5dGURg+fH9Rklm6Q1dqgkwjDS1YPldKKhm1kxwSdvOQk9F6xY
         HQm0jRriMz15FczzIezD0t1LHyQQpg4TUT2QuiE0HKS9N4n4UiHpFZ1X8svb+02nJCSj
         lN5hQBzVtC0a4ooTSmIguHWeWPl1UuZGeMxDXV4kPzGmlOe2Ceqt6NAK34oj8FxI5rZ1
         BLAWfEpXN71e92fNXx8KzDsVN0i80mBYtkf7tTpVCcdtfRWwpqN34duabRcvLTDyNyOb
         PIL6SW/1IU+Psqg6sYBB8YllygFRB21Y6/RxftM6ucBGLHSgjoFp/6Nfo1ACDB69PQ4b
         b2tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4VchXGJRi71YWOB3jfH3EvBS4JbDgo7AC6aCyYRNxBo=;
        b=U1+zP8V4bKKyIWCYm1ZS71mzOkzgWEsoYk0RXYmnfPUcdVXI86mUrPmEZJP18CDxHA
         Ot0lm4qFVbs6adPF1kdBv87VOZtwjZeo58EsSHk3AwdQNWmfA3SWNcBzza6N9BQxRrAS
         Vfq3GeloQe4nZ3yuy/CczFk7aSn/k1GTTDWIyiLWColA62/1y5f+1mGHLqIXbkMt5Bkl
         OiqA4LqKGJSwO5sbvlzJwuB1pf7uBGafBniGZqyTPUrSONNjixCzoqUYpcxeYUGGt7HT
         5fN3gNyWbKTV/Br7G6fZ6ALQ+r08jq6bF/5YAtMsKOlUadDNGYXC3Kd2VWZF+ACIYP/2
         lV+Q==
X-Gm-Message-State: AOAM5313VRo53MvgpBltOJUSguQzYaIvXtjXtIjTUi3wEG/d4Eqq5/v/
        Bd7QdMMBmQKUZ4Y51nXV0i/j/A==
X-Google-Smtp-Source: ABdhPJxX+a16IMjtH56euBWFjix7tt/mv2Fzl9Hcocp1woXhLoe0dpZYb84hSpzPcBa+ihCCPyJXYQ==
X-Received: by 2002:a9d:ed6:: with SMTP id 80mr29824055otj.35.1638804267774;
        Mon, 06 Dec 2021 07:24:27 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id bf17sm2888192oib.27.2021.12.06.07.24.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 07:24:26 -0800 (PST)
Date:   Mon, 6 Dec 2021 09:24:21 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Shawn Guo <shawn.guo@linaro.org>
Cc:     Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] clk: qcom: smd-rpm: Drop the use of struct rpm_cc
Message-ID: <Ya4rJUU6tBOw3cGw@builder.lan>
References: <20211031020715.21636-1-shawn.guo@linaro.org>
 <20211031020715.21636-3-shawn.guo@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211031020715.21636-3-shawn.guo@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 30 Oct 21:07 CDT 2021, Shawn Guo wrote:

> Considering that struct rpm_cc is now identical to rpm_smd_clk_desc,
> and function qcom_smdrpm_clk_hw_get() uses rpm_cc in a read-only manner,
> rpm_cc can be dropped by getting the function use rpm_smd_clk_desc
> directly.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> ---
>  drivers/clk/qcom/clk-smd-rpm.c | 21 ++++-----------------
>  1 file changed, 4 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/clk/qcom/clk-smd-rpm.c b/drivers/clk/qcom/clk-smd-rpm.c
> index a27c0e740ab7..dd3d373a1309 100644
> --- a/drivers/clk/qcom/clk-smd-rpm.c
> +++ b/drivers/clk/qcom/clk-smd-rpm.c
> @@ -150,11 +150,6 @@ struct clk_smd_rpm_req {
>  	__le32 value;
>  };
>  
> -struct rpm_cc {
> -	struct clk_smd_rpm **clks;
> -	size_t num_clks;
> -};
> -
>  struct rpm_smd_clk_desc {
>  	struct clk_smd_rpm **clks;
>  	size_t num_clks;
> @@ -1157,20 +1152,19 @@ MODULE_DEVICE_TABLE(of, rpm_smd_clk_match_table);
>  static struct clk_hw *qcom_smdrpm_clk_hw_get(struct of_phandle_args *clkspec,
>  					     void *data)
>  {
> -	struct rpm_cc *rcc = data;
> +	const struct rpm_smd_clk_desc *desc = data;
>  	unsigned int idx = clkspec->args[0];
>  
> -	if (idx >= rcc->num_clks) {
> +	if (idx >= desc->num_clks) {
>  		pr_err("%s: invalid index %u\n", __func__, idx);
>  		return ERR_PTR(-EINVAL);
>  	}
>  
> -	return rcc->clks[idx] ? &rcc->clks[idx]->hw : ERR_PTR(-ENOENT);
> +	return desc->clks[idx] ? &desc->clks[idx]->hw : ERR_PTR(-ENOENT);
>  }
>  
>  static int rpm_smd_clk_probe(struct platform_device *pdev)
>  {
> -	struct rpm_cc *rcc;
>  	int ret;
>  	size_t num_clks, i;
>  	struct qcom_smd_rpm *rpm;
> @@ -1190,13 +1184,6 @@ static int rpm_smd_clk_probe(struct platform_device *pdev)
>  	rpm_smd_clks = desc->clks;
>  	num_clks = desc->num_clks;
>  
> -	rcc = devm_kzalloc(&pdev->dev, sizeof(*rcc), GFP_KERNEL);
> -	if (!rcc)
> -		return -ENOMEM;
> -
> -	rcc->clks = rpm_smd_clks;
> -	rcc->num_clks = num_clks;
> -
>  	for (i = 0; i < num_clks; i++) {
>  		if (!rpm_smd_clks[i])
>  			continue;
> @@ -1222,7 +1209,7 @@ static int rpm_smd_clk_probe(struct platform_device *pdev)
>  	}
>  
>  	ret = devm_of_clk_add_hw_provider(&pdev->dev, qcom_smdrpm_clk_hw_get,
> -				     rcc);
> +					  (void *)desc);
>  	if (ret)
>  		goto err;
>  
> -- 
> 2.17.1
> 
