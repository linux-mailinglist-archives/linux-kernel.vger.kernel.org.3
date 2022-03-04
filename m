Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 908624CCFCD
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 09:18:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232244AbiCDITK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 03:19:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232098AbiCDITI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 03:19:08 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD432198ED4
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 00:18:19 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id ay10so11475969wrb.6
        for <linux-kernel@vger.kernel.org>; Fri, 04 Mar 2022 00:18:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=KHvgGTih2dVoUEaH61oQ42JGeTYk4JGgudGnLS9971U=;
        b=u0n+IPWNbY4HzO5MAQdFq+nogfDQDq2mUjKhkhY8vQHB+CBjNtWqxy6h7vKvbG5E++
         JQ0a4Ui+PjFo7PnbPcYc1P9/V5VZwEw7AKHSanNI1+jUrTOlmlngAZSd7yzIwmND0ofm
         Noztmv14PL7HWthkf1ftO7dlbvVFtKY5qHrKL/8SKReN+rrmDzWXIbRTYPuX8FIu/q/j
         YycuDnwcrNqBm8ixbGoOYKHycgtIz3d4q1wTKEufEyDAylvgNsC4vxhy0JN7hIB0VqlW
         FoqX4oYvGSbXXW7Oa2jyowRdUMrYdyupwp8GwWiHBx8+4n351Ik2arpvC9iXI/ESO7jA
         N1jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=KHvgGTih2dVoUEaH61oQ42JGeTYk4JGgudGnLS9971U=;
        b=cy2yG5OhhSzDp4OEZEQ5seB+oJPYbdEL0epVGb+qlQtz/8OplRlepee1WnBI4qA/7e
         QzcMR5x/wOV+cOoPydcuDI8DkNAsxIFv1GngP8ZscRLp8TUNWZ2fTSpbLGd8ehmtJOYU
         WkHMAbrNSJbPFK/cSSZ3ZBCZXuqIxyqoD2bzAxzxUIZr1u/t7WZXbasmcSeYQRlDvVUD
         2Sl+b72lG4uJJcC4bvt2gg7dIQQgYAZKpRMa38rXcUwjZInjFGcKaJjzhuopPdKVHZhx
         vqvCWWXBpR9tV9XBw8KKrXaa5XJ0Bs928OsC6MPCUsd2w9cBr7kdEJab9qcp5RsvG4gR
         Cmeg==
X-Gm-Message-State: AOAM5336lQxraMfpL2fnfup0KfvMubu10SaiqQrIzAVoDYz1JeYqb5L9
        cjaaXtqDPkEGnfuaj5Q4a1AKxNLmYXMuiQ==
X-Google-Smtp-Source: ABdhPJzxdM8deXKouzdgjNPY43ykpYWNxmiMKuoUK0JBgLG1mk7sq7VRJQGPUSX50J0Z9N1xzC1ufA==
X-Received: by 2002:adf:fa8c:0:b0:1f0:47ef:a04 with SMTP id h12-20020adffa8c000000b001f047ef0a04mr6664397wrr.398.1646381897794;
        Fri, 04 Mar 2022 00:18:17 -0800 (PST)
Received: from ?IPV6:2a01:e34:ed2f:f020:551f:d79e:5d4c:9b99? ([2a01:e34:ed2f:f020:551f:d79e:5d4c:9b99])
        by smtp.googlemail.com with ESMTPSA id n5-20020a05600c3b8500b00380fc02ff76sm4783611wms.15.2022.03.04.00.18.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Mar 2022 00:18:17 -0800 (PST)
Message-ID: <5ca8ba3b-e5e0-805d-bc48-7a00d424722f@linaro.org>
Date:   Fri, 4 Mar 2022 09:18:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH -next] clocksource/drivers/imx-tpm: Move
 tpm_read_sched_clock() under CONFIG_ARM
Content-Language: en-US
To:     Nathan Chancellor <nathan@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Peng Fan <peng.fan@nxp.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, patches@lists.linux.dev
References: <20220303184212.2356245-1-nathan@kernel.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20220303184212.2356245-1-nathan@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/03/2022 19:42, Nathan Chancellor wrote:
> When building this driver for an architecture other than ARCH=arm:
> 
>    drivers/clocksource/timer-imx-tpm.c:78:20: error: unused function 'tpm_read_sched_clock' [-Werror,-Wunused-function]
>    static u64 notrace tpm_read_sched_clock(void)
>                       ^
>    1 error generated.
> 
> Move the function definition under the existing CONFIG_ARM section so
> there is no more warning.
> 
> Fixes: 10720e120e2b ("clocksource/drivers/imx-tpm: Exclude sched clock for ARM64")
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---

Applied, thx

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
