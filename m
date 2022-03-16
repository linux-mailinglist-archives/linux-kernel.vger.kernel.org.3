Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93D884DB199
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 14:36:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239990AbiCPNhj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 09:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbiCPNhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 09:37:36 -0400
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33DB447075;
        Wed, 16 Mar 2022 06:36:22 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:35184)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nUTp6-00BMHf-2H; Wed, 16 Mar 2022 07:36:20 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:37920 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nUTp4-00Bptv-1e; Wed, 16 Mar 2022 07:36:19 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Yang Li <yang.lee@linux.alibaba.com>,
        Oleg Nesterov <oleg@redhat.com>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Abaci Robot <abaci@linux.alibaba.com>
References: <20220315235148.54253-1-yang.lee@linux.alibaba.com>
        <CAMuHMdXvgXAnZTGxBWyQ78LPko1f1uUhQRT6TxE1ZDHhRiT2Zw@mail.gmail.com>
Date:   Wed, 16 Mar 2022 08:35:59 -0500
In-Reply-To: <CAMuHMdXvgXAnZTGxBWyQ78LPko1f1uUhQRT6TxE1ZDHhRiT2Zw@mail.gmail.com>
        (Geert Uytterhoeven's message of "Wed, 16 Mar 2022 08:20:09 +0100")
Message-ID: <87pmmm58ao.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1nUTp4-00Bptv-1e;;;mid=<87pmmm58ao.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18H+qCfF1DyV5JF2Ghckp/00rukoXyHPSg=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa08 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Geert Uytterhoeven <geert@linux-m68k.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1456 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 13 (0.9%), b_tie_ro: 11 (0.8%), parse: 0.86
        (0.1%), extract_message_metadata: 11 (0.8%), get_uri_detail_list: 1.20
        (0.1%), tests_pri_-1000: 5 (0.4%), tests_pri_-950: 1.54 (0.1%),
        tests_pri_-900: 1.19 (0.1%), tests_pri_-90: 136 (9.3%), check_bayes:
        131 (9.0%), b_tokenize: 6 (0.4%), b_tok_get_all: 8 (0.5%),
        b_comp_prob: 2.2 (0.1%), b_tok_touch_all: 110 (7.6%), b_finish: 1.54
        (0.1%), tests_pri_0: 1269 (87.1%), check_dkim_signature: 0.68 (0.0%),
        check_dkim_adsp: 9 (0.6%), poll_dns_idle: 0.42 (0.0%), tests_pri_10:
        3.9 (0.3%), tests_pri_500: 11 (0.8%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH -next] ptrace: Remove duplicated include in ptrace.c
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Geert Uytterhoeven <geert@linux-m68k.org> writes:

> Hi Yang,
>
> CC Eric
>
> On Wed, Mar 16, 2022 at 12:52 AM Yang Li <yang.lee@linux.alibaba.com> wrote:
>> Fix following includecheck warning:
>> ./arch/m68k/kernel/ptrace.c: linux/ptrace.h is included more than once.
>>
>> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
>> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
>
> Thanks for your patch!
>
> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
>
>> --- a/arch/m68k/kernel/ptrace.c
>> +++ b/arch/m68k/kernel/ptrace.c
>> @@ -19,7 +19,6 @@
>>  #include <linux/ptrace.h>
>>  #include <linux/user.h>
>>  #include <linux/signal.h>
>> -#include <linux/ptrace.h>
>>
>>  #include <linux/uaccess.h>
>>  #include <asm/page.h>
>
> This is due to commit 153474ba1a4aed0a ("ptrace: Create
> ptrace_report_syscall_{entry,exit} in ptrace.h"), which is not yet
> in the m68k tree, but only in next-20220315, so I cannot do anything
> about it before v5.18-rc1.
>
> Eric: Can you still fix this in the original commit?

Not unless it is something very serious.  Replacing the commit means invalidating
testing and review.  Which I would rather not do.

In this case I can merge a trivial fix to remove the duplicate.  Let me
find Lang Li's patch and merge that.

Eric
