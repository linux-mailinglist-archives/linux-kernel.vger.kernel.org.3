Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82DA15394BB
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 18:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346011AbiEaQKC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 12:10:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346020AbiEaQJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 12:09:56 -0400
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 311C557B13
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 09:09:55 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:46482)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nw4RG-001g9g-Vu; Tue, 31 May 2022 10:09:47 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:40316 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nw4RF-007jjf-IH; Tue, 31 May 2022 10:09:46 -0600
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
Date:   Tue, 31 May 2022 11:09:01 -0500
In-Reply-To: <b2ddcd64-2779-ede9-3615-ad5bc90a3bc1@huawei.com> (Miaohe Lin's
        message of "Tue, 31 May 2022 17:01:09 +0800")
Message-ID: <87bkvdfzvm.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1nw4RF-007jjf-IH;;;mid=<87bkvdfzvm.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX1/wo32upDdcYiQB3D7INFrZxxd/vhQS/wg=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Virus: No
X-Spam-DCC: XMission; sa01 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;Miaohe Lin <linmiaohe@huawei.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 649 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 4.0 (0.6%), b_tie_ro: 2.7 (0.4%), parse: 0.73
        (0.1%), extract_message_metadata: 10 (1.5%), get_uri_detail_list: 2.5
        (0.4%), tests_pri_-1000: 12 (1.8%), tests_pri_-950: 0.98 (0.2%),
        tests_pri_-900: 0.80 (0.1%), tests_pri_-90: 204 (31.4%), check_bayes:
        202 (31.2%), b_tokenize: 8 (1.2%), b_tok_get_all: 79 (12.2%),
        b_comp_prob: 2.2 (0.3%), b_tok_touch_all: 110 (16.9%), b_finish: 0.76
        (0.1%), tests_pri_0: 406 (62.7%), check_dkim_signature: 0.42 (0.1%),
        check_dkim_adsp: 2.7 (0.4%), poll_dns_idle: 1.25 (0.2%), tests_pri_10:
        1.74 (0.3%), tests_pri_500: 6 (0.9%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v4 1/4] mm: reduce the rcu lock duration
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Miaohe Lin <linmiaohe@huawei.com> writes:

> On 2022/5/31 14:06, Ying Huang wrote:
>> On Mon, 2022-05-30 at 19:30 +0800, Miaohe Lin wrote:
>>> Commit 3268c63eded4 ("mm: fix move/migrate_pages() race on task struct")
>>> extends the period of the rcu_read_lock until after the permissions checks
>>> are done to prevent the task pointed to from changing from under us. But
>>> the task_struct refcount is also taken at that time, the reference to task
>>> is guaranteed to be stable. So it's unnecessary to extend the period of
>>> the rcu_read_lock. Release the rcu lock after task refcount is successfully
>>> grabbed to reduce the rcu holding time.
>> 
>> Sorry for late reply, I am busy on something else recently.
>
> That's all right. Many thanks for your hard work. :)
>
>> 
>> I have just read the whole thread of the original patch discussion. 
>> During discussion, in
>> 
>> https://lore.kernel.org/lkml/alpine.DEB.2.00.1202241131400.3726@router.home/
>> 
>> a patch that is same as your one is proposed.  Then in the following
>> message, Eric think that the rcu read lock should be released until
>> permission is checked,
>> 
>> https://lore.kernel.org/lkml/87sjhzun47.fsf@xmission.com/
>> 
>> "
>> At the moment I suspect the permissions checks are not safe unless
>> performed under both rcu_read_lock and task_lock to ensure that
>> the task<->mm association does not change on us while we are
>> working.  Even with that the cred can change under us but at least
>> we know the cred will be valid until rcu_read_unlock happens.
>> "
>> 
>> So the rcu lock duration is enlarged in the following message.
>> 
>> https://lore.kernel.org/lkml/alpine.DEB.2.00.1202271238450.32410@router.home/
>> 
>> But, after some thought, I don't think extended rcu read lock adds much
>> value.  Because after permission checking the permission may still be
>> changed.  There's no much difference.
>> 
>> So, I have no objection to the patch itself.  But you should add more
>> information in patch description about why the RCU proected region is
>> extended and why we can reduce it.
>
> Does below patch description makes sense for you?
>
> "
> Commit 3268c63eded4 ("mm: fix move/migrate_pages() race on task struct")
> extends the period of the rcu_read_lock until after the permissions checks
> are done because it suspects the permissions checks are not safe unless
> performed under both rcu_read_lock and task_lock to ensure the task<->mm
> association does not change on us while we are working [1]. But extended
> rcu read lock does not add much value. Because after permission checking
> the permission may still be changed. There's no much difference. So it's
> unnecessary to extend the period of the rcu_read_lock. Release the rcu
> lock after task refcount is successfully grabbed to reduce the rcu holding
> time.
>
> [1] https://lore.kernel.org/lkml/87sjhzun47.fsf@xmission.com/
> "

It doesn't make sense to me.

I don't see any sleeping functions called from find_mm_struct or
kernel_migrate_pages in the area kernel_migrate_pages in the area of the
code protected by get_task_struct.  So at a very basic level I see a
justification for dirtying a cache line twice with get_task_struct and
put_task_struct to reduce rcu_read_lock hold times.

I would contend that a reasonable cleanup based up on the current state
of the code would be to extend the rcu_read_lock over get_task_mm so
that a reference to task_struct does not need to be taken.  That has
the potential to reduce contention and reduce lock hold times.


The code is missing a big fat comment with the assertion that it is ok
if the permission checks are racy because the race is small, and the
worst case thing that happens is the page is migrated to another
numa node.


Given that the get_mm_task takes task_lock the cost of dirtying the
cache line is already being paid.  Perhaps not extending task_lock hold
times a little bit is justified, but I haven't seen that case made.

This seems like code that is called little enough it would be better for
it to be correct, and not need big fat comments explaining why it
doesn't matter that they code is deliberately buggy.


In short it does not make sense to me to justify a patch for performance
reasons when it appears that extending the rcu_read_lock hold time and
not touch the task reference count would stop dirtying a cache line and
likely have more impact.

Eric
