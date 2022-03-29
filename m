Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B141E4EB17D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 18:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239250AbiC2QME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 12:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbiC2QMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 12:12:02 -0400
Received: from out203-205-221-191.mail.qq.com (out203-205-221-191.mail.qq.com [203.205.221.191])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C878FE43AA
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 09:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1648570210;
        bh=mE9DRDsHIsIHAbKbJFK2/CHjDpNdpunTcLE/Dg65eAI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=Dvu/zZXYxlw+7IC7fC0iLm3ZvARxX7CzLK6ef6jjY2f3IAZfB5ZLL2hblPoO5RND/
         ZYGn2SmomZNzlrEdvCjIlJKB8KrSRjRjepuvOGxguDEQZgipSKniIYkd7ukpAzlSHJ
         uSkiM4ol6edA557OquaKshsZG3ugr+t6AdMeo2jI=
Received: from [192.168.31.6] ([120.245.132.52])
        by newxmesmtplogicsvrszc11.qq.com (NewEsmtp) with SMTP
        id 28897A01; Wed, 30 Mar 2022 00:10:08 +0800
X-QQ-mid: xmsmtpt1648570208tm8np4p8u
Message-ID: <tencent_39A03E44FA72A77EC50A3F8F02C71F0EFA09@qq.com>
X-QQ-XMAILINFO: OYji31yNgomxdzawO0x/piNS6YFdtMMQ9FSm2rMyK0ZKdKsF7BqYhCbcqbwoqe
         zIDca7AZHfKpDI2L+27tL+KnvLyR9x6RzBCEIZ9B4BkS4ik46njjwKNB77HhZuCnWbCkUAC3kfuU
         5zRur5hZB4BU8eSlXIT8XrWbuaDw1HXA1prNkvtjhVT8I0MRkRKzlePtdeMb61HC5mLlUWhzzp2+
         EZkazy60AjWGEKJ6K3bmuiAOs1AA0XaMs2g7YgdimbIuvuKvybhQn6qXSpUQ+RleaQJFoqft692N
         h6mAAVIpGEAWyAej6EJKSqzt+MrWubXLWaS9F5j4S82FSY89gxKFGZLYstjUHz1zI6hglcNRE73p
         22aT0X9P1QSwB4y90BxwIjWZU8Eq8otD7wr0cHJfGJU0PGOZbwT1S8PYhhnOEvVB2Z2VnQ7DH0bk
         7ClNIi+Tcxk2nR/LJ0LZLRRQKWFjSSvcV441pEkF/nLnetAXA2f8Ex9ESiQHnZjhZMaHzWNEQbMB
         dCO8+6/Pw4u0X9FRqtX+2ol8DHvX/jReSSGr7dBAtICO5hna3OmGuflNrdsAuGxNMubnkhSJ0Rww
         Jai9IVA8zbE/iBNJV1vOxcVXjN7mXr8kvaMCP9ZuFHGRyvetQXqbMimDKIhZ9O6kfMgURpoRlc5X
         H+kfaggx7eOUabExe3RmT0R3reL1c3UyZ3DjeHihkTwMX9OlfKqr91nFgU4A3X3GUge10khC+jco
         wxZPSH8Xs1JqeJV01u4HSWKcyONaFG7XsEc93HDPOn7qTBvsvufxpDRhhMOZ/ryQ/Cvh9BYsm8yI
         2pGoCzQDrI8/dBhoA5H6tqlEQ4IwsMm2zwpWM829u2kc5RaB8/AwpMB9I73dP3Gs+psCKeCE7sB5
         yYzEw4mTBCK4JAlwLVrQs=
X-OQ-MSGID: <0c20c29b-acc5-3bfa-4947-b7629c2a56ea@foxmail.com>
Date:   Wed, 30 Mar 2022 00:10:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 0/3] ipmi: msghandler: check the users and msgs causing
 the system to block
Content-Language: en-US
To:     minyard@acm.org
Cc:     openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <tencent_BD6D4CB98B6D7FAA04F63D28F6457F10F40A@qq.com>
 <20220328013842.GN3457@minyard.net>
 <tencent_071EACFAEE3F0CFA14A674C4603E39026F09@qq.com>
 <20220328154545.GP3457@minyard.net>
From:   chenchacha <chen.chenchacha@foxmail.com>
In-Reply-To: <20220328154545.GP3457@minyard.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,HELO_DYNAMIC_IPADDR,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/3/28 23:45, Corey Minyard wrote:
> On Mon, Mar 28, 2022 at 11:27:06PM +0800, chenchacha wrote:
>>
>>> Anyway, a better solution for the kernel side of things, I think, would
>>> be to add limits on the number of users and the number of messages per
>>> user.  That's more inline with what other kernel things do.  I know of
>>> nothing else in the kernel that does what you are proposing.
>>
>> The precondition for add limits, is that people known that ipmi has too many
>> users and messages cause problems, this patch is to let administrator known
>> that.
>>
>> In addition, different machines have different limit, My server my block
>> 700,000 messages and it's fine, and my NAS pc went to OOM when it probably
>> blocked for 10,000 messages. So, to limit the number of users and messages,
>> can wait until we have accumulated some online experience?
> 
> I don't mean a limit on the total number of messages, but a limit on the
> total number of oustanding messages, and a limit on the total number of
> users.  No user should have more than a handful of oustanding message,
> and limiting the number of users to 20 or 30 should be more than enough
> for any system.
> 
> Having those limits in place would probably help you trace down your
> problem, as you would hit the limits and it should report it at the
> source of the problem.
> 
> -corey

Hi Corey:

According to your suggestion, I have don some tests. After adding 
limits, event if the bmc hardware fails, the ipmi will not occupy a 
large memory in system.

The modifications are in the next version of the patch.

Thanks
--
Chen Guanqiao
