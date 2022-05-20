Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7698052F3C0
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 21:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350617AbiETTZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 15:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233590AbiETTZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 15:25:16 -0400
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2D3517CC90
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 12:25:14 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:59076)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1ns8FN-005abm-0f; Fri, 20 May 2022 13:25:13 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:38902 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1ns8FL-00AvPl-JP; Fri, 20 May 2022 13:25:12 -0600
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
        <87bkvt4d56.fsf@email.froward.int.ebiederm.org>
        <20220520104641.GB194232@MiWiFi-R3L-srv>
Date:   Fri, 20 May 2022 14:25:05 -0500
In-Reply-To: <20220520104641.GB194232@MiWiFi-R3L-srv> (Baoquan He's message of
        "Fri, 20 May 2022 18:46:41 +0800")
Message-ID: <877d6g0zxq.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1ns8FL-00AvPl-JP;;;mid=<877d6g0zxq.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX1/URvw/lxAMbTzvDCmfUuuQSRX+KM9N0yg=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ******;Baoquan He <bhe@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 634 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 11 (1.7%), b_tie_ro: 9 (1.5%), parse: 0.97 (0.2%),
         extract_message_metadata: 14 (2.2%), get_uri_detail_list: 3.4 (0.5%),
        tests_pri_-1000: 12 (1.8%), tests_pri_-950: 1.22 (0.2%),
        tests_pri_-900: 0.97 (0.2%), tests_pri_-90: 160 (25.2%), check_bayes:
        157 (24.8%), b_tokenize: 12 (1.9%), b_tok_get_all: 52 (8.2%),
        b_comp_prob: 3.9 (0.6%), b_tok_touch_all: 85 (13.5%), b_finish: 1.05
        (0.2%), tests_pri_0: 422 (66.6%), check_dkim_signature: 0.54 (0.1%),
        check_dkim_adsp: 3.0 (0.5%), poll_dns_idle: 1.18 (0.2%), tests_pri_10:
        2.2 (0.3%), tests_pri_500: 7 (1.1%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] kexec_file: Drop weak attribute from
 arch_kexec_apply_relocations[_add]
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Baoquan He <bhe@redhat.com> writes:

> On 05/19/22 at 12:59pm, Eric W. Biederman wrote:
>> Baoquan He <bhe@redhat.com> writes:
>> 
>> > Hi Eric,
>> >
>> > On 05/18/22 at 04:59pm, Eric W. Biederman wrote:
>> >> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> writes:
>> >> 
>> >> > Since commit d1bcae833b32f1 ("ELF: Don't generate unused section
>> >> > symbols") [1], binutils (v2.36+) started dropping section symbols that
>> >> > it thought were unused.  This isn't an issue in general, but with
>> >> > kexec_file.c, gcc is placing kexec_arch_apply_relocations[_add] into a
>> >> > separate .text.unlikely section and the section symbol ".text.unlikely"
>> >> > is being dropped. Due to this, recordmcount is unable to find a non-weak
>> >> > symbol in .text.unlikely to generate a relocation record against.
>> >> >
>> >> > Address this by dropping the weak attribute from these functions:
>> >> > - arch_kexec_apply_relocations() is not overridden by any architecture
>> >> >   today, so just drop the weak attribute.
>> >> > - arch_kexec_apply_relocations_add() is only overridden by x86 and s390.
>> >> >   Retain the function prototype for those and move the weak
>> >> >   implementation into the header as a static inline for other
>> >> >   architectures.
>> >> >
>> >> > [1] https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=d1bcae833b32f1
>> >> 
>> >> Any chance you can also get machine_kexec_post_load,
>> >> crash_free_reserved_phys_range, arch_kexec_protect_protect_crashkres,
>> >> arch_kexec_unprotect_crashkres, arch_kexec_kernel_image_probe,
>> >> arch_kexec_kernel_image_probe, arch_kimage_file_post_load_cleanup,
>> >> arch_kexec_kernel_verify_sig, and arch_kexec_locate_mem_hole as well.
>> >> 
>> >> That is everything in kexec that uses a __weak symbol.  If we can't
>> >> count on them working we might as well just get rid of the rest
>> >> preemptively.
>> >
>> > Is there a new rule that __weak is not suggested in kernel any more?
>> > Please help provide a pointer if yes, so that I can learn that.
>> >
>> > In my mind, __weak is very simple and clear as a mechanism to add
>> > ARCH related functionality.
>> 
>> You should be able to trace the conversation back for all of the details
>> but if you can't here is the summary.
>> 
>> There is a tool that some architectures use called recordmcount.  The
>> recordmcount looks for a symbol in a section, and ignores all weak
>> symbols.  In certain cases sections become so simple there are only weak
>> symbols.  At which point recordmcount fails.
>> 
>> Which means in practice __weak symbols are unreliable and don't work
>> to add ARCH related functionality.
>> 
>> Given that __weak symbols fail randomly I would much rather have simpler
>> code that doesn't fail.  It has never been the case that __weak symbols
>> have been very common in the kernel.  I expect they are something like
>> bool that have been gaining traction.  Still given that __weak symbols
>> don't work.  I don't want them.
>
> Thanks for the summary, Eric.
>
> From Naveen's reply, what I got is, llvm's recent change makes
> symbol of section .text.unlikely lost,

If I have read the thread correctly this change happened in both
llvm and binutils.  So both tools chains that are used to build the
kernel.

> but the secton .text.unlikely
> still exists. The __weak symbol will be put in .text.unlikely partly,
> when arch_kexec_apply_relocations_add() includes the pr_err line. While
> removing the pr_err() line will put __weak symbol
> arch_kexec_apply_relocations_add() in .text instead.

Yes.  Calling pr_err has some effect.  Either causing an mcount
entry to be ommitted, or causing the symbols in the function to be
placed in .text.unlikely.

> Now the status is that not only recordmcount got this problem, objtools
> met it too and got an appropriate fix. Means objtools's fix doesn't need
> kernel's adjustment. Recordmcount need kernel to adjust because it lacks
> continuous support and developement. Naveen also told that they are
> converting to objtools, just the old CI cases rely on recordmcount. In
> fact, if someone stands up to get an appropriate recordmcount fix too,
> the problem will be gone too.

If the descriptions are correct I suspect recoredmcount could just
decided to use the weak symbol, and not ignore it.

Unfortunately I looked at the code and it looks like recordmcount
is only ignoring weak symbols on arm.  So without being able to
reproduce this I don't understand enough of what is going to on to fix
it.

> Asking this because __weak will be sentenced to death from now on, if we
> decide to change kernel. And this thread will be the pointer provided to
> others when telling them not to use __weak.

Well knowing that it is recordmcount all someone has to do is show that
recordmcount has been removed/fixed for the case in question.

> I am not strongly against taking off __weak, just wondering if there's
> chance to fix it in recordmcount, and the cost comparing with kernel fix;
> except of this issue, any other weakness of __weak. Noticed Andrew has
> picked this patch, as a witness of this moment, raise a tiny concern.

I just don't see what else we can realistically do.

Eric



