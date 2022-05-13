Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 639AC52628A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 15:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380532AbiEMNDm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 09:03:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240402AbiEMNDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 09:03:38 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0664F46143;
        Fri, 13 May 2022 06:03:38 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id y63so10022429oia.7;
        Fri, 13 May 2022 06:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=kvr3Begq22WBEyGxs8maYiCPrh4so4dTPZyog74y3T0=;
        b=YEwfmmlyZgqYrhuuDmRqATA6c7fMLLPBB8Q4BEMYK9Q6dPk4H60yVoLqKvQ3McY3LX
         LlnqOlKnORu4h0Su6I99mUzvs2ZzOjbgFH1MIjRAH+bilFShhl3GQpSFIWcSWkaTobQy
         I17wACj+3C+EPBxzi1oIVp4g1Qid9PZ/DjO0MH0yiIwDpC1sGDKVWeXqcbwIBszoQShc
         hmH1K9r23wJNvnMbLzDCg4jC+nMP2OumCdld6ZYXg+Ps2JYsiC7LeVuJk1as+ymHuBbo
         prGUjklpod1UeSBpDe+pYmZ+2lf0gpe7ikxTsKqRwytDeKenJTxGOSmHM+0PTb+Iq1R/
         C3aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=kvr3Begq22WBEyGxs8maYiCPrh4so4dTPZyog74y3T0=;
        b=DtmyMAmWJ7cCo7NYZb0bYxeF53zJVVi8jzcjqemXzh7nnrN5NCfqO4bgwyHErHKjmJ
         MNfdlQHf8n7D7cnjRsP4Pe7UXXcrnwwDH6MhcU5S6QJO6MtUQ/M+mGa1I/lwJR/tYens
         C3vrbmwFUGD/RZJIT1V1UcDqBG+2t6xlVgA0ZbvtphSkWHSpc1+WAblTmvHpCKHAAuDq
         mQlAMkxk4IAjXRBRclDMyIq2c7FHXcsLPn2HBHJKJSONOg/cYb4qf/n8jjFQiTmMdhJM
         JkMgCiYfaRrfovdipY6X5D8j0Q+HrWLPJ/ZrFejj8weosWpOhxgJGmM1hxIgP9ltNkKG
         E+HQ==
X-Gm-Message-State: AOAM531ESnpn4xIgb0KWB7s4P9VUcQy7HUZeW54GOdG+rV27tHGzrlKy
        LP+TjSk9U/HH/IWSBtlfAmI=
X-Google-Smtp-Source: ABdhPJy9SpVg/HP+p2qRJ/JoVGVlKj308DrO7IZ5HYDFdxJU8QkkiAsBKN6uumQtGcsyF34bjicmWQ==
X-Received: by 2002:a54:4505:0:b0:325:e50c:a71 with SMTP id l5-20020a544505000000b00325e50c0a71mr7274438oil.70.1652447015822;
        Fri, 13 May 2022 06:03:35 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id ep36-20020a056870a9a400b000e686d1387bsm999102oab.21.2022.05.13.06.03.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 May 2022 06:03:35 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <83c22b32-d3e0-eb85-02b5-0068dcf0412f@roeck-us.net>
Date:   Fri, 13 May 2022 06:03:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v3 2/2] hwmon: acpi_power_meter: convert to
 hwmon_device_register_with_info
Content-Language: en-US
To:     LABBE Corentin <clabbe@baylibre.com>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>
References: <20220509063010.3878134-1-clabbe@baylibre.com>
 <20220509063010.3878134-3-clabbe@baylibre.com>
 <e5f6c712-efed-2126-de2b-9a0d09150e7b@roeck-us.net> <Yn4QhhTI7t6Gi+fE@Red>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <Yn4QhhTI7t6Gi+fE@Red>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/13/22 01:02, LABBE Corentin wrote:
> Le Wed, May 11, 2022 at 07:10:29PM -0700, Guenter Roeck a écrit :
>> Corentin,
>>
>> On 5/8/22 23:30, Corentin Labbe wrote:
>>> Booting lead to a hwmon_device_register() is deprecated. Please convert the driver to use hwmon_device_register_with_info().
>>> So let's convert the driver to use hwmon_device_register_with_info().
>>>
>>> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
>>> ---
>> [ ... ]
>>
>>> @@ -836,20 +740,20 @@ static void acpi_power_meter_notify(struct acpi_device *device, u32 event)
>>>    		if (res)
>>>    			break;
>>>    
>>> -		remove_attrs(resource);
>>> +		remove_domain_devices(resource);
>>>    		setup_attrs(resource);
>>
>> Zhang Rui found an interesting problem with this code:
>> It needs a call to sysfs_update_groups(hwmon_dev->groups)
>> to update sysfs attribute visibility, probably between
>> remove_domain_devices() and setup_attrs().
>>
>>>    		break;
>>>    	case METER_NOTIFY_TRIP:
>>> -		sysfs_notify(&device->dev.kobj, NULL, POWER_AVERAGE_NAME);
>>> +		hwmon_notify_event(&device->dev, hwmon_power, hwmon_power_average, 0);
>>
>> ... which makes realize: The notification device should be the hwmon device.
>> That would be resource->hwmon_dev, not the acpi device.
>>
> 
> Hello
> 
> I will fix this, but do you have an example how to test thoses code path easily ?
> 

No, sorry.

Guenter
