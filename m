Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94E5C4B2C6A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 19:09:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352521AbiBKSIU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 13:08:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343603AbiBKSIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 13:08:19 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB1013A;
        Fri, 11 Feb 2022 10:08:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=Ujdmirxmv9J+xYKwu/KpZa9Pjtl6WCpcTWo64lQCL/Y=; b=Iz5TYEtx4Jt5k1HufobAB3vhVM
        kyUQZAHhc44BGy8iRMMFPbUqCRDgMjTW6lkhbxOGkW5DGq0NX3yiYNQ0y2p+tfn19UYnhe1hPj1EL
        7g7d/6c/JWeXkUJ0Y8LzXbor1Iwkcn92Ok4n3eUUJI5Kybv/bg6CwPZk+iV6B973mAkwamQYX8X2y
        r6H6wHv2SvaiQX+dRT1FkBcXGIkEsrXdpYHfwZpDB99ktTDEv7XRLBThydTeTc2RH79E0fFI0k/og
        zg6sta1tzg28uOw+Acx9WJRbBQXi86ZP6Vv3CNGNZE61iGGkBUbYfSS6InIdE9a2auGQsucfJWIZ6
        DgUX2dKw==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nIaL4-00AcW0-RO; Fri, 11 Feb 2022 18:08:11 +0000
Message-ID: <87137253-82a8-a070-2378-5e965987a34f@infradead.org>
Date:   Fri, 11 Feb 2022 10:08:06 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH V2] watchdog: Improve watchdog_dev function documentation
Content-Language: en-US
To:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
References: <30378a03e9cd9b5f6e92ec9bf512edc38bad8627.1644589712.git.bristot@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <30378a03e9cd9b5f6e92ec9bf512edc38bad8627.1644589712.git.bristot@kernel.org>
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

On 2/11/22 06:30, Daniel Bristot de Oliveira wrote:
> Adjust function comments to the kernel doc format. It
> also adjusts some variable names and adds return values.
> 
> No functional change.
> 
> Changes from V1:
>   Change "Returns" to "Return:" (Randy Dunlap)
> 
> Cc: Wim Van Sebroeck <wim@linux-watchdog.org>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: linux-watchdog@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>


scripts/kernel-doc throws one warning:
watchdog_dev.c:1194: warning: contents before sections

which is a bug in the script IMO.
I would just ignore this one.
(see more below)


Tested-by: Randy Dunlap <rdunlap@infradead.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  drivers/watchdog/watchdog_dev.c | 244 ++++++++++++++++----------------
>  1 file changed, 125 insertions(+), 119 deletions(-)
> 
> diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
> index 3a3d8b5c7ad5..54903f3c851e 100644
> --- a/drivers/watchdog/watchdog_dev.c
> +++ b/drivers/watchdog/watchdog_dev.c


scripts/kernel-doc does not nicely handle a function that has
no parameters (hence no @param descriptions) that is followed
by a function description.

Adding one line (I am not suggesting this as a patch) stops the
warning:

 * @void: none


This is the function that kernel-doc complains about
(nothing wrong with it):

/**
 * watchdog_dev_init - init dev part of watchdog core
 *
 * Allocate a range of chardev nodes to use for watchdog devices.
 *
 * Return: 0 if successful, error otherwise.
 */
int __init watchdog_dev_init(void)
{


-- 
~Randy
