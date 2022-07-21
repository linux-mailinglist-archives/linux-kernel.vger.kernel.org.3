Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46F7757C96F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 12:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232537AbiGUK7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 06:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232345AbiGUK7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 06:59:06 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 434B881497
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 03:59:05 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id w8-20020a05600c014800b003a32e89bc4eso607500wmm.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 03:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=fBZXdbMaIyk36U5hEKPOdPBFqAAcCzL3k7olq+kmY9U=;
        b=KTH1rb16f1KimVK0JWIgAMHb7kqjKy2jWlZIymA4cyN3Si/Qu8IVjMMHTvrxHRYrNh
         jpqBPA+biP3CnWGuTfD3HroTtzN3fr6OblG9R3BaRwqdldZ2UAAvF6NmDIEnmCOCo/CG
         NJRMvyRXe0FOe+qEnpaljpXTjcTUtM2vVmT2r0kGRiHnnv2mae1HXdNwhhymRHiDn38Z
         vzcjwd3zzhOBYe/NHP9WUP4wYsuCYpiBbIw5Aa6joQ7HGRpvR96vHItNSphEsTKQEw2o
         ZaXw3YXkFpTLILQzn/Wqc7FpQteC0HCOPlkjq6sb+NScHX2do3d/Z7QTiFhy4HRGLn/M
         E7UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=fBZXdbMaIyk36U5hEKPOdPBFqAAcCzL3k7olq+kmY9U=;
        b=Z3QHQVw181LZ9ob/oA/rnhLQFI79uV2LdExSvqgeLJKmmmk9fdDhdRGX+w4LHQ7Kyp
         nQkgF3xx4eD/gRNXLD6+XnK6EfsytSiSnw7d+yXiS22RGv0ZA/pg0qQFLLFrNc/whqJw
         E5kqE+WUqJN1zQLyRAc/LdA1AA99VDAmZE8Evv2HA+o8I4osgc8HET0P9IyhwnsABUWY
         xKvTJxzh2ikrdIR3Za1d2AOyc8hpbdJP0zDPV9sbR+A9aaji+kwSeunNFGbf5VieZlqu
         CBIImV3SmMSMpqfdgCtiYf/KREHAV0ByZcfLXwvLJKSb7b1aGs1a+LKz3KxtNwHFXXcO
         Bicg==
X-Gm-Message-State: AJIora+MAaRMOP+Abs5A+Mzpp+PmokYRKcX9AjffHybjKrPUR+JQldDo
        bJN02hs8Tk8omcHrf7D19CzrIUBtiR0Whg==
X-Google-Smtp-Source: AGRyM1tNVGfGQr664Nk+tWORjPREQrDamx6Pnw7DakdRXd/gnGPnZo9esViXQ2BwLpKy5cSqrAvMPA==
X-Received: by 2002:a1c:2944:0:b0:3a2:fece:29de with SMTP id p65-20020a1c2944000000b003a2fece29demr7844515wmp.115.1658401143632;
        Thu, 21 Jul 2022 03:59:03 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:5c9a:ee80:52f5:6a1? ([2a05:6e02:1041:c10:5c9a:ee80:52f5:6a1])
        by smtp.googlemail.com with ESMTPSA id k1-20020adff5c1000000b0020fff0ea0a3sm1491753wrp.116.2022.07.21.03.59.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jul 2022 03:59:03 -0700 (PDT)
Message-ID: <117c778a-4496-4d49-e73d-06fa3efa4d09@linaro.org>
Date:   Thu, 21 Jul 2022 12:59:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v4 3/4] thermal/core: Build ascending ordered indexes for
 the trip points
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220718145038.1114379-1-daniel.lezcano@linaro.org>
 <20220718145038.1114379-3-daniel.lezcano@linaro.org>
 <CAJZ5v0hj0kMRNBqO_0SqsAAY8Rb8h2NrWOYogDLgGZnCtiTEwg@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0hj0kMRNBqO_0SqsAAY8Rb8h2NrWOYogDLgGZnCtiTEwg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/07/2022 20:56, Rafael J. Wysocki wrote:
> On Mon, Jul 18, 2022 at 4:50 PM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>> By convention the trips points are declared in the ascending
>> temperature order. However, no specification for the device tree, ACPI
>> or documentation tells the trip points must be ordered this way.
>>
>> In the other hand, we need those to be ordered to browse them at the
> 
> s/In/On/
> 
>> thermal events.
> 
> What if they are all inspected every time?

My bad, my sentence is confusing. The trip point are browsed every time 
and we need to have them ordered to detect correctly the thermal events.

>> But if we assume they are ordered and change the code
>> based on this assumption, any platform with shuffled trip points
>> description will be broken (if they exist).
>>
>> Instead of taking the risk of breaking the existing platforms, use an
>> array of temperature ordered trip identifiers and make it available
>> for the code needing to browse the trip points in an ordered way.
> 
> Well, having ops->get_trip_temp() suggests that the trip temperatures
> can be dynamic.  Is the ordering guaranteed to be preserved in that
> case?

The number of trips can not be changed. It is fixed when the thermal 
zone is created AFAICT. The get_trip_temp() is just a way to let the 
different driver declare their own trip structure which is actually 
something I'm trying to fix by moving the structure thermal_trip inside 
the thermal zone. But that is a longer and separate work.

> Anyway, if they need to be sorted, why don't we just sort them
> properly instead of adding this extra array?

We can not because ATM the trip points array is private to the different 
sensors.

[ ... ]


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
