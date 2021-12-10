Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E2964706A2
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 18:02:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244333AbhLJRFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 12:05:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237724AbhLJRFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 12:05:54 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA080C061746;
        Fri, 10 Dec 2021 09:02:18 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id d10so19207519lfg.6;
        Fri, 10 Dec 2021 09:02:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=khe42KQd2i39PRZO8NKm3PH3oE5cDTRnrPeaaVcSlKs=;
        b=aT7O05Ob2F7u0IucdOLOdYhj2Y5eqR5hBxxJrJ8DW/EY7X8rKUpDWeWZ5luBvaIX/r
         HKJCT2arWXABOgWOO4uI6JhtC1iqZjryMGoSY8cjTMKV1glKXd8ZZNpp8lV79xrxdFBt
         5TyW6h0DDOu6NwW9eUWmn60BcpqHv0cX2+Db5+HsiBBpWvu9K6GY5i2au3XRWMYlVbn/
         4n26zfICKYqURTQEkXQKLSTMPJGAHaVX8ypa+WLDcZDi3Iiyt6vWj6gsOAjUMpaHDTBL
         L2FjQMoH/JczSz3woiDe2+0p5KiAgL/7qB2Yl0SwOY13V2vZzWUCnZdYlloXnHg+1aJ0
         emKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=khe42KQd2i39PRZO8NKm3PH3oE5cDTRnrPeaaVcSlKs=;
        b=pU0nTJaKxoAVa6BeR5QAx3RgG7L1j98KV8zMjjaSgkW0YNPUFyfMOfVXL05gPl+FML
         TFAB11wm6ZuU5b4NdF3ozOV20NuVldkti6CA3tjVVBFUACzhkp0NRUXX8iCMF3fao2di
         +1SPRUgnVSECvtY4a1txThAgzD9WL61i7CnGYfiBdNTXFjfv+0eYu/7P/t7p2Trgadif
         jwqkalO0hWrsSicSLTnWMo0yQyTtu8foEhJ2EKcDSQOWuyo/YZ8t3TgvywDkZ+uaB7v2
         3QnQjJIvHb3uyFf+ueu8+1ON+JiqEho/30PiAivTcvZuOJzxEmmfdCCLGsbbxY8EtJiE
         1ZTw==
X-Gm-Message-State: AOAM531D/csV+0k08lfPw/mWKimFHDhhBHNehwffMPAf45Y4GwruHIl5
        ia2eTRbQISuwOO+iJTUnse3b3yiYNxk=
X-Google-Smtp-Source: ABdhPJwNyEUsEdqvetBjSnSDOj73MmwzhfsOY76fP8zmlqjVuPrjyf/EFK/lSd61vQzt4HIW6syguw==
X-Received: by 2002:a05:6512:1506:: with SMTP id bq6mr13705022lfb.444.1639155735845;
        Fri, 10 Dec 2021 09:02:15 -0800 (PST)
Received: from [192.168.2.145] (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.googlemail.com with ESMTPSA id b5sm360912lff.278.2021.12.10.09.02.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Dec 2021 09:02:15 -0800 (PST)
Subject: Re: [PATCH v5 06/24] ARM: tegra: Add common device-tree base for
 Tegra30 ASUS Transformers
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        David Heidelberg <david@ixit.cz>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        Anton Bambura <jenneron@protonmail.com>,
        Antoni Aloy Torrens <aaloytorrens@gmail.com>,
        Nikola Milosavljevic <mnidza@outlook.com>,
        Ion Agorria <ion@agorria.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Ihor Didenko <tailormoon@rambler.ru>,
        Andreas Westman Dorcsak <hedmoo@yahoo.com>,
        Maxim Schwalm <maxim.schwalm@gmail.com>,
        Raffaele Tranquillini <raffaele.tranquillini@gmail.com>,
        Jasper Korten <jja2000@gmail.com>,
        Thomas Graichen <thomas.graichen@gmail.com>,
        Stefan Eichenberger <stefan.eichenberger@toradex.com>,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211208173609.4064-1-digetx@gmail.com>
 <20211208173609.4064-7-digetx@gmail.com> <YbN3OektEKoHY3s1@orome>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <55a397be-a1cd-efaa-28bb-c0291c200295@gmail.com>
Date:   Fri, 10 Dec 2021 20:02:14 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YbN3OektEKoHY3s1@orome>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

10.12.2021 18:50, Thierry Reding пишет:
> On Wed, Dec 08, 2021 at 08:35:51PM +0300, Dmitry Osipenko wrote:
>> From: Svyatoslav Ryhel <clamor95@gmail.com>
>>
>> Add common DTSI for Tegra30 ASUS Transformers. It will be used by multiple
>> device-trees of ASUS devices. The common part initially was born out of
>> the ASUS TF300T tablet's device-tree that was created by Michał Mirosław.
>> It was heavily reworked and improved by Svyatoslav Ryhel, Maxim Schwalm,
>> Ion Agorria et al.
>>
>> [digetx@gmail.com: factored out common part into separate patch and wrote commit message]
>> Co-developed-by: Ion Agorria <ion@agorria.com>
>> Signed-off-by: Ion Agorria <ion@agorria.com>
>> Co-developed-by: Maxim Schwalm <maxim.schwalm@gmail.com>
>> Signed-off-by: Maxim Schwalm <maxim.schwalm@gmail.com>
>> Co-developed-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
>> Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
>> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  .../dts/tegra30-asus-transformer-common.dtsi  | 1729 +++++++++++++++++
>>  1 file changed, 1729 insertions(+)
>>  create mode 100644 arch/arm/boot/dts/tegra30-asus-transformer-common.dtsi
>>
>> diff --git a/arch/arm/boot/dts/tegra30-asus-transformer-common.dtsi b/arch/arm/boot/dts/tegra30-asus-transformer-common.dtsi
>> new file mode 100644
>> index 000000000000..be77212dd8c7
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/tegra30-asus-transformer-common.dtsi
>> @@ -0,0 +1,1729 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +#include <dt-bindings/input/gpio-keys.h>
>> +#include <dt-bindings/input/input.h>
>> +#include <dt-bindings/thermal/thermal.h>
>> +
>> +#include "tegra30.dtsi"
>> +#include "tegra30-cpu-opp.dtsi"
>> +#include "tegra30-cpu-opp-microvolt.dtsi"
>> +
>> +/ {
>> +	chassis-type = "convertible";
>> +
>> +	aliases {
>> +		mmc0 = &sdmmc4;	/* eMMC */
> 
> Looks like a tab snuck in there... otherwise this also has some nodes
> sorted in the wrong order.

I was fixing these tabs, but missed that one. Good catch.

Apparently I missed to recheck the order after the most recent changes,
good that you noticed it.

> [...]
>> +	pad-keys {
> 
> Any specific reason why this is called pad-keys? We call it gpio-keys
> everywhere else.

Not sure about the name. Perhaps Svyatoslav likes the pad-keys name
more. I recall it was named gpio-keys at some point in the past.

Again, will you change it all by yourself or should I make v6?
