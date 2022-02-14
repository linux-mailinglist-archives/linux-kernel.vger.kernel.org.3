Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1DC04B4E4F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 12:27:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350797AbiBNL1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 06:27:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345773AbiBNL1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 06:27:11 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4211F70906
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 03:02:50 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id d27so22378207wrb.5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 03:02:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=rY6QvvVRqOvPAGc/v6yuZaAnxNGOJih1tbWFe0TRT+8=;
        b=r+EpbXVhOjAUFCGJgqRB9cfXnZf47V3kY8RXt+P+9ENGtagytayFrd9RZbDfVGDgmk
         qyyusJ4t5L/SlK3KnY2WaxccqVbEfz7b9isdtipuw76VyT9/MEB/BEgkEvVBUz8FBDbu
         iZjCmTaxy6s194lR2+n+zgv66SjUzG2cwkk25+r9tkynU/eYhtY+Zzzby6atYwRXMRiF
         ZBqur0WyMl/MPLRf4n4mj2VvMvZ6TOd4LZLiMOo+0nXN7pCgKRueCJcIlTOx0hGVez0J
         x9BY67unoRW2Jbxme4NUc+NC7kNqcaqdi5EMm3ILeZgO70oIu9c+DHnvCl+lwW4NNjq7
         quvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=rY6QvvVRqOvPAGc/v6yuZaAnxNGOJih1tbWFe0TRT+8=;
        b=BpBzWjpQCKhXtBSezRMZpQjNCggQM/w0PeoGI8Wth7+m48gQ28j+SULxPpt5UVd34h
         Exjv37ADtL9wAoO1vrDYF975rroNctw8f6ilVuSNfhQAtt7xD+ECKmSmOQPGdv9tNxjK
         i7XBavAGEzZ5IM37HpSWctLujybkqZsGinvV/1yuWm5AmSqeLFqxxZUHcR/j17CnueXx
         1sYt5aLHq+97l/XqkWPNd9I6zQn0y2N5v9T9ve3ZhFqtUPZ5CoqibTcwMpIxICesS2Oh
         EsH63i/6JjsFMuZL5Phe3bo34lSedZ4rS+BpGMPqgZjvkoH3LoA9KUwUVhz3D4drECOw
         p3Eg==
X-Gm-Message-State: AOAM531LZbXy8h3uQvllXxSZR0s9UP4BrDujQXEH4VT2y80jCn4poHj0
        Zfqx1ugwv5tQCD5RCoyZUR8X6Q==
X-Google-Smtp-Source: ABdhPJxLurLedRSdtH+QhxXlsrZ9XXK/g0KEduGYx1QwiEKeQ+rKMBO3/YugsxGdBwwWLZUUHjaGsA==
X-Received: by 2002:a5d:5386:: with SMTP id d6mr10249921wrv.392.1644836568786;
        Mon, 14 Feb 2022 03:02:48 -0800 (PST)
Received: from ?IPV6:2a01:e34:ed2f:f020:1088:8527:61da:d6b? ([2a01:e34:ed2f:f020:1088:8527:61da:d6b])
        by smtp.googlemail.com with ESMTPSA id r11sm7189107wmb.19.2022.02.14.03.02.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Feb 2022 03:02:48 -0800 (PST)
Message-ID: <c0b863ee-cf40-3dc9-f1d0-0f036b560cbd@linaro.org>
Date:   Mon, 14 Feb 2022 12:02:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 0/5] clocksource/drivers/imx: several updates
Content-Language: en-US
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
 <c7584787-838f-97b8-5e2a-c7f271d8a406@linaro.org>
 <DU0PR04MB9417CFE2BBFDB2FDC32CA8F088329@DU0PR04MB9417.eurprd04.prod.outlook.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <DU0PR04MB9417CFE2BBFDB2FDC32CA8F088329@DU0PR04MB9417.eurprd04.prod.outlook.com>
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

On 14/02/2022 00:46, Peng Fan wrote:
>> Subject: Re: [PATCH 0/5] clocksource/drivers/imx: several updates
>>
>>
>> On 26/01/2022 09:24, Peng Fan wrote:
>>> Daniel,
>>>
>>>> Subject: RE: [PATCH 0/5] clocksource/drivers/imx: several updates
>>>
>>> Do you have time to give a look?
>>
>> Yeah, sorry for the delay
>>
>> They sounds good, I'll pick them up
> 
> Still not in your tree? Or later?

Just pushed my branch

https://git.linaro.org/people/daniel.lezcano/linux.git/log/?h=timers/drivers/next

It will land in linux-next


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
