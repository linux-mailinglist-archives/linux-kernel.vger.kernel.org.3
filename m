Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6619247CB83
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 04:09:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242039AbhLVDJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 22:09:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbhLVDI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 22:08:59 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F7D2C061574;
        Tue, 21 Dec 2021 19:08:59 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id 47-20020a9d0332000000b005798ac20d72so1008232otv.9;
        Tue, 21 Dec 2021 19:08:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0sZ36XFv1tC6Scd0xjGBrQm0gcAyHl/g9SBMsUgYs3g=;
        b=FRJRyg2aNtpN2HgtQo9fu28eTTJzPpfE9xMyNKkVTUc8Y/u6DAVWs/CeiUBRoFslQI
         abs1LRgKTkHxG0rQlyzDWp9IvAn97G4OPq4h9rUEcIYH9yhlSc44VZlJfmAnyvZpbsTF
         pVp49Ner2R/PsX6hrRhhVASotzthbtuGrIpJXY/g5vK3W/uLAfd2outauhD9QLz/yW0s
         x+wVdL4i9jF1JGUoFt/gVcOUm1/ScgyKjTOpxwYbCgoxX7rUWX6Bru2AF8XJuXdz4m6Z
         pcn5ZGCZiwOdNHSvX6TOaQ82qIiAsk0pBPWQGsUK2Wp31Saj1wvxiKHPFXkH6WDQj44U
         3sPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0sZ36XFv1tC6Scd0xjGBrQm0gcAyHl/g9SBMsUgYs3g=;
        b=X6q0d+81x9uwj/4hKGtqOuik5P3pJ+m7vg8G6rEwSdVMqTB6RBBzXa1SlnvUFrYdSp
         1i3Nw9W+dlGw+3EUoYwnaICwVTTC6ljqW2q5PG+beuoqHnxDKmJtunA0jKthJg/MI6Cg
         Ed7c+AvZZi3WuJkO4u4kusDZcheZ6WKQkXDkaXCj9YxvsAKvFJjeO1Ygzt/wJ0Q3D7tG
         AWt9Hq4wEK7z6zH5yt2VnKCIT7OT39Z5AN/z08pQjELK3EkBkncHujZBbVOd0TU8vFuB
         fuJI8Wg0XJcsb/FsQ19Ks8r5C/s5eZe4UaxscCTVM4Ig2eWZg1efT28wFATNl5nCI3qQ
         3lHg==
X-Gm-Message-State: AOAM531YzenR3T+wBAVRjGUUsVU+UgURcFjxAaL7Tu56piarIZ5Kn6Re
        sV2H0aCPcU+ARWMX7kdPLN4nVDyX3k4=
X-Google-Smtp-Source: ABdhPJw5+fy87s23SsMKufLehyHdHohJIx+VP+fiUI/Ls5j7bOK1W9044U0FxGjWuXhvllyVuG13TA==
X-Received: by 2002:a05:6830:4d:: with SMTP id d13mr874244otp.45.1640142538209;
        Tue, 21 Dec 2021 19:08:58 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x4sm161776oiv.35.2021.12.21.19.08.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Dec 2021 19:08:57 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH v3 3/7] hwmon: (adt7x10) Use
 devm_hwmon_device_register_with_info
To:     Cosmin Tanislav <demonsingur@gmail.com>
Cc:     cosmin.tanislav@analog.com, Jean Delvare <jdelvare@suse.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211221215841.2641417-1-demonsingur@gmail.com>
 <20211221215841.2641417-4-demonsingur@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <ff8b73b0-0c28-e1f3-d254-ea03fb594ffc@roeck-us.net>
Date:   Tue, 21 Dec 2021 19:08:56 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211221215841.2641417-4-demonsingur@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/21/21 1:58 PM, Cosmin Tanislav wrote:
> From: Cosmin Tanislav <cosmin.tanislav@analog.com>
> 
[ ... ]

> +
> +static int adt7x10_read(struct device *dev, enum hwmon_sensor_types type,
> +			u32 attr, int channel, long *val)
> +{
> +	struct adt7x10_data *data = dev_get_drvdata(dev);
> +
> +	switch (attr) {
> +	case hwmon_temp_input:
> +		return adt7x10_temp_read(data, 0, val);
> +	case hwmon_temp_max:
> +		return adt7x10_temp_read(data, 1, val);
> +	case hwmon_temp_min:
> +		return adt7x10_temp_read(data, 2, val);
> +	case hwmon_temp_crit:
> +		return adt7x10_temp_read(data, 3, val);

Ok, so you want to keep using the internal "index" to indicate the
array position in the register cache. I _did_ specifically ask
to use defines for index values in this case. You did not explain
why you ignored this. So now you'll have to explain 1) why you
ignored my request and 2) why you want to keep the code as is.

And, _please_, add a To: recipient to your patches. I am getting
tired having to handle the fallout.

Guenter
