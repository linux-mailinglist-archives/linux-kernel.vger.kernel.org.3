Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EFEC559ECA
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 18:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbiFXQoQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 12:44:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiFXQoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 12:44:15 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A0EE45078;
        Fri, 24 Jun 2022 09:44:14 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id z7so2272488qko.8;
        Fri, 24 Jun 2022 09:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=lxeOf8gRI7b8vqenJT5BFJHtGU3Y5eC0Lv4oQODAS3I=;
        b=iFf3VNIquhKPf+anolpFz7WoZ7alkM5djhS/1ISUHHILKCpYssVLUIftUBhD7kyVIg
         mPjneUZjZU5YNs3Oz287D2wK24vcMRJo8LkhMpke3a/oNkkZdnholy71GJMQ4Hh6iaay
         eqkpzPX6wVuIbQXpc+70U++QUpMKew35TuKG+/NwHJQKzn7HWxncv2/bQFdZQenrePc0
         BVKUrN3Yi5IByJh1Nl5AmDdiIuOPYINw3VMyNADHS9/pVH905vN5AukFbAqwT8xBZncD
         HycL2fk7seNEC0Wf0jN/8+6naXRSuSXmQU8d7uPRzy7Mid+wyYBluVu6VKEyHbLGym36
         dv+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=lxeOf8gRI7b8vqenJT5BFJHtGU3Y5eC0Lv4oQODAS3I=;
        b=sVtoWtdOPrKU5+BH5fAiKfpHA1k06C69yNM+0IKWRDeUS2RhbwjWpCMl5VgAd05alj
         ZjjyTm5Plsxk8wrSjKb8PctqZbpLfPwRnIrNf5Q/RhmA8KtiRqOsoyRix8D+lkOPA7V/
         ogk5Zx0K3b3R96crHNZtLV9FyAfz9vtwtFQ8QuIWTkdawLPgwcD9yZZd2smgKTbVZu+h
         Y31VbfU/TjrqL8s9QuVt0XmhdQR+aPft+AqVUoICQo3ACRUkV7j2LObVNqRw/uj+a389
         jEB0jDidsgfiZKCcO245IimL5Rl17g81YiRSsGPsA+xzUGXbmOJDcxOcH6PyQok2/VO1
         K5vA==
X-Gm-Message-State: AJIora+WQ0b5um9oCM+4gn+SxUt74TEaeT3M+8OWTM9Lm/v1SYq1++KZ
        BUsAMOdCC6B9J5nJ6mYZiNO+EPXJJkyGZg==
X-Google-Smtp-Source: AGRyM1upbhuaWpzC5LYndFf2Uve+B0qHvBXyWbsiOwK4ZUmFW05a55Acw8Q5uC8MlmbM+Of7twaegQ==
X-Received: by 2002:a05:620a:2681:b0:67e:909f:d5ac with SMTP id c1-20020a05620a268100b0067e909fd5acmr35848qkp.125.1656089053234;
        Fri, 24 Jun 2022 09:44:13 -0700 (PDT)
Received: from ?IPV6:2600:1700:2442:6db0:a5d0:6e89:b8e1:59fc? ([2600:1700:2442:6db0:a5d0:6e89:b8e1:59fc])
        by smtp.gmail.com with ESMTPSA id p10-20020a05620a112a00b006a72b38e2ecsm2036103qkk.51.2022.06.24.09.44.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jun 2022 09:44:09 -0700 (PDT)
Message-ID: <6d40876c-2751-01bb-94ab-7c9ab90e636f@gmail.com>
Date:   Fri, 24 Jun 2022 11:44:07 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 1/2] of: create of_root if no dtb provided
Content-Language: en-US
To:     =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lizhi Hou <lizhi.hou@xilinx.com>,
        Allan Nielsen <allan.nielsen@microchip.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Steen Hegelund <steen.hegelund@microchip.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20220624034327.2542112-1-frowand.list@gmail.com>
 <20220624034327.2542112-2-frowand.list@gmail.com>
 <20220624141320.3c473605@fixe.home>
From:   Frank Rowand <frowand.list@gmail.com>
In-Reply-To: <20220624141320.3c473605@fixe.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/24/22 08:13, Clément Léger wrote:
> Le Thu, 23 Jun 2022 22:43:26 -0500,
> frowand.list@gmail.com a écrit :
> 
>>  
>> +/*
>> + * __dtb_empty_root_begin[] magically created by cmd_dt_S_dtb in
>> + * scripts/Makefile.lib
>> + */
>> +extern void *__dtb_empty_root_begin;
>> +
>>  /*
>>   * of_fdt_limit_memory - limit the number of regions in the /memory node
>>   * @limit: maximum entries
>> @@ -1332,8 +1338,13 @@ bool __init early_init_dt_scan(void *params)
>>   */
>>  void __init unflatten_device_tree(void)
>>  {
> 
> Hi Frank,
> 
> This function is only defined when CONFIG_OF_EARLY_FLATTREE is enabled.

More precisely, only if CONFIG_OF_FLATTREE is enabled.  But that would
most likely be seleved by CONFIG_OF_EARLY_FLATTREE, so in practice the
issue you raise is valid.

> Which means that on platforms that do not select this, the default
> empty device-tree creation will not be done.

Yes, so platforms that need this functionality need to select this
option.

> 
> This configuration option is selected by the platform and not by the
> user. On x86, only one config enables this (X86_INTEL_CE) which means
> this won't work on all the other platforms even if CONFIG_OF is
> selected. I would need this to work by only selected CONFIG_OF.

Maybe this means that CONFIG_OF should be changed to select
CONFIG_OF_FLATTREE.  Any opinions on this Rob?

> That's why I decided to add the of_root creation in of_core_init()
> using a function (of_fdt_unflatten()) that is provided if CONFIG_OF is
> defined.

I mentioned this in response to the previous patch series, but will
repeat here for those who might not have read that email thread.

I do not want the root live tree to be created buy different code in
different places; I want one central place where this occurs.  When
the tree can be created in multiple places by different code blocks,
it becomes more difficult to understand the code and more likely that
one of the tree creation code blocks is not updated when another is.

> 
>> -	__unflatten_device_tree(initial_boot_params, NULL, &of_root,
>> +	if (!initial_boot_params) {
>> +		initial_boot_params = (void *) __dtb_empty_root_begin;
>> +		unflatten_and_copy_device_tree();
>> +	} else {
>> +		__unflatten_device_tree(initial_boot_params, NULL, &of_root,
>>  				early_init_dt_alloc_memory_arch, false);
>> +	}
>>  
>>  	/* Get pointer to "/chosen" and "/aliases" nodes for use everywhere */
>>  	of_alias_scan(early_init_dt_alloc_memory_arch);
>> @@ -1373,6 +1384,12 @@ void __init unflatten_and_copy_device_tree(void)
>>  	unflatten_device_tree();
>>  }
>>  
>> +void __init setup_of(void)
>> +{
>> +	if (!of_root)
>> +		unflatten_device_tree();
>> +}
>> +
>>  #ifdef CONFIG_SYSFS
>>  static ssize_t of_fdt_raw_read(struct file *filp, struct kobject *kobj,
>>  			       struct bin_attribute *bin_attr,
>> diff --git a/include/linux/of_fdt.h b/include/linux/of_fdt.h
>> index d69ad5bb1eb1..4566876db351 100644
>> --- a/include/linux/of_fdt.h
>> +++ b/include/linux/of_fdt.h
>> @@ -81,6 +81,7 @@ extern const void *of_flat_dt_match_machine(const void *default_match,
>>  /* Other Prototypes */
>>  extern void unflatten_device_tree(void);
>>  extern void unflatten_and_copy_device_tree(void);
>> +extern void setup_of(void);
>>  extern void early_init_devtree(void *);
>>  extern void early_get_first_memblock_info(void *, phys_addr_t *);
>>  #else /* CONFIG_OF_EARLY_FLATTREE */
>> @@ -91,6 +92,7 @@ static inline void early_init_fdt_reserve_self(void) {}
>>  static inline const char *of_flat_dt_get_machine_name(void) { return NULL; }
>>  static inline void unflatten_device_tree(void) {}
>>  static inline void unflatten_and_copy_device_tree(void) {}
>> +static inline void of_setup(void) {}
> 

> Shouldn't this be setup_of(void) ?

Yes, thanks!  Will fix.

One other thing I need to do is test this patch on a user mode linux
kernel.

-Frank

