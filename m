Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0AC4AF73A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 17:51:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237496AbiBIQvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 11:51:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237198AbiBIQvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 11:51:43 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 627CBC0613C9;
        Wed,  9 Feb 2022 08:51:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=q3LL0HFbBfXngCsMvOL6XP66dZ422PxATU19M2OtQz4=; b=htlKhTf+eJufJBy2BI4ceOhD2H
        NdfraeH8gjDM7juKD3V291LZSw0kw2E5SqcD2fqInQiSzYO3ntBNQPZ2i2HSLRIHN7qkXnWolOliy
        gKlsQsHL7ijKLPwDVoWDZUMV92CpOtz9o7SDaScnX5sH+9S4aSkuJA9FmVtXrTCZwZPXE74NFYIc4
        mjd8ELKsujXHyEYHUTrIhWEOH8Pesqm6nwgp2EYGcQfNXEuy4ZQjRufgPfXHJ64qBE8abVf/8aUWB
        2shZdZ3mp8P0UTb1tA5PQCXhbWSZSF5v92L5nF796kaykfv9Y261C84+u2a3mVU8e1G5s8dr96k5Q
        31mDogAQ==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nHqBu-008BjK-T1; Wed, 09 Feb 2022 16:51:39 +0000
Message-ID: <ec5cc9e3-88d4-cc54-0490-7da87b65193b@infradead.org>
Date:   Wed, 9 Feb 2022 08:51:33 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH] watchdog: Improve watchdog_dev function documentation
Content-Language: en-US
To:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
References: <274cc9a2b34c7ffd042170fe2f8a5e55e22766b8.1644396833.git.bristot@redhat.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <274cc9a2b34c7ffd042170fe2f8a5e55e22766b8.1644396833.git.bristot@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On 2/9/22 01:08, Daniel Bristot de Oliveira wrote:
> Adjust function comments to the kernel doc format. It
> also adjusts some variable names and adds return values.
> 
> No functional change.

After applying the patch, I still see 3 warnings:

watchdog_dev.c:1127: warning: No description found for return value of 'watchdog_dev_register'
watchdog_dev.c:1169: warning: No description found for return value of 'watchdog_set_last_hw_keepalive'
watchdog_dev.c:1197: warning: No description found for return value of 'watchdog_dev_init'


Ah, I see. The format for function Return in kernel-doc is:

 * Return: func return info here

> Cc: Wim Van Sebroeck <wim@linux-watchdog.org>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: linux-watchdog@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
> ---
>  drivers/watchdog/watchdog_dev.c | 244 ++++++++++++++++----------------
>  1 file changed, 125 insertions(+), 119 deletions(-)
> 

thanks.
-- 
~Randy
