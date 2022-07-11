Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 405AC56D852
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 10:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbiGKIjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 04:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbiGKIjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 04:39:19 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E67A0222BE
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 01:38:22 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id be14-20020a05600c1e8e00b003a04a458c54so2582722wmb.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 01:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Kgo58hYFJMv0Dv334lipPvuc1y1O+OqlmbGXxQSTx84=;
        b=K8QZKZgydQK0fXlg54LgQ12ser5eS7Q8wd5H94r6dkqIc0tbXKk53fkUAtZs7z7Tq6
         tTkGPJbzjvV0G5G6DXlsjA0m6eWg4DDVcXeQPjVv6vAoDl44uOSXhMsNkKNWndb+oY0X
         eYNeBnkeOu2/9vDJummfHTru7bzQXMnzB5tKzxN9GfTqf+Oi5kGEdbltWyhtVA/nZ5Iv
         WJz0diNVvFyp9D2/vn5h5wLZdJlsQtrBNWIWvWAp6UbohHZnqwTA/98syJTO/zU4MIHT
         b9ZI3BiqXMh3E7ST6/grY8HLKCqChVKhkMcuGp6Z6GjD+XgGJ6qvBpZTlD2t4XinimGp
         EnBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Kgo58hYFJMv0Dv334lipPvuc1y1O+OqlmbGXxQSTx84=;
        b=UhjF28ON+knPH2H97AJhulK1OuIdWu4+2WxaRLq4mAn9j6fpDze+eYe64TC/8KfRu/
         yZJyEkKalGJQPw+sWbAhjUjzNt3q48k8LWKy5bolHIk5W80kXMQIqGNXWYJmQKCiutAU
         ydZVZJLC76TWg1idcyBNYlizCtgFTjHaCKgsUUgSE+8v4oEHiGg6SFsidaitJIgLc9m2
         Udju/GGBaVL1GItanrzvu/RYYkBPqnJ+Eq4JmMBdoKhaA5hcfy5iAzMgCkT1p4vp6zaM
         GVzVRtVfuFmK2tPxWkEVY5+kD794NOjLp6ONYe7xkeFXfalQMTvOcxkhW4WxLJNEOXnS
         7QjQ==
X-Gm-Message-State: AJIora/cR7s4iYkgM/m+/CEKA/TsXZ5vkpFeYXU3T40CsGwaDk4JTdW/
        Ey3z0uZoim3PCej0j40AcJ4TGM/FdXajKA==
X-Google-Smtp-Source: AGRyM1tll8h9ClZT0BKRzXJTL8n72YZiTNj7I0xCeHV15MfD2ops0UsjrKo/4GklacsIdmqhbpeNig==
X-Received: by 2002:a1c:7703:0:b0:3a2:d01c:c4e9 with SMTP id t3-20020a1c7703000000b003a2d01cc4e9mr15000947wmi.200.1657528701322;
        Mon, 11 Jul 2022 01:38:21 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id g6-20020a5d64e6000000b0021d887f9468sm5146668wri.25.2022.07.11.01.38.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 01:38:20 -0700 (PDT)
Date:   Mon, 11 Jul 2022 09:38:19 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v2 10/11] mfd: intel_soc_pmic_bxtwc: Drop unneeded casting
Message-ID: <YsvheyLSWVrCiHLE@google.com>
References: <20220628221747.33956-1-andriy.shevchenko@linux.intel.com>
 <20220628221747.33956-10-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220628221747.33956-10-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Jun 2022, Andy Shevchenko wrote:

> The casting from size_t to ssize_t is not needed in addr_store(),
> drop it.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> ---
> v2: added tag (Lee)
> 
>  drivers/mfd/intel_soc_pmic_bxtwc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
