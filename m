Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 340A4548366
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 11:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239488AbiFMJnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 05:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240222AbiFMJm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 05:42:57 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB5A61901E
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 02:42:56 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 31so3422100pgv.11
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 02:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5NDzvjfMCFAmFHxCoKwikhbXpxpjUpoHP86mEjsNFxE=;
        b=tV+cQALK9x1tNg/BbmFnfN0bRTWtZ1BjT8fDQUmuAnRlR+cwjJzeKjRRz/rk+5TcqA
         +csmsHauEhIUz/f5UL/0zjmFPxiZ0POufJwmu/fO7Yp3Z0WtdH07ujK/0LScYrKgE3ID
         a3Y+mEfy4tiRzTepXEDzXuTd/CuBlCwxbx8ih4cx3cLaaXNRoBlS0VQoYN+QhK7G4Axt
         R+lahczlw/lWfAPPTRW35Guy1XtK0LKdnWHBEujT3comrEL69bbSNXMS3cFvzE8v0q66
         QO8sXeDblmxKpOThR5w32Mnwa4LV0st+zdIxI9A/11WiVUQYkyYbZwzn6cFAeGn9V9Mi
         PE/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5NDzvjfMCFAmFHxCoKwikhbXpxpjUpoHP86mEjsNFxE=;
        b=7tu8W+yImWTXRW06ANc2PXgSa5XAHdkP2Cj4M1jcO5q/N09t9y2Bnw9ZE+cFTPr+LQ
         8cafmcUcW81mWpO60sS8ebTjsMgyskPAskDBmsiL/A+1205O5nvF5tfMpRjKrBFMRexE
         ApsA07CmHDbs1FyWlsoNiLg3uTFoT64mDBoO0xYhbm67ptOEQ6YCZfyTZhcTxAxFL8zy
         RsSMCaV75q8YdSV2Ul5+13LPJ0JBGW8+zFAI3IdtYPLIMMN1oT5c+kxOu9RcB9v/Aysx
         ET8Hmb1zJiyuOLre8HKVbwXu+VfQSJvFiN8qhYKP8cbtzK8JSnbFiYjAy3yZe1Uc6HsA
         nSAQ==
X-Gm-Message-State: AOAM533mHo7K5me5JrmMbltL4M+yCyaZOK0bZ8R/jdbSvGbEP4fzi1KY
        jhwu5yDgltv4YypPe1VvxakpLQ==
X-Google-Smtp-Source: ABdhPJxjz+VO42wkE/kKNwDgTRF7V0OVwIiStEG8cJtl1IBzCbp8uJNbykZw81bRmctnpW6uw7iH8w==
X-Received: by 2002:a63:da56:0:b0:3fe:2bc7:a605 with SMTP id l22-20020a63da56000000b003fe2bc7a605mr24918350pgj.560.1655113376408;
        Mon, 13 Jun 2022 02:42:56 -0700 (PDT)
Received: from localhost ([122.162.234.2])
        by smtp.gmail.com with ESMTPSA id jd13-20020a170903260d00b00168adae4ea2sm4631032plb.39.2022.06.13.02.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 02:42:56 -0700 (PDT)
Date:   Mon, 13 Jun 2022 15:12:53 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        daniel.lezcano@linaro.org, amitk@kernel.org, rui.zhang@intel.com,
        rafael@kernel.org, dietmar.eggemann@arm.com
Subject: Re: [PATCH 3/3] thermal: cpufreq_cooling: Update outdated comments
Message-ID: <20220613094253.36qukzq2vuat3ey6@vireshk-i7>
References: <20220610100343.32378-1-lukasz.luba@arm.com>
 <20220610100343.32378-3-lukasz.luba@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220610100343.32378-3-lukasz.luba@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10-06-22, 11:03, Lukasz Luba wrote:
> The code has moved and left some comments stale. Update them where
> there is a need.
> 
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>  drivers/thermal/cpufreq_cooling.c | 44 +++++++++++++------------------
>  1 file changed, 18 insertions(+), 26 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
