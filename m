Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47B3E595C4D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 14:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbiHPMw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 08:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231810AbiHPMwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 08:52:21 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56BC36565E
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 05:52:20 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id k17so5190292wmr.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 05:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=QIjj7h4Isq+cfghBOqfVoLTefEPxxEUame3Phutl2H8=;
        b=keaWwdH65TdPofXhAKOaLQGVlrg/k0rwK/7d76EP+wuvXfZbkvU1NWK5NWmeFAib1k
         zwyQCvrWhzffYB8AzvN5SawhuF/v7hCt7RA4+F5oXleHf6Q1/wbO4+Cw0bLbEastGMD1
         5IVhPXRTfdH6QdKU4z+3NlpF4j37rD5KE6a57IiME3PVp9W5d12ISKCG6cLR9WEwJmLE
         q94Avi7HegBixZqkUDuG/kNk+2JcmL/FO0iq/1w9YETOWFVRXgVmEOvfUN6WhZiMfSy8
         eDtpqrhUpN8cKtgfHqXh/5AkSDOknww3Uwcrtzeuu1mu1oIkhBvgT4Hl3EKp55/hBy+5
         R1BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=QIjj7h4Isq+cfghBOqfVoLTefEPxxEUame3Phutl2H8=;
        b=qz9HmQkqpUkU/3ODAX4Dj8cit5o51QkHe/6xZ15sw0WW6f6eFusrCRQ8PEJoVZ+gz6
         BglhhWNPgn4i/MDDSSJaLDIKLM6t5BZsZkSC078WbPQi1zhgyywP/gARu9xyJg9deheG
         dgF3r7nEX2aqgQhCheGmdJ6KnXGjHf41VUoG0cIBepBtYiPXAIOVbQ+YhbUg1kHG6KRE
         7rdfpbCH/hZnYBXCcaWfjieDPSjOJFPA5kcN2gDWiSUXxhoeBwyiO+TzF8vhB7hFqu8G
         SHnjluF7AFq153MuotXwcdtf2uy51yjtf863+BI4LaVe8ZvlLx+X8dbm44cfzG0/BfFc
         Gv7g==
X-Gm-Message-State: ACgBeo1spCdQC38CDEgoSVkKunMh2CfOROZFOa9lHD/UpKkpx1ANodMv
        3XfpUEfwJZwKsLSUdDBEAw8eQA==
X-Google-Smtp-Source: AA6agR5w2lzHymM1CcgQLif6OsRje2M3vDi7dqWzHaue5rZKN7mnqR21Z4P1a3ivItOfmhCv/TiMtQ==
X-Received: by 2002:a05:600c:3545:b0:3a6:df3:b395 with SMTP id i5-20020a05600c354500b003a60df3b395mr486580wmq.145.1660654338674;
        Tue, 16 Aug 2022 05:52:18 -0700 (PDT)
Received: from [192.168.2.1] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id q13-20020a056000136d00b00224f5bfa890sm9186732wrz.97.2022.08.16.05.52.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Aug 2022 05:52:18 -0700 (PDT)
Message-ID: <17669bc3-7f58-ea32-71f9-81b5a147f713@linaro.org>
Date:   Tue, 16 Aug 2022 14:52:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 00/32] New thermal OF code
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Daniel Lezcano <daniel.lezcano@linexp.org>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Alexandre Bailon <abailon@baylibre.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Mark Brown <broonie@kernel.org>,
        damien.lemoal@opensource.wdc.com, Heiko Stuebner <heiko@sntech.de>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        mhiramat@kernel.org, Talel Shenhar <talel@amazon.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>, anarsoul@gmail.com,
        Yangtao Li <tiny.windzz@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        glaroque@baylibre.com, Miquel Raynal <miquel.raynal@bootlin.com>,
        Shawn Guo <shawnguo@kernel.org>,
        =?UTF-8?Q?Niklas_S=c3=b6derlund?= <niklas.soderlund@ragnatech.se>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Keerthy <j-keerthy@ti.com>
References: <20220727210253.3794069-1-daniel.lezcano@linexp.org>
 <35457e1c-fe6b-2212-9624-70369f04ef0d@linaro.org>
 <CAJZ5v0g5gtQGyLM2C+D5-Y-T_7+GHp4=Ptt7Reh6xgL-D77asQ@mail.gmail.com>
 <2ab74b1a-7087-cbfc-3f05-92e0eef30ca9@linaro.org>
 <CAJZ5v0jKpT0R2btHCtoyqrnF6-pvVx2q8zmYcR2mT6qtsbkJVg@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0jKpT0R2btHCtoyqrnF6-pvVx2q8zmYcR2mT6qtsbkJVg@mail.gmail.com>
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

On 16/08/2022 14:40, Rafael J. Wysocki wrote:
> On Mon, Aug 15, 2022 at 9:02 PM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>>
>> Hi Rafael,
>>
>> On 28/07/2022 16:37, Rafael J. Wysocki wrote:
>>> Hi Daniel,
>>>
>>> On Wed, Jul 27, 2022 at 11:46 PM Daniel Lezcano
>>> <daniel.lezcano@linaro.org> wrote:
>>>>
>>>>
>>>> Hi Rafael,
>>>>
>>>> we are close to release v5.19.
>>>>
>>>> I want to send a PR this week but it would be nice if this series could
>>>> be part of it, so the trip point rework we discussed earlier (it is a
>>>> long series) could be merged more easily for v5.21-rc1 as it will depend
>>>> on these changes.
>>>>
>>>> This series was tested on different platforms, rk3399, broadcom and
>>>> rcar. The external drivers as ata, touchscreen, regulator, hwmon were
>>>> acked/reviewed and some other thermal drivers reviewed also. Some others
>>>> remain without feedback because the maintainer is unresponsive or the
>>>> driver is orphaned, falling under the thermal framework maintenance
>>>> umbrella. All the drivers changes are the same.
>>>>
>>>> I do believe it does a nice cleanup and consolidation of the OF thermal
>>>> code and realign it with the core thermal framework.
>>>>
>>>> Is it ok to merge the series?
>>>
>>> I would prefer to put it into linux-next for a few days.
>>>
>>> Why don't you send 2 pull requests, one with all of the other material
>>> you have for 5.20 and another one with this series (it may be on top
>>> of the first one)?
>>>
>>> I will be able to defer pushing the second one till the second half of
>>> the merge window.
>>
>> I setup a branch with the patches and the fixes.
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git/log/?h=thermal/v6.0-rc1-2
>>
>> Is there still time for a PR ?
> 
> Not for 6.0-rc.


Ok, I'll setup a signed tag for the 'fixes' branch.


> I'm out of office this week, but I'll gladly merge an early PR for 6.1
> next week.

Ok, sounds good, thanks

   -- Daniel


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
