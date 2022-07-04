Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C88CF565F17
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 23:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234559AbiGDVZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 17:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234183AbiGDVYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 17:24:34 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8285111835
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 14:24:29 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id v14so14958507wra.5
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 14:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=K1zsnTZeP71xcq6/4jCrDaSeHSVbNI/dcdfTDxzZdJU=;
        b=tnoQbaOWxG/vu+qyqQ9yuyJNNA+r7LFQp0N3e2xgoFXfXzEDubdBL/ebEsXAm/nMZU
         QoN6hvTqCtJ9WVpmBJWGrFtg1YpypAvx0MPEaqWjczAJ5DApl1GZMibmbXkTtMc4jGME
         1CIxvXAhnavM7jvLS8wWd3/EFzSA0Pwd54H9nhI72Iaxy2y3KM6XYHBsF3RY4h46SNQi
         9RdWmq4d6AfzBvLqM8xlf2W95NwEfCoH1WQwtcebVwsHG7Ot5Fo8QVq+HJVyCvxrqjeV
         gShmnsiKyKgjjtVhddZqvGqmK73HnehxVo88Im13UicwDLkWQJCHH+AV+ZJ9ok1bpJRa
         bL2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=K1zsnTZeP71xcq6/4jCrDaSeHSVbNI/dcdfTDxzZdJU=;
        b=Bck6weSV/Azdla/AHtFcKA4wFdpALjI3SgvsqJ4e51GDmo9240gnWKuhtDjcKr4jwY
         luA9Zrz36mZvs7ozMzgQ5x4OIRfucTqUCBZ9HKo1v8LprLrwj9VPS0z1LuxYvpo0n6b9
         k0WGyJQ0phs4dqPacDZ3z7lfobjguE4HKBGYzi1q/s4mh1GeJ/9VH9j3DKEHWt79u8v1
         HQTlb98OJXNa4Qoq6IuYD+MmX/pqeOZBGqB7yjq2MzMXEbSdUdeDFG0plllBA91oe6eg
         yBuPr5THTIpy0jwHa/sHobF5xEGipBDaNIt7U4xIVDsBXFwSZfiIgM9/SYWJSmAheGEM
         ByyA==
X-Gm-Message-State: AJIora/EtUyDv5Gge4ZzMeIaxmhK1objXkqPRRf2oDyLXfsJOq52V2Hj
        Fs9k2VUM7brflTkhyCKGYq/FiHZn3FhB+g==
X-Google-Smtp-Source: AGRyM1sr6TxLW6JQZgXRLjX3krb5qDHxESaO7PpS+06IYyc/F7xjv1kP8SWhEvfUffbXGNXKE7jx0Q==
X-Received: by 2002:a05:6000:1446:b0:21d:2245:ab65 with SMTP id v6-20020a056000144600b0021d2245ab65mr28670994wrx.315.1656969868142;
        Mon, 04 Jul 2022 14:24:28 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id bn24-20020a056000061800b0020fe35aec4bsm30258258wrb.70.2022.07.04.14.24.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Jul 2022 14:24:27 -0700 (PDT)
Message-ID: <f16d855b-28b0-b4ee-0e42-7293d0e61c21@linexp.org>
Date:   Mon, 4 Jul 2022 23:24:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3 11/12] thermal/of: Use thermal trips stored in the
 thermal zone
Content-Language: en-US
To:     Zhang Rui <rui.zhang@intel.com>, daniel.lezcano@linaro.org,
        rafael@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        khilman@baylibre.com, abailon@baylibre.com,
        Amit Kucheria <amitk@kernel.org>
References: <20220703183059.4133659-1-daniel.lezcano@linexp.org>
 <20220703183059.4133659-12-daniel.lezcano@linexp.org>
 <6c7e1865e7e68ac0f035680044eb878ced715a1b.camel@intel.com>
From:   Daniel Lezcano <daniel.lezcano@linexp.org>
In-Reply-To: <6c7e1865e7e68ac0f035680044eb878ced715a1b.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/07/2022 16:14, Zhang Rui wrote:
> On Sun, 2022-07-03 at 20:30 +0200, Daniel Lezcano wrote:
>> Now that we have the thermal trip stored in the thermal zone in a
>> generic way, we can rely on them and remove one indirection we found
>> in the thermal_of code and do one more step forward the removal of
>> the
>> duplicated structures.
>>
>> Cc: Alexandre Bailon <abailon@baylibre.com>
>> Cc: Kevin Hilman <khilman@baylibre.com>
>> Cc; Eduardo Valentin <eduval@amazon.com>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>
>> ---

[ ... ]

>>   EXPORT_SYMBOL_GPL(of_thermal_get_ntrips);
>>   
>> @@ -139,9 +134,7 @@ EXPORT_SYMBOL_GPL(of_thermal_get_ntrips);
>>    */
>>   bool of_thermal_is_trip_valid(struct thermal_zone_device *tz, int
>> trip)
>>   {
>> -	struct __thermal_zone *data = tz->devdata;
>> -
>> -	if (!data || trip >= data->ntrips || trip < 0)
>> +	if (trip >= tz->ntrips || trip < 0)
>>   		return false;
>>   
>>   	return true;
>> @@ -161,12 +154,7 @@ EXPORT_SYMBOL_GPL(of_thermal_is_trip_valid);
>>   const struct thermal_trip *
>>   of_thermal_get_trip_points(struct thermal_zone_device *tz)
>>   {
>> -	struct __thermal_zone *data = tz->devdata;
>> -
>> -	if (!data)
>> -		return NULL;
>> -
>> -	return data->trips;
>> +	return tz->trips;
>>   }
>>   EXPORT_SYMBOL_GPL(of_thermal_get_trip_points);
> 
> what is the difference between
> of_thermal_get_ntrips/of_thermal_get_trip_points and
> thermal_zone_get_ntrips/thermal_zone_get_trips as introduced in this
> patch series?
> 
> we need to remove the duplications.

There is no difference between those functions. There are 34 more 
patches in the pipe to be sent after this series to do more cleanups and 
remove code duplication.


