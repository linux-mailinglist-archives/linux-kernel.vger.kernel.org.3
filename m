Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C53B5A17F9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 19:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241106AbiHYRaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 13:30:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241018AbiHYR35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 13:29:57 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F15A14D1B
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 10:29:55 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id bs25so25515557wrb.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 10:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=xv80AdlB+SsjBLoDIgwEjmBWdBKDGfqlqLNj3IFDEQs=;
        b=MStK53Ak1Gk5mCSta3xroLD0KsZQ6DY4QsKYMe4pOrMp2u1HfYHa1m2wMVMyTSHmwb
         pS9G587JwlukyBLYXS4dWDK4ZJEBFfRRfMU8BIUXyps9qcHjYepPp5l9vtZCSA+FRQY7
         5Ym5jfikNtrThLCo6a8KYEHLolX5oMux7G5jVQ/qGES6XtoscQ3oyVgxP6SpqCsjANeL
         ntr7Jx/gfyYtsPd3d4Nhjqnaab+pID5+OPeW7AI7cgHR/PlrBmChuA8owNxA4iVdmd+D
         uR/ZT8N35oCgJRj2Q6wPHJ8zb4bs2hlkrqOdDJUnbKDR366whziUl3ha9uHOlgILoB9+
         BNBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=xv80AdlB+SsjBLoDIgwEjmBWdBKDGfqlqLNj3IFDEQs=;
        b=qCVCbiFI0xWzzBOaJIuY8VlBYQ/KfJVIjHK3IqDrqM8pwmVAaKMCWk0BKnZ0OSh+Ub
         HMwGtmTIk+OSy5UgmulRvwcWGgaLLegQvEIKv/tKfjkyg+ks7+AM6MvENcEBH81ghKXV
         e+TkUG9WTRtsd7HYAjeuQDNXTen6GelkteWP27O7Iu3Emf24E/NGpdpPKCmJHe9c7CMh
         bQKxqKPGt6pZ0e9n4hiN8WBDR+71t1p8wjywK0yC5/G5mxOG6o3LWYgoAazmd/ietQmT
         xj5RX4H5ldM+r9ydUoSoCrguiOI98wubr9Ug6pwkpxxJS5X6Pik1TZNV8JIcG2uzSqhj
         UNJQ==
X-Gm-Message-State: ACgBeo0JpS507UopCMlQuVnHCl+v/LZkYnu8WV2ynKAxoBMSsmGQ1AyO
        dP8RhI+p/C94m1zxMgj/Hhb3JQ==
X-Google-Smtp-Source: AA6agR6BAArwEMQHc3BN5JDrOtUJIEACpOEZOvDPNRStjOFBQDS3wXj0/ux78aI79Rkb/tnmA2dKtQ==
X-Received: by 2002:a05:6000:1446:b0:222:c466:58a0 with SMTP id v6-20020a056000144600b00222c46658a0mr2973130wrx.53.1661448593721;
        Thu, 25 Aug 2022 10:29:53 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id g13-20020adfe40d000000b0021f15514e7fsm24976334wrm.0.2022.08.25.10.29.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Aug 2022 10:29:53 -0700 (PDT)
Message-ID: <05fa19f7-7997-51c3-767f-c40cb321d2a4@linaro.org>
Date:   Thu, 25 Aug 2022 19:29:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v9,4/7] thermal: mediatek: Add LVTS driver for mt8192
 thermal zones
Content-Language: en-US
To:     bchihi@baylibre.com, rafael@kernel.org, rui.zhang@intel.com,
        amitk@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        khilman@baylibre.com, mka@chromium.org, robh+dt@kernel.org,
        krzk+dt@kernel.org, matthias.bgg@gmail.com, p.zabel@pengutronix.de,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, james.lo@mediatek.com,
        fan.chen@mediatek.com, louis.yu@mediatek.com,
        rex-bc.chen@mediatek.com, abailon@baylibre.com
References: <20220817080757.352021-1-bchihi@baylibre.com>
 <20220817080757.352021-5-bchihi@baylibre.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20220817080757.352021-5-bchihi@baylibre.com>
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


Hi Balsam,

On 17/08/2022 10:07, bchihi@baylibre.com wrote:
> From: Michael Kao <michael.kao@mediatek.com>
> 
> Add LVTS v4 (Low Voltage Thermal Sensor) driver to report junction
> temperatures in MediaTek SoC mt8192 and register the maximum temperature
> of sensors and each sensor as a thermal zone.

Thanks for your work

First of all, the patch is way too big.

The organization of the data is hard to understand.

Could you give a description of the sensors, how they are organized ?

I can see the there are 'tc' and each have a group of sensing points? Is 
that correct? Do have the 'tc's a shared clock? etc ...

I have another email with the comments inline but without more insights 
on the hardware it is difficult to review accurately. This driver looks 
more complex than the other ones I've reviewed. At least that is what 
looks like with the different macros names found.



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
