Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C9EB49B259
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 11:54:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349331AbiAYKuI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 05:50:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240054AbiAYKqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 05:46:53 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE67FC06173E
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 02:46:52 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id a13so19046187wrh.9
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 02:46:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ODHhtpuCmlqbjTbHm7GxkArm+DSdAOP3TtnFywy+XCo=;
        b=HmvFaF91GZm0DymBzoHuOcm36L25FbImJBqbmmxCXNcRLvmmmhn11beqmxS91cgwtO
         ygyU0UDTC2Rv4gSMI2lwGx+J8qehCq+YpnyW/4fR9NksEquu3qcDFodZWMUXKkHXATI2
         gQQ16sZ0jkYCOBZi9U80VhZH7lzbMpaqXl9q//Y4PaHhm88tzrPOqHyNBL1WGzy1CtEg
         gHgMfyhuUBbd7NtveONKtXgQvKQ+nAJPslsRIwRMH6oZCrlG61IrAHbcKp4UISjbavDs
         TmpI/z/5QQswMKpB70MYlgsXaHd+qc5njVsdcKSt2myqneM7cJrHMkGj+O5DC/t+ZuVy
         8kSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ODHhtpuCmlqbjTbHm7GxkArm+DSdAOP3TtnFywy+XCo=;
        b=d8kwV8U1+ZpxeabxK7G1gvneHrfZV+mFTMCKSjDKJ5m6xcy9NynBljhwNhbsA3J+gz
         3wYkGrsuo5Vmh+dFjoaMYPpZWc9p5sK4a5bcNupC7ULaj1iV0Ov4zLlf2KPGAwC99dkn
         U+tEH/sDzRomzUEnQbp3usMwOVPnVwcbuc21c/CJ2Ag4PY3Viqmh7boCrvkBlGJ85ISi
         3/t9aYBmlCuJ3IfFKOPp6OuRx7ZLAjmYQDONhNGwGk9TO54DNz/IWt7iHfvgGKxo8Z2B
         t45gJg54M+UMw1Yi5ATvtCcEPMyEi5AeNnu3AKwMAo9hadRPeDR4v1ex158gpbLef9B4
         Az4A==
X-Gm-Message-State: AOAM531EAezlv+dK1N3GMOr5mcCZGtUSZtYT3g0Od8rAaPbfghT8e5Zf
        qiqzASOhCU0TeI84yIIEihGUq9nUhpctcA==
X-Google-Smtp-Source: ABdhPJwwYsaVtN/JMQj85M9Nhk3qx3KgFaCxZJu9P/WNzNz0qAG506UC4zor7KqLyhQWoeAaS86hvw==
X-Received: by 2002:adf:9d85:: with SMTP id p5mr17950595wre.694.1643107611071;
        Tue, 25 Jan 2022 02:46:51 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:6406:77e0:3787:258a? ([2a01:e34:ed2f:f020:6406:77e0:3787:258a])
        by smtp.googlemail.com with ESMTPSA id j15sm261351wmq.19.2022.01.25.02.46.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jan 2022 02:46:50 -0800 (PST)
Subject: Re: [PATCH v6 2/5] powercap/drivers/dtpm: Add hierarchy creation
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     rjw@rjwysocki.net, robh@kernel.org, lukasz.luba@arm.com,
        heiko@sntech.de, arnd@linaro.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>
References: <20220119085719.1357874-1-daniel.lezcano@linaro.org>
 <20220119085719.1357874-3-daniel.lezcano@linaro.org>
 <CAPDyKFrtq0J2O0WBwLr7Zb+WkomhLcR1h+eDzzV-SxpiJmm_yQ@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <061cd428-c022-4058-9a11-c5dbe3cb9777@linaro.org>
Date:   Tue, 25 Jan 2022 11:46:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFrtq0J2O0WBwLr7Zb+WkomhLcR1h+eDzzV-SxpiJmm_yQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/01/2022 21:00, Ulf Hansson wrote:
> On Wed, 19 Jan 2022 at 09:58, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>>
>> The DTPM framework is available but without a way to configure it.
>>
>> This change provides a way to create a hierarchy of DTPM node where
>> the power consumption reflects the sum of the children's power
>> consumption.
>>
>> It is up to the platform to specify an array of dtpm nodes where each
>> element has a pointer to its parent, except the top most one. The type
>> of the node gives the indication of which initialization callback to
>> call. At this time, we can create a virtual node, where its purpose is
>> to be a parent in the hierarchy, and a DT node where the name
>> describes its path.
>>
>> In order to ensure a nice self-encapsulation, the DTPM subsys array
>> contains a couple of initialization functions, one to setup the DTPM
>> backend and one to initialize it up. With this approach, the DTPM
>> framework has a very few material to export.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---
>>  drivers/powercap/Kconfig |   1 +
>>  drivers/powercap/dtpm.c  | 168 ++++++++++++++++++++++++++++++++++++++-
>>  include/linux/dtpm.h     |  15 ++++
>>  3 files changed, 181 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/powercap/Kconfig b/drivers/powercap/Kconfig
>> index 8242e8c5ed77..b1ca339957e3 100644
>> --- a/drivers/powercap/Kconfig
>> +++ b/drivers/powercap/Kconfig
>> @@ -46,6 +46,7 @@ config IDLE_INJECT
>>
>>  config DTPM
>>         bool "Power capping for Dynamic Thermal Power Management (EXPERIMENTAL)"
>> +       depends on OF
>>         help
>>           This enables support for the power capping for the dynamic
>>           thermal power management userspace engine.
>> diff --git a/drivers/powercap/dtpm.c b/drivers/powercap/dtpm.c
>> index 0e5c93443c70..10032f7132c4 100644
>> --- a/drivers/powercap/dtpm.c
>> +++ b/drivers/powercap/dtpm.c
>> @@ -23,6 +23,7 @@
>>  #include <linux/powercap.h>
>>  #include <linux/slab.h>
>>  #include <linux/mutex.h>
>> +#include <linux/of.h>
>>
>>  #include "dtpm_subsys.h"
>>
>> @@ -463,14 +464,175 @@ int dtpm_register(const char *name, struct dtpm *dtpm, struct dtpm *parent)
>>         return 0;
>>  }
>>
>> -static int __init init_dtpm(void)
>> +static struct dtpm *dtpm_setup_virtual(const struct dtpm_node *hierarchy,
>> +                                      struct dtpm *parent)
>>  {
>> +       struct dtpm *dtpm;
>> +       int ret;
>> +
>> +       dtpm = kzalloc(sizeof(*dtpm), GFP_KERNEL);
>> +       if (!dtpm)
>> +               return ERR_PTR(-ENOMEM);
>> +       dtpm_init(dtpm, NULL);
>> +
>> +       ret = dtpm_register(hierarchy->name, dtpm, parent);
>> +       if (ret) {
>> +               pr_err("Failed to register dtpm node '%s': %d\n",
>> +                      hierarchy->name, ret);
>> +               kfree(dtpm);
>> +               return ERR_PTR(ret);
>> +       }
>> +
>> +       return dtpm;
>> +}
>> +
>> +static struct dtpm *dtpm_setup_dt(const struct dtpm_node *hierarchy,
>> +                                 struct dtpm *parent)
>> +{
>> +       struct device_node *np;
>> +       int i, ret;
>> +
>> +       np = of_find_node_by_path(hierarchy->name);
>> +       if (!np) {
>> +               pr_err("Failed to find '%s'\n", hierarchy->name);
>> +               return ERR_PTR(-ENXIO);
>> +       }
>> +
>> +       for (i = 0; i < ARRAY_SIZE(dtpm_subsys); i++) {
>> +
>> +               if (!dtpm_subsys[i]->setup)
>> +                       continue;
>> +
>> +               ret = dtpm_subsys[i]->setup(parent, np);
>> +               if (ret) {
>> +                       pr_err("Failed to setup '%s': %d\n", dtpm_subsys[i]->name, ret);
>> +                       of_node_put(np);
>> +                       return ERR_PTR(ret);
>> +               }
>> +       }
>> +
>> +       of_node_put(np);
>> +
>> +       /*
>> +        * By returning a NULL pointer, we let know the caller there
>> +        * is no child for us as we are a leaf of the tree
>> +        */
>> +       return NULL;
>> +}
>> +
>> +typedef struct dtpm * (*dtpm_node_callback_t)(const struct dtpm_node *, struct dtpm *);
>> +
>> +dtpm_node_callback_t dtpm_node_callback[] = {
>> +       [DTPM_NODE_VIRTUAL] = dtpm_setup_virtual,
>> +       [DTPM_NODE_DT] = dtpm_setup_dt,
>> +};
>> +
>> +static int dtpm_for_each_child(const struct dtpm_node *hierarchy,
>> +                              const struct dtpm_node *it, struct dtpm *parent)
>> +{
>> +       struct dtpm *dtpm;
>> +       int i, ret;
>> +
>> +       for (i = 0; hierarchy[i].name; i++) {
>> +
>> +               if (hierarchy[i].parent != it)
>> +                       continue;
>> +
>> +               dtpm = dtpm_node_callback[hierarchy[i].type](&hierarchy[i], parent);
>> +               if (!dtpm || IS_ERR(dtpm))
> 
> This can be tested with the "IS_ERR_OR_NULL()" macro.
> 
>> +                       continue;
> 
> We have discussed the error path previously. Just ignoring errors here
> and continuing with the initialization, isn't normally how we design
> good kernel code.
> 
> However, you have also explained that the error path is special and
> somewhat non-trivial to manage in this case. I get that now and thanks
> for clarifying.
> 
> Nevertheless, I think it deserves to be explained a bit with a comment
> in the code of what goes on here. Otherwise another developer that
> looks at this code in the future, may think it looks suspicious too.
> 
>> +
>> +               ret = dtpm_for_each_child(hierarchy, &hierarchy[i], dtpm);
>> +               if (ret)
>> +                       return ret;
>> +       }
>> +
>> +       return 0;
>> +}
> 
> [...]
> 
> Other than the above, this looks good to me!

With the above fixed, shall I add your reviewed-by ?


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
