Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1234569D78
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 10:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234252AbiGGIbP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 04:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbiGGIbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 04:31:14 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39C974D4C3
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 01:31:13 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id z12so15626855wrq.7
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 01:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=iEpJ0Faa5HinvvV8LbrdCivzlY1w4WWTlez8JQQ0Tqw=;
        b=hDhr2Tsswdl0BgVCFzv2nbBSNGEEsvCRgOaBeLa7ElSnrfaBGZCSrSKOHMigXxUaRk
         Akg9tzuYKLrHHONclkQqdFIXwhQKKxlMjJ3x92IiyTXMiGQh5ClJR+X8HJ6MFnqL7hJq
         bkNIzrg6ymYGWNME2LrM1NfWvzQuI0PzcZhJ54BhJxKve+tR5c9ZUBDG5fpoEo4B0frc
         J4JDS7EqAAvcdBXyvUojXo5KjIetPZMxlw4xm7JXC5MrH8ghwSCtzTitLyfYZP4qC9aU
         c/mxtj+SAMLb8Ec4iWiDp64ygRxvgZ0BSxzRKGZrEAa0V+AGbvnUKlOFasa16QFEHzv2
         HqgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=iEpJ0Faa5HinvvV8LbrdCivzlY1w4WWTlez8JQQ0Tqw=;
        b=awhYaeUjODvXkMb0KLUXrp7YFosofZ2vBgp2mvQN7sqZxS4EllBiZsCZ+UhUMkvDDq
         f+pFSAHdwLzXP/CSYfmpqBE7YxAsMm3ZCVvj/p7eFVrRXL+PheISROEVB2UPpGnprKud
         7e5gqQKgcJ9uO5SEsYr3ScCv9Z+AGmmuS/dTqFFULUzAuk/SBUy61YUvlv2u9xglxYx8
         HbjNahH8RRw/zW71U7ryZQwkC9/J2x0s77YAlVVGYKi7m9urF7EQZ+pmWvqMEq0T9zTK
         7t+IP0GXEKyLeWLMHzKHLZD8ejZWqWuKLzNQTjoiqoVAaas82glnmnmW+PdxCO2QU4Rl
         d3eQ==
X-Gm-Message-State: AJIora+15rHUdEXtgeRPp7y+MxGmO172FTgf5KeXy9G+1Pei3aq3Hn6Q
        ViEKO3/pxnV1w60AUkbbtgXfNA==
X-Google-Smtp-Source: AGRyM1sMvogXLR0SM3XrhPZifE5icXaMEbUXIgBNN7AIe+ZKwqUr0Lzy8U6Gveurz7cEokhdBJW4qw==
X-Received: by 2002:a05:6000:178d:b0:21d:7de8:de76 with SMTP id e13-20020a056000178d00b0021d7de8de76mr7010531wrg.624.1657182671527;
        Thu, 07 Jul 2022 01:31:11 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id v3-20020adfedc3000000b0021d76a1b0e3sm6116552wro.6.2022.07.07.01.31.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Jul 2022 01:31:10 -0700 (PDT)
Message-ID: <9b4bd8b5-d5d9-7f75-128a-87b727ad0bd7@linaro.org>
Date:   Thu, 7 Jul 2022 10:31:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 1/4] PM: EM: convert power field to micro-Watts
 precision and align drivers
Content-Language: en-US
To:     Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     amitk@kernel.org, rui.zhang@intel.com, viresh.kumar@linaro.org,
        rafael@kernel.org, dietmar.eggemann@arm.com, nm@ti.com,
        sboyd@kernel.org, sudeep.holla@arm.com, cristian.marussi@arm.com,
        matthias.bgg@gmail.com, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
References: <20220707071555.10085-1-lukasz.luba@arm.com>
 <20220707071555.10085-2-lukasz.luba@arm.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20220707071555.10085-2-lukasz.luba@arm.com>
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

On 07/07/2022 09:15, Lukasz Luba wrote:
> The milli-Watts precision causes rounding errors while calculating
> efficiency cost for each OPP. This is especially visible in the 'simple'
> Energy Model (EM), where the power for each OPP is provided from OPP
> framework. This can cause some OPPs to be marked inefficient, while
> using micro-Watts precision that might not happen.
> 
> Update all EM users which access 'power' field and assume the value is
> in milli-Watts.
> 
> Solve also an issue with potential overflow in calculation of energy
> estimation on 32bit machine. It's needed now since the power value
> (thus the 'cost' as well) are higher.
> 
> Example calculation which shows the rounding error and impact:
> 
> power = 'dyn-power-coeff' * volt_mV * volt_mV * freq_MHz
> 
> power_a_uW = (100 * 600mW * 600mW * 500MHz) / 10^6 = 18000
> power_a_mW = (100 * 600mW * 600mW * 500MHz) / 10^9 = 18
> 
> power_b_uW = (100 * 605mW * 605mW * 600MHz) / 10^6 = 21961
> power_b_mW = (100 * 605mW * 605mW * 600MHz) / 10^9 = 21
> 
> max_freq = 2000MHz
> 
> cost_a_mW = 18 * 2000MHz/500MHz = 72
> cost_a_uW = 18000 * 2000MHz/500MHz = 72000
> 
> cost_b_mW = 21 * 2000MHz/600MHz = 70 // <- artificially better
> cost_b_uW = 21961 * 2000MHz/600MHz = 73203
> 
> The 'cost_b_mW' (which is based on old milli-Watts) is misleadingly
> better that the 'cost_b_uW' (this patch uses micro-Watts) and such
> would have impact on the 'inefficient OPPs' information in the Cpufreq
> framework. This patch set removes the rounding issue.
> 
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
