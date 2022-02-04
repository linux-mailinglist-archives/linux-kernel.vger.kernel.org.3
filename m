Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBE384A92CA
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 04:41:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356837AbiBDDlt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 22:41:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232345AbiBDDls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 22:41:48 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 736B2C061714;
        Thu,  3 Feb 2022 19:41:48 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id z1so4724332qto.3;
        Thu, 03 Feb 2022 19:41:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7mi+rsnY3rOXooKo8WaV+dwZtlr3f4pyVzHcdNPQMpQ=;
        b=T40GCJdjXaaTjaczrdWdZj7khY2Y7yBugzTdvsQorikd4Fj7O2S42NsW+TLWBwKNnu
         G5PRYGPcxJcCI10fuuHsRsbwCT7G1wfllTdyMqB8eLp2I3/XqgQ1uDlIkda6dV1lIY0z
         ie4zP+dHOXZWb0DqfEwZu4TFZlEx26WEhwprbAWrZn2UjVZMVoiF6kV9YmbCL2+aj1YA
         jzgr9qdn0hmKH/78O653HptID/h3QxFMctqDlhht9anexxYXaAyDtGletsRvWtpEXMjv
         9pUlrM21GEiljtlGg+wzhtx14+tDw5tZyUugtwBtY2Nr2tvAuY/pxbPzay2F94Hv1BpZ
         sMtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7mi+rsnY3rOXooKo8WaV+dwZtlr3f4pyVzHcdNPQMpQ=;
        b=rCXih+OFPLAeVMoKWBXqrg/pcUXEcgPo0n/Aqpqpbfvjothmv44guK9EL78NHSATu9
         FkbsAPh/BgQaN++8RZly/HlJcMMsOqCB1JQpeMFzSefOFC/WT2HkTB1UddavIFZkKF2j
         Q2JA0NG1mhj4o3UF3xYiZmewH5F2u7sI9OuwNkzm4qccZiGUJLuuMiaSsvc6ZgJQmrQD
         wLihb98A/GNozg/S6KrA4wGc5k8kN3CP1C495LjYb+Rdz/hyXQ8q/ia2khjaW+xByxLB
         0a+5w+Mzve+c6lJMDV43Tbn/ivuvROK9QwM5Zei/ZIo8/EhbI0fywahBIYdyCBdXEbob
         /2JQ==
X-Gm-Message-State: AOAM533IuU6qtF7YshvQqh2+nTlB4uqcSaGfAc4UL/BE73nak1ymdJI3
        IYLc1C3SpzR18uCTpGX0CyY=
X-Google-Smtp-Source: ABdhPJyCq6LWvW14DLtDjrArdY2ynqb/JUcPPk0wBnj+yXyUU5psYtk8PSgDMA6MzcpNuwegbgeFxg==
X-Received: by 2002:ac8:5a50:: with SMTP id o16mr831938qta.260.1643946107201;
        Thu, 03 Feb 2022 19:41:47 -0800 (PST)
Received: from [192.168.1.49] (c-67-187-90-124.hsd1.tn.comcast.net. [67.187.90.124])
        by smtp.gmail.com with ESMTPSA id s1sm500616qkp.40.2022.02.03.19.41.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Feb 2022 19:41:46 -0800 (PST)
Subject: Re: [PATCH 1/1] of: unittest: print pass messages at same loglevel as
 fail
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220203211150.2912192-1-frowand.list@gmail.com>
 <CAL_JsqKMZWMtvdTvYHmWkd5CmehKJexJVv_BUBENrMPOf002+w@mail.gmail.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <24652725-91d8-9db4-e14a-e1bb5ded87b1@gmail.com>
Date:   Thu, 3 Feb 2022 21:41:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqKMZWMtvdTvYHmWkd5CmehKJexJVv_BUBENrMPOf002+w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/3/22 3:40 PM, Rob Herring wrote:
> On Thu, Feb 3, 2022 at 3:12 PM <frowand.list@gmail.com> wrote:
>>
>> From: Frank Rowand <frank.rowand@sony.com>
>>
>> Printing the devicetree unittest pass message for each passed test
>> creates much console verbosity.  The existing pass messages are
>> printed at loglevel KERN_DEBUG so they will not print by default.
>>
>> Change default to print the pass messages at the same loglevel as
>> the fail messages.
>>
>> The test community expects either a pass or a fail message for each
>> test in a test suite.  The messages are typically post-processed to
>> report pass/fail results.
>>
>> Suppressing printing the pass message for each individual test is
>> available via the kernel command line parameter unittest.hide_pass.
>>
>> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
>> ---
>>  Documentation/admin-guide/kernel-parameters.txt |  4 ++++
>>  drivers/of/unittest.c                           | 17 ++++++++++++++++-
>>  2 files changed, 20 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>> index f5a27f067db9..045455f9b7e1 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -5997,6 +5997,10 @@
>>                         Note that genuine overcurrent events won't be
>>                         reported either.
>>
>> +       unittest.hide_pass
> 
> Can we rename the module name to include 'dt' so we're not taking a
> generic name.

I got most of the way through writing a reply to the various questions, then got to
the point where my answer to a specific question ended up being something to the
effect of: "this line of code (where a change was suggested) will end up being
replaced when I convert the unittest messages to KTAP format".

Then I got sidelined by going back and re-reading the KTAP specification email
thread from August, then discovering that there is also a patch submission email
thread from December where a KTAP specification is accepted into the kernel tree.

Being KTAP compliant does not allow for suppressing the individual test pass
messages, so I think I should just drop my desire to be able to do so.  That
would reduce this patch to a one line change to print the pass messages at the
same loglevel as the fail messages.  And I would prefer to not worry about
whether the pass message is 'pass' vs 'PASS' since that text will get replaced
by the KTAP syntax anyway.

Would you be ok with that one line patch?

-Frank

> 
>> +                       Disable printing individual drivers/of/unittest test
>> +                       pass messages.
>> +
>>         unknown_nmi_panic
>>                         [X86] Cause panic on unknown NMI.
>>
>> diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
>> index 70992103c07d..2cfbdc6b29ac 100644
>> --- a/drivers/of/unittest.c
>> +++ b/drivers/of/unittest.c
>> @@ -12,6 +12,7 @@
>>  #include <linux/errno.h>
>>  #include <linux/hashtable.h>
>>  #include <linux/libfdt.h>
>> +#include <linux/module.h>
>>  #include <linux/of.h>
>>  #include <linux/of_address.h>
>>  #include <linux/of_fdt.h>
>> @@ -32,6 +33,19 @@
>>
>>  #include "of_private.h"
>>
>> +MODULE_LICENSE("GPL v2");
>> +static bool hide_pass;
>> +
>> +static int __init hide_pass_setup(char *str)
>> +{
>> +       hide_pass = true;
>> +       return 0;
>> +}
>> +
>> +early_param("hide_pass", hide_pass_setup);
>> +module_param(hide_pass, bool, 0);
>> +MODULE_PARM_DESC(hide_pass, "Disable printing individual of unittest pass messages");
>> +
>>  static struct unittest_results {
>>         int passed;
>>         int failed;
>> @@ -44,7 +58,8 @@ static struct unittest_results {
>>                 pr_err("FAIL %s():%i " fmt, __func__, __LINE__, ##__VA_ARGS__); \
>>         } else { \
>>                 unittest_results.passed++; \
>> -               pr_debug("pass %s():%i\n", __func__, __LINE__); \
>> +               if (!hide_pass) \
>> +                       pr_err("pass %s():%i\n", __func__, __LINE__); \
> 
> Would 'PASS' be better here to align with FAIL?
> 
> If we make this info level, then you can filter with dmesg and also
> seems to be aligned with what kunit does.
> 
> 
> Rob
> 

