Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 519065B0987
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 18:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbiIGQBs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 12:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbiIGQAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 12:00:47 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C591098A6D;
        Wed,  7 Sep 2022 09:00:10 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id m3so4398917pjo.1;
        Wed, 07 Sep 2022 09:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date;
        bh=R2aYA3nGCz9EA7+1cg3dqptus0IcFIXTQNzZ+9Ertlw=;
        b=A0Ph3CtK+AKbnVr46VJVTi+2MJE30nUI6K5sJZVD42j3lrmauNuYhZ58r30MMdkIzj
         5LtpAN8dMsS/qwW2AWvLMW69TSojVVZWhrIr57Bglp/Ur+YFgGdXAa2b07KNle9G0iIv
         pHAVgF41sAew3lU8t4YBiXGTJGZXW1+9yHsgkD6k/1LJ17WgrUMBcsz+MHQa4XiXsw7B
         J/7xm0LQJci7zUGEOGku2eqGGQWLW0pDZdsMoefaoNG2fQGmQFvjwkTXY05Yu42iJguV
         1QXKYI3m6dJ3Xhq/LK8jo5YBml1urHrCTIogf2TQUgOLj30PQKWGlycNScccIy/5hZxP
         eKOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date;
        bh=R2aYA3nGCz9EA7+1cg3dqptus0IcFIXTQNzZ+9Ertlw=;
        b=cQH3RC5y9CGq1H+fRctCQn26AL8ddRWjJUtF6Nw83+5cvbaHU/peYOgVcnicaNgEXK
         5qqPSaU+0mQVx3XPmR1D70cOHRVKU3aNIVyjKBB3+OT5qEPd/h+9wxW6ux5KudS1+XRB
         Ja1e/NkyVCKcLW+6p/lUX7qdnu4Mzpw3odDrP1Ho0wQcOvWOqBqEgthNHs8i5jxXgD77
         /iAMVwabQUooQ5ZoYMJZWdD2lcef+K/XAho+OAUH5Ja+cKFj323BY3l+6q9sAYdcsgZ4
         lJv7HaL2aUA6sGp5WIIpv0DKJpzfpsAVpjd9jmlMLnnHRFw++ieugNOMVdM4lloRyWtE
         A5IA==
X-Gm-Message-State: ACgBeo2MWwhlqBGcV6wnp2uhL6PszCu7vONlWneayIDZTxuU746UmxJe
        MoZT83Nmp46PZHNXrf/OGVY=
X-Google-Smtp-Source: AA6agR4OBht6eg8IitoDsRgFpboXcA4R5BTYMEzgSwBQhYw4kaM/4fVldaLwu7Q/IbtVj47X3NvbUw==
X-Received: by 2002:a17:903:40c9:b0:176:e58c:f082 with SMTP id t9-20020a17090340c900b00176e58cf082mr4567450pld.60.1662566409286;
        Wed, 07 Sep 2022 09:00:09 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q14-20020a17090311ce00b001743c51123esm12630838plh.72.2022.09.07.09.00.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Sep 2022 09:00:07 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <5b2f5918-b26b-f7d3-7764-7832be139a92@roeck-us.net>
Date:   Wed, 7 Sep 2022 09:00:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4 02/21] dt-bindings: hwmon: (mr75203) fix "intel,
 vm-map" property to be optional
Content-Language: en-US
To:     "Farber, Eliav" <farbere@amazon.com>
Cc:     jdelvare@suse.com, robh+dt@kernel.org, p.zabel@pengutronix.de,
        rtanwar@maxlinear.com, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        hhhawa@amazon.com, jonnyc@amazon.com, andriy.shevchenko@intel.com
References: <20220906083356.21067-1-farbere@amazon.com>
 <20220906083356.21067-3-farbere@amazon.com>
 <20220906165359.GA817639@roeck-us.net>
 <f638f9bc-b757-c352-7be0-4f9ab6607378@amazon.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <f638f9bc-b757-c352-7be0-4f9ab6607378@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/6/22 23:28, Farber, Eliav wrote:
> On 9/6/2022 7:53 PM, Guenter Roeck wrote:
>> On Tue, Sep 06, 2022 at 08:33:37AM +0000, Eliav Farber wrote:
>>> Change "intel,vm-map" property to be optional instead of required.
>>>
>>> The driver implementation indicates it is not mandatory to have
>>> "intel,vm-map" in the device tree:
>>>  - probe doesn't fail in case it is absent.
>>>  - explicit comment in code - "Incase intel,vm-map property is not
>>>    defined, we assume incremental channel numbers".
>>>
>>> Fixes: 748022ef093f ("hwmon: Add DT bindings schema for PVT controller")
>>> Signed-off-by: Eliav Farber <farbere@amazon.com>
>>> ---
>>> V3 -> V2:
>>> - Change this patch to be first in the series.
>>> - Add explanation why "intel,vm-map" is not required.
>>>
>>
>> I don't see how this change warrants dropping Rob's Acked-by tag.
>> Am I missing something ? 
> 
> My apology. I wasn’t aware I had to keep the Acked-by tag.
> I'll add it in v5.
> 

"have" is such a strong word. Just keep in mind that unnecessarily
dropping tags tends to result in irritated reviewers.

Thanks,
Guenter
