Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD91B53A944
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 16:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353956AbiFAOh4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 10:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiFAOhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 10:37:52 -0400
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 542F131233
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 07:37:51 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:39050)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nwPTm-003wch-Kk; Wed, 01 Jun 2022 08:37:46 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:47918 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nwPTk-00ASIR-BF; Wed, 01 Jun 2022 08:37:46 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     Ying Huang <ying.huang@intel.com>, <peterx@redhat.com>,
        <apopple@nvidia.com>, <osalvador@suse.de>,
        <mike.kravetz@oracle.com>, <songmuchun@bytedance.com>,
        <hch@lst.de>, <dhowells@redhat.com>, <cl@linux.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <akpm@linux-foundation.org>, <naoya.horiguchi@nec.com>
References: <20220530113016.16663-1-linmiaohe@huawei.com>
        <20220530113016.16663-2-linmiaohe@huawei.com>
        <bbc060ca6e967790423e0a3ca940d1e700447554.camel@intel.com>
        <b2ddcd64-2779-ede9-3615-ad5bc90a3bc1@huawei.com>
        <87bkvdfzvm.fsf@email.froward.int.ebiederm.org>
        <e10023d7-3d19-1edf-86af-4cb79071b78f@huawei.com>
Date:   Wed, 01 Jun 2022 09:37:21 -0500
In-Reply-To: <e10023d7-3d19-1edf-86af-4cb79071b78f@huawei.com> (Miaohe Lin's
        message of "Wed, 1 Jun 2022 14:33:02 +0800")
Message-ID: <87y1yga1r2.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1nwPTk-00ASIR-BF;;;mid=<87y1yga1r2.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX19dRjWhftz57Cs5rYGnFs7Ohp6QmfecC1w=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ****;Miaohe Lin <linmiaohe@huawei.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1647 ms - load_scoreonly_sql: 0.10 (0.0%),
        signal_user_changed: 12 (0.7%), b_tie_ro: 10 (0.6%), parse: 1.61
        (0.1%), extract_message_metadata: 17 (1.0%), get_uri_detail_list: 3.8
        (0.2%), tests_pri_-1000: 8 (0.5%), tests_pri_-950: 1.43 (0.1%),
        tests_pri_-900: 1.08 (0.1%), tests_pri_-90: 71 (4.3%), check_bayes: 70
        (4.2%), b_tokenize: 11 (0.7%), b_tok_get_all: 12 (0.7%), b_comp_prob:
        3.8 (0.2%), b_tok_touch_all: 38 (2.3%), b_finish: 1.02 (0.1%),
        tests_pri_0: 1513 (91.8%), check_dkim_signature: 0.71 (0.0%),
        check_dkim_adsp: 2.9 (0.2%), poll_dns_idle: 0.94 (0.1%), tests_pri_10:
        3.4 (0.2%), tests_pri_500: 15 (0.9%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v4 1/4] mm: reduce the rcu lock duration
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Miaohe Lin <linmiaohe@huawei.com> writes:

> On 2022/6/1 0:09, Eric W. Biederman wrote:
>> Miaohe Lin <linmiaohe@huawei.com> writes:
> snip
>>>
>>> "
>>> Commit 3268c63eded4 ("mm: fix move/migrate_pages() race on task struct")
>>> extends the period of the rcu_read_lock until after the permissions checks
>>> are done because it suspects the permissions checks are not safe unless
>>> performed under both rcu_read_lock and task_lock to ensure the task<->mm
>>> association does not change on us while we are working [1]. But extended
>>> rcu read lock does not add much value. Because after permission checking
>>> the permission may still be changed. There's no much difference. So it's
>>> unnecessary to extend the period of the rcu_read_lock. Release the rcu
>>> lock after task refcount is successfully grabbed to reduce the rcu holding
>>> time.
>>>
>>> [1] https://lore.kernel.org/lkml/87sjhzun47.fsf@xmission.com/
>>> "
>> 
>> It doesn't make sense to me.
>> 
>> I don't see any sleeping functions called from find_mm_struct or
>> kernel_migrate_pages in the area kernel_migrate_pages in the area of the
>> code protected by get_task_struct.  So at a very basic level I see a
>> justification for dirtying a cache line twice with get_task_struct and
>> put_task_struct to reduce rcu_read_lock hold times.
>> 
>> I would contend that a reasonable cleanup based up on the current state
>> of the code would be to extend the rcu_read_lock over get_task_mm so
>
> If so, security_task_movememory will be called inside rcu lock. It might
> call sleeping functions, e.g. smack_log(). I think it's not a good
> idea.

In general the security functions are not allowed to sleep.
The audit mechanism typically preallocates memory so it does
not need to sleep.  From a quick skim through the code I don't
see smack_log sleeping.

Certainly the security hooks are not supposed to be inserted into the
code that they prevent reasonable implementation decisions.

Which is to say if there is a good (non-security hook reason) for
supporting sleeping deal with it.  Otherwise the security hooks has a
bug and needs to get fixed/removed.

>> that a reference to task_struct does not need to be taken.  That has
>> the potential to reduce contention and reduce lock hold times.
>> 
>> 
>> The code is missing a big fat comment with the assertion that it is ok
>> if the permission checks are racy because the race is small, and the
>> worst case thing that happens is the page is migrated to another
>> numa node.
>> 
>> 
>> Given that the get_mm_task takes task_lock the cost of dirtying the
>> cache line is already being paid.  Perhaps not extending task_lock hold
>> times a little bit is justified, but I haven't seen that case made.
>> 
>> This seems like code that is called little enough it would be better for
>> it to be correct, and not need big fat comments explaining why it
>> doesn't matter that they code is deliberately buggy.
>> 
>
> Agree. A big fat comments will make code hard to follow.

No.

The code is impossible to follow currently.

The code either requires a comment pointing out that it is deliberately
racy, or the code needs to be fixed.

Clever and subtle code always requires a comment if for no other
reason then to alert the reader that something a typical is going on.

>> In short it does not make sense to me to justify a patch for performance
>> reasons when it appears that extending the rcu_read_lock hold time and
>> not touch the task reference count would stop dirtying a cache line and
>> likely have more impact.
>
> IMHO, incremented task refcount should make code works correctly. And extending
> the rcu_read_lock over get_task_mm will break the things because sleeping functions
> might be called while holding rcu lock.

Which sleeping functions?

I can't find any.  In particular smack_task_movememory calls
smk_curacc_on_task which is the same function called by
security_task_getpgid.  security_task_getpgid is called
under rcu_read_lock.  So smack won't sleep.

> Does the patch itself makes sense for you? Should I rephase the commit log further?
> I'm afraid I didn't get your point correctly.

The patch makes no sense to me because I don't see it doing anything
worth doing.

get/put_task_struct both dirty a cache line and are expensive especially
when contended.  Dirtying a cache line that is contended is the pretty
much the most expensive native cpu operation.  In pathological scenarios
I have seen it take up to 1s.  Realistically in a cache cold scenario
(which is not as bad as a contended scenario) you are looking at 100ns
or more just to execute get_task_struct/put_task_struct.  That is the
kind of cost it would be nice to avoid all together (even if the
pathological case never comes up).

So I see two pieces of code where we could use the cheap operation
rcu_read_lock/rcu_read_unlock to remove the expensive operation
get_task_struct/put_task_struct.  Instead I see people removing
rcu_read_lock/rcu_read_unlock.

That makes no sense.  Especially as your implied reason for making this
change is to make the code have better performance.  Improving
performance is the reason for making critical sections smaller isn't it?

Eric
