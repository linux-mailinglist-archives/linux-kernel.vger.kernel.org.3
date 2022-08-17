Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B28C597642
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 21:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240837AbiHQTIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 15:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240845AbiHQTIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 15:08:22 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0294CE02
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 12:08:18 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id d5so4800764wms.5
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 12:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=J9AXcuae1QkF8XymgwwmSeuKlWD8EIXrIbDt1sXlScQ=;
        b=tSNSj5QIxzcFFZsjBZqkte5K4qd8QHsBxgo4FBfStGknNza/hdAuB3H0ZpdcYRoBjI
         nAVWIiu0FdTPjXSwnnNKgU3jswSFnvNQ89bMTLt5PdRfuWoroP5uKEqF89sLBn9jsbsE
         Pb2OWvMxKj8FeBiDAjD9wn7aTU6JgfFSDPj6Hvnk3YpbU62VpSn0/vr7ato4ki1Ozcyw
         7WE4+2HcWJgweLrXi/lmm2dduTruonLiAzIT8tS5ixrn/Tqah3VLBFTWzkFOBRR6XObd
         1SUHyjymosRSLgcmUpub+pOksO6QNFvtmIHUB9w2kbb5V6cMdgMfKwaRyZErvH/YWWB1
         Khbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=J9AXcuae1QkF8XymgwwmSeuKlWD8EIXrIbDt1sXlScQ=;
        b=in901JyDKghQLgLlVXImhRKHzuXDW4w+KVrIZWTjSxhcIce2thdIBJaJ35lvahX5Fu
         Y1fDjMWAp0p3rL4wZ8WloIoODZ4Nf+3axtT6Tu6yi1r8agavYUF4P69vHB7ErHD7Nejf
         MU75bBUo631lRSq4rlzPI/tCsBNvTHVCI5W2ElS2oir/XWYNFMyaSmJg3d2y1ZgpPbZ8
         +xDsW0nMvE0KMvRHXf9Pyh2hxRJCU76QUlvSr52ooQCnq7pe0lR1kQNlQl2P1sFpLUfq
         +ZjeCxFfVTB/2bljptBvjP1rfzc0tZcLbWJPPWPUXQSteTEUE1E/UxXmsruhcinMEj0s
         aCWA==
X-Gm-Message-State: ACgBeo3UuTcmEPz1Y7bYlwge1ugf5bWR9tjOsQFgOYkBzjwgCJTwuIiJ
        kn8uq4D9wbmHLyWysuHoiN+a40S5azTrnA==
X-Google-Smtp-Source: AA6agR7leKO6iw2GT6Tideh2I6FDNBqzotp1SkL1/uDZyEpzkupUsZNKcKoFbf4WGrKPnrRNlnaS2Q==
X-Received: by 2002:a05:600c:3516:b0:3a5:c28a:f01d with SMTP id h22-20020a05600c351600b003a5c28af01dmr3106529wmq.165.1660763297354;
        Wed, 17 Aug 2022 12:08:17 -0700 (PDT)
Received: from [192.168.2.1] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id z3-20020a05600c0a0300b003a5c2abc412sm3784162wmp.44.2022.08.17.12.08.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Aug 2022 12:08:16 -0700 (PDT)
Message-ID: <56dbbf30-6c4b-c781-3978-a844bcb88e8f@linaro.org>
Date:   Wed, 17 Aug 2022 21:08:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 1/1] clocksource/drivers/timer-ti-dm: Fix compile test
 warning
Content-Language: en-US
To:     Tony Lindgren <tony@atomide.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        kernel test robot <lkp@intel.com>,
        Arnd Bergmann <arnd@arndb.de>
References: <20220815131642.35116-1-tony@atomide.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20220815131642.35116-1-tony@atomide.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/08/2022 15:16, Tony Lindgren wrote:
> We can get a warning with COMPILE_TEST enabled for omap_timer_match
> for 'omap_timer_match' defined but not used.
> 
> Fixes: ab0bbef3ae0f ("clocksource/drivers/timer-ti-dm: Make timer selectable for ARCH_K3")
> Reported-by: kernel test robot <lkp@intel.com>
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> 
> ---
> 
> Changes since v1:
> 
> - Remove of_match_ptr() instead of adding __maybe_unused as suggested by Arnd

Applied for 6.0-rc, thanks



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
