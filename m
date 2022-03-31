Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B82A94ED99F
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 14:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236116AbiCaM3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 08:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234476AbiCaM3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 08:29:30 -0400
Received: from gateway33.websitewelcome.com (gateway33.websitewelcome.com [192.185.146.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D21A210466
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 05:27:42 -0700 (PDT)
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway33.websitewelcome.com (Postfix) with ESMTP id 7673BBCA1F
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 07:27:42 -0500 (CDT)
Received: from gator4132.hostgator.com ([192.185.4.144])
        by cmsmtp with SMTP
        id ZttunhyI6b6UBZttunkP0S; Thu, 31 Mar 2022 07:27:42 -0500
X-Authority-Reason: nr=8
Received: from host-79-43-204-123.retail.telecomitalia.it ([79.43.204.123]:33844 helo=[10.0.0.45])
        by gator4132.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <bristot@kernel.org>)
        id 1nZttt-003gUe-U1; Thu, 31 Mar 2022 07:27:42 -0500
Message-ID: <f3bfc577-181f-6b5b-b6ff-30edd90bbe83@kernel.org>
Date:   Thu, 31 Mar 2022 14:27:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] rtla/osnoise: avoid NULL pointer dereference on out
Content-Language: en-US
To:     Haowen Bai <baihaowen@meizu.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1648623748-8833-1-git-send-email-baihaowen@meizu.com>
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <1648623748-8833-1-git-send-email-baihaowen@meizu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4132.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - kernel.org
X-BWhitelist: no
X-Source-IP: 79.43.204.123
X-Source-L: No
X-Exim-ID: 1nZttt-003gUe-U1
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: host-79-43-204-123.retail.telecomitalia.it ([10.0.0.45]) [79.43.204.123]:33844
X-Source-Auth: kernel@bristot.me
X-Email-Count: 6
X-Source-Cap: YnJpc3RvdG1lO2JyaXN0b3RtZTtnYXRvcjQxMzIuaG9zdGdhdG9yLmNvbQ==
X-Local-Domain: no
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/30/22 09:02, Haowen Bai wrote:
> record is NULL and go out but dereference record->trace.
> 
> report by coccicheck:
> tools/tracing/rtla/src/osnoise_top.c:650:31-36: ERROR:
> record is NULL but dereferenced.

Duplicated of:
https://lore.kernel.org/lkml/20220322113253.57390-1-wanjiabing@vivo.com/

-- Daniel
