Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7C1F53AB6F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 18:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356206AbiFAQ6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 12:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354317AbiFAQ6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 12:58:45 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E2284A0B;
        Wed,  1 Jun 2022 09:58:41 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id C3F8D2C3;
        Wed,  1 Jun 2022 16:58:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net C3F8D2C3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1654102720; bh=iM1gTdQgfAuBfQa3sOYlXR+O5U2vnXeo1TB17L2Db6I=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=WJ7QNIqSlBYZsXHKuPOyYrcBHyL2dlZgIShiNGRfYmN768mLEcpGGz192/jNlVdnt
         wGKSFbB9nRmX16KFjSw/yuExh8g8aJebpskqT6ezPhrFr23xp2mnAw5kbwCIEmj2Il
         m0QNUtjgoxIp2QEKgTbX9je2ZX2SSGpeHr00tzfSQwU71/0htsHItnZHfvPUapoLSJ
         VYWwmN8XYWaImIeI6lromuZ0/eHAJ9BM/JbTpq9VgkmGw6xOkbuuQ3DA8CTnkgpDuM
         fX6iqBuS1dkVmFhB5Tc7ik7yyCdHpkKSG8PlxS6u0wMLLxiEQFoQnuibDy1peoRmTg
         ZuiKD9txUL2bw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Vegard Nossum <vegard.nossum@oracle.com>, linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Amit Shah <aams@amazon.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Solar Designer <solar@openwall.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Will Deacon <will@kernel.org>, Willy Tarreau <w@1wt.eu>
Subject: Re: [PATCH] Documentation/security-bugs: overhaul
In-Reply-To: <20220531230309.9290-1-vegard.nossum@oracle.com>
References: <20220531230309.9290-1-vegard.nossum@oracle.com>
Date:   Wed, 01 Jun 2022 10:58:50 -0600
Message-ID: <87fsko48xh.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vegard Nossum <vegard.nossum@oracle.com> writes:

> The current instructions for reporting security vulnerabilities in the
> kernel are not clear enough, in particular the process of disclosure
> and requesting CVEs, and what the roles of the different lists are and
> how exactly to report to each of them.
>
> Let's give this document an overhaul. Goals are stated as a comment at
> the top of the document itself (these will not appear in the rendered
> document).

OK, some other thoughts...

[...]

> +Linux kernel security team at security@kernel.org, henceforth "the
> +security list". This is a closed list of trusted developers who will
> +help verify the bug report and develop a patch.
> +
> +While the security list is closed, the security team may bring in
> +extra help from the relevant maintainers to understand and fix the
> +security vulnerability.
> +
> +Note that the main interest of the kernel security list is in getting
> +bugs fixed; CVE assignment, disclosure to distributions, and public
> +disclosure happens on different lists with different people.

Adding "as described below" or some such might be helpful for readers
who are mostly interested in those things.  

> +Here is a quick overview of the various lists:
> +
> +.. list-table::
> +   :widths: 35 10 20 35
> +   :header-rows: 1
> +
> +   * - List address
> +     - Open?
> +     - Purpose
> +     - Members
> +   * - security@kernel.org
> +     - Closed
> +     - Reporting; patch development
> +     - Trusted kernel developers
> +   * - linux-distros@vs.openwall.org
> +     - Closed
> +     - Coordination; CVE assignment; patch development, testing, and backporting
> +     - Linux distribution representatives
> +   * - oss-security@lists.openwall.com
> +     - Public
> +     - Disclosure
> +     - General public

Please don't use list-table, that's totally unreadable in the plain-text
format.  How about something like:

 =============================== ===== ================= ===============
 List address                    Open? Purpose           Members
 =============================== ===== ================= ===============
 security@kernel.org                no Reporting         Trusted kernel
                                                         developers
                                       Patch development
 linux-distros@vs.openwall.org      no Coordination      Distribution 
                                                         representatives
                                       CVE assignment
                                       Patch development
                                       Testing
                                       Backporting
 oss-security@lists.openwall.com   yes Disclosure        General public
 =============================== ===== ================= ===============

(Note I haven't tried to format this, there's probably an error in there
somewhere). 

> +The following sections give a step-by-step guide to reporting and
> +disclosure.
> +
> +Contacting the security list
> +----------------------------
> +
> +As it is with any bug, the more information provided the easier it will
> +be to diagnose and fix; please review the procedure outlined in
> +Documentation/admin-guide/reporting-issues.rst if you are unclear about
> +what information is helpful. Any exploit code is very helpful and will
> +not be released without consent from the reporter unless it has already
> +been made public.
> +
> +The security team does not assign CVEs, nor does it require them
> +for reports or fixes. CVEs may be requested when the issue is reported to
> +the linux-distros list.
> +
> +**Disclosure.** The security list prefers to merge fixes into the
> +appropriate public git repository as soon as they become available.

More to the point, the idea is to get *review attention* onto the
patches, presumably before they are commited to some repo, right?
That's my understanding from the oss-security discussion, anyway.  So
the first disclosure may not be when it shows up in a repo, as suggested
here. 

[...]

> +Once a patch has been developed, you are encouraged to contact the
> +linux-distros list; see below.

Nit: "see below" seems unnecessary when "below" is the next line down

> +Contacting the linux-distros list
> +---------------------------------
> +
> +Fixes for particularly sensitive bugs (such as those that might lead to
> +privilege escalations) may need to be coordinated with the private
> +linux-distros mailing list (linux-distros@vs.openwall.org) so that
> +distribution vendors are well prepared to release a fixed kernel as soon
> +as possible after the public disclosure of the upstream fix. This
> +includes verifying the reported issue, testing proposed fixes,
> +developing a fix (if none is known yet), and backporting to older kernels
> +and other versions.
> +
> +The linux-distros list can also help with assigning a CVE for your issue.
> +
> +**Disclosure.** The linux-distros list has a strict policy of requiring
> +reporters to post about the security issue on oss-security within 14 days
> +of the list being contacted regardless of whether a patch is available or
> +not. It is therefore preferable that you don't send your initial bug
> +report to the linux-distros list unless you already have a patch for the
> +issue.
> +
> +**List rules.** The main rules to be aware of when contacting the
> +linux-distros list are:

So this seems certain to go out of date when the other list's rules
change.  I wonder if it would be better just to tell readers they need
to be aware of that list's rules and give a pointer?

Thanks,

jon
