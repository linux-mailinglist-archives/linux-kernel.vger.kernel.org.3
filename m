Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E031C4E6D6B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 05:47:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351653AbiCYErg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 00:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236696AbiCYErd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 00:47:33 -0400
Received: from gateway24.websitewelcome.com (gateway24.websitewelcome.com [192.185.51.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04411C6EC8
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 21:45:56 -0700 (PDT)
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway24.websitewelcome.com (Postfix) with ESMTP id 7A7C9C30
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 23:45:56 -0500 (CDT)
Received: from 162-215-252-75.unifiedlayer.com ([208.91.199.152])
        by cmsmtp with SMTP
        id XbpknDZMpdx86Xbpknulgk; Thu, 24 Mar 2022 23:45:56 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ychwoWq+jKWXscmOpK+qKFx885JOQlK6rLw3cnAAJtU=; b=n8PNSaX442ga68s56glkIFM2tw
        BPwaHBRnYvPChM9shQYkg2+QJ9xzPTsL4IlQ76Bjm9vxQ2xxLjScMndy8q+Lj8M5+e9d2LQHHqhAs
        2SI7HUXWc7TGIFhR93GM5SbRe1Cr1/PRXzVNhugMDgfkCsPMmL93oCMaNXavXvTvDpz+OHi7LXgu1
        5GdhsmTkiZsKEoRnovXblriXzXV+z9ybmI7gvamptfT+zayNTVPK5YxZPCbmvf+nsQ7xn9QElM8Sn
        LDLgTNuD5PiqALk6AVGPrOT04M7YS3Pi5H1bFvwIYFL82tKbRSz/JPWpYG6lGmpBwGKA4WppaL5za
        Ct9UvLrg==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:54468)
        by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@roeck-us.net>)
        id 1nXbpk-000lJ4-1e; Fri, 25 Mar 2022 04:45:56 +0000
Message-ID: <86b338ea-2c6c-a06f-c935-30e2ebdd37ea@roeck-us.net>
Date:   Thu, 24 Mar 2022 21:45:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] usb: typec: tcpm: testing array offset
 'port->logbuffer_head' before use
Content-Language: en-US
To:     Haowen Bai <baihaowen@meizu.com>, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1648182849-9209-1-git-send-email-baihaowen@meizu.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <1648182849-9209-1-git-send-email-baihaowen@meizu.com>
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
X-Exim-ID: 1nXbpk-000lJ4-1e
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net [108.223.40.66]:54468
X-Source-Auth: linux@roeck-us.net
X-Email-Count: 1
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/24/22 21:34, Haowen Bai wrote:
> Fix possible indexing array of bound for
> port->logbuffer[port->logbuffer_head], where port->logbuffer_head boundary
>   check happens later. so we do it before.
> 
> Signed-off-by: Haowen Bai <baihaowen@meizu.com>
> ---
>   drivers/usb/typec/tcpm/tcpm.c | 15 ++++++++-------
>   1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 5fce795..541e9e4 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -591,6 +591,14 @@ static void _tcpm_log(struct tcpm_port *port, const char *fmt, va_list args)
>   	unsigned long rem_nsec;
>   
>   	mutex_lock(&port->logbuffer_lock);
> +
> +	if (port->logbuffer_head < 0 ||
> +	    port->logbuffer_head >= LOG_BUFFER_ENTRIES) {
> +		dev_warn(port->dev,
> +			 "Bad log buffer index %d\n", port->logbuffer_head);
> +		goto abort;
> +	}
> +
>   	if (!port->logbuffer[port->logbuffer_head]) {
>   		port->logbuffer[port->logbuffer_head] =
>   				kzalloc(LOG_BUFFER_ENTRY_SIZE, GFP_KERNEL);
> @@ -607,13 +615,6 @@ static void _tcpm_log(struct tcpm_port *port, const char *fmt, va_list args)
>   		strcpy(tmpbuffer, "overflow");
>   	}
>   
> -	if (port->logbuffer_head < 0 ||
> -	    port->logbuffer_head >= LOG_BUFFER_ENTRIES) {
> -		dev_warn(port->dev,
> -			 "Bad log buffer index %d\n", port->logbuffer_head);
> -		goto abort;
> -	}
> -
>   	if (!port->logbuffer[port->logbuffer_head]) {
>   		dev_warn(port->dev,
>   			 "Log buffer index %d is NULL\n", port->logbuffer_head);

One could argue that the check is unnecessary and can be removed as it can be proven
that it logbuffer_head always in the range of [0, LOG_BUFFER_ENTRIES - 1]. Moving
the check, however, does not add any value unless you can _prove_ that it needs to
be moved, ie that logbuffer_head can be observed to be < 0 or >= LOG_BUFFER_ENTRIES.
I think that is quite unlikely.

Guenter
