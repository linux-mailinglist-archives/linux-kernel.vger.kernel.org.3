Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFA7F53CDFB
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 19:22:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344362AbiFCRV7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 13:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235281AbiFCRV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 13:21:56 -0400
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2D90116C
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 10:21:55 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:46024)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nxAzi-00Gdhh-7l; Fri, 03 Jun 2022 11:21:54 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:41234 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nxAzh-00HHJ3-7S; Fri, 03 Jun 2022 11:21:53 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     <linux-kernel@vger.kernel.org>, Alexey Gladkov <legion@kernel.org>,
        Linux Containers <containers@lists.linux.dev>
Date:   Fri, 03 Jun 2022 12:21:46 -0500
Message-ID: <875ylh8xxx.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1nxAzh-00HHJ3-7S;;;mid=<875ylh8xxx.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX190rHEzYxtUa/aQ3ZUqCkNLM08+VG1MKnY=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa04 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ****;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 459 ms - load_scoreonly_sql: 0.09 (0.0%),
        signal_user_changed: 12 (2.7%), b_tie_ro: 11 (2.3%), parse: 0.95
        (0.2%), extract_message_metadata: 12 (2.5%), get_uri_detail_list: 1.83
        (0.4%), tests_pri_-1000: 13 (2.8%), tests_pri_-950: 1.14 (0.2%),
        tests_pri_-900: 0.90 (0.2%), tests_pri_-90: 127 (27.7%), check_bayes:
        126 (27.4%), b_tokenize: 6 (1.2%), b_tok_get_all: 6 (1.3%),
        b_comp_prob: 2.0 (0.4%), b_tok_touch_all: 108 (23.6%), b_finish: 0.91
        (0.2%), tests_pri_0: 265 (57.7%), check_dkim_signature: 0.88 (0.2%),
        check_dkim_adsp: 3.5 (0.8%), poll_dns_idle: 0.74 (0.2%), tests_pri_10:
        4.1 (0.9%), tests_pri_500: 21 (4.5%), rewrite_mail: 0.00 (0.0%)
Subject: [GIT PULL] ipc: per namespace ipc sysctl changes for v5.19
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Please pull the per-namespace-ipc-sysctls-for-v5.19 tag from the git tree:

  git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git per-namespace-ipc-sysctls-for-v5.19
  HEAD: 38cd5b12b7854941ede1954cf5a2393eb94b5d37 ipc: Remove extra braces

These changes update the ipc sysctls so that they are fundamentally
per ipc namespace.  Previously these sysctls depended upon a hack to
simulate being per ipc namespace by looking up the ipc namespace in
read or write.  With this set of changes the ipc sysctls are
registered per ipc namespace and open looks up the ipc namespace.

Not only does this series of changes ensure the traditional binding at
open time happens, but it sets a foundation for being able to relax the
permission checks to allow a user namspace root to change the ipc sysctls
for an ipc namespace that the user namespace root requires.  To do this
requires the ipc namespace to be known at open time.

These changes were sent for v5.18[1] but were dropped because some
additional cleanups were requested.  Linus has given his nod[2] to the
cleanups so I hope enough cleanups are present this time.

[1] https://lkml.kernel.org/r/877d8kfmdp.fsf@email.froward.int.ebiederm.org
[2] https://lkml.kernel.org/r/CAHk-=whi2SzU4XT_FsdTCAuK2qtYmH+-hwi1cbSdG8zu0KXL=g@mail.gmail.com

Alexey Gladkov (6):
      ipc: Store mqueue sysctls in the ipc namespace
      ipc: Store ipc sysctls in the ipc namespace
      ipc: Use the same namespace to modify and validate
      ipc: Remove extra1 field abuse to pass ipc namespace
      ipc: Check permissions for checkpoint_restart sysctls at open time
      ipc: Remove extra braces


 include/linux/ipc_namespace.h |  37 +++++++-
 ipc/ipc_sysctl.c              | 205 +++++++++++++++++++++++++-----------------
 ipc/mq_sysctl.c               | 121 +++++++++++++------------
 ipc/mqueue.c                  |  10 +--
 ipc/namespace.c               |  10 +++
 5 files changed, 238 insertions(+), 145 deletions(-)

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

p.s. My apologies for this coming in so late.  Everyone in the house has
been sick.

