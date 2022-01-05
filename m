Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77D33484FEF
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 10:22:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238831AbiAEJWC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 04:22:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiAEJWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 04:22:02 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2D1FC061761
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 01:22:01 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id k18so44894417wrg.11
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jan 2022 01:22:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=36HWW0hYRMzTGJgOF2Hhqt8UhNo3eiE5xA5YF+rYVCA=;
        b=ExXs4oRL1W7tObWa/h9o4bst7B77VUpcnP6vebd/XcxHcsuHjJYP46sBunAzmARIXH
         Fm+aNa7Tp3LTRCU08jKBszK7n0w5rKk8VRmGdj0OJzjUiD4xalgu0gZnZzAdilOWBqWE
         H/ez/MCvgnmaUCsVzwh1q4/jGLXhoKglfWwFtWz/GBcYkK+h860DbRF4VcqAijsnPE87
         ii2W+r6GA+lEj2amkAhEFxiPqXw9ZPT/ZJEyS8yhi9LMcE4OP1eEQiLT06HfgRFLnOpr
         JLBUfQuZHbAfqZJORLmqEOR2vA69h2KXv+NGuygBVhaEFAaSF5mSNy8Zh0240Ry+6+zV
         uGiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=36HWW0hYRMzTGJgOF2Hhqt8UhNo3eiE5xA5YF+rYVCA=;
        b=FvTn13GkpBqdkLR2lXRiDYn4+g5peV/8WZUlt7mVEhbnHwdpclrmOjgoH/2a5OQxEa
         V1bfKoZJtzFD8D6RIbDGwvr3x1UTUFv0aut4+kPbCNTA+lUjfMcsNlkNkPJMb+bdUmn+
         2rdDt6YvhsM0aInKNFWP9q9WBSwzO815e9AZac0Wfz2EsCM37qIchLvFv04LEImfFv1a
         4I/YMw+0wDv9YFbiXwMwV1NYkr2ILEnv1PG7et0/33Lci7Lm3XF3X2YT/jr1bb1IhfwB
         pZ7TrIc8DkDAV6k98bHqvHzbOpYSIagH0MNgiDG9pRZOB3CO+ol8q6mU7lVfzYdPIFyp
         GtEw==
X-Gm-Message-State: AOAM530jlNfwcYxc0OZgfcE2LzWTCvXU2woiNa5CpW5Cy43eviyiiI24
        FMZL16mCeT3Y5f/eh6Mq+MsENw==
X-Google-Smtp-Source: ABdhPJxrVfKVBzchLy0D6aJ/irztUnYgE5NOowgvLeaVDTqUhmw1be6mFqctzKDqkax6Ez+eV65Y4A==
X-Received: by 2002:adf:df09:: with SMTP id y9mr45140559wrl.594.1641374520220;
        Wed, 05 Jan 2022 01:22:00 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:9997:55b1:2e48:dc4a? ([2a01:e34:ed2f:f020:9997:55b1:2e48:dc4a])
        by smtp.googlemail.com with ESMTPSA id b4sm1537957wrw.4.2022.01.05.01.21.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jan 2022 01:21:59 -0800 (PST)
Subject: Re: [PATCH v5 5/6] rockchip/soc/drivers: Add DTPM description for
 rk3399
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Rob Herring <robh@kernel.org>, rjw@rjwysocki.net,
        lukasz.luba@arm.com, heiko@sntech.de, arnd@linaro.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "moderated list:ARM/Rockchip SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC support" 
        <linux-rockchip@lists.infradead.org>
References: <20211218130014.4037640-1-daniel.lezcano@linaro.org>
 <20211218130014.4037640-6-daniel.lezcano@linaro.org>
 <CAPDyKFqWUJTKte3dM=7xG6EtKR8i9neCCNYFs7Jf1J34TezUEQ@mail.gmail.com>
 <CAMuHMdXzs9WMksQAJXdYaQndsqK3CnQZTGYw=TSFVrDEdX8PCA@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <08787cb7-439e-74a4-f268-6c8de0d60a30@linaro.org>
Date:   Wed, 5 Jan 2022 10:21:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdXzs9WMksQAJXdYaQndsqK3CnQZTGYw=TSFVrDEdX8PCA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Geert,

thanks for your feedback

On 04/01/2022 10:29, Geert Uytterhoeven wrote:
> On Fri, Dec 31, 2021 at 2:58 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> On Sat, 18 Dec 2021 at 14:00, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>>> The DTPM framework does support now the hierarchy description.
>>>
>>> The platform specific code can call the hierarchy creation function
>>> with an array of struct dtpm_node pointing to their parent.
>>>
>>> This patch provides a description of the big and Little CPUs and the
>>> GPU and tie them together under a virtual package name. Only rk3399 is
>>> described now.
>>>
>>> The description could be extended in the future with the memory
>>> controller with devfreq if it has the energy information.
>>>
>>> The hierarchy uses the GPU devfreq with the panfrost driver, and this
>>> one could be loaded as a module. If the hierarchy is created before
>>> the panfrost driver is loaded, it will fail. For this reason the
>>> Kconfig option depends on the panfrost Kconfig's option. If this one
>>> is compiled as a module, automatically the dtpm hierarchy code will be
>>> a module also. Module loading ordering will fix this chicken-egg
>>> problem.
>>>
>>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> 
>>> --- /dev/null
>>> +++ b/drivers/soc/rockchip/dtpm.c
>>> @@ -0,0 +1,56 @@
>>> +// SPDX-License-Identifier: GPL-2.0-only
>>> +/*
>>> + * Copyright 2021 Linaro Limited
>>> + *
>>> + * Author: Daniel Lezcano <daniel.lezcano@linaro.org>
>>> + *
>>> + * DTPM hierarchy description
>>> + */
>>> +#include <linux/dtpm.h>
>>> +#include <linux/module.h>
>>> +#include <linux/of.h>
>>> +#include <linux/platform_device.h>
>>> +
>>> +static struct dtpm_node __initdata rk3399_hierarchy[] = {
>>> +       [0]{ .name = "rk3399" },
>>> +       [1]{ .name = "package",
>>> +            .parent = &rk3399_hierarchy[0] },
>>> +       [2]{ .name = "/cpus/cpu@0",
>>> +            .type = DTPM_NODE_DT,
>>> +            .parent = &rk3399_hierarchy[1] },
>>> +       [3]{ .name = "/cpus/cpu@1",
>>> +            .type = DTPM_NODE_DT,
>>> +            .parent = &rk3399_hierarchy[1] },
>>> +       [4]{ .name = "/cpus/cpu@2",
>>> +            .type = DTPM_NODE_DT,
>>> +            .parent = &rk3399_hierarchy[1] },
>>> +       [5]{ .name = "/cpus/cpu@3",
>>> +            .type = DTPM_NODE_DT,
>>> +            .parent = &rk3399_hierarchy[1] },
>>> +       [6]{ .name = "/cpus/cpu@100",
>>> +            .type = DTPM_NODE_DT,
>>> +            .parent = &rk3399_hierarchy[1] },
>>> +       [7]{ .name = "/cpus/cpu@101",
>>> +            .type = DTPM_NODE_DT,
>>> +            .parent = &rk3399_hierarchy[1] },
>>> +       [8]{ .name = "rockchip,rk3399-mali",
>>> +            .type = DTPM_NODE_DT,
>>> +            .parent = &rk3399_hierarchy[1] },
>>> +       [9]{ },
>>> +};
>>
>> I will not object to this, as in the end this seems like what we need
>> to do, unless we can describe things through generic DT bindings for
>> DTPM. Right?
>>
>> Although, if the above is correct, I need to stress that I am kind of
>> worried that this doesn't really scale. We would need to copy lots of
>> information from the DTS files into platform specific c-files, to be
>> able to describe the DTPM hierarchy.
> 
> The description in rk3399_hierarchy[] looks fairly similar to a
> power-domains hierarchy, like we have in e.g. the various
> drivers/soc/renesas/r8*-sysc.c files.  One big difference is that the
> latter do not hardcode the node paths in the driver, but use power
> domain indices, referenced from DT in power-domains properties.
> 
> Perhaps a similar approach can be used for DTPM?
> Does DTPM differ a lot from PM Domains? 

Yes they differ. A DTPM node is a powerzone, a place where we can get
and set the power.

That is the reason why initially a separate binding was proposed.

> If not, perhaps no new
> properties are needed, and power-domains/#power-domain-cells can be
> used as is?




-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
