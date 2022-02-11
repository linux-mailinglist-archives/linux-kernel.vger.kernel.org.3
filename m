Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8D94B2D7A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 20:24:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352821AbiBKTXU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 11 Feb 2022 14:23:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241986AbiBKTXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 14:23:17 -0500
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9767CF2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 11:23:15 -0800 (PST)
Received: from in01.mta.xmission.com ([166.70.13.51]:54624)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nIbVg-002qrV-Ad; Fri, 11 Feb 2022 12:23:12 -0700
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:50218 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nIbVf-000w6K-DF; Fri, 11 Feb 2022 12:23:11 -0700
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Alexey Gladkov <legion@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <shuah@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Solar Designer <solar@openwall.com>,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
References: <20220207121800.5079-1-mkoutny@suse.com>
        <87o83e2mbu.fsf@email.froward.int.ebiederm.org>
        <f0d686aa-3fad-afac-d377-f5d63111704a@linuxfoundation.org>
Date:   Fri, 11 Feb 2022 13:23:05 -0600
In-Reply-To: <f0d686aa-3fad-afac-d377-f5d63111704a@linuxfoundation.org> (Shuah
        Khan's message of "Fri, 11 Feb 2022 11:22:13 -0700")
Message-ID: <87leyhyzqe.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-XM-SPF: eid=1nIbVf-000w6K-DF;;;mid=<87leyhyzqe.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19LUXAJ/33c8R6qojTj8/18WpDwWjCXwzw=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Shuah Khan <skhan@linuxfoundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 339 ms - load_scoreonly_sql: 0.12 (0.0%),
        signal_user_changed: 11 (3.2%), b_tie_ro: 8 (2.5%), parse: 1.26 (0.4%),
         extract_message_metadata: 13 (3.7%), get_uri_detail_list: 1.22 (0.4%),
         tests_pri_-1000: 7 (2.1%), tests_pri_-950: 1.41 (0.4%),
        tests_pri_-900: 1.08 (0.3%), tests_pri_-90: 56 (16.5%), check_bayes:
        54 (16.0%), b_tokenize: 7 (2.0%), b_tok_get_all: 6 (1.7%),
        b_comp_prob: 2.2 (0.6%), b_tok_touch_all: 37 (10.9%), b_finish: 0.88
        (0.3%), tests_pri_0: 231 (68.1%), check_dkim_signature: 0.66 (0.2%),
        check_dkim_adsp: 2.7 (0.8%), poll_dns_idle: 0.44 (0.1%), tests_pri_10:
        2.1 (0.6%), tests_pri_500: 12 (3.6%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 0/8] ucounts: RLIMIT_NPROC fixes
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shuah Khan <skhan@linuxfoundation.org> writes:

> On 2/10/22 7:01 PM, Eric W. Biederman wrote:
>> Michal Koutný recently found some bugs in the enforcement of
>> RLIMIT_NPROC in the recent ucount rlimit implementation.
>> I saw some additional bugs and some cleaner ways to fix the problem so
>> instead of starting with his fixes these are my own.
>> I am aiming to send the first 5 of these to Linus once they have been
>> reviewed.  Two more are fixes in principle but I don't think do anything
>> in practice.  The last one is just a cleanup to prevent future
>> divergence of RLIMIT_NPROC logic.
>> Eric W. Biederman (8):
>>        ucounts: Fix RLIMIT_NPROC regression
>>        ucounts: Fix set_cred_ucounts
>>        ucounts: Fix and simplify RLIMIT_NPROC handling during setuid()+execve
>>        ucounts: Only except the root user in init_user_ns from RLIMIT_NPROC
>
> Should this be "Only exempt"?

Yes.
>  >        ucounts: Handle wrapping in is_ucounts_overlimit
>>        ucounts: Handle inc_rlimit_ucounts wrapping in fork
>>        rlimit: For RLIMIT_NPROC test the child not the parent for capabilites
>>        ucounts: Use the same code to enforce RLIMIT_NPROC in fork and exec
>>   fs/exec.c                    | 12 +++++-------
>>   include/linux/sched.h        |  2 +-
>>   include/linux/sched/signal.h |  2 ++
>>   kernel/cred.c                | 24 +++++++++++-------------
>>   kernel/fork.c                | 32 ++++++++++++++++++++++++--------
>>   kernel/sys.c                 | 14 --------------
>>   kernel/ucount.c              |  3 ++-
>>   kernel/user_namespace.c      |  2 ++
>>   8 files changed, 47 insertions(+), 44 deletions(-)
>> Eric
>> 
>
> Do we need updates to selftests - Michal's patch series included changes to
> selftests/exec

selftests would be good.

Eric


