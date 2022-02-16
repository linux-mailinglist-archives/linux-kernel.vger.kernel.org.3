Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 738F74B8D03
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 16:57:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235807AbiBPP5K convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 16 Feb 2022 10:57:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235773AbiBPP5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 10:57:04 -0500
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23C431A1323
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 07:56:49 -0800 (PST)
Received: from in01.mta.xmission.com ([166.70.13.51]:49644)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nKMfd-001nv3-J2; Wed, 16 Feb 2022 08:56:45 -0700
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:37420 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nKMfc-002XrX-IJ; Wed, 16 Feb 2022 08:56:45 -0700
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     <linux-kernel@vger.kernel.org>
Cc:     Alexey Gladkov <legion@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <shuah@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Solar Designer <solar@openwall.com>,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>,
        <linux-api@vger.kernel.org>
References: <20220207121800.5079-1-mkoutny@suse.com>
        <87o83e2mbu.fsf@email.froward.int.ebiederm.org>
Date:   Wed, 16 Feb 2022 09:56:37 -0600
In-Reply-To: <87o83e2mbu.fsf@email.froward.int.ebiederm.org> (Eric
        W. Biederman's message of "Thu, 10 Feb 2022 20:01:25 -0600")
Message-ID: <87ilteiz4a.fsf_-_@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-XM-SPF: eid=1nKMfc-002XrX-IJ;;;mid=<87ilteiz4a.fsf_-_@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+/L9et1C/bHc4Ya5pJzRgmcgiNxBncn0I=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;<linux-kernel@vger.kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 380 ms - load_scoreonly_sql: 0.19 (0.1%),
        signal_user_changed: 10 (2.7%), b_tie_ro: 8 (2.1%), parse: 1.05 (0.3%),
         extract_message_metadata: 3.1 (0.8%), get_uri_detail_list: 0.92
        (0.2%), tests_pri_-1000: 4.5 (1.2%), tests_pri_-950: 1.60 (0.4%),
        tests_pri_-900: 1.47 (0.4%), tests_pri_-90: 105 (27.6%), check_bayes:
        103 (27.1%), b_tokenize: 6 (1.6%), b_tok_get_all: 7 (1.8%),
        b_comp_prob: 2.2 (0.6%), b_tok_touch_all: 84 (22.1%), b_finish: 1.13
        (0.3%), tests_pri_0: 234 (61.6%), check_dkim_signature: 1.09 (0.3%),
        check_dkim_adsp: 2.8 (0.7%), poll_dns_idle: 0.83 (0.2%), tests_pri_10:
        2.4 (0.6%), tests_pri_500: 8 (2.0%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH v2 0/5] ucounts: RLIMIT_NPROC fixes
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


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

Anyone who can please take a look and tell me if I am doing something silly.

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

Eric
