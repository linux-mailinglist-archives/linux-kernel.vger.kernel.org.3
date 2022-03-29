Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70E624EB4B1
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 22:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbiC2U2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 16:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232126AbiC2U2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 16:28:11 -0400
Received: from gateway24.websitewelcome.com (gateway24.websitewelcome.com [192.185.51.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A770CA9969
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 13:26:27 -0700 (PDT)
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway24.websitewelcome.com (Postfix) with ESMTP id F2BEDC0D4F
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 15:26:26 -0500 (CDT)
Received: from 162-215-252-75.unifiedlayer.com ([208.91.199.152])
        by cmsmtp with SMTP
        id ZIQ6nz8LJb6UBZIQ6n46fJ; Tue, 29 Mar 2022 15:26:26 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:Subject:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=MGJIj6LR5/dj1D1aLADvu0DWbqeTReXZvYG/C4cvdVo=; b=QGOkJb7I8X80501zSDB5EFAY4E
        L4ufW5Y9FDmz81Fy9SxBS3aWcox5IeQki2CmpD5G1natHax563ajwCgivzn7nOD6ll32rQO4RBVEB
        n/xJvTPuNzB7LlpzKrrRZSaRLt7vkX30reLuM0bCjwukH5CTq1SDJINQiY49NpMbyAwqNOD7CFo5v
        lkAsWB5TxUdESYcNqks529rxyEz+EL9NFuSLflRyiUpZOfS7nyxceIQyKIm4fJwt+HAnzEfKViIed
        s/eHKpX82de4jKJZv8GaIzIJe/gB92NWZchKZn5GFAWjhtZgbRINUy6VgRMc3TJO7S7ZxdzmP+vHo
        tXikhR7Q==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:54544)
        by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@roeck-us.net>)
        id 1nZIQ6-003Biv-K6; Tue, 29 Mar 2022 20:26:26 +0000
Message-ID: <1239901b-9b4a-53ef-be86-1aa8337e0f31@roeck-us.net>
Date:   Tue, 29 Mar 2022 13:26:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To:     Eugene Shalygin <eugene.shalygin@gmail.com>
Cc:     darcagn@protonmail.com, Jean Delvare <jdelvare@suse.com>,
        linux-hwmon@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220327121404.1702631-1-eugene.shalygin@gmail.com>
 <20220327121404.1702631-2-eugene.shalygin@gmail.com>
 <16a36e23-bab2-4314-54ea-ff6b1011e6d7@roeck-us.net>
 <CAB95QATxYy5aj97P=S=L-kGE9dppuEbTYq=K=HGMBuZYVUBR4g@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 1/4] hwmon: (asus-ec-sensors) introduce ec_board_info
 struct for board data
In-Reply-To: <CAB95QATxYy5aj97P=S=L-kGE9dppuEbTYq=K=HGMBuZYVUBR4g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1nZIQ6-003Biv-K6
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net [108.223.40.66]:54544
X-Source-Auth: linux@roeck-us.net
X-Email-Count: 1
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/29/22 12:22, Eugene Shalygin wrote:
> On Tue, 29 Mar 2022 at 15:44, Guenter Roeck <linux@roeck-us.net> wrote:
>>>
>>>    struct ec_sensors_data {
>>> -     unsigned long board_sensors;
>>> +     struct ec_board_info board_info;
>>
>> Please explain why this needs to be the entire structure and not
>> just a pointer to it.
> 
> I marked the board_info array as __initconst assuming that this large
> array will be unloaded from memory after the init phase, while we keep
> only a single element. Is that assumption incorrect?
> 

What happens if you build the driver into the kernel and then instantiate
and de-instantiate it multiple times ?

>>> +static int sensor_count(const struct ec_board_info *board)
>>> +{
>>> +     return hweight_long(board->sensors);
>>> +}
>>
>> This function is called several times. Does it really make sense, or is it
>> necessary, to re-calculate the number of sensors over and over again
>> instead of keeping it in ec->nr_sensors as before ? What are the benefits ?
>> Unless there is a good explanation I see that as unrelated and unnecessary
>> change.
> 
> This had something to do with data deduplication. However, I need the
> count value only for looping over the sensor array, thus I can as well
> add an invalid element to the end of the array. I rushed to submit
> this driver to replace the wmi one, and it still has an artifact for
> the WMI code I'd like to get rid of eventually, which is the read
> buffer and the registers array. This will remove all the nr_ variables
> and two dynamically allocated arrays. I will understand, of course, if
> you ask to submit that refactoring separately.
> 

The rule of "one logical change per patch" still applies. If you start
intermixing parts of future clean-up efforts into current patches, you'll
see a very unhappy maintainer - especially since this change makes up
a significant part of this patch, complicates review significantly,
and makes me wonder if other unrelated changes are included that I don't
see right now due to all the noise.

Besides, at least in this patch, I don't buy the "deduplication" argument.
Keeping a single additional variable in a data structure is much simpler
and straightforward than calling hweight_long() several times. I'd call
that "complification".

Guenter
