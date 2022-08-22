Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D9A559BC62
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 11:12:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234351AbiHVJLn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 05:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234293AbiHVJLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 05:11:24 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 499722F011
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 02:11:09 -0700 (PDT)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1oQ3Sc-0000bT-Up; Mon, 22 Aug 2022 11:11:07 +0200
Message-ID: <b64ae172-505a-fbbe-688c-d2d7a713f9a4@leemhuis.info>
Date:   Mon, 22 Aug 2022 11:11:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.0
Subject: Re: regression bisect --> 88f1669019bd " scsi: sd: Rework
 asynchronous resume support"
Content-Language: en-US
To:     Mike Galbraith <efault@gmx.de>, lkml <linux-kernel@vger.kernel.org>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.de>,
        John Garry <john.garry@huawei.com>, ericspero@icloud.com,
        jason600.groome@gmail.com,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
References: <ca8052efe4d1357bc6ece0a45e8429de37e3ae03.camel@gmx.de>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <ca8052efe4d1357bc6ece0a45e8429de37e3ae03.camel@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1661159470;0dc5f60a;
X-HE-SMSGID: 1oQ3Sc-0000bT-Up
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, this is your Linux kernel regression tracker.

On 21.08.22 09:34, Mike Galbraith wrote:
> Greetings,
> 
> My box claims this patch is a dud for it, symptom being hang during
> suspend _after_ a successful suspend/resume cycle. Revert at bisect
> starting point and now HEAD (15b3f48a4339) confirms box's assertion.
> [...]
> # first bad commit: [88f1669019bd62b3009a3cebf772fbaaa21b9f38] scsi: sd: Rework asynchronous resume support

FYI, in case you missed it: there are multiple reports that this patch
is causing problems. A revert and a partial reverts are discussed:

https://lore.kernel.org/all/20220816172638.538734-1-bvanassche@acm.org/
https://lore.kernel.org/regressions/dd6844e7-f338-a4e9-2dad-0960e25b2ca1@redhat.com/
https://lore.kernel.org/all/98592410-dd31-9081-86be-fda67d3b06d2@suse.cz/

See also:
https://lore.kernel.org/all/ecf878dc-905b-f714-4c44-6c90e81f8391@acm.org/

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

P.S.: As the Linux kernel's regression tracker I deal with a lot of
reports and sometimes miss something important when writing mails like
this. If that's the case here, don't hesitate to tell me in a public
reply, it's in everyone's interest to set the public record straight.

P.P.S.: Just to be sure, add this report to the regression tracking, too:

#regzbot ^introduced: 88f1669019bd62b3009a3
#regzbot dup-of:
https://lore.kernel.org/all/98592410-dd31-9081-86be-fda67d3b06d2@suse.cz/
#regzbot monitor:
https://lore.kernel.org/linux-scsi/20220821220502.13685-1-bvanassche@acm.org/
