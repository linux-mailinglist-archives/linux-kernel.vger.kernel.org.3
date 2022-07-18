Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 186E2577BF3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 08:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233605AbiGRGzn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 02:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233301AbiGRGzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 02:55:40 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4989313E09;
        Sun, 17 Jul 2022 23:55:39 -0700 (PDT)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1oDKfH-0005xs-S1; Mon, 18 Jul 2022 08:55:35 +0200
Message-ID: <0f226def-baf9-d6b2-2ee3-f6fae7d675f1@leemhuis.info>
Date:   Mon, 18 Jul 2022 08:55:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] certs: make system keyring depend on x509 parser
Content-Language: en-US
To:     Adam Borowski <kilobyte@angband.pl>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        keyrings@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220717231105.33005-1-kilobyte@angband.pl>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     Steven Rostedt <rostedt@goodmis.org>
In-Reply-To: <20220717231105.33005-1-kilobyte@angband.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1658127339;eec334ab;
X-HE-SMSGID: 1oDKfH-0005xs-S1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, this is your Linux kernel regression tracker.

Thx for looking into this.

On 18.07.22 01:11, Adam Borowski wrote:
> This code requires x509_load_certificate_list() to be built-in.
> 
> Fixes: 60050ffe3d770dd1df5b641aa48f49d07a54bd84

Just BTW: per docs.kernel.org/process/submitting-patches.html this
should be

Fixes: 60050ffe3d77 ("certs: Move load_certificate_list() to be with the
asymmetric keys code")

But I write for a different reason: Could you also please add "Link:"
and "Reported-by:" tags for earlier reports about this issue please:

Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/all/202206221515.DqpUuvbQ-lkp@intel.com/
Reported-by: Steven Rostedt <rostedt@goodmis.org>
Link:
https://lore.kernel.org/all/20220712104554.408dbf42@gandalf.local.home/

tia

> […]

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

P.S.: As the Linux kernel's regression tracker I deal with a lot of
reports and sometimes miss something important when writing mails like
this. If that's the case here, don't hesitate to tell me in a public
reply, it's in everyone's interest to set the public record straight.

P.P.S.: Let me tell regzbot to monitor this thread:

#regzbot ^backmonitor:
https://lore.kernel.org/all/20220712104554.408dbf42@gandalf.local.home/
