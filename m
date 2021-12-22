Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 250A147CD04
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 07:35:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242771AbhLVGfe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 01:35:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233215AbhLVGfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 01:35:33 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C447C061574;
        Tue, 21 Dec 2021 22:35:33 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id o20so4452743eds.10;
        Tue, 21 Dec 2021 22:35:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=xEapk50ifuXBbTxNfc6D2mliKNWBBXhcN1w8lp7MAfQ=;
        b=TDGRKkhGj4YL1dapChD6fSZRGEpPyZjt7hbEslO+MX9Ewmpk7A8ER7jwBRzX0Rw07R
         bL0DiHOfJi3EyBLk4NAUbPquXZl5B7Eox0ZngerQaiw5r11uW2Aai1u1LKStJG+8ROAv
         OPeEd7tNcjKFeh3tJtL4eMcnCgsfv9Fnsa8n2iV9HHnG1pWP25za1SS3mANPeWufYwht
         f1ml51USgYuUjx0J0xYkaxmZvbsmJPoAxRuPPxbE8Lvi9VUcbn1AVxGhG+KP3haGgTs/
         /WjGMwjjs8l89F61oGg+BGYLZ4aY1OOInNVkePmtGhCLGEy5enRy3Xm8yGBAGtxEnUuK
         XYuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=xEapk50ifuXBbTxNfc6D2mliKNWBBXhcN1w8lp7MAfQ=;
        b=2OV2OrzvL1ckxg5XGnoL0oxhTOnj0XFhHgc3X0Hw2Wh/2zoONAzG08iAEq4zllqkQj
         p3gkX7cQxfyyFqRAPzg7R+7DjrSGNQDxr/e9rQ2WL5d56LfyQ4bLxn4id/xv0qE6J7bl
         awjXdheazRBwcqBt0bopfW3cPislpirCxJEoCzI/zrV+YKAtjymfe2aGHrmcrc6ugTyz
         K/e0hYbGS3A0Muf6X9XAgOmmduTws8UhJbNJz+bXokTqpznip0/a336LfBPS4SUOJD1y
         ojFBNDb/dXEFIO7l/yoJGWly+ujos5Zvw2EUFMYGoFKlF4LtjdxKl7iXoa42Jz9qV5kZ
         tzcg==
X-Gm-Message-State: AOAM532+jUVMrglNgImjkeFtX/cwoz0kn0OSccNGW1bdneftAZJFjg5a
        CrY01ajvdyTLU6nl7r/8WJs=
X-Google-Smtp-Source: ABdhPJxdPpMJcaer3j8CVjCJbiT1oZiZjxN3vL5MlCbDl+Lm7Cs0kK7/PJizy0g9ydoQDZLff1hHZQ==
X-Received: by 2002:a17:906:cb11:: with SMTP id lk17mr1341890ejb.654.1640154931502;
        Tue, 21 Dec 2021 22:35:31 -0800 (PST)
Received: from [192.168.0.182] ([188.24.42.157])
        by smtp.gmail.com with ESMTPSA id sh11sm347661ejc.17.2021.12.21.22.35.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Dec 2021 22:35:31 -0800 (PST)
Message-ID: <03bf1d99-5411-daca-bc96-319e30b5e836@gmail.com>
Date:   Wed, 22 Dec 2021 08:35:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v3 3/7] hwmon: (adt7x10) Use
 devm_hwmon_device_register_with_info
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     cosmin.tanislav@analog.com, Jean Delvare <jdelvare@suse.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211221215841.2641417-1-demonsingur@gmail.com>
 <20211221215841.2641417-4-demonsingur@gmail.com>
 <ff8b73b0-0c28-e1f3-d254-ea03fb594ffc@roeck-us.net>
From:   Cosmin Tanislav <demonsingur@gmail.com>
In-Reply-To: <ff8b73b0-0c28-e1f3-d254-ea03fb594ffc@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/22/21 05:08, Guenter Roeck wrote:
> On 12/21/21 1:58 PM, Cosmin Tanislav wrote:
>> From: Cosmin Tanislav <cosmin.tanislav@analog.com>
>>
> [ ... ]
> 
>> +
>> +static int adt7x10_read(struct device *dev, enum hwmon_sensor_types 
>> type,
>> +            u32 attr, int channel, long *val)
>> +{
>> +    struct adt7x10_data *data = dev_get_drvdata(dev);
>> +
>> +    switch (attr) {
>> +    case hwmon_temp_input:
>> +        return adt7x10_temp_read(data, 0, val);
>> +    case hwmon_temp_max:
>> +        return adt7x10_temp_read(data, 1, val);
>> +    case hwmon_temp_min:
>> +        return adt7x10_temp_read(data, 2, val);
>> +    case hwmon_temp_crit:
>> +        return adt7x10_temp_read(data, 3, val);
> 
> Ok, so you want to keep using the internal "index" to indicate the
> array position in the register cache. I _did_ specifically ask
> to use defines for index values in this case. You did not explain
> why you ignored this. So now you'll have to explain 1) why you
> ignored my request and 2) why you want to keep the code as is.
> 
> And, _please_, add a To: recipient to your patches. I am getting
> tired having to handle the fallout.
> 
> Guenter


First of all, maybe you should compare the time these patches were
sent to the time that your reply that "I ignored" was sent.
I sent the patches before you "specifically asked me to use defines for
index values in this case".

Second of all, this specific place is a 1:1 conversion from the original 
code. If I change to using defines here, I'll have to change to using
defines everywhere else in the code, which doesn't seem to be the scope
of this exact patch. Of course it looks bad, but it looked equally bad
before. I can introduce more following patches that fix some obvious
non-functional problems with the driver.

Third of all, why are you so tense? You're making both of our lives
harder. I understand being an upstream maintainer is hard work, but
everyone's job is hard work. It's not like I wanted to work on
refactoring ADT7x10, I just had to so I can later introduce a
patch that implements debugfs reg access...
