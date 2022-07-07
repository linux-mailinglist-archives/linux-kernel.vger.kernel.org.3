Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5836D56AB98
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 21:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236784AbiGGTNX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 15:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236771AbiGGTNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 15:13:22 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B0845C967;
        Thu,  7 Jul 2022 12:13:21 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id g126so6875069pfb.3;
        Thu, 07 Jul 2022 12:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=+a9U/lrXZB0DRTtUvI77chx5EBjon1Z1z5u0IXVmPOI=;
        b=F9euu/HZZkDKNjM/tZASNqPe47V2r8DieCF2kaekE86LIqKto8U0683wc9BikUsdYa
         n3wLY/1Tu/SSPMB4SQpSirRbTzl/rfVR5FiK+g452qcm9E/PGgHvoyXNT3RC1wScR8NR
         19GcX5RBC1I1l1umdETLz2A2k6DGQxh2zUVIchqI3W+G/kfoRraeZUH4Df6uaxnc5D9a
         2vmSBYtJ/s9frF4T8Q8ccmcfqUK+6oP8X9w2OJq6NteIt0QdWbOYvp8sLYBVztEToO2p
         0FIhx3JrJAbBWFI4h0zsHsQMvqQHetZe5JBH/oMY6btUZVykR5q6Sv++3JobV7RbGMth
         PmhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+a9U/lrXZB0DRTtUvI77chx5EBjon1Z1z5u0IXVmPOI=;
        b=iYzVonqMNQ+ihhwWUlg46BkDdBGhshdawtM59TG91u7Jfp4OQUa6XUvGUNgc0ZVOeA
         oTzdRhtJt8kTe6y2QzVBOUmUFLNDJ43d9RQbtQwt1uPh9+shFI5unx2LLs91NMJ+3p3D
         ImhOn90jIXhVS89/ReQ86xzquUX9uJmd20qVq1vnb59I2E2fFmlZXTggBeqEsmifvLx/
         dmRYG2kQ3lybDNK9qDDk9XBB5qf1mvmKJa8vvphnm38Pzl08Y8biDrtQVDDEpR2MupTn
         t5QvNKcbJOItPtqOEZ/PFNAoHayBK6kXGGtrlfX6nGc2c22MmFuGgbwqB9+N8cAjxagL
         1tKg==
X-Gm-Message-State: AJIora8zpRbJEmV9f+RtEvxCVD+wDMct6DkEDuPNN5f/y5DW/Io2s3CF
        0Ute8cVE3A5e6WACgPHISbxf4z400uU=
X-Google-Smtp-Source: AGRyM1sy6XlJfeuSwtPQidiBf+mNaxZmwOgBDYCy3EgvWnPppdyIQrwHaj5IRbsCQCvR8svwBwsRVQ==
X-Received: by 2002:a17:902:d50b:b0:16c:474:ce67 with SMTP id b11-20020a170902d50b00b0016c0474ce67mr9653986plg.112.1657221200953;
        Thu, 07 Jul 2022 12:13:20 -0700 (PDT)
Received: from [172.30.1.47] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id s10-20020a170902ea0a00b0016c1efb9195sm309937plg.298.2022.07.07.12.13.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Jul 2022 12:13:20 -0700 (PDT)
Message-ID: <37298477-b25d-ce84-67eb-091f6e0e5f73@gmail.com>
Date:   Fri, 8 Jul 2022 04:13:19 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v1] PM / devfreq: tegra30: Add error message for
 devm_devfreq_add_device()
Content-Language: en-US
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220630075751.1360786-1-dmitry.osipenko@collabora.com>
From:   Chanwoo Choi <cwchoi00@gmail.com>
In-Reply-To: <20220630075751.1360786-1-dmitry.osipenko@collabora.com>
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

On 22. 6. 30. 16:57, Dmitry Osipenko wrote:
> It's difficult to notice that driver failed to probe by looking at KMSG
> when devm_devfreq_add_device() fails. Add explicit error message for this
> case.
> 
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> ---
>  drivers/devfreq/tegra30-devfreq.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
> index 30382bdfc655..f0d414b881e3 100644
> --- a/drivers/devfreq/tegra30-devfreq.c
> +++ b/drivers/devfreq/tegra30-devfreq.c
> @@ -926,8 +926,10 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
>  
>  	devfreq = devm_devfreq_add_device(&pdev->dev, &tegra_devfreq_profile,
>  					  "tegra_actmon", NULL);
> -	if (IS_ERR(devfreq))
> +	if (IS_ERR(devfreq)) {
> +		dev_err(&pdev->dev, "Failed to add device: %pe\n", devfreq);
>  		return PTR_ERR(devfreq);
> +	}
>  
>  	return 0;
>  }

Applied it. Thanks.

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi
