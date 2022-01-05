Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C80C485657
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 17:00:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241765AbiAEQAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 11:00:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241756AbiAEQAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 11:00:20 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24CB5C061201
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 08:00:20 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id o30so23322431wms.4
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jan 2022 08:00:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OsIo63TaJf5IMnoCC04rGUJ5yO3jh/yMaxDgfSCEg3A=;
        b=zHgQTr15GcuEmqgs5pY/TFxSoDxtYxBhz0Lo6+zoUnt9pkevuN0ihHBqfKUo5pa7pS
         jlJFjSemCr2pNeW6BHCrgmxuTeYSo3A2FA6HkAYHKLRegmMMAyIpnRUSiwyuVC0eveHm
         gy6gpUPCnIUantWtktjTeWiutkyP2QGhTBjProouYGWuBtw+IO3ZlG4R37G13uuSZ9o+
         okMUYL0HQoGtPCpbv9sFDQ5/KzcQLK4OPlOyvTAFunEnm4Zjbw+Vs3ienKu2u4ieKx/9
         ZMUIP7oqkhWmmH5tJcPEuIyHFNBC87IPeyPMspNnPDWAimOZ2aHqyXVnXPfV9+xNrrBB
         05Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OsIo63TaJf5IMnoCC04rGUJ5yO3jh/yMaxDgfSCEg3A=;
        b=azNdEnJlSaXsXjdKNZtTgPH4HMy9PqaXUZCkqH+MN+sgeetmmsn2Q+OAspc6iO0Gb+
         ctHhWGaLltTRwi9xJbHi+yy24s2xDDI8Z3vEh3Z82Yq5mGRRUK3k+aqxDQvpHu/hoCCJ
         CsoRHC1AzFvaFP5qbxfcS+6gQbVMmL8I0UKiCtaa/luYKugUVqyNilXHXLnk8PmiMLDf
         kehbDbCuotzumgOy7XDjSdtuERMZ+tQLN8Pa3oXEr2qMVc+cSogGXkGr4DVAG7HCPxcd
         9m4SK84KAt/Bnni0pffJ/CY62bnkp9QeDoQKhxVXSInmuNdkIW9NSfH06+sTdBYWJHKi
         zRAQ==
X-Gm-Message-State: AOAM530Q4tuXmRQ6v/YfdkONekhRm1+MsvWiZPBc2fiRTCfT5zPy/cth
        /3nhSSH+7XBpf1gUHkYDzUAbEA==
X-Google-Smtp-Source: ABdhPJwe8DDWfcyC6KbDtO8Xoq30PvrV29yHpsaNgEBsUGb11Gk8yrxaQv77LC6DepasDzirBCCh0g==
X-Received: by 2002:a05:600c:2f97:: with SMTP id t23mr2345181wmn.85.1641398418421;
        Wed, 05 Jan 2022 08:00:18 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:9997:55b1:2e48:dc4a? ([2a01:e34:ed2f:f020:9997:55b1:2e48:dc4a])
        by smtp.googlemail.com with ESMTPSA id a2sm47146853wri.17.2022.01.05.08.00.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jan 2022 08:00:17 -0800 (PST)
Subject: Re: [PATCH v5 2/6] powercap/drivers/dtpm: Add hierarchy creation
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     rjw@rjwysocki.net, lukasz.luba@arm.com, robh@kernel.org,
        heiko@sntech.de, arnd@linaro.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>
References: <20211218130014.4037640-1-daniel.lezcano@linaro.org>
 <20211218130014.4037640-3-daniel.lezcano@linaro.org>
 <CAPDyKFrLTsUxG8JHdK33h2BT8pxeHk6kiU-4uGrvxUhcQKg3Sw@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <8fcc0ef8-b0c7-da73-434f-31c88896aed5@linaro.org>
Date:   Wed, 5 Jan 2022 17:00:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFrLTsUxG8JHdK33h2BT8pxeHk6kiU-4uGrvxUhcQKg3Sw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/12/2021 14:45, Ulf Hansson wrote:

[ ... ]

>> +static struct dtpm *dtpm_setup_dt(const struct dtpm_node *hierarchy,
>> +                                 struct dtpm *parent)
>> +{
>> +       struct dtpm_descr *dtpm_descr;
>> +       struct device_node *np;
>> +       int ret;
>> +
>> +       np = of_find_node_by_path(hierarchy->name);
>> +       if (!np) {
>> +               pr_err("Failed to find '%s'\n", hierarchy->name);
>> +               return ERR_PTR(-ENXIO);
>> +       }
>> +
>> +       for_each_dtpm_table(dtpm_descr) {
>> +
>> +               ret = dtpm_descr->setup(parent, np);
> 
> This will unconditionally call the ->setup callback() for each dtpm
> desc in the dtpm table. At this point the ->setup() callback has not
> been assigned by anyone that uses DTPM_DECLARE(), so if this would be
> called, it would trigger a NULL pointer dereference error.
> 
> On the other hand, we don't have someone calling
> dtpm_create_hierarchy() yet, so this code doesn't get exercised, but

Yes, that is the reason why the test is not here.

> it still looks a bit odd to me. Maybe squashing patch2 and patch3 is
> an option?
Sure

>> +               if (ret) {
>> +                       pr_err("Failed to setup '%s': %d\n", hierarchy->name, ret);
>> +                       of_node_put(np);
>> +                       return ERR_PTR(ret);
>> +               }
>> +
>> +               of_node_put(np);
> 
> This will be called for every loop in the dtpm table. This is wrong,
> you only want to call it once, outside the loop.

Right, good catch

>> +       }
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
>> +                       continue;
>> +
>> +               ret = dtpm_for_each_child(hierarchy, &hierarchy[i], dtpm);
> 
> Why do you need to recursively call dtpm_for_each_child() here?
> 
> Is there a restriction on how the dtpm core code manages adding
> children/parents?

[ ... ]

The recursive call is needed given the structure of the tree in an array
in order to connect with the parent.


>> + *
>> + * struct dtpm_node hierarchy[] = {
>> + *     [0] { .name = "topmost" },
> 
> For clarity, I think we should also specify DTPM_NODE_VIRTUAL here.
> 
>> + *      [1] { .name = "package", .parent = &hierarchy[0] },
> 
> Ditto.

Sure

[ ... ]

>> +static int __init init_dtpm(void)
>> +{
>>         pct = powercap_register_control_type(NULL, "dtpm", NULL);
>>         if (IS_ERR(pct)) {
>>                 pr_err("Failed to register control type\n");
>>                 return PTR_ERR(pct);
>>         }
> 
> It looks like powercap_register_control_type() should be able to be
> called from dtpm_create_hierarchy(). In this way we can simply drop
> the initcall below, altogether.
>
> Of course, that assumes that dtpm_create_hierachy() is being called
> from a regular module_platform_driver() path - or at least from a
> later initcall than fs_initcall(), which is when the "powercap_class"
> is being registered. But that sounds like a reasonable assumption we
> should be able to make, no?

Yes, agree. Good suggestion, I will do the change.

[ ... ]

>>  int dtpm_register(const char *name, struct dtpm *dtpm, struct dtpm *parent);
>>
>> +int dtpm_create_hierarchy(struct of_device_id *dtpm_match_table);
> 
> To start simple, I think dtpm_create_hiearchy() is the sufficient
> interface to add at this point.
> 
> However, it's quite likely that it's going to be called from a regular
> module (SoC specific platform driver), which means it needs to manage
> ->remove() operations too. Anyway, I am fine if we look into that as
> improvements on top of the $subject series.

Yes, ATM, the modules can not be unloaded on purpose. The removal can be
added later


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
