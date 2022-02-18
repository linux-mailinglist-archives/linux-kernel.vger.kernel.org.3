Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52AB64BBC44
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 16:35:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237076AbiBRPf1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 18 Feb 2022 10:35:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236375AbiBRPf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 10:35:26 -0500
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 484B32B2C4F;
        Fri, 18 Feb 2022 07:35:09 -0800 (PST)
Received: from in02.mta.xmission.com ([166.70.13.52]:34138)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nL5Hk-0071wH-Qv; Fri, 18 Feb 2022 08:35:04 -0700
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:48854 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nL5Hj-000V6x-Ed; Fri, 18 Feb 2022 08:35:04 -0700
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     <linux-kernel@vger.kernel.org>, Alexey Gladkov <legion@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <shuah@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Solar Designer <solar@openwall.com>,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Michal =?utf-8?Q?Kou?= =?utf-8?Q?tn=C3=BD?= <mkoutny@suse.com>,
        <linux-api@vger.kernel.org>
In-Reply-To: <87ilteiz4a.fsf_-_@email.froward.int.ebiederm.org> (Eric
        W. Biederman's message of "Wed, 16 Feb 2022 09:56:37 -0600")
References: <20220207121800.5079-1-mkoutny@suse.com>
        <87o83e2mbu.fsf@email.froward.int.ebiederm.org>
        <87ilteiz4a.fsf_-_@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
Date:   Fri, 18 Feb 2022 09:34:24 -0600
Message-ID: <87wnhsfatb.fsf_-_@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-XM-SPF: eid=1nL5Hj-000V6x-Ed;;;mid=<87wnhsfatb.fsf_-_@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19XCajOGFlerezhWHtxQiJqFG3eQqptWXk=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: ; sa04 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 502 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 8 (1.7%), b_tie_ro: 7 (1.4%), parse: 0.89 (0.2%),
        extract_message_metadata: 3.4 (0.7%), get_uri_detail_list: 1.61 (0.3%),
         tests_pri_-1000: 3.2 (0.6%), tests_pri_-950: 1.01 (0.2%),
        tests_pri_-900: 0.84 (0.2%), tests_pri_-90: 184 (36.7%), check_bayes:
        182 (36.2%), b_tokenize: 6 (1.3%), b_tok_get_all: 8 (1.6%),
        b_comp_prob: 2.1 (0.4%), b_tok_touch_all: 161 (32.0%), b_finish: 1.32
        (0.3%), tests_pri_0: 277 (55.2%), check_dkim_signature: 0.64 (0.1%),
        check_dkim_adsp: 3.5 (0.7%), poll_dns_idle: 1.14 (0.2%), tests_pri_10:
        3.1 (0.6%), tests_pri_500: 13 (2.7%), rewrite_mail: 0.00 (0.0%)
Subject: [GIT PULL] ucounts: RLIMIT_NPROC fixes for v5.17
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Please pull the ucount-rlimit-fixes-for-v5.17 branch from the git tree:

  git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git ucount-rlimit-fixes-for-v5.17

  HEAD: 0cbae9e24fa7d6c6e9f828562f084da82217a0c5 ucounts: Handle wrapping in is_ucounts_overlimit

Michal Koutný recently found some bugs in the enforcement of
RLIMIT_NPROC in the recent ucount rlimit implementation.

I saw some additional bugs and some cleaner ways to fix the problem so
instead of starting with his fixes these are my own.

I have rewritten about half my fixes since the last time this was
posted.  There is this notion (not entirely wrong) that the code should
be consistent and make sense.  When I dug in I discovered that has not
been the case for the last 20 years.  Fixing the long standing
inconsistencies is something that seems to warrent wider vetting on
linux-api.

So with this set of patches I have developed a very conservative
approach changing only what is necessary to fix the bugs that I can
see clearly.  Cleanups and anything that is making the code more
consistent can follow after we have the code working as it has
historically.

I had hoped to let this sit in linux-next for a few days just to be
doubly certain all is well.  But these patches are all trivial and
linux-next is on holiday.

v2: https://lkml.kernel.org/r/87ilteiz4a.fsf_-_@email.froward.int.ebiederm.org>
v1: https://lkml.kernel.org/r/87o83e2mbu.fsf@email.froward.int.ebiederm.org>

Eric W. Biederman (5):
      rlimit: Fix RLIMIT_NPROC enforcement failure caused by capability calls in set_user
      ucounts: Enforce RLIMIT_NPROC not RLIMIT_NPROC+1
      ucounts: Base set_cred_ucounts changes on the real user
      ucounts: Move RLIMIT_NPROC handling after set_user
      ucounts: Handle wrapping in is_ucounts_overlimit

 kernel/cred.c   |  9 ++-------
 kernel/fork.c   | 10 +++++-----
 kernel/sys.c    | 20 ++++++++++++++------
 kernel/ucount.c |  3 ++-
 4 files changed, 23 insertions(+), 19 deletions(-)

p.s. I should say that the problem is not so much inconsistencies
(although those exist) but that it is very difficult to figure out what
the code should be doing in the case of RLIMIT_NPROC.

All other rlimits are only enforced where the resource is acquired
(allocated).  RLIMIT_NPROC by necessity needs to be enforced in
an additional location, and our current implementation stumbled
it's way into that implementation.

Eric




