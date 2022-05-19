Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5085352DECF
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 22:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244876AbiESUzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 16:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236881AbiESUzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 16:55:03 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E9AA1117D
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 13:55:01 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id a23so7577664ljd.9
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 13:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wirenboard-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:to:cc:references:subject
         :content-language:from:in-reply-to:content-transfer-encoding;
        bh=ykepN6VoLxDb519/zdl3hvscRGddEy2w8xlt6V9kG3g=;
        b=dMve2Rz5oX6qOdwprOe+DoCzTq+YEQgYj9e3Sh1Z7OES+6dVVGzh4jbb1En18wQf53
         BRuJEShG3rUzrDiN0HAe++6iYSFPX18sMPZOvOOe514v+5sUFDVWbpKXg5MCtJayT8RT
         Df1IFuZ8IS14Cfe+ACIGnu3YSIoy9KnnNa3ZnoEhn74qPGXqYmyGShnSBPrJt1Fe3jIN
         JIw84UwlxBWYR5H8fmXUl1nOqYHVxJ2M+ch/sIESxn7sWsCvU+1hVsE4Jn8CrdDEcr9+
         YGO4Xd8u+Zg1w/u6ng06m2B0oZHMhxgSiDkIuB7XXFJ1ZBYrESyxHHF2KMuMj8GhNJiv
         OHNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:to:cc
         :references:subject:content-language:from:in-reply-to
         :content-transfer-encoding;
        bh=ykepN6VoLxDb519/zdl3hvscRGddEy2w8xlt6V9kG3g=;
        b=sUoyJ/Cb/1204BBjsZmdUAKhwUoW1y4iLmYvnYvYPN3vVi12VyP7Uz74XzTNbjjG9g
         1oI9FJEKniMdqUcYCsEuZMeHatjrey1lAYfhiEOUEu2YwvCmJC/tK//3iw6eqtSH/JJf
         zEfEYTGgjcRGTE4oRIl5wC0DdEErzlowdrxvZmH1335BpgV5EtFLf8R/DjMQ1KaWnKBw
         VQ4axBxpK5mUyOPg4gqJM4XrmDbhNLCBhPb1dEfkUqV6A+Be5cTP8/ZpkS1Je65Xy6J1
         gJXsAbBrgR4aEHVRK0eNcsQi9jb9hhr8F/K1h2ezpwDzaOD1voaZa51X9cG+BQbOVLv2
         V38w==
X-Gm-Message-State: AOAM532/S1/zkKfNkuHXOryAzqU1SPz9PNVktQm5WhzcIdjyf5SPA3Yr
        QYxNsT1h1Pne3HGJTJCW3B9R/naW2DZAxJ+S
X-Google-Smtp-Source: ABdhPJxDVsDoZQ3rFb716+iXoB+BWGYPfwVUdvxncdPn1zWF/QEbWLsi0SxLUsOS7u5CqmXAXGPpDQ==
X-Received: by 2002:a05:651c:2124:b0:250:5b55:8147 with SMTP id a36-20020a05651c212400b002505b558147mr3612417ljq.439.1652993699699;
        Thu, 19 May 2022 13:54:59 -0700 (PDT)
Received: from [192.168.1.21] ([78.109.71.116])
        by smtp.googlemail.com with ESMTPSA id x14-20020a2e7c0e000000b00253d654b2desm37550ljc.91.2022.05.19.13.54.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 May 2022 13:54:58 -0700 (PDT)
Message-ID: <ec5f7fe8-d47d-ce7f-0e0a-2bdf41a88ba2@wirenboard.com>
Date:   Thu, 19 May 2022 23:54:57 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
To:     qianfanguijin@163.com
Cc:     andre.przywara@arm.com, boger@wirenboard.com,
        devicetree@vger.kernel.org, jernej.skrabec@gmail.com,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev, robh+dt@kernel.org,
        samuel@sholland.org, wens@csie.org
References: <264cb004-677a-13df-cc68-676ef3c2e7d8@163.com>
Subject: Re: [PATCH v4 0/2] ARM: sun8i-r40: Enable usb otg support
Content-Language: en-GB
From:   Evgeny Boger <boger@wirenboard.com>
In-Reply-To: <264cb004-677a-13df-cc68-676ef3c2e7d8@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi qianfan,

As Allwinner A40i user, let me first thank you for your effort for 
making better upstream support for R40!

However, I would strongly suggest *not* to add USB support to one more 
Allwinner SoC in this particular way.
The problem is, this approach consists of a number of carefully crafted 
hacks in device tree to make current drivers work on Allwinner hardware 
without modification to the drivers.

a few examples:

1) please notice how ohci0 and ehci0 nodes do not contain reference to 
usb phy. It is done intentionally, otherwise EHCI will reset musb mode.
Of course omitting phy reference here is also completely breaking power 
cycling in case of usb error and otherwise messes with a power management.

2) one must always enable ohci, ehci and usb_otg nodes at the same time. 
If one forgets to enable ohci/ehci nodes while enabling usb_otg node, 
the system will silently fail to work as USB host.

3) For host-only mode we still have to enable usb_otg node despite no 
role switching is needed. That's because phy reference is missing in 
ehci/ohci, so the ehci/ohci driver won't enable the PHY.
Also I might be wrong, but I think phy won't be routed to ehci/ohci 
controllers is this case.

4) musb host controller is initialized and present to hardware though 
never actually used

To summarize, not only the resulting device tree is not describing the 
hardware properly, it is creating device tree configuration which will 
be very hard to support in future, once proper driver support is in place.


At Wiren Board kernel tree we tried to untangle this issue [1-6]. 
Unfortunately I didn't have time to prepare it for kernel submission 
yet, but I think I better submit it as RFC to get a feedback from you 
and others.


[1] 
https://github.com/wirenboard/linux/commit/359abbbd86ddff4d3c61179c882c286de32bb089
[2] 
https://github.com/wirenboard/linux/commit/6327f9d7972c21b229fb83457fdde643b31553f9
[3] 
https://github.com/wirenboard/linux/commit/f01f4c66758bde460a4d8c5b54ecee3b585c0232
[4] 
https://github.com/wirenboard/linux/commit/c27598ad601e5a46f624b73412a531d6f1f63d37
[5] 
https://github.com/wirenboard/linux/commit/5796d6eebb86b32a3751b2038b63af46f94954b3
[6] 
https://github.com/wirenboard/linux/commit/0928a675d875f9c2849fd3a9888f718bbb673bda


-- 
Kind regards,
Evgeny Boger
CTO @ Wiren Board
+49 3046690053
https://wirenboard.com/

