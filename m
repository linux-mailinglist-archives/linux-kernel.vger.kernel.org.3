Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5BDF4F8636
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 19:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346348AbiDGRaO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 13:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346506AbiDGR1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 13:27:37 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C4FEFDE3D
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 10:23:48 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id h5so4555916pgc.7
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 10:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=DFecdRo1OcDJL+E53AYAzBMzke472lhEFN6Lut7X4Ts=;
        b=RR0h+gY5cOptCFHpbs2kfVqhRd2qnjomTxAX3aw6Z2qukKffYeou0GZ7qiZMXepddM
         Mdetx+EF5JkUPT1QcKOq7Z8Ce+cYwUQOcv+2b6w4ghfO8gVfSm80kV6smnGW1SQB56lJ
         q5rsQJHhIz1/1UnwQqwflKnteNhxueIt55HPQJiUJdG3h+Ud4w4uY1lnQIP2l/XlTcA8
         e+qxhc6VeDth+AaDhNEFM8E5Tp84A2zcvd985556vxoZaohNr47+QJA5015Vq1wS3KGa
         jUpAHcZ6HJz4g6RxhpX/vo5K+SGTpnzk0PH+pY00W7xEdnnq00YucTWDWjBWIf9JiOjf
         bgTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=DFecdRo1OcDJL+E53AYAzBMzke472lhEFN6Lut7X4Ts=;
        b=s5kDz1m3PXYtE937ocJskKAZ2PZSwBP0XijxdJd+wqMWg1V/sthZy2UNYbFFhat51d
         jMnvNhmCEuoUZAhMA8V+wB5Z7tCnPgdQ3os+GZRJnb3cZ7HlebHD9N9L8eo4pKbRFX0v
         CiPrp2nsYImzFzyzr3s7ZaExCvnuwiE/ZVRLzGENGhaStsl3iBM3apWRJKfHblPHt905
         Sd/eEIetMBAx4L0r2Ok8T491L4Jv7xAQYpjRbkEV4yIjv1D4pI28lvVl7WY7+OpbN+qO
         5T6XSa69Ksq1zbA9MCCTCj4ex00K+ZfK+AI3haeyekVG7gzPBTJVftEtUO8LfHK5ns/q
         //xA==
X-Gm-Message-State: AOAM531p8p6rqxMuNC7RChUvy5i9iBNfocjNX2alEgwj/RyqUkq98g1U
        NtZJ098XcFkZJcldakEZakY=
X-Google-Smtp-Source: ABdhPJxYiR0NcIeHKJJ/5fG4QYKdRPTuU7O5K/S9aM2IXV5B9pWF/vjBEHR94NW+9djC/DDGTvUATw==
X-Received: by 2002:a62:84d3:0:b0:4fa:72e2:1c64 with SMTP id k202-20020a6284d3000000b004fa72e21c64mr15392218pfd.29.1649352196013;
        Thu, 07 Apr 2022 10:23:16 -0700 (PDT)
Received: from [192.168.66.3] (p912131-ipoe.ipoe.ocn.ne.jp. [153.243.13.130])
        by smtp.gmail.com with ESMTPSA id y16-20020a637d10000000b00381268f2c6fsm19720585pgc.4.2022.04.07.10.23.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Apr 2022 10:23:15 -0700 (PDT)
Message-ID: <e14f1964-2692-df77-35ac-78236fc84ee2@gmail.com>
Date:   Fri, 8 Apr 2022 02:23:12 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] platform/chrome: cros_ec_typec: Check for EC driver
Content-Language: en-US
To:     Benson Leung <bleung@google.com>
Cc:     Guenter Roeck <groeck@google.com>,
        Prashant Malani <pmalani@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        chrome-platform@lists.linux.dev,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
References: <20220404041101.6276-1-akihiko.odaki@gmail.com>
 <Yk4DGZfpYbK8dofL@chromium.org>
 <CABXOdTcY3w56hc7kWsDLxKU-c6fCLYt_jigK13tKjjm9OHi2+w@mail.gmail.com>
 <033c1ec4-4bee-a689-140c-9694dfee435b@gmail.com>
 <CABXOdTet5ynSXf94qMimobJF4LLzHc89cVbwJ5NuAz8G6jmVdQ@mail.gmail.com>
 <0fdba110-8743-3b2d-cb30-3a89b7cfa592@gmail.com>
 <Yk8atphiUdlU0gPO@google.com>
From:   Akihiko Odaki <akihiko.odaki@gmail.com>
In-Reply-To: <Yk8atphiUdlU0gPO@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/04/08 2:09, Benson Leung wrote:
> Hi Akihiko,
> 
> On Fri, Apr 08, 2022 at 02:03:52AM +0900, Akihiko Odaki wrote:
>> If I read the code correctly, the registration itself happens synchronously
>> and platform_device_register_data() always returns a non-NULL value unless
>> it returns -ENOMEM. The driver, however, can be asynchronously bound and
>> dev_get_drvdata(&typec->ec->ec->dev) can return NULL as the consequence. It
>> would have a call trace like the following when scheduling asynchronous
>> driver binding:
>> platform_device_register_data()
>> platform_device_register_resndata()
>> platform_device_register_full()
>> -  This always creates and returns platform_device.
>> platform_device_add()
>> - This adds the created platform_device.
>> device_add()
>> bus_probe_device()
>> device_initial_probe()
>> __device_attach()
>> - This schedules asynchronous probing.
>>
>> typec->ec->ec should be pointing to the correct platform_device as the
>> patched driver works without Oops on my computer. It is not NULL at least.
> 
> Can you provide more information about your test computer in this case?
> 
> Is it a Chromebook running stock firmware (if so, please let us know which
> model, and which firmware version it is running).
> In the past, we've also gotten some reports from people running MrChromebox
> custom firmware on older Chromebooks which have exposed other bugs in
> this driver.
> 
> Let us know if that's the case here, and where we can get that firmware.

My computer is Lenovo ThinkPad C13 Yoga Chromebook. It is running the 
stock firmware. The firmware was updated by running the following 
command on Google Chrome OS Version 99.0.4844.86 (Official Build) (64-Bit):
chromeos-firmwareupdate --mode=recovery

Regards,
Akihiko Odaki

> 
> Thanks,
> Benson
> 

