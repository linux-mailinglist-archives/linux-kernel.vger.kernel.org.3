Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 145AF5802B4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 18:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236135AbiGYQaq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 12:30:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236109AbiGYQaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 12:30:39 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ACBC642D
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 09:30:38 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id l15so12698084wro.11
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 09:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=B40ZoPefI8SBiHuN5afFJ4mj6nBUZJkbwv3yhzKnPiI=;
        b=qn9HKlIpvU0/7IBQHq3yDr1L3ywxAAAefWHF7827SMfGDN3ERhk20MgQICmZdq5SpX
         MsoRkLoM6pzVz4UruGkI7kNRLoSoVM8xWpLJYXN74sDCYk0dmHlm6WDeZOsdq3dVTybO
         e0RVDfd40wrwVhZq8OOCg7OYmShGvqTIJfZ9Mb7fLau9f18jIhpr1+/qRBaN/FFEE1U4
         hHkIB3YhVpeGQYq6SzpfO4dma28m+NTZx+oiPd1S7cXZrQbPOd/iNE7ZnmBciYd9Iqkp
         F18h4Wkx3gJmGGnUeiMcjfimSspx2GhnhpxtTWQcwHja1if/8TwtOzFmF0afsWKcp6m/
         gtkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=B40ZoPefI8SBiHuN5afFJ4mj6nBUZJkbwv3yhzKnPiI=;
        b=6x+lry0yT2rbIri28bRi1EGwZBBZeoI7c5sFiwKTMZLDmAZTe0JB0wbO0xEFmWmAtY
         F9sLQplJeVEAWbPcOIzfEkTylBkd7lHDb/w4yHHSnXwG1a9l0AANLsvgxjlzX0Z7dNhy
         gbX7gMhFMAvTxOwZDdkYAGZO+gfKLlBXm+cqr/PHQ/WJMPryLOI/8A400iBbVvwA5oQJ
         bEWyH1qqPwyzqvaGYCkWiV5qIXViIoDs6i2+7tEEB0y5I0ZxsRrMZwArOSTW/YIMUCgC
         r78pK4QGJ5ykLNf5QxqEOvE3kPzJBn67tdfMyQJGAvzs2JT3yok6Ks3/fNvh8OueRhJf
         +WQA==
X-Gm-Message-State: AJIora/4t+k2u8mB2H4fexhvD92U/+QbSq+qtYvpGcnav52lSYXlL5M9
        rY44p/AWAwWV/lhpECM44fsCtA==
X-Google-Smtp-Source: AGRyM1vE8FiX5QZx/421nTZcPS2PBqwlFOaX7fPkJo/i+j4dMuIMjVapkeHheYdCJbJmAfuOovaVfg==
X-Received: by 2002:a05:6000:1ac5:b0:21d:beaf:c2c3 with SMTP id i5-20020a0560001ac500b0021dbeafc2c3mr8064189wry.609.1658766636460;
        Mon, 25 Jul 2022 09:30:36 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:1780:8e54:dd38:6668? ([2a05:6e02:1041:c10:1780:8e54:dd38:6668])
        by smtp.googlemail.com with ESMTPSA id n12-20020a05600c3b8c00b003a2ed2a40e4sm20227116wms.17.2022.07.25.09.30.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Jul 2022 09:30:36 -0700 (PDT)
Message-ID: <67c14427-1f9b-d623-8008-dcb5a2f79ea4@linaro.org>
Date:   Mon, 25 Jul 2022 18:30:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v4 2/4] thermal/core: Avoid calling ->get_trip_temp()
 unnecessarily
Content-Language: en-US
To:     rafael@kernel.org
Cc:     quic_manafm@quicinc.com, rui.zhang@intel.com, amitk@kernel.org,
        lukasz.luba@arm.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220718145038.1114379-1-daniel.lezcano@linaro.org>
 <20220718145038.1114379-2-daniel.lezcano@linaro.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20220718145038.1114379-2-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/07/2022 16:50, Daniel Lezcano wrote:
> As the trip temperature is already available when calling the function
> handle_critical_trips(), pass it as a parameter instead of having this
> function calling the ops again to retrieve the same data.
> 
> Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
> Reviewed-by: Zhang Rui <rui.zhang@intel.com>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>   v3:
>     - Massaged the patch title and the description
> ---
>   drivers/thermal/thermal_core.c | 8 ++------
>   1 file changed, 2 insertions(+), 6 deletions(-)

I'll apply this patch individually

Thanks
   -- D.


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
