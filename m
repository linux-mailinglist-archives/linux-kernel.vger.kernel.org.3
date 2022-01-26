Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DD6A49C7A4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 11:33:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240017AbiAZKc6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 05:32:58 -0500
Received: from gateway24.websitewelcome.com ([192.185.50.66]:26449 "EHLO
        gateway24.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240029AbiAZKc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 05:32:56 -0500
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway24.websitewelcome.com (Postfix) with ESMTP id 640772BFE8
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 04:32:55 -0600 (CST)
Received: from gator4132.hostgator.com ([192.185.4.144])
        by cmsmtp with SMTP
        id CfbjnyTNJb6UBCfbjnIwPX; Wed, 26 Jan 2022 04:32:55 -0600
X-Authority-Reason: nr=8
Received: from host-79-47-126-144.retail.telecomitalia.it ([79.47.126.144]:46580 helo=[10.0.0.238])
        by gator4132.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <bristot@kernel.org>)
        id 1nCfbi-001LvI-TU; Wed, 26 Jan 2022 04:32:55 -0600
Message-ID: <cbcfff61-0b5d-01e9-f3e1-2b80144576ff@kernel.org>
Date:   Wed, 26 Jan 2022 11:32:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] tools/tracing: Update Makefile to build rtla
Content-Language: en-US
To:     Shuah Khan <skhan@linuxfoundation.org>, rostedt@goodmis.org
Cc:     linux-kernel@vger.kernel.org
References: <20220126002234.79337-1-skhan@linuxfoundation.org>
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <20220126002234.79337-1-skhan@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4132.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - kernel.org
X-BWhitelist: no
X-Source-IP: 79.47.126.144
X-Source-L: No
X-Exim-ID: 1nCfbi-001LvI-TU
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: host-79-47-126-144.retail.telecomitalia.it ([10.0.0.238]) [79.47.126.144]:46580
X-Source-Auth: kernel@bristot.me
X-Email-Count: 4
X-Source-Cap: YnJpc3RvdG1lO2JyaXN0b3RtZTtnYXRvcjQxMzIuaG9zdGdhdG9yLmNvbQ==
X-Local-Domain: no
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/26/22 01:22, Shuah Khan wrote:
> Update tracing Makefile to build/install/clean rtla tragets.
> 
> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>

Reviewed-by: Daniel Bristot de Oliveira <bristot@kernel.org>

Thanks, Shuah!
-- Daniel
> ---
>  tools/tracing/Makefile | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/tracing/Makefile b/tools/tracing/Makefile
> index 87e0ec48e2e7..95e485f12d97 100644
> --- a/tools/tracing/Makefile
> +++ b/tools/tracing/Makefile
> @@ -1,11 +1,11 @@
>  # SPDX-License-Identifier: GPL-2.0
>  include ../scripts/Makefile.include
>  
> -all: latency
> +all: latency rtla
>  
> -clean: latency_clean
> +clean: latency_clean rtla_clean
>  
> -install: latency_install
> +install: latency_install rtla_install
>  
>  latency:
>  	$(call descend,latency)
> @@ -16,4 +16,14 @@ latency_install:
>  latency_clean:
>  	$(call descend,latency,clean)
>  
> -.PHONY: all install clean latency latency_install latency_clean
> +rtla:
> +	$(call descend,rtla)
> +
> +rtla_install:
> +	$(call descend,rtla,install)
> +
> +rtla_clean:
> +	$(call descend,rtla,clean)
> +
> +.PHONY: all install clean latency latency_install latency_clean \
> +	rtla rtla_install rtla_clean

