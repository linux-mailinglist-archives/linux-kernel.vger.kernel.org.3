Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D0634E362D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 02:51:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235141AbiCVBv7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 21:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235114AbiCVBv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 21:51:57 -0400
Received: from gateway30.websitewelcome.com (gateway30.websitewelcome.com [192.185.146.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E04DE3BA54
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 18:50:30 -0700 (PDT)
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway30.websitewelcome.com (Postfix) with ESMTP id 012B66D1F
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 20:50:30 -0500 (CDT)
Received: from 162-215-252-75.unifiedlayer.com ([208.91.199.152])
        by cmsmtp with SMTP
        id WTdMnmipnHnotWTdNnrXgC; Mon, 21 Mar 2022 20:48:29 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=uywUMPoBYXp6PjZ9nM9SBumqFsG3gbfJp1KNVLB3onA=; b=4gTC9WJ7KGNBp7piv1YTtUa3lw
        zLkOpNlQGAfi6oNWBaU+2qz0Cwg6xK2vbmA3X9jjkzdYj3OoXdFH02dQTAdVh8aenAQ0V2c1bDASh
        4NUTQ06Gj9ymwWxBHnonpZI1WJWHn6+iRDyCm59aaw3hxIGDZ9vP1h0Tbanq2ELpdxcRO0MeJZnNJ
        75rqt5K+62bPy2zSXFOb74fzzOp9mDkkH+wleqpt1E+3hjMqmCm5XD+tOWEC3JzLnfEiEqdfelZZF
        38Q4I8uQ1I1p3epGbWPnzHuetZeq3J7Tt5IL1gNVpdILyqv+tqo4E78aM/Mbz12howATwzSyAS3IO
        DqMcCM5A==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:54388)
        by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@roeck-us.net>)
        id 1nWTdM-001yfU-Lc; Tue, 22 Mar 2022 01:48:28 +0000
Message-ID: <b3830750-f534-0c1c-f09b-3cce7fc6208b@roeck-us.net>
Date:   Mon, 21 Mar 2022 18:48:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [GIT PULL] hwmon updates for v5.18
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-hwmon@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220320231317.2171300-1-linux@roeck-us.net>
 <CAHk-=wgM1uHH1WJ47Zt5OGK5qjtFkvVCZLff+TKA2ahXAM1xQg@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <CAHk-=wgM1uHH1WJ47Zt5OGK5qjtFkvVCZLff+TKA2ahXAM1xQg@mail.gmail.com>
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
X-Exim-ID: 1nWTdM-001yfU-Lc
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net [108.223.40.66]:54388
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

On 3/21/22 18:21, Linus Torvalds wrote:
> On Sun, Mar 20, 2022 at 4:13 PM Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> Improvements to existing drivers:
>> - adt7x10: Convert to use regmap, convert to use with_info API,
>>    use hwmon_notify_event, and other cleanup
>> - aquacomputer_d5next: Add support for Aquacomputer Farbwerk 360
>> - asus_wmi_sensors: Add ASUS ROG STRIX B450-F GAMING II
>> - asus_wmi_ec_sensors: Support T_Sensor on Prime X570-Pro
>>    Deprecate driver (replaced by new driver)
> [...]
> 
> To make my life easier, can I ask you to try to format these things a
> bit more sanely and legibly?
> 
> You had this odd mix of sometimes using new lines to separate
> different things (eg that asus_wmi_ec_sensors entry), and sometimes
> just multiple different things in a list that then had line-breaks in
> the middle.
> 
> That kind of stuff is _very_ hard to parse as anything but a random
> jumble of words all crammed together.
> 
> Whitespace to separate things is good, and some kind of consistent
> indentation makes it more legible. I edited it all up (hopefully
> correctly), but it would be nice to get it in a readable form to begin
> with..
> 
> Yeah, if everything does well, nobody will ever need to read that
> merge message, but let's try to aim for nice and informative commit
> messages anyway.
> 

Sorry for that. I'll use your reformatting as example and use
the same format in the future.

Guenter
