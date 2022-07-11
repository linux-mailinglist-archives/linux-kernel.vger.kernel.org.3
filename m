Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAB0B570D20
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 00:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbiGKWEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 18:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbiGKWEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 18:04:32 -0400
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8602C509F8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 15:04:31 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:59882)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1oB1W2-006u22-Jr; Mon, 11 Jul 2022 16:04:30 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:46748 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1oB1W1-00H0EA-J3; Mon, 11 Jul 2022 16:04:30 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <YrslT9h0whngMIhw@zx2c4.com>
        <20220628161441.892925-1-Jason@zx2c4.com> <YsLbggVXONPJcZsn@zx2c4.com>
        <CAHmME9qt9hUTgJQSdv3_Yzkc3e7H8OkhPSv_pUaXV_2AOA1S=g@mail.gmail.com>
        <87o7xvcw98.fsf@email.froward.int.ebiederm.org>
        <YsyFhfAunVfVQKci@zx2c4.com>
Date:   Mon, 11 Jul 2022 17:04:22 -0500
In-Reply-To: <YsyFhfAunVfVQKci@zx2c4.com> (Jason A. Donenfeld's message of
        "Mon, 11 Jul 2022 22:18:13 +0200")
Message-ID: <87pmib9uhl.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1oB1W1-00H0EA-J3;;;mid=<87pmib9uhl.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX1/1HTqajhPT84+ODD85nv77lVNjH4ulgdI=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;"Jason A. Donenfeld" <Jason@zx2c4.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 476 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 15 (3.1%), b_tie_ro: 13 (2.7%), parse: 1.92
        (0.4%), extract_message_metadata: 15 (3.2%), get_uri_detail_list: 1.25
        (0.3%), tests_pri_-1000: 5 (1.1%), tests_pri_-950: 1.46 (0.3%),
        tests_pri_-900: 1.09 (0.2%), tests_pri_-90: 111 (23.4%), check_bayes:
        109 (22.9%), b_tokenize: 6 (1.2%), b_tok_get_all: 5 (1.1%),
        b_comp_prob: 1.85 (0.4%), b_tok_touch_all: 93 (19.6%), b_finish: 1.04
        (0.2%), tests_pri_0: 165 (34.6%), check_dkim_signature: 0.63 (0.1%),
        check_dkim_adsp: 3.2 (0.7%), poll_dns_idle: 136 (28.6%), tests_pri_10:
        2.5 (0.5%), tests_pri_500: 152 (32.1%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v3] signal: break out of wait loops on kthread_stop()
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Jason A. Donenfeld" <Jason@zx2c4.com> writes:

> Hi Eric,
>
> Thanks for the review.
>
>> Which I guess my long way of saying I think you can just change
>> kthread_stop to say:
>> 
>> diff --git a/kernel/kthread.c b/kernel/kthread.c
>> index 544fd4097406..52e9b3432496 100644
>> --- a/kernel/kthread.c
>> +++ b/kernel/kthread.c
>> @@ -704,6 +704,7 @@ int kthread_stop(struct task_struct *k)
>>  	kthread = to_kthread(k);
>>  	set_bit(KTHREAD_SHOULD_STOP, &kthread->flags);
>>  	kthread_unpark(k);
>> +	set_tsk_thread_flag(k, TIF_NOTIFY_SIGNAL);
>>  	wake_up_process(k);
>>  	wait_for_completion(&kthread->exited);
>>  	ret = kthread->result;
>> 
>
> Okay. I'll constrain it to just kthread_stop(). But please file away in
> the back of your mind the potential for kthread_park() to be problematic
> down the line, in case we have to fix that later.

Definitely.  Right now I am certain you are motivated to test and make
certain the kthread_stop case will work.  I just have the feeling that
we don't care enough about kthread_park, and so attempting to solve it
now is as likely to cause problems as solve them.

Eric
