Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CB5657B473
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 12:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234526AbiGTKZc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 06:25:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233360AbiGTKZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 06:25:30 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CAFFE0C4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 03:25:29 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id d16so25451570wrv.10
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 03:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=yejlrYISSFvhPNBKBdxPZvCzF3/CE0/YpMN2GnONxr4=;
        b=sYQhUBG62rxyDAci/Tms08U2qkKt3Np3EY5j29crS/8TSutBlBXpXsxu21EOroVzzO
         z3OX17bQ468fhmS3sQap454H4jl/eLMVKdAx8zl5NpPQND2C6NTbL9WLFOIuxDwCLb7M
         Hzip5AXITWaoIqx6OD+WN9oCVsGCD9MR78XBBLSJt+/l0ZLGgoRJOJQRPSwRVXMEY0pc
         wD86/tD5zIq0T4YISfadrOwgk1L/sYNCjitGV2WCr/Qa60jZHIufoHK6opqHGzl6xfIa
         6IcfDR4Aj/OpmRtq1sqLxlynlIJczDDt6Lzhl/XTzc0jO6CtL3vCbQ/msxoJmMwW/Q9C
         FA0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=yejlrYISSFvhPNBKBdxPZvCzF3/CE0/YpMN2GnONxr4=;
        b=opzM19mJppIRA5J4yGCbVr20whotrFFkCf1Aq3gjYv/ld2DXrwm56Tdt46Zp743alI
         ptEed34v3w6Dc2pfHG80XchG55h+sxRYgTe0U0cDBezIQ2Av/Z/9llSMo2wB3AGgdyI+
         nVLLKi0Xpuukpc+MrbRVaYT39GAEkhnP+mJWq1Cb+qRRVJx0vPga4kUseBP3hSeX2hP5
         WoChyOHf8cgyfLdpNIiWw/Y6d3wiuA1497TRdF+L9Oh5GvVIB/wX0Z1UGNV4ChPEGTV+
         /HzK3F2N9oC4Jo6xB2PA7DCVXI/hstbzG+HIg7jIjxSVx9RL0yH0A1Y83FTCy8VaKF3g
         xpjg==
X-Gm-Message-State: AJIora99fp9ow/B+sIjnbuLQfLvcSQw4ZAjmRMxd9nWdqSAuhAFcIl2I
        Va+6WA0bJofcD15zjdTXPmFy0Q==
X-Google-Smtp-Source: AGRyM1ubms2QeI4CFrNlI7wGZGAyw8ZhcZq3U30rSIxFd1xLqoC+dvvDB5eDe3YHJXftDWwxykpcbw==
X-Received: by 2002:adf:fb43:0:b0:21a:22eb:da43 with SMTP id c3-20020adffb43000000b0021a22ebda43mr30106888wrs.347.1658312727696;
        Wed, 20 Jul 2022 03:25:27 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:b579:e7b5:219d:267c? ([2a05:6e02:1041:c10:b579:e7b5:219d:267c])
        by smtp.googlemail.com with ESMTPSA id c7-20020a05600c0a4700b003a31f71c5b8sm2398969wmq.27.2022.07.20.03.25.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jul 2022 03:25:27 -0700 (PDT)
Message-ID: <43bc1bf8-a734-e184-e38f-5e2f16a31f1b@linaro.org>
Date:   Wed, 20 Jul 2022 12:25:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH -next] thermal/drivers/u8500: Remove unnecessary print
 function dev_err()
Content-Language: en-US
To:     Yang Li <yang.lee@linux.alibaba.com>, rafael@kernel.org
Cc:     amitk@kernel.org, rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220719003556.74460-1-yang.lee@linux.alibaba.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20220719003556.74460-1-yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/07/2022 02:35, Yang Li wrote:
> The print function dev_err() is redundant because platform_get_irq()
> already prints an error.
> 
> Eliminate the follow coccicheck warnings:
> ./drivers/thermal/db8500_thermal.c:162:2-9: line 162 is redundant because platform_get_irq() already prints an error
> ./drivers/thermal/db8500_thermal.c:176:2-9: line 176 is redundant because platform_get_irq() already prints an error
> 
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
