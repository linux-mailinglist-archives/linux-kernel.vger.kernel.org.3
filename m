Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D0244A8A11
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 18:30:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235554AbiBCRar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 12:30:47 -0500
Received: from gateway30.websitewelcome.com ([192.185.194.16]:34393 "EHLO
        gateway30.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1352894AbiBCRao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 12:30:44 -0500
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
        by gateway30.websitewelcome.com (Postfix) with ESMTP id B01A51DC7B
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 11:30:43 -0600 (CST)
Received: from gator4132.hostgator.com ([192.185.4.144])
        by cmsmtp with SMTP
        id FfwRn5cuT9AGSFfwRnaURh; Thu, 03 Feb 2022 11:30:43 -0600
X-Authority-Reason: nr=8
Received: from host-79-47-126-144.retail.telecomitalia.it ([79.47.126.144]:35786 helo=[10.0.0.45])
        by gator4132.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <bristot@kernel.org>)
        id 1nFfwR-001jMb-5w; Thu, 03 Feb 2022 11:30:43 -0600
Message-ID: <846b245d-82c4-faa5-1ba3-733ad197d953@kernel.org>
Date:   Thu, 3 Feb 2022 18:30:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 3/8] rtla/osnoise_top: Fix segmentation fault when failing
 to enable -t
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, linux-trace-devel@vger.kernel.org
References: <cover.1643033113.git.bristot@kernel.org>
 <3ef9cb911e9b51be55a874cacc847d44bca9877e.1643033113.git.bristot@kernel.org>
 <20220203114126.3ec6b37d@gandalf.local.home>
 <20220203114303.575910f8@gandalf.local.home>
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <20220203114303.575910f8@gandalf.local.home>
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
X-Exim-ID: 1nFfwR-001jMb-5w
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: host-79-47-126-144.retail.telecomitalia.it ([10.0.0.45]) [79.47.126.144]:35786
X-Source-Auth: kernel@bristot.me
X-Email-Count: 2
X-Source-Cap: YnJpc3RvdG1lO2JyaXN0b3RtZTtnYXRvcjQxMzIuaG9zdGdhdG9yLmNvbQ==
X-Local-Domain: no
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/3/22 17:43, Steven Rostedt wrote:
> On Thu, 3 Feb 2022 11:41:26 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
>> Wouldn't these four patches be more robust if you just initialized record
>> (and tool) to NULL, and change osnoise_destroy_tool() to:
> And if you do this, it should be one patch, not four.


Yeah, it works. The order would still be wrong, but it would be just an esthetic
thing.

I will send a v2 removing these four patches, and adding a patch with your
suggestion.

[ thinking aloud, is it possible to have multiple Fixes:? well, adding just one
would also solve the issue, and... we are still in the same release ]

Thanks,
-- Daniel
