Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D2214FA9F1
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 19:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242889AbiDIRbp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 13:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242871AbiDIRbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 13:31:42 -0400
Received: from gateway30.websitewelcome.com (gateway30.websitewelcome.com [192.185.145.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C2CC83B2A
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 10:29:34 -0700 (PDT)
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway30.websitewelcome.com (Postfix) with ESMTP id 6A1E038E1
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 12:29:34 -0500 (CDT)
Received: from gator4132.hostgator.com ([192.185.4.144])
        by cmsmtp with SMTP
        id dEtynSwIWRnrrdEtynN3MS; Sat, 09 Apr 2022 12:29:34 -0500
X-Authority-Reason: nr=8
Received: from host-95-245-33-130.retail.telecomitalia.it ([95.245.33.130]:38022 helo=[192.168.0.89])
        by gator4132.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <bristot@kernel.org>)
        id 1ndEtx-004Ng6-RW; Sat, 09 Apr 2022 12:29:34 -0500
Message-ID: <90b3fa39-0e35-2ee1-773e-8d51006c73fa@kernel.org>
Date:   Sat, 9 Apr 2022 19:29:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2] rtla: Minor grammar fix for rtla README
Content-Language: en-US
To:     John Kacur <jkacur@redhat.com>
Cc:     RT <linux-rt-users@vger.kernel.org>,
        linux-trace-devel@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
References: <20220408161012.10544-1-jkacur@redhat.com>
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <20220408161012.10544-1-jkacur@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4132.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - kernel.org
X-BWhitelist: no
X-Source-IP: 95.245.33.130
X-Source-L: No
X-Exim-ID: 1ndEtx-004Ng6-RW
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: host-95-245-33-130.retail.telecomitalia.it ([192.168.0.89]) [95.245.33.130]:38022
X-Source-Auth: kernel@bristot.me
X-Email-Count: 2
X-Source-Cap: YnJpc3RvdG1lO2JyaXN0b3RtZTtnYXRvcjQxMzIuaG9zdGdhdG9yLmNvbQ==
X-Local-Domain: no
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/8/22 18:10, John Kacur wrote:
> - Change to "The rtla meta-tool includes"
> - Remove an unnecessary "But, "
> - Adjust the formatting of the paragraph resulting from the changes.
> - Simplify the wording for the libraries and tools.
> 
> Signed-off-by: John Kacur <jkacur@redhat.com>

Acked-by: Daniel Bristot de Oliveira <bristot@kernel.org>

Thanks!
-- Daniel
