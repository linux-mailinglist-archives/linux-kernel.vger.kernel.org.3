Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 343F7473F3B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 10:19:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232308AbhLNJTn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 04:19:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbhLNJTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 04:19:40 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14779C061748
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 01:19:40 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id o29so13773058wms.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 01:19:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=k3efaQzs9TBXZxHbVU2KdU9tRh/DmlHzVjWIjnkrNxI=;
        b=kydxewF9zwdRMWfXv+6E/2rinWs78wMfy76ZGOOrTe4lwtVn0YgmjNy+oopCfMhWpR
         57tNQpfJ4xCFqVdrvRMUZ0maOMJT6d1uRgyGwJpMqpkLzLAqBxJiWOsUVVV9aygawP9s
         SJQlYNOl0PvM6LMFD/9hujyOcecbuDd52hYdRb0u5/+BgPELEf4W977j43r2IROaDaZ5
         RfAtG0SoXguF+lpjl6XTLH6Acu45KDbws/lGW/rydkK+zLOj7qbkq0ydEJvnUT/NSJKZ
         c2oSbUmKn/0fFFtphY83VHtai39Cdr0D/b5mE6TIyN/u1k8Zn4ircvLLX7c3qUHwBRfX
         eL2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=k3efaQzs9TBXZxHbVU2KdU9tRh/DmlHzVjWIjnkrNxI=;
        b=tlsXqAuoW5MokSQs8wox4s74FO0EUXVSTP2uE8idBcPlZDGiUWyq4WYpdBWI1NbY1f
         a43F3vrvh0MdOrjDr+Iy+k2dLJNj0PjsAtx5YHTJkxgB2EQdoGEkdCZku3J4AiuPw7kO
         Wiblf9xwKW51TCWQ5Fvh7j/g/oRQQ3lZt1wag8sa2LzMiL0QoAMlh5fpFgaWSkBYHt6h
         NdUAMxKjJ0JBfbl9L1UJQgdrWof8szKdi4J1LGv4vlLLRLzi3xlwF71kryL141cokvaL
         3sqFOiOFeyiBVjSOambvevMRmgbsX8uBlionaRSyQvfLhOlkcQLeT4QIvkd+9f9mXX5l
         H+ew==
X-Gm-Message-State: AOAM530tfUmuOZdBIipXayVIzNEXkqekLeBtHUl8mX7k3UHiKe3HAhnM
        dRzXczSycRGjW5+RUxp8kBjY4g==
X-Google-Smtp-Source: ABdhPJxEKXuoToRSOSqbspo1zrgNmcoM6MdqePSeCkHWRALaGVXkQFyvg9LgrzN/Qfy1CSym0nmzFg==
X-Received: by 2002:a7b:ca4c:: with SMTP id m12mr5685603wml.119.1639473578522;
        Tue, 14 Dec 2021 01:19:38 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:73fb:501f:c3de:9d49? ([2a01:e34:ed2f:f020:73fb:501f:c3de:9d49])
        by smtp.googlemail.com with ESMTPSA id i3sm12027614wro.117.2021.12.14.01.19.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Dec 2021 01:19:37 -0800 (PST)
Subject: Re: [PATCH 1/2] clocksource/drivers/imx-sysctr: mark two variable
 with __ro_after_init
To:     Peng Fan <peng.fan@nxp.com>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
Cc:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "van.freenix@gmail.com" <van.freenix@gmail.com>,
        Kees Cook <keescook@chromium.org>
References: <20211201125030.2307746-1-peng.fan@oss.nxp.com>
 <1c7ecec9-6a1c-3940-4b4e-e9011c916870@linaro.org>
 <DU0PR04MB94177C2C02E5DC01CE33A5C788759@DU0PR04MB9417.eurprd04.prod.outlook.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <2dab0938-5f3b-8da9-795e-f875376fd908@linaro.org>
Date:   Tue, 14 Dec 2021 10:19:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <DU0PR04MB94177C2C02E5DC01CE33A5C788759@DU0PR04MB9417.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=koi8-r
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/12/2021 09:25, Peng Fan wrote:
> Hi Daniel,
> 
>> Subject: Re: [PATCH 1/2] clocksource/drivers/imx-sysctr: mark two variable
>> with __ro_after_init
>>
>> On 01/12/2021 13:50, Peng Fan (OSS) wrote:
>>> From: Peng Fan <peng.fan@nxp.com>
>>>
>>> sys_ctr_base and cmpcr will not be updated after init, so mark as
>>> __ro_after_init.
>>>
>>> Cc: Kees Cook <keescook@chromium.org>
>>> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>>> ---
>>>  drivers/clocksource/timer-imx-sysctr.c | 4 ++--
>>
>> Applied, thanks
> 
> I not see this patch in your tree.
> https://git.linaro.org/people/daniel.lezcano/linux.git/log/?h=timers/drivers/next


You should see it now

Thanks

  -- Daniel


-- 
<http://www.linaro.org/> Linaro.org Å Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
