Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1493052DC23
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 19:59:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243473AbiESR7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 13:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231908AbiESR7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 13:59:46 -0400
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31941D4101
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 10:59:46 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:36212)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nrkR5-00ENiG-OH; Thu, 19 May 2022 11:59:43 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:38802 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nrkR3-006e82-PA; Thu, 19 May 2022 11:59:43 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org,
        Andrew Morton <akpm@linux-foundation.org>
References: <20220518181828.645877-1-naveen.n.rao@linux.vnet.ibm.com>
        <87ee0q7b92.fsf@email.froward.int.ebiederm.org>
        <YoWySwbszfdZS9LU@MiWiFi-R3L-srv>
Date:   Thu, 19 May 2022 12:59:17 -0500
In-Reply-To: <YoWySwbszfdZS9LU@MiWiFi-R3L-srv> (Baoquan He's message of "Thu,
        19 May 2022 10:58:19 +0800")
Message-ID: <87bkvt4d56.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1nrkR3-006e82-PA;;;mid=<87bkvt4d56.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX1/rSxyKigaHMoSccMUFZ8spyBuVsjtCT6w=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Virus: No
X-Spam-DCC: XMission; sa01 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ******;Baoquan He <bhe@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1394 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 4.8 (0.3%), b_tie_ro: 3.3 (0.2%), parse: 1.12
        (0.1%), extract_message_metadata: 12 (0.8%), get_uri_detail_list: 2.8
        (0.2%), tests_pri_-1000: 8 (0.6%), tests_pri_-950: 1.07 (0.1%),
        tests_pri_-900: 0.77 (0.1%), tests_pri_-90: 48 (3.4%), check_bayes: 47
        (3.4%), b_tokenize: 6 (0.4%), b_tok_get_all: 8 (0.6%), b_comp_prob:
        1.84 (0.1%), b_tok_touch_all: 28 (2.0%), b_finish: 0.75 (0.1%),
        tests_pri_0: 1308 (93.8%), check_dkim_signature: 0.40 (0.0%),
        check_dkim_adsp: 2.8 (0.2%), poll_dns_idle: 0.24 (0.0%), tests_pri_10:
        1.78 (0.1%), tests_pri_500: 6 (0.4%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] kexec_file: Drop weak attribute from
 arch_kexec_apply_relocations[_add]
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Baoquan He <bhe@redhat.com> writes:

> Hi Eric,
>
> On 05/18/22 at 04:59pm, Eric W. Biederman wrote:
>> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> writes:
>> 
>> > Since commit d1bcae833b32f1 ("ELF: Don't generate unused section
>> > symbols") [1], binutils (v2.36+) started dropping section symbols that
>> > it thought were unused.  This isn't an issue in general, but with
>> > kexec_file.c, gcc is placing kexec_arch_apply_relocations[_add] into a
>> > separate .text.unlikely section and the section symbol ".text.unlikely"
>> > is being dropped. Due to this, recordmcount is unable to find a non-weak
>> > symbol in .text.unlikely to generate a relocation record against.
>> >
>> > Address this by dropping the weak attribute from these functions:
>> > - arch_kexec_apply_relocations() is not overridden by any architecture
>> >   today, so just drop the weak attribute.
>> > - arch_kexec_apply_relocations_add() is only overridden by x86 and s390.
>> >   Retain the function prototype for those and move the weak
>> >   implementation into the header as a static inline for other
>> >   architectures.
>> >
>> > [1] https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=d1bcae833b32f1
>> 
>> Any chance you can also get machine_kexec_post_load,
>> crash_free_reserved_phys_range, arch_kexec_protect_protect_crashkres,
>> arch_kexec_unprotect_crashkres, arch_kexec_kernel_image_probe,
>> arch_kexec_kernel_image_probe, arch_kimage_file_post_load_cleanup,
>> arch_kexec_kernel_verify_sig, and arch_kexec_locate_mem_hole as well.
>> 
>> That is everything in kexec that uses a __weak symbol.  If we can't
>> count on them working we might as well just get rid of the rest
>> preemptively.
>
> Is there a new rule that __weak is not suggested in kernel any more?
> Please help provide a pointer if yes, so that I can learn that.
>
> In my mind, __weak is very simple and clear as a mechanism to add
> ARCH related functionality.

You should be able to trace the conversation back for all of the details
but if you can't here is the summary.

There is a tool that some architectures use called recordmcount.  The
recordmcount looks for a symbol in a section, and ignores all weak
symbols.  In certain cases sections become so simple there are only weak
symbols.  At which point recordmcount fails.

Which means in practice __weak symbols are unreliable and don't work
to add ARCH related functionality.

Given that __weak symbols fail randomly I would much rather have simpler
code that doesn't fail.  It has never been the case that __weak symbols
have been very common in the kernel.  I expect they are something like
bool that have been gaining traction.  Still given that __weak symbols
don't work.  I don't want them.

Eric
