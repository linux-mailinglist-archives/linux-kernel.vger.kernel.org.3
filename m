Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFFF552AA65
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 20:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350503AbiEQSPc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 14:15:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbiEQSP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 14:15:29 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A7671FA68
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 11:15:28 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id f10so6223263pjs.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 11:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=5MIOs9ZQETChvxlBzZ2KtZj7CH5Bf4PZZcNMjN//C1k=;
        b=h1lh0h2PqCf/2EMtqQu1F0SuL1g0y217799nXSUL5/7B5fU8rLVVPXFvUSkKAectXV
         7HdRbbdT6JcKa4emntE25nmplanhnH3cbgCLQKp2d+nYNsNEOxaeFFvc5j7kYkkWmkhS
         znE55a3AQKWyqZxlySMSgC26Fa4EuhRaDGxR0XF6TvmEfdkENRMlJbu72J3toc1a+vo0
         io5DqAHOlHaFpe0OpHohBUwlyxNEGP0RTWHKj3aGg7m17m2/maiH8mSDWCrZ1Bp5B28/
         873yowgAb6lgzHkg6flnvhxJ+U/4/JL5YBvixqK1u8w92iB9g9wAo8WrXXkVWOkKCdqz
         XY6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=5MIOs9ZQETChvxlBzZ2KtZj7CH5Bf4PZZcNMjN//C1k=;
        b=mBwglY3+dmZGeeEz0ODEWub1PpP36PW9yV54ypvjK5E6cl5OlT18QBCFy2Zl+dCoHn
         Z21lKErkW9dT667ffSEFJV94+wddPFYcJiof5G5xvbWZODmbuA05kleSk01u+plc8qhs
         hUD4YAfV6s/fPvldMRtfPYAQsGcCTW8ol3d9n8S2D5gXaCZnfak1gZ66OanuJsPasK17
         WFaxFyGJDIC2fRujTCin5gf4isJfNJaJH2wpvQ+D2763fefi8U5WMWM29DGuAvuWdXkM
         qg46fmx5YYft6Dgu6QRyWRO/h8VUlysLrRHsiNnpAuKlciRjr8B64x2U3huloU32XsAS
         Kl/g==
X-Gm-Message-State: AOAM531RCFaOSSkglKo9+VFDNH2niFauo7Pe1OjtkrzoA2d5MWI4bqm3
        Lqky4u+sUHSGB1TV0j9tT4g=
X-Google-Smtp-Source: ABdhPJzfdrUX0I3Ef9b6ZfFUov+il2klRQ8ibKsEmlWT//prbekfuPElSeJkHOF4iRqKgDpjHbA64g==
X-Received: by 2002:a17:902:700b:b0:15f:a51a:cdeb with SMTP id y11-20020a170902700b00b0015fa51acdebmr23136711plk.137.1652811327660;
        Tue, 17 May 2022 11:15:27 -0700 (PDT)
Received: from [172.30.1.37] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id d2-20020a170902cec200b0015e8d4eb2dasm9528150plg.292.2022.05.17.11.15.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 May 2022 11:15:27 -0700 (PDT)
Message-ID: <3f917cf0-72c7-91ab-c8e9-eef02889c7b1@gmail.com>
Date:   Wed, 18 May 2022 03:15:23 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 2/2] extcon: Add extcon-regulator driver
Content-Language: en-US
To:     Zev Weiss <zev@bewilderbeest.net>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        openbmc@lists.ozlabs.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>
References: <20220505232557.10936-1-zev@bewilderbeest.net>
 <20220505232557.10936-3-zev@bewilderbeest.net>
 <e27ff1b2-c82f-8335-340f-ae1fa914ed30@gmail.com>
 <YnkyIBh2HnXXLHw3@sirena.org.uk>
 <CGME20220517010322epcas1p45d7fdaa06d23f07533350b7d0cf9e9d6@epcas1p4.samsung.com>
 <YoL0UGR+TiZojL9Y@hatter.bewilderbeest.net>
 <bc6595c8-5f05-ac2c-63e0-f442f9ec83be@samsung.com>
 <YoNz9NPLkYSd8i/s@hatter.bewilderbeest.net>
From:   Chanwoo Choi <cwchoi00@gmail.com>
In-Reply-To: <YoNz9NPLkYSd8i/s@hatter.bewilderbeest.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22. 5. 17. 19:07, Zev Weiss wrote:
> On Mon, May 16, 2022 at 08:15:31PM PDT, Chanwoo Choi wrote:
>> Hi Mark, Zev,
>>
>> On 5/17/22 10:03 AM, Zev Weiss wrote:
>>> [Adding Sebastian for drivers/power discussion]
>>>
>>> On Mon, May 09, 2022 at 08:24:16AM PDT, Mark Brown wrote:
>>>> On Mon, May 09, 2022 at 09:24:39PM +0900, Chanwoo Choi wrote:
>>>>> Hi Zev,
>>>>>
>>>>> I checked this patch. But, it doesn't look like the extcon provider
>>>>> driver. Because basically, extcon provider driver need the circuit
>>>>> in order to detect the kind of external connector. But, there are
>>>>> no any code for detection. Just add the specific sysfs attribute
>>>>> for only this driver. It is not standard interface.
>>>>
>>>> OTOH it's something where if I look at the physical system with the
>>>> hardware there's a clearly visible external connector that I can point
>>>> to - it just happens to not support hotplug.  It's not clear what other
>>>> system it would sit in, and it seems like an application that displays
>>>> external connections on a system in a UI would be able to do something
>>>> sensible with it.
>>>
>>> Chanwoo, any further thoughts on Mark's reasoning above?
>>>
>>> I certainly understand the reluctance to add an extcon driver that 
>>> doesn't really do anything with the extcon API, and I have no idea when 
>>> we might end up enhancing it to do something more meaningful with that 
>>> API (I don't know of any hardware at the moment that would need it).
>>>
>>> That said, as Mark points out, the hardware *is* ultimately an "external 
>>> connector" (if a very simplistic one).
>>>
>>> Do you have any other ideas for where this functionality could go?  Greg 
>>> wasn't enthusiastic about a previous revision that had it in 
>>> drivers/misc -- though now a fair amount of what was in that version is 
>>> now going to be in the regulator core, so maybe that could be 
>>> reconsidered?
>>>
>>> Or maybe something under drivers/power, though it's not really a supply 
>>> or a reset device...drivers/power/output.c or something?
>>>
>>> Personally I don't have any terribly strong opinions on this, I'd just 
>>> like to reach a mutually-agreeable consensus on a place for it to live.
>>>
>>
>> After Mark's reply, I considered extcon provider driver without hotplug
>> feature. I think that extcon need to support the following something:
>>
>> 1. Need to specify the type of external connector instead of EXTCON_NONE.
>> 2. extcon subsystem provides the standard sysfs interface
>>    for non-hotplug extcon provider driver.
>> 3. User can control the state of external connector via
>>    the standard extcon sysfs attributes.
>>
>>
>> For example of extcon provider driver,
>> static const unsigned int supported_cables[] = {
>> 	EXTCON_USB,
>> 	EXTCON_NONE,
>> };
>>
>> int extcon_usb_callback(int connector_id, int property_id, int state, void *data) {
>> 	struct extcon_dev *edev = data;
>>
>> 	if (id == EXTCON_USB && property_id == EXTCON_NOT_HOTPLUG) {
>> 		regulator_enable() or regulator_disable()
>> 	}
>>
>> 	return 0;
>> }
>>
>> int extcon_provider_probe(...) {
>> 	edev = devm_extcon_dev_allocate(dev, supported_cables);
>>
>> 	devm_extcon_dev_register(dev, edev);
>>
>> 	extcon_set_property_capability(edev, EXTCON_USB, EXTCON_NOT_HOTPLUG);
>> 	extcon_set_property_callback(edev, EXTCON_USB, extcon_usb_callback);
>>
>> 	...
>> }
>>
>> And then user can change the state of each external connector
>> via '/sys/class/extcon/extcon0/cable.0/state' 
>> if cable.0 contains the EXTCON_NOT_HOTPLUG property.
>>
>> I'm designing this approach. But it has not yet decided
>> because try to check that this approach is right or not.
>>
> 
> Okay, so if I'm understanding correctly we'd be using the extcon 
> subsystem's existing attached/detached state to model (and control) the 
> on/off state of the power output?

The extcon provides the sysfs interface to control the state of each cable
and then passes the extra role to each extcon provider driver with using
the registered callback. The extcon core don't care the detailed operation
in registered callback. Just provide the interface from sysfs interface
to extcon provider driver and then handle the state of external connector.

In your case, you might enable/disable the regulator on the registered callback
like extcon_usb_callback in example.

> 
> That could work for the particular hardware I'm dealing with at the 
> moment, though I'd be a bit concerned that conflating the two might 
> constrain things in the future if there's some similar but slightly more 
> sophisticated hardware we'd want to extend the same driver to support.  
> For example on a power connector with some capability for presence 
> detection, we might want to be able to support "attached but powered 
> off" as a valid state for it to be in -- would the above approach be 
> able to do that?

Yes. As I mentioned above, the regulator control is extra role
for the specific extcon provider driver. Any extcon provider driver
without hotplug feature might control the audio volume in the registered
callback like extcon_usb_callback in example. The extra job depends
on the extcon provider driver.

> 
> 
> Thanks,
> Zev
> 


-- 
Best Regards,
Samsung Electronics
Chanwoo Choi
