Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A02C49C5A3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 09:59:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238642AbiAZI7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 03:59:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbiAZI7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 03:59:30 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F557C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 00:59:30 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id s18so24435963wrv.7
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 00:59:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zQvPFjLLRa6HRJk2BgAUClUH4j39/b6WfUyuXMyTxSI=;
        b=cfsCz7sXyWW5krNSpKoaHoTX5s0nujhme9eVeP1qfPdFmBBsGRmMkhaTmRUPUnH8qO
         2JX4jfT+KFRCK8dAT2AnaWQ1yp4fWgXEn7aQHMuQP71ZLbzHEao8RwmV9jzE7bGgAXd7
         jKNRKEsqlxwoM6a3l0nTwxDksjV4+NRmy0We5YsSn32XwgH/wCEUEVUFbODxqJD8mcVp
         mBejbDKNmLfqZn8NVf0JSC5bcYr/2Sj9wLhAO6r3Q451QWeS7EXGonSdhPXTCQgbI68g
         rncB9ey5yu/zIBA3kPbLiF/IEZ+EM7WCHRvjSj9QNBRop4QybU5Wq93zQDGi3JuJ+lYk
         kKmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zQvPFjLLRa6HRJk2BgAUClUH4j39/b6WfUyuXMyTxSI=;
        b=RyeeLpGS0d/yn9cgzSBEEUAxVcAFtpfFAegjR9zhPXVHuyI9ktL1EvPCV9SodbmCmr
         xK0z3JU+9Ot/nFkwoPhmvnzHjOJ7hcoWw8GEES+KcWaBXu6vYtcTPJgQFs/P2YSNWbQX
         dLCKx9ueCMzs1nzEh3OvPvW08R7LdwawXQcHeXd0yYnQrPMwx3veF/NVRTMWeJBqh2A/
         Rq1rPwzla51NB+7kR1veCvX0CslSW/YbtBhix5R2DDfItpkUb//r3+Mc39B0oofklt4v
         Ay9IjHkaxMnH/GZCFrvIlVHGjUqpyAFGjFHHGFbh0ehPNjnwlOhxveOpB/23SB4DkRdJ
         UGiw==
X-Gm-Message-State: AOAM533kbW/GJeCZYsOxgrXrCKnF0zF6lezmE6M1TTkK8ev0IaUdfVhg
        2OEovcH7xbfvggvRxRBg+FxhMw==
X-Google-Smtp-Source: ABdhPJxSgbRAoHwRBT6vs3teem1jRvlCGwMFxR+ltfzIVOEkF7dCgOl8o3YAVd87qh729pqmb7sdDQ==
X-Received: by 2002:a5d:4050:: with SMTP id w16mr5335831wrp.662.1643187568636;
        Wed, 26 Jan 2022 00:59:28 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:f589:cf7d:b2ee:bb5e? ([2a01:e34:ed2f:f020:f589:cf7d:b2ee:bb5e])
        by smtp.googlemail.com with ESMTPSA id m14sm12466672wrp.4.2022.01.26.00.59.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jan 2022 00:59:28 -0800 (PST)
Subject: Re: [PATCH 0/5] clocksource/drivers/imx: several updates
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
        <linux-arm-kernel@lists.infradead.org>
References: <20211214120737.1611955-1-peng.fan@oss.nxp.com>
 <DU0PR04MB94177F777E854B92C665303488519@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <DU0PR04MB9417BA24DB13CD6C98BE47CF88209@DU0PR04MB9417.eurprd04.prod.outlook.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <c7584787-838f-97b8-5e2a-c7f271d8a406@linaro.org>
Date:   Wed, 26 Jan 2022 09:59:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <DU0PR04MB9417BA24DB13CD6C98BE47CF88209@DU0PR04MB9417.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 26/01/2022 09:24, Peng Fan wrote:
> Daniel,
> 
>> Subject: RE: [PATCH 0/5] clocksource/drivers/imx: several updates
> 
> Do you have time to give a look?

Yeah, sorry for the delay

They sounds good, I'll pick them up

Thanks

  -- Daniel


>>> Subject: [PATCH 0/5] clocksource/drivers/imx: several updates
>>>
>>> From: Peng Fan <peng.fan@nxp.com>
>>>
>>> This patchset includes several update of i.MX sysctr and tpm driver.
>>
>> Ping..
>>
>> Thanks,
>> Peng.
>>
>>>
>>> Peng Fan (5):
>>>   clocksource/drivers/imx-sysctr: drop IRQF_IRQPOLL
>>>   clocksource/drivers/imx-tpm: drop IRQF_IRQPOLL
>>>   clocksource/drivers/imx-tpm: mark two variable with __ro_after_init
>>>   clocksource/drivers/imx-tpm: add CLOCK_EVT_FEAT_DYNIRQ
>>>   clocksource/drivers/imx-tpm: update name of clkevt
>>>
>>>  drivers/clocksource/timer-imx-sysctr.c |  2 +-
>>>  drivers/clocksource/timer-imx-tpm.c    | 10 +++++-----
>>>  2 files changed, 6 insertions(+), 6 deletions(-)
>>>
>>> --
>>> 2.25.1
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
