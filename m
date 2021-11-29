Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 165E246167A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 14:32:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344765AbhK2Nfr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 08:35:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240573AbhK2Ndp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 08:33:45 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFC63C08EC3F
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 04:11:16 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id o29so14391626wms.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 04:11:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=lIhJ6EWRZeDL2UKHWmc3PShBzOOTPj2dGPU3mDr8HSo=;
        b=bsz0i8NaAFaHr5IFai9RSvyF7VWu2B9E78KIzsWH6pb53V7LuuwD5JwoGCt7SEO9pa
         mPBnc7X5hQ0Zf7iZcylyHeKAXK0CNFXXbUlaKPdsegH9xMD+yCmebUUT+COOnChfqKGv
         PTkG0K8mnzm0mqtcwWMdx442mfG47rlLcGYp9j0rBSNJ8mbGq9BFnZIlZdnjSa244m4B
         REFi7mugs/30ISUiPbxibHceiH6Bgcj5dlP7x6nJpwqXZ5DN9vFiGp4DBtqWeXvJZ7hB
         n1cW74UaLHXyLjKGWG0aQxUIa6R9YQNHOzXYQg7f8RK8WcBhhTKQG3ApCElbyS6NcR1V
         gUQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=lIhJ6EWRZeDL2UKHWmc3PShBzOOTPj2dGPU3mDr8HSo=;
        b=7XWJJK1WJBylkN0s4qsKYEPDtuytYDA4cdupLtNa+Mz63R5bg9kYLodxB5gU8VEY0j
         h6LKYjR6PP94QY55YZFV+/l9wxBjzSm8kRlwoAi4nvS11Q2l4wo2eLYYuRNzARFxunPb
         6D0hwh4l/+B0l3GdfqTdam4iBKgb/xsbkSpuDtGtUSbg1UDn8YFRIKGFOdt7TFHS/HXy
         O+RmSU0JC+0JkyXauNYtsoplrb/OmoWxRYGZtH/N5/V0lYu0LvTHZOt+divLpVvyZU+E
         6AYaHPGT4kEgfxXJPdAUSOv3r5WJiITZRq4fUwE4OR2lqcM+OY/g5uAMcR/NbFi8Aw7w
         VeNw==
X-Gm-Message-State: AOAM531Z2ym3HP68WBe6bf2jKMwJIzuxpzO/nW0yOVHsGgqVcv7R2C2R
        vTTQGhoE2UhIvIumQVFats9NGg==
X-Google-Smtp-Source: ABdhPJzPcOdHh4KliSQQfIZR3SKJcWQ1+425UAkltZhFR29Fpq2r7uhw28kwZKcNZGdxpsHfBIfCWw==
X-Received: by 2002:a05:600c:3541:: with SMTP id i1mr37500315wmq.124.1638187875372;
        Mon, 29 Nov 2021 04:11:15 -0800 (PST)
Received: from google.com ([2.31.167.18])
        by smtp.gmail.com with ESMTPSA id l18sm14009993wrt.81.2021.11.29.04.11.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 04:11:14 -0800 (PST)
Date:   Mon, 29 Nov 2021 12:11:13 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Orlando Chamberlain <redecorating@protonmail.com>
Cc:     andriy.shevchenko@linux.intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2] mfd: intel-lpss-pci: fix clock speed for 38a8 UART
Message-ID: <YaTDYUORb6Zi52wt@google.com>
References: <20211124091846.11114-1-redecorating@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211124091846.11114-1-redecorating@protonmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Nov 2021, Orlando Chamberlain wrote:

> This device is found in the MacBookPro16,2, and as the MacBookPro16,1 is
> from the same generation of MacBooks and has a UART with bxt_uart_info,
> it was incorrectly assumed that the MacBookPro16,2's UART would have the
> same info.
> 
> This led to the wrong clock speed being used, and the Bluetooth
> controller exposed by the UART receiving and sending random data, which
> was incorrectly assumed to be an issue with the Bluetooth stuff, not an
> error with the UART side of things.
> 
> Changing the info to spt_uart_info changes the clock speed and makes it
> send and receive data correctly.
> 
> Fixes: ddb1ada416fd ("mfd: intel-lpss: Add support for MacBookPro16,2 ICL-N UART")
> Signed-off-by: Orlando Chamberlain <redecorating@protonmail.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> v1 -> v2: Remove blank line in tag block, add Reviewed-by.
>  drivers/mfd/intel-lpss-pci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
