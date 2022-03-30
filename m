Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 731B14EC2D6
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 14:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344494AbiC3MBi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 08:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344845AbiC3Lxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 07:53:41 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A8DD26E576
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 04:49:46 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id m30so28922225wrb.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 04:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Zz5V7y6zyX28uzHv7nbJNO/THNVqL6J0WR2WWuQ7SCY=;
        b=ZUOogO2MuK6NJjubHjbfEz+haJ4Oh6ePGA6/+gd7oK40h63IMjwzaVvnJYUmTxImAs
         MyvMzaw35CVlu+C1Qwxa9gZov8B7ynpIwE3Kahpcz6sN0ho/mSj65L6ftNnsKk0N0nfj
         4FD0bVTJb2fmEnKM40jG3JvPfGa1UEDFrVUzYozFy2JbNwdiOUCDqvoRUU5p/1MuvQtk
         H1t8//3ATlKAdlXRm+jWADGLrIYnbjN2Vd+1QzD13qGQn0d2D1eJ8SeQBqJ9cpJE8m8y
         rxQTaDbTj6arnFaptoXI1QxDOgI01CGVevoN+fRv/LEDGV5rgU6D1hGjCmYn3/CIg8i5
         eoDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Zz5V7y6zyX28uzHv7nbJNO/THNVqL6J0WR2WWuQ7SCY=;
        b=XtdSd5nyWf4yNfkB1PKwtcNdpaDZy2/LhaTzU7bERuL8LIZ7Fi4pyovY72kid7f1rJ
         VqRN0CkkGoPerLU6bQyDxPRrXZX1jUTHp9hU3u2sT5rdvoDJENo+BWqnXSGsZawG3ero
         BOQ2raZEHAYITYk8p7WpGLEwHRSq9qHhZMlsRN3hyOcRMsebc5ZU9q+CieKIz9sbEBlo
         Yo9I44y8RXR8uJWuZsOOuNc6A7/8lWmKwIbtVSEyMCBtysF9QebnDEGXp1i4JomWeoGl
         QYq/mlrjSkH+a1VEoCs4D/UcuzT+MAI5I+4LmeI1jZtDWc6tea3uQGNR3er6YeHI6Fte
         ktsQ==
X-Gm-Message-State: AOAM532LejRYI0rkg7u5t7gZyprPpDNb9DfUxe1+LODc6sJsrdoW7D1v
        /rRuUmAARxUGIVTF98E6ZuulQA==
X-Google-Smtp-Source: ABdhPJxlxhSbqKiKCa9E9IGILcoh2/H6PVy3wwrQdQj0w9n8pdqxILCg+dwurPk7Vv6V2VCi3BDOrQ==
X-Received: by 2002:adf:d1e5:0:b0:205:85f5:656c with SMTP id g5-20020adfd1e5000000b0020585f5656cmr35738237wrd.65.1648640983633;
        Wed, 30 Mar 2022 04:49:43 -0700 (PDT)
Received: from ?IPV6:2a01:e34:ed2f:f020:8f92:3217:a3c6:3ee8? ([2a01:e34:ed2f:f020:8f92:3217:a3c6:3ee8])
        by smtp.googlemail.com with ESMTPSA id z5-20020a05600c0a0500b0037fa93193a8sm5539221wmp.44.2022.03.30.04.49.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Mar 2022 04:49:43 -0700 (PDT)
Message-ID: <98be733a-62b0-4cf6-ab27-992ea49da5b1@linaro.org>
Date:   Wed, 30 Mar 2022 13:49:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v4 1/4] dt-bindings: timer: Add compatible for Mediatek
 MT8186
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Cc:     hsinyi@chromium.org, Thomas Gleixner <tglx@linutronix.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
References: <20220311130732.22706-1-allen-kh.cheng@mediatek.com>
 <20220311130732.22706-2-allen-kh.cheng@mediatek.com>
 <Yitv3IUpCzp1/eGX@robh.at.kernel.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <Yitv3IUpCzp1/eGX@robh.at.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/03/2022 16:50, Rob Herring wrote:
> On Fri, 11 Mar 2022 21:07:29 +0800, Allen-KH Cheng wrote:
>> From: Allen-KH Cheng <Allen-KH.Cheng@mediatek.com>
>>
>> This commit adds dt-binding documentation of timer for Mediatek MT8186 SoC
>> Platform.
>>
>> Signed-off-by: Allen-KH Cheng <Allen-KH.Cheng@mediatek.com>
>> ---
>>   Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt | 1 +
>>   1 file changed, 1 insertion(+)
>>
> 
> Acked-by: Rob Herring <robh@kernel.org>

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
