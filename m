Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1027B50BB6A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 17:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448215AbiDVPPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 11:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1449332AbiDVPP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 11:15:26 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97CA95DA21
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 08:12:27 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id u17-20020a05600c211100b0038eaf4cdaaeso8166364wml.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 08:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=RTXQxTUlDy/+XtQ3FRDbwb/fEP0/XOiKskHAERCJ+aA=;
        b=Li35G7NpXuvuBIHaNfZEPJ/UkjIgIle1to/jslIte4pPT7SoHLW9heC5fTTcFJUiZX
         Z+L2yRuLcsU4nH2o3sHramC8AjH2M7vYdn9NNa62cdZfDK6Myg5AcUjywaYGzhXsOff7
         0mei52r8X848r3jjymXS7WJP+25/4BTUXDHet1DWXTcdTuFZL03XsyGj1tzE3rPcXs4e
         9hCKEpO6xuyWagFlDEU96BvE/XX/XNvqLgGgKtoZ+OJ+4jt80aSCEVMJK+RizhJv+4Dg
         3UxE+OzXPvh8hB0FdsLXh2chCOgrcdbPSgnS8ST8NzhVmnlnY/LGNyab+lPyFbve99/w
         RODg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=RTXQxTUlDy/+XtQ3FRDbwb/fEP0/XOiKskHAERCJ+aA=;
        b=eG3TCoW6fIru3YUef7g9mCBG1KWwNw2e8kgu1Y+wr4vNWzTEknQi0I4ZdgUTiC2DUw
         NlEdqBIHIDViRMhAm0jlgXvcF6Qc74Dd1XrLNhbKUmnIXF2EhKiLOnRjUulnIq+qKcLu
         Mm7D0b60HAM0tIflhlazsRq5K0t/H4G650TuHA2gZljPcJY3kK6xMASIGdufL8Kg0kG8
         c6lZVasxNCzgsa1diDs9YBa5z/DyM+8bKgX5lkSgH2BjENC+sXo7gzNz92p30JOgtX+H
         ZI1BcJzu7FasytrWH7RWQiXtNNmKIzlzLKVnX1MZllnCeZWPkttX4uj2drS/DYN3wgH+
         5xuw==
X-Gm-Message-State: AOAM533uWWHGKoBo2Ue5nQjwQcEzR/0eBlaCN10JnZcZMB1YGD6a1mNK
        YqavwN2yZzSTvHR5XcMO9oI=
X-Google-Smtp-Source: ABdhPJx/9ozGt+podmI9X7yq2z0UtTmdQqvAQs7KH6K85Wh/0AMDUalJOhps+qXlZoJnjpD9AeZZEw==
X-Received: by 2002:a05:600c:20c7:b0:38e:bf41:edef with SMTP id y7-20020a05600c20c700b0038ebf41edefmr13797138wmm.173.1650640346174;
        Fri, 22 Apr 2022 08:12:26 -0700 (PDT)
Received: from [192.168.1.145] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id v2-20020adf8b42000000b0020aa790a258sm2031690wra.8.2022.04.22.08.12.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Apr 2022 08:12:25 -0700 (PDT)
Message-ID: <8a341814-6165-df6c-e99f-afc38a46448e@gmail.com>
Date:   Fri, 22 Apr 2022 17:12:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] arm: mediatek: select arch timer for mt7629
Content-Language: en-US
To:     Chuanhong Guo <gch981213@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Russell King <linux@armlinux.org.uk>,
        Ryder Lee <ryder.lee@mediatek.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20220409091347.2473449-1-gch981213@gmail.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220409091347.2473449-1-gch981213@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/04/2022 11:13, Chuanhong Guo wrote:
> This chip has an armv7 arch timer according to the dts. Select it in
> Kconfig to enforce the support for it.
> Otherwise the system time is just completely wrong if user forget to
> enable ARM_ARCH_TIMER in kernel config.
> 
> Fixes: a43379dddf1b ("arm: mediatek: add MT7629 smp bring up code")
> Signed-off-by: Chuanhong Guo <gch981213@gmail.com>

Applied, thanks!

> ---
>   arch/arm/mach-mediatek/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/mach-mediatek/Kconfig b/arch/arm/mach-mediatek/Kconfig
> index 9e0f592d87d8..35a3430c7942 100644
> --- a/arch/arm/mach-mediatek/Kconfig
> +++ b/arch/arm/mach-mediatek/Kconfig
> @@ -30,6 +30,7 @@ config MACH_MT7623
>   config MACH_MT7629
>   	bool "MediaTek MT7629 SoCs support"
>   	default ARCH_MEDIATEK
> +	select HAVE_ARM_ARCH_TIMER
>   
>   config MACH_MT8127
>   	bool "MediaTek MT8127 SoCs support"
