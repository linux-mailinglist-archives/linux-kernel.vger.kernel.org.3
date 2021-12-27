Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF0DA47FE34
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 16:24:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237327AbhL0PW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 10:22:56 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:46624 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbhL0PWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 10:22:55 -0500
Received: from in01.mta.xmission.com ([166.70.13.51]:57768)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1n1rpu-00EZTE-Bn; Mon, 27 Dec 2021 08:22:54 -0700
Received: from ip68-110-24-146.om.om.cox.net ([68.110.24.146]:53952 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1n1rpt-000RLD-2o; Mon, 27 Dec 2021 08:22:53 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Alexey Gladkov <legion@kernel.org>
Cc:     Qian Cai <quic_qiancai@quicinc.com>, Yu Zhao <yuzhao@google.com>,
        linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
References: <YZV7Z+yXbsx9p3JN@fixkernel.com>
        <875ysptfgi.fsf@email.froward.int.ebiederm.org>
        <YZa4YbcOyjtD3+pL@fixkernel.com>
        <87k0h5rxle.fsf@email.froward.int.ebiederm.org>
        <YZ6zXEZf9qHLFyIp@fixkernel.com> <YaBxzDGyWxU/836N@fixkernel.com>
        <8735mnakby.fsf@email.froward.int.ebiederm.org>
        <20211221130937.yokn25stgjpzax7n@example.org>
Date:   Mon, 27 Dec 2021 09:22:20 -0600
In-Reply-To: <20211221130937.yokn25stgjpzax7n@example.org> (Alexey Gladkov's
        message of "Tue, 21 Dec 2021 14:09:37 +0100")
Message-ID: <87zgomrs2b.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1n1rpt-000RLD-2o;;;mid=<87zgomrs2b.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.110.24.146;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+eeZnfb1D1Jnm9EjwwOXbfxGZEXvWZ6DQ=
X-SA-Exim-Connect-IP: 68.110.24.146
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa05.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=8.0 tests=ALL_TRUSTED,BAYES_00,
        DCC_CHECK_NEGATIVE,FVGT_m_MULTI_ODD,T_TM2_M_HEADER_IN_MSG
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        * -3.0 BAYES_00 BODY: Bayes spam probability is 0 to 1%
        *      [score: 0.0004]
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa05 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.4 FVGT_m_MULTI_ODD Contains multiple odd letter combinations
X-Spam-DCC: XMission; sa05 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Alexey Gladkov <legion@kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 424 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 9 (2.0%), b_tie_ro: 7 (1.7%), parse: 1.17 (0.3%),
        extract_message_metadata: 12 (2.8%), get_uri_detail_list: 1.68 (0.4%),
        tests_pri_-1000: 5 (1.2%), tests_pri_-950: 1.27 (0.3%),
        tests_pri_-900: 1.03 (0.2%), tests_pri_-90: 132 (31.2%), check_bayes:
        119 (28.0%), b_tokenize: 7 (1.6%), b_tok_get_all: 8 (1.9%),
        b_comp_prob: 2.5 (0.6%), b_tok_touch_all: 98 (23.1%), b_finish: 0.96
        (0.2%), tests_pri_0: 250 (58.9%), check_dkim_signature: 0.65 (0.2%),
        check_dkim_adsp: 3.0 (0.7%), poll_dns_idle: 1.14 (0.3%), tests_pri_10:
        2.3 (0.5%), tests_pri_500: 7 (1.7%), rewrite_mail: 0.00 (0.0%)
Subject: Re: BUG: KASAN: use-after-free in dec_rlimit_ucounts
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alexey Gladkov <legion@kernel.org> writes:

> On Sun, Dec 19, 2021 at 11:58:41PM -0600, Eric W. Biederman wrote:
>> Qian Cai <quic_qiancai@quicinc.com> writes:
>> 
>> > On Wed, Nov 24, 2021 at 04:49:19PM -0500, Qian Cai wrote:
>> >> Hmm, I don't know if that or it is just this platfrom is lucky to trigger
>> >> the race condition quickly, but I can't reproduce it on x86 so far. I am
>> >> Cc'ing a few arm64 people to see if they have spot anything I might be
>> >> missing. The original bug report is here:
>> >> 
>> >> https://lore.kernel.org/lkml/YZV7Z+yXbsx9p3JN@fixkernel.com/
>> >
>> > Okay, I am finally able to reproduce this on x86_64 with the latest
>> > mainline as well by setting CONFIG_USER_NS and KASAN on the top of
>> > defconfig (I did not realize it did not select CONFIG_USER_NS in the first
>> > place). Anyway, it still took less than 5-minute by running:
>> >
>> > $ trinity -C 48
>> 
>> It took me a while to get to the point of reproducing this but I can
>> confirm I see this with 2 core VM, running 5.16.0-rc4.
>> 
>> Running trinity 2019.06 packaged in debian 11.
>
> I still can't reproduce :(
>
>> I didn't watch so I don't know if it was 5 minutes but I do know it took
>> less than an hour.
>
> --- a/kernel/ucount.c
> +++ b/kernel/ucount.c
> @@ -209,6 +209,7 @@ void put_ucounts(struct ucounts *ucounts)
>
>         if (atomic_dec_and_lock_irqsave(&ucounts->count, &ucounts_lock, flags)) {
>                 hlist_del_init(&ucounts->node);
> +               ucounts->ns = NULL;
>                 spin_unlock_irqrestore(&ucounts_lock, flags);
>                 kfree(ucounts);
>         }
>
> Does the previous hack increase the likelihood of an error being
> triggered?

It doesn't seem to make a difference.  That makes sense as the kernel
address sanitizer is part of the kernel configuration required to
reproduce the issue.

Eric
