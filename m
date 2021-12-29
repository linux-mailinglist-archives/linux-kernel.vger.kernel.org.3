Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AABD6481516
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 17:30:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237511AbhL2QaH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 11:30:07 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:49182 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbhL2QaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 11:30:06 -0500
Received: from in01.mta.xmission.com ([166.70.13.51]:60148)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1n2bq1-006J2r-5p; Wed, 29 Dec 2021 09:30:05 -0700
Received: from ip68-110-24-146.om.om.cox.net ([68.110.24.146]:42112 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1n2bpz-007BGD-Dr; Wed, 29 Dec 2021 09:30:04 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Guo Ren <guoren@kernel.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Brian Cain <bcain@codeaurora.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20211227184851.2297759-1-nathan@kernel.org>
        <20211227184851.2297759-4-nathan@kernel.org>
        <CAJF2gTSB8rT=g_v=NAE1YmM_qNWAVj=H5mrnty-zPVXOKYCARg@mail.gmail.com>
Date:   Wed, 29 Dec 2021 10:29:19 -0600
In-Reply-To: <CAJF2gTSB8rT=g_v=NAE1YmM_qNWAVj=H5mrnty-zPVXOKYCARg@mail.gmail.com>
        (Guo Ren's message of "Tue, 28 Dec 2021 09:46:25 +0800")
Message-ID: <87o84zs7c0.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1n2bpz-007BGD-Dr;;;mid=<87o84zs7c0.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.110.24.146;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18zHzrgEB0nCAqppPLTARSuCpNxGJFcVxU=
X-SA-Exim-Connect-IP: 68.110.24.146
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.2 required=8.0 tests=ALL_TRUSTED,BAYES_20,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        T_TooManySym_02,T_TooManySym_03,XMNoVowels,XMSubLong
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        * -0.0 BAYES_20 BODY: Bayes spam probability is 5 to 20%
        *      [score: 0.1503]
        *  0.7 XMSubLong Long Subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
        *  0.0 T_TooManySym_03 6+ unique symbols in subject
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Guo Ren <guoren@kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1144 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 11 (1.0%), b_tie_ro: 10 (0.8%), parse: 0.79
        (0.1%), extract_message_metadata: 2.6 (0.2%), get_uri_detail_list:
        0.65 (0.1%), tests_pri_-1000: 3.6 (0.3%), tests_pri_-950: 1.21 (0.1%),
        tests_pri_-900: 1.03 (0.1%), tests_pri_-90: 64 (5.6%), check_bayes: 62
        (5.4%), b_tokenize: 4.3 (0.4%), b_tok_get_all: 6 (0.5%), b_comp_prob:
        1.70 (0.1%), b_tok_touch_all: 47 (4.1%), b_finish: 1.06 (0.1%),
        tests_pri_0: 1040 (90.9%), check_dkim_signature: 0.82 (0.1%),
        check_dkim_adsp: 3.0 (0.3%), poll_dns_idle: 0.56 (0.0%), tests_pri_10:
        2.9 (0.3%), tests_pri_500: 9 (0.8%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 3/3] csky: Fix function name in csky_alignment() and die()
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Guo Ren <guoren@kernel.org> writes:

> Hi Nathan,
>
> Three wrong parts in csky! you forgot mm/fault.c.
>
> Eric's patch seems not to cc me? Why arm64 is correct, csky is wrong. -_*!

Human frailty and the unfortunate fact I could not find a compiler for
csky, h8300, or hexagon.

Since I could not find a compiler I could not even compile test my
changes.  Nor I presume could any of the automated bots.

The good thing is that Nathan caught my typo before the change made it
to Linus.


I will get these changes applied to my tree shortly.

Eric
