Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5D484BD1CF
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 22:14:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244251AbiBTVKt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 16:10:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234315AbiBTVKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 16:10:46 -0500
X-Greylist: delayed 1490 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 20 Feb 2022 13:10:24 PST
Received: from gateway33.websitewelcome.com (gateway33.websitewelcome.com [192.185.147.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C41549F8A
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 13:10:24 -0800 (PST)
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
        by gateway33.websitewelcome.com (Postfix) with ESMTP id 012A110C478
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 14:45:34 -0600 (CST)
Received: from gator4132.hostgator.com ([192.185.4.144])
        by cmsmtp with SMTP
        id Lt3NnySPK9AGSLt3NngUj3; Sun, 20 Feb 2022 14:43:33 -0600
X-Authority-Reason: nr=8
Received: from host-95-232-30-176.retail.telecomitalia.it ([95.232.30.176]:34172 helo=[10.0.0.45])
        by gator4132.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <bristot@kernel.org>)
        id 1nLt3M-003r3n-Jq; Sun, 20 Feb 2022 14:43:32 -0600
Message-ID: <9531b09c-6dc2-f551-d699-29b0c8cc2aeb@kernel.org>
Date:   Sun, 20 Feb 2022 21:43:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] docs: Remove duplicated words in trace/osnoise-tracer
Content-Language: en-US
To:     Oscar Shiang <oscar0225@livemail.tw>,
        Steven Rostedt <rostedt@goodmis.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <TYCP286MB1913117487F390E3BCE38B15A1399@TYCP286MB1913.JPNP286.PROD.OUTLOOK.COM>
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <TYCP286MB1913117487F390E3BCE38B15A1399@TYCP286MB1913.JPNP286.PROD.OUTLOOK.COM>
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
X-Exim-ID: 1nLt3M-003r3n-Jq
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: host-95-232-30-176.retail.telecomitalia.it ([10.0.0.45]) [95.232.30.176]:34172
X-Source-Auth: kernel@bristot.me
X-Email-Count: 1
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

On 2/20/22 13:12, Oscar Shiang wrote:
> There are 2 duplicated words found in osnoise tracer documentation.
> This patch removes them.
> 
> Signed-off-by: Oscar Shiang <oscar0225@livemail.tw>

Acked-by: Daniel Bristot de Oliveira <bristot@kernel.org>

Thanks
-- Daniel
