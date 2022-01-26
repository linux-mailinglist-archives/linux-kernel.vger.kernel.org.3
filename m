Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B164649C79F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 11:32:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240028AbiAZKcN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 05:32:13 -0500
Received: from gateway24.websitewelcome.com ([192.185.50.66]:49213 "EHLO
        gateway24.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240044AbiAZKcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 05:32:08 -0500
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway24.websitewelcome.com (Postfix) with ESMTP id 0C35F1D562
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 04:32:06 -0600 (CST)
Received: from gator4132.hostgator.com ([192.185.4.144])
        by cmsmtp with SMTP
        id Cfavne83P22u3Cfawn8odr; Wed, 26 Jan 2022 04:32:06 -0600
X-Authority-Reason: nr=8
Received: from host-79-47-126-144.retail.telecomitalia.it ([79.47.126.144]:46578 helo=[10.0.0.238])
        by gator4132.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <bristot@kernel.org>)
        id 1nCfav-001LCX-IB; Wed, 26 Jan 2022 04:32:05 -0600
Message-ID: <86189da9-92b5-c211-e406-5d8b10eb3a77@kernel.org>
Date:   Wed, 26 Jan 2022 11:32:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] rtla: make doc build optional
Content-Language: en-US
To:     Shuah Khan <skhan@linuxfoundation.org>, rostedt@goodmis.org
Cc:     linux-kernel@vger.kernel.org
References: <20220126001301.79096-1-skhan@linuxfoundation.org>
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <20220126001301.79096-1-skhan@linuxfoundation.org>
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
X-Exim-ID: 1nCfav-001LCX-IB
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: host-79-47-126-144.retail.telecomitalia.it ([10.0.0.238]) [79.47.126.144]:46578
X-Source-Auth: kernel@bristot.me
X-Email-Count: 1
X-Source-Cap: YnJpc3RvdG1lO2JyaXN0b3RtZTtnYXRvcjQxMzIuaG9zdGdhdG9yLmNvbQ==
X-Local-Domain: no
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/26/22 01:13, Shuah Khan wrote:
> rtla build fails due to doc build dependency on rst2man. Make
> doc build optional so rtla could be built without docs. Leave
> the install dependency on doc_install alone.
> 
> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>

Acked-by: Daniel Bristot de Oliveira <bristot@kernel.org>

Thanks, Shuah!
-- Daniel

> ---
>  tools/tracing/rtla/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/tracing/rtla/Makefile b/tools/tracing/rtla/Makefile
> index 2d52ff0bff7d..7c39728d08de 100644
> --- a/tools/tracing/rtla/Makefile
> +++ b/tools/tracing/rtla/Makefile
> @@ -59,7 +59,7 @@ endif
>  .PHONY:	all
>  all:	rtla
>  
> -rtla: $(OBJ) doc
> +rtla: $(OBJ)
>  	$(CC) -o rtla $(LDFLAGS) $(OBJ) $(LIBS)
>  
>  static: $(OBJ)

