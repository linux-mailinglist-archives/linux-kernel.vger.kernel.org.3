Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8AD052A6B9
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 17:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350092AbiEQPdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 11:33:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiEQPdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 11:33:35 -0400
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC1734130C
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 08:33:33 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:56996)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nqzCV-008zaP-Nq; Tue, 17 May 2022 09:33:31 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:38502 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nqzCU-00CBh4-Iq; Tue, 17 May 2022 09:33:31 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc:     Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>
References: <20220425174128.11455-1-naveen.n.rao@linux.vnet.ibm.com>
        <YoNqJ/MOSIVwKP/o@MiWiFi-R3L-srv>
        <1652782155.56t7mah8ib.naveen@linux.ibm.com>
Date:   Tue, 17 May 2022 10:32:18 -0500
In-Reply-To: <1652782155.56t7mah8ib.naveen@linux.ibm.com> (Naveen N. Rao's
        message of "Tue, 17 May 2022 15:49:41 +0530")
Message-ID: <8735h8b2f1.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1nqzCU-00CBh4-Iq;;;mid=<8735h8b2f1.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX1+Rsm9jiHl7RP207+UxFb0FJ9BaNggLsNY=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa05 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ******;"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 510 ms - load_scoreonly_sql: 0.12 (0.0%),
        signal_user_changed: 13 (2.6%), b_tie_ro: 11 (2.2%), parse: 1.65
        (0.3%), extract_message_metadata: 7 (1.4%), get_uri_detail_list: 3.2
        (0.6%), tests_pri_-1000: 6 (1.1%), tests_pri_-950: 1.93 (0.4%),
        tests_pri_-900: 1.52 (0.3%), tests_pri_-90: 162 (31.8%), check_bayes:
        159 (31.3%), b_tokenize: 10 (2.0%), b_tok_get_all: 9 (1.8%),
        b_comp_prob: 4.0 (0.8%), b_tok_touch_all: 132 (25.8%), b_finish: 1.16
        (0.2%), tests_pri_0: 289 (56.7%), check_dkim_signature: 0.89 (0.2%),
        check_dkim_adsp: 3.5 (0.7%), poll_dns_idle: 0.73 (0.1%), tests_pri_10:
        2.8 (0.5%), tests_pri_500: 12 (2.4%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] kexec_file: Drop pr_err in weak implementations of
 arch_kexec_apply_relocations[_add]
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Looking at this the pr_err is absolutely needed.  If an unsupported case
winds up in the purgatory blob and the code can't handle it things
will fail silently much worse later.  So the proposed patch is
unfortunately the wrong direction.

"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> writes:

> Baoquan He wrote:
>> On 04/25/22 at 11:11pm, Naveen N. Rao wrote:
>>> kexec_load_purgatory() can fail for many reasons - there is no need to
>>> print an error when encountering unsupported relocations.
>>> This solves a build issue on powerpc with binutils v2.36 and newer [1].
>>> Since commit d1bcae833b32f1 ("ELF: Don't generate unused section
>>> symbols") [2], binutils started dropping section symbols that it thought
>> I am not familiar with binutils, while wondering if this exists in other
>> ARCHes except of ppc. Arm64 doesn't have the ARCH override either, do we
>> have problem with it?
>
> I'm not aware of this specific file causing a problem on other architectures -
> perhaps the config options differ enough. There are however more reports of
> similar issues affecting other architectures with the llvm integrated assembler:
> https://github.com/ClangBuiltLinux/linux/issues/981
>
>> 
>>> were unused.  This isn't an issue in general, but with kexec_file.c, gcc
>>> is placing kexec_arch_apply_relocations[_add] into a separate
>>> .text.unlikely section and the section symbol ".text.unlikely" is being
>>> dropped. Due to this, recordmcount is unable to find a non-weak symbol
>> But arch_kexec_apply_relocations_add is weak symbol on ppc.
>
> Yes. Note that it is just the section symbol that gets dropped. The section is
> still present and will continue to hold the symbols for the functions
> themselves.

So we have a case where binutils thinks it is doing something useful
and our kernel specific tool gets tripped up by it.

Reading the recordmcount code it looks like it is finding any symbol
within a section but ignoring weak symbols.  So I suspect the only
remaining symbol in the section is __weak and that confuses
recordmcount.

Does removing the __weak annotation on those functions fix the build
error?  If so we can restructure the kexec code to simply not use __weak
symbols.

Otherwise the fix needs to be in recordmcount or binutils, and we should
loop whoever maintains recordmcount in to see what they can do.

Eric
