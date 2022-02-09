Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 624494AF800
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 18:25:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238124AbiBIRYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 12:24:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231791AbiBIRYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 12:24:37 -0500
X-Greylist: delayed 1281 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 09 Feb 2022 09:24:40 PST
Received: from gateway20.websitewelcome.com (gateway20.websitewelcome.com [192.185.48.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3D6FC0613C9
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 09:24:40 -0800 (PST)
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway20.websitewelcome.com (Postfix) with ESMTP id 021F2400DDCB2
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 11:03:19 -0600 (CST)
Received: from gator4132.hostgator.com ([192.185.4.144])
        by cmsmtp with SMTP
        id HqLGndAeFRnrrHqLGn4EOx; Wed, 09 Feb 2022 11:01:18 -0600
X-Authority-Reason: nr=8
Received: from host-95-232-30-176.retail.telecomitalia.it ([95.232.30.176]:59302 helo=[10.0.0.45])
        by gator4132.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <bristot@kernel.org>)
        id 1nHqLF-001DpH-7N; Wed, 09 Feb 2022 11:01:17 -0600
Message-ID: <055fcdfe-3e18-0bdc-817a-a51049978803@kernel.org>
Date:   Wed, 9 Feb 2022 18:01:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] watchdog: Improve watchdog_dev function documentation
Content-Language: en-US
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
References: <274cc9a2b34c7ffd042170fe2f8a5e55e22766b8.1644396833.git.bristot@redhat.com>
 <ec5cc9e3-88d4-cc54-0490-7da87b65193b@infradead.org>
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <ec5cc9e3-88d4-cc54-0490-7da87b65193b@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4132.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - kernel.org
X-BWhitelist: no
X-Source-IP: 95.232.30.176
X-Source-L: No
X-Exim-ID: 1nHqLF-001DpH-7N
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: host-95-232-30-176.retail.telecomitalia.it ([10.0.0.45]) [95.232.30.176]:59302
X-Source-Auth: kernel@bristot.me
X-Email-Count: 3
X-Source-Cap: YnJpc3RvdG1lO2JyaXN0b3RtZTtnYXRvcjQxMzIuaG9zdGdhdG9yLmNvbQ==
X-Local-Domain: no
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/9/22 17:51, Randy Dunlap wrote:
> Hi Daniel,
> 
> On 2/9/22 01:08, Daniel Bristot de Oliveira wrote:
>> Adjust function comments to the kernel doc format. It
>> also adjusts some variable names and adds return values.
>>
>> No functional change.
> After applying the patch, I still see 3 warnings:
> 
> watchdog_dev.c:1127: warning: No description found for return value of 'watchdog_dev_register'
> watchdog_dev.c:1169: warning: No description found for return value of 'watchdog_set_last_hw_keepalive'
> watchdog_dev.c:1197: warning: No description found for return value of 'watchdog_dev_init'
> 
> 
> Ah, I see. The format for function Return in kernel-doc is:
> 
>  * Return: func return info here
> 

Ack, I will fix that.

Thanks, Randy!
-- Daniel
