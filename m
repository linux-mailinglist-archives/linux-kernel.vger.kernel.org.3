Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE8958E04F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 21:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245292AbiHITkH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 15:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343707AbiHITjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 15:39:41 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84E1425E83
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 12:39:39 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-10ec41637b3so15218995fac.4
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 12:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=Y4xtVh6rKLC18LGlTT+3Ax84sybyATKEPgEJphnGXaA=;
        b=Q9o7SiOteq1Uvizzk/FQD3F00tJ4Y8n9nalK3/F7i4dhCG2b2jxGFLRH65sgKz7svA
         652UH300EuQC45ZbUKfWBy0QDOgVmZhFVRqUyn9cVeDhVBRpHR2hNP75KOvLQ3xabtBK
         E030VCSNBOkv5gRya3/FZ+RR+xHR6PUuAQ8hZlxfiOL9qe7P13+YXrv8gkXQ7JatCA1y
         0QOwL/GSciCBR9Q6xUvWLWFEyNW6sTVGosGtUlaFnHNBqllpb9yqN0y1z6kJ0y93ZPGy
         xMq+DZpqTqR/uAT6sR6TlsObN1YqPYt/0ijuqx65QDbBkVrwImvJSpI+xhxZY6cYGw0w
         DOCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=Y4xtVh6rKLC18LGlTT+3Ax84sybyATKEPgEJphnGXaA=;
        b=KBFJyTQNHOKW4kUHt9ecjPtAsn5/7nzXtHPl7x4gDe5PJvuuEEv2+BHQ7Go+D77LAJ
         q5OmsjcxAgcrxuyP/tbWKe5Ew3kL30LKGTIwieYG4HUcZjZYlGhPDmkZPycDXXeTE8Ie
         9D/g395zvDI0oIn4RPSCYclfzQiFiLlH1r5TSHyzk2zO0NYWWnUxseRk+oXcHjH0LubO
         K0Q6h+SfGIXE55CLeIw/Gmie7swLkHGNcaA3z8VhFekat5we1l4EyApgU4x/c53p4qVa
         gno/91YJc739pH8KNdkhsP19+PoB3cyeeE6vAvXD9W4zKBDgZza56vBIrpbdU8avjMv/
         X0aA==
X-Gm-Message-State: ACgBeo0r1he8z+/qTeNyHsaP10yv874lmsqj7FeIKOQSb8jYTKd+BLEp
        8BDoM4+WcOMntASMUGuT7wu5mQ==
X-Google-Smtp-Source: AA6agR6Muw5kLsPzbUDs4YBNgRzRSgmWL1i9N9XkVnNMg6+XbgYMrzTqQtStjRed3wN7adGB4jhWIA==
X-Received: by 2002:a05:6870:c0ca:b0:10d:cc1e:5c4c with SMTP id e10-20020a056870c0ca00b0010dcc1e5c4cmr40040oad.132.1660073977444;
        Tue, 09 Aug 2022 12:39:37 -0700 (PDT)
Received: from baldur ([2600:380:785a:7aa8:200:ff:fe00:0])
        by smtp.gmail.com with ESMTPSA id c8-20020a056870b28800b000f346e6d786sm3300286oao.54.2022.08.09.12.39.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 12:39:36 -0700 (PDT)
Date:   Tue, 9 Aug 2022 14:39:33 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     agross@kernel.org, konrad.dybcio@somainline.org, amitk@kernel.org,
        thara.gopinath@gmail.com, rafael@kernel.org,
        daniel.lezcano@linaro.org, rui.zhang@intel.com,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] thermal/drivers/qcom/spmi-adc-tm5: Remove unnecessary
 print function dev_err()
Message-ID: <YvK39TTGdgHV1HSb@baldur>
References: <20220809034346.128607-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220809034346.128607-1-jiapeng.chong@linux.alibaba.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 08 Aug 22:43 CDT 2022, Jiapeng Chong wrote:

> The print function dev_err() is redundant because platform_get_irq()
> already prints an error.
> 
> ./drivers/thermal/qcom/qcom-spmi-adc-tm5.c:1029:2-9: line 1029 is redundant because platform_get_irq() already prints an error.
> 
> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=1846
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> ---
>  drivers/thermal/qcom/qcom-spmi-adc-tm5.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/thermal/qcom/qcom-spmi-adc-tm5.c b/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
> index add6f40e5e2a..af68adf720cc 100644
> --- a/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
> +++ b/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
> @@ -1025,10 +1025,8 @@ static int adc_tm5_probe(struct platform_device *pdev)
>  	adc_tm->base = reg;
>  
>  	irq = platform_get_irq(pdev, 0);
> -	if (irq < 0) {
> -		dev_err(dev, "get_irq failed: %d\n", irq);
> +	if (irq < 0)
>  		return irq;
> -	}
>  
>  	ret = adc_tm5_get_dt_data(adc_tm, node);
>  	if (ret) {
> -- 
> 2.20.1.7.g153144c
> 
