Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77AFB490FA3
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 18:31:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237971AbiAQRbm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 12:31:42 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:47644 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239005AbiAQRbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 12:31:34 -0500
Received: from in02.mta.xmission.com ([166.70.13.52]:44742)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1n9Vqt-00HRqg-CU; Mon, 17 Jan 2022 10:31:31 -0700
Received: from ip68-110-24-146.om.om.cox.net ([68.110.24.146]:47238 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1n9Vqs-00FkwG-D8; Mon, 17 Jan 2022 10:31:31 -0700
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Mike Christie <michael.christie@oracle.com>
Cc:     geert@linux-m68k.org, vverma@digitalocean.com, hdanton@sina.com,
        hch@infradead.org, stefanha@redhat.com, jasowang@redhat.com,
        mst@redhat.com, sgarzare@redhat.com,
        virtualization@lists.linux-foundation.org,
        christian.brauner@ubuntu.com, axboe@kernel.dk,
        linux-kernel@vger.kernel.org
References: <20211129194707.5863-1-michael.christie@oracle.com>
        <87tuf79gni.fsf@email.froward.int.ebiederm.org>
        <a171238e-d731-1c22-af72-0f7faf7f4bea@oracle.com>
        <87tuf11oe6.fsf@email.froward.int.ebiederm.org>
        <a3bd6fe7-1775-6fdd-3a02-e779c4d4e498@oracle.com>
        <87pmpoxzuf.fsf@email.froward.int.ebiederm.org>
        <783145b7-243b-b85e-e274-44ef6c0696b9@oracle.com>
Date:   Mon, 17 Jan 2022 11:31:22 -0600
In-Reply-To: <783145b7-243b-b85e-e274-44ef6c0696b9@oracle.com> (Mike
        Christie's message of "Mon, 17 Jan 2022 10:41:05 -0600")
Message-ID: <874k62b76d.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1n9Vqs-00FkwG-D8;;;mid=<874k62b76d.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.110.24.146;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19/12qxSuzbVIP5mosEcqpM6N5wKVRUr9o=
X-SA-Exim-Connect-IP: 68.110.24.146
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Mike Christie <michael.christie@oracle.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 444 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 9 (2.1%), b_tie_ro: 8 (1.8%), parse: 0.78 (0.2%),
        extract_message_metadata: 2.4 (0.5%), get_uri_detail_list: 0.74 (0.2%),
         tests_pri_-1000: 3.5 (0.8%), tests_pri_-950: 1.19 (0.3%),
        tests_pri_-900: 0.99 (0.2%), tests_pri_-90: 101 (22.8%), check_bayes:
        100 (22.5%), b_tokenize: 5.0 (1.1%), b_tok_get_all: 6 (1.3%),
        b_comp_prob: 1.73 (0.4%), b_tok_touch_all: 84 (18.9%), b_finish: 0.98
        (0.2%), tests_pri_0: 304 (68.5%), check_dkim_signature: 0.49 (0.1%),
        check_dkim_adsp: 2.6 (0.6%), poll_dns_idle: 0.80 (0.2%), tests_pri_10:
        2.3 (0.5%), tests_pri_500: 10 (2.3%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH V6 01/10] Use copy_process in vhost layer
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Christie <michael.christie@oracle.com> writes:

> On 12/22/21 12:24 PM, Eric W. Biederman wrote:
>> All I am certain of is that you need to set
>> "args->exit_signal = -1;".  This prevents having to play games with
>> do_notify_parent.
>
> Hi Eric,
>
> I have all your review comments handled except this one. It's looking like it's
> more difficult than just setting the exit_signal=-1, so I wanted to check that
> I understood you.

[snip problems with exit_signal = -1]

>
> What do you think?

I was wrong.  I appear to have confused the thread and the non-thread
cases.

Perhaps I meant "args->exit_signal = 0".  That looks like
do_notify_parent won't send it, and thread_group_leader continues to do
the right thing.

Baring any additional confusion on my part that cleanly solves the
problem of how not to send a signal from a child process cleanly.

My apologies for sending you on a wild goose chase.

Eric


