Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80C2A506449
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 08:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235470AbiDSGQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 02:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235144AbiDSGQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 02:16:45 -0400
Received: from gateway30.websitewelcome.com (gateway30.websitewelcome.com [192.185.197.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB05613DD5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 23:14:03 -0700 (PDT)
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
        by gateway30.websitewelcome.com (Postfix) with ESMTP id 520E010267
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 01:10:29 -0500 (CDT)
Received: from gator4132.hostgator.com ([192.185.4.144])
        by cmsmtp with SMTP
        id gh4HnZEqU9AGSgh4HnrLBI; Tue, 19 Apr 2022 01:10:29 -0500
X-Authority-Reason: nr=8
Received: from host-95-246-22-34.retail.telecomitalia.it ([95.246.22.34]:44488 helo=[192.168.0.198])
        by gator4132.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <bristot@kernel.org>)
        id 1ngh4G-001KbM-Nt; Tue, 19 Apr 2022 01:10:28 -0500
Message-ID: <552ada0e-62f9-1cca-0a81-5a67d30b3bbf@kernel.org>
Date:   Tue, 19 Apr 2022 08:10:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] rtla: Documentation: fix email addresses
Content-Language: en-US
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-doc@vger.kernel.org, linux-trace-devel@vger.kernel.org
References: <20220418011450.11821-1-rdunlap@infradead.org>
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <20220418011450.11821-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4132.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - kernel.org
X-BWhitelist: no
X-Source-IP: 95.246.22.34
X-Source-L: No
X-Exim-ID: 1ngh4G-001KbM-Nt
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: host-95-246-22-34.retail.telecomitalia.it ([192.168.0.198]) [95.246.22.34]:44488
X-Source-Auth: kernel@bristot.me
X-Email-Count: 5
X-Source-Cap: YnJpc3RvdG1lO2JyaXN0b3RtZTtnYXRvcjQxMzIuaG9zdGdhdG9yLmNvbQ==
X-Local-Domain: no
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/18/22 03:14, Randy Dunlap wrote:
> Correct lkml@vger to linux-kernel@vger.
> Add linux-trace-devel since that is what is in the MAINTAINERS file.

Ouch, Daniel! :)

> Fixes: d40d48e1f1f2 ("rtla: Add Documentation")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Daniel Bristot de Oliveira <bristot@kernel.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: linux-doc@vger.kernel.org
> Cc: linux-trace-devel@vger.kernel.org

Acked-by: Daniel Bristot de Oliveira

Thanks, Randy!

-- Daniel
