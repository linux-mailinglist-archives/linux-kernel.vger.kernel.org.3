Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB36484038
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 11:57:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231727AbiADK5k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 05:57:40 -0500
Received: from gateway23.websitewelcome.com ([192.185.49.219]:26214 "EHLO
        gateway23.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229504AbiADK5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 05:57:39 -0500
X-Greylist: delayed 1506 seconds by postgrey-1.27 at vger.kernel.org; Tue, 04 Jan 2022 05:57:39 EST
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway23.websitewelcome.com (Postfix) with ESMTP id C50D7AC8
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 04:12:19 -0600 (CST)
Received: from gator4132.hostgator.com ([192.185.4.144])
        by cmsmtp with SMTP
        id 4gnjnPxmcqH054gnjnSHdj; Tue, 04 Jan 2022 04:12:19 -0600
X-Authority-Reason: nr=8
Received: from host-79-52-207-139.retail.telecomitalia.it ([79.52.207.139]:33524 helo=[10.0.0.69])
        by gator4132.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <bristot@kernel.org>)
        id 1n4gni-003d7F-PN; Tue, 04 Jan 2022 04:12:18 -0600
Message-ID: <de6126fb-68db-7369-a14a-1172f0899e91@kernel.org>
Date:   Tue, 4 Jan 2022 11:12:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] tracing/osnoise: Fix sparse warning in function
 start_kthread
Content-Language: en-US
To:     Wang ShaoBo <bobo.shaobowang@huawei.com>, rostedt@goodmis.org
Cc:     xiexiuqi@huawei.com, cj.chengjian@huawei.com, liwei391@huawei.com,
        linux-kernel@vger.kernel.org
References: <20220104094829.334872-1-bobo.shaobowang@huawei.com>
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <20220104094829.334872-1-bobo.shaobowang@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4132.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - kernel.org
X-BWhitelist: no
X-Source-IP: 79.52.207.139
X-Source-L: No
X-Exim-ID: 1n4gni-003d7F-PN
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: host-79-52-207-139.retail.telecomitalia.it ([10.0.0.69]) [79.52.207.139]:33524
X-Source-Auth: kernel@bristot.me
X-Email-Count: 1
X-Source-Cap: YnJpc3RvdG1lO2JyaXN0b3RtZTtnYXRvcjQxMzIuaG9zdGdhdG9yLmNvbQ==
X-Local-Domain: no
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/4/22 10:48, Wang ShaoBo wrote:
> Change main to main_func to fix following sparse warning:
> 
> kernel/trace/trace_osnoise.c: In function ‘start_kthread’:
> kernel/trace/trace_osnoise.c:1674:8: warning: ‘main’ is usually a function [-Wmain]
>   void *main = osnoise_main;
>         ^~~~

NAK!

This was already discussed... many times. The problem is not in the usage of
main as a variable name but in the tool that you are using. Try to fix your tool.

E.g., https://lore.kernel.org/lkml/20210813224131.25803-1-rdunlap@infradead.org/

-- Daniel
