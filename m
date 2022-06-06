Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A310E53EEE5
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 21:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232720AbiFFTws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 15:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232539AbiFFTwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 15:52:46 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA1E3B87B;
        Mon,  6 Jun 2022 12:52:44 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 256JgLi5032275;
        Mon, 6 Jun 2022 19:50:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2021-07-09; bh=qPtoKwjaGXQDfHGktMSxgJtZW9CJTyC6C2NEYzPUbD4=;
 b=Btw6TAPn2XOwX2i2pHFN3Qv8eWGJ5dDCMiIDJmHtrfHXB0wznoVMjyqBTN+OXYAgiL+y
 mg9Z+dBfZC6Zn2jc6YrH1yuXfRAdHQ6Aol4rNqhBaK3cOTnLHs5J4t0FeUo0mVRBvTt4
 IFAFZKBzJYP/9HxI7j3uuZA7APJ1sGy06BEb3JC23mTnJLHRzeS3gRhTDV0RujHvI5RP
 or+Sm7LE0C1ekGE4LUfg6rdZapZ0MKesQLT13TkseoeULJWuf2MviJgrh87jqNrQF1OT
 hhW2tTigttQDm7R7Q63ZppVORuFEugKCzFbiyHDWFkgUJbQt5Jqlk4feK++wbLq6SjrH pA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gfyxsc3ck-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Jun 2022 19:50:32 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 256JZtgE040786;
        Mon, 6 Jun 2022 19:50:31 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gfwu1yp72-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Jun 2022 19:50:31 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 256Jo3sX037867;
        Mon, 6 Jun 2022 19:50:30 GMT
Received: from t460.home (dhcp-10-175-25-223.vpn.oracle.com [10.175.25.223])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gfwu1yp4e-1;
        Mon, 06 Jun 2022 19:50:30 +0000
From:   Vegard Nossum <vegard.nossum@oracle.com>
To:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Amit Shah <aams@amazon.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Solar Designer <solar@openwall.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Will Deacon <will@kernel.org>, Willy Tarreau <w@1wt.eu>
Subject: [PATCH v2] Documentation/security-bugs: overhaul
Date:   Mon,  6 Jun 2022 21:48:50 +0200
Message-Id: <20220606194850.26122-1-vegard.nossum@oracle.com>
X-Mailer: git-send-email 2.35.1.46.g38062e73e0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: IBhixqoE1HZJtxo06R1xxu1bdPKwan0C
X-Proofpoint-GUID: IBhixqoE1HZJtxo06R1xxu1bdPKwan0C
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current instructions for reporting security vulnerabilities in the
kernel are not clear enough, in particular the process of disclosure
and requesting CVEs, and what the roles of the different lists are and
how exactly to report to each of them.

Let's give this document an overhaul. Goals are stated as a comment at
the bottom of the document; these will not appear in the rendered HTML
document.

v2: address feedback from Willy Tarreau and Jonathan Corbet

Link: https://seclists.org/oss-sec/2022/q2/133
Cc: Amit Shah <aams@amazon.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Gustavo A. R. Silva <gustavoars@kernel.org>
Cc: Jiri Kosina <jkosina@suse.cz>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Kees Cook <keescook@chromium.org>
Cc: Laura Abbott <labbott@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Solar Designer <solar@openwall.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Thorsten Leemhuis <linux@leemhuis.info>
Cc: Tyler Hicks <tyhicks@linux.microsoft.com>
Cc: Will Deacon <will@kernel.org>
Cc: Willy Tarreau <w@1wt.eu>
Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
---
 Documentation/admin-guide/security-bugs.rst | 252 +++++++++++++-------
 1 file changed, 167 insertions(+), 85 deletions(-)

v1 thread:
https://lore.kernel.org/all/20220531230309.9290-1-vegard.nossum@oracle.com/T/#u

Updated rendered HTML:
https://vegard.github.io/security/Documentation/output/admin-guide/security-bugs-v2.html

diff --git a/Documentation/admin-guide/security-bugs.rst b/Documentation/admin-guide/security-bugs.rst
index 82e29837d5898..c63eeb1e89ffd 100644
--- a/Documentation/admin-guide/security-bugs.rst
+++ b/Documentation/admin-guide/security-bugs.rst
@@ -1,96 +1,178 @@
+
 .. _securitybugs:
 
-Security bugs
-=============
+Reporting security bugs
+=======================
 
 Linux kernel developers take security very seriously.  As such, we'd
 like to know when a security bug is found so that it can be fixed and
 disclosed as quickly as possible.  Please report security bugs to the
-Linux kernel security team.
-
-Contact
--------
-
-The Linux kernel security team can be contacted by email at
-<security@kernel.org>.  This is a private list of security officers
-who will help verify the bug report and develop and release a fix.
-If you already have a fix, please include it with your report, as
-that can speed up the process considerably.  It is possible that the
-security team will bring in extra help from area maintainers to
-understand and fix the security vulnerability.
-
-As it is with any bug, the more information provided the easier it
-will be to diagnose and fix.  Please review the procedure outlined in
-'Documentation/admin-guide/reporting-issues.rst' if you are unclear about what
-information is helpful.  Any exploit code is very helpful and will not
-be released without consent from the reporter unless it has already been
-made public.
-
-Please send plain text emails without attachments where possible.
-It is much harder to have a context-quoted discussion about a complex
-issue if all the details are hidden away in attachments.  Think of it like a
-:doc:`regular patch submission <../process/submitting-patches>`
-(even if you don't have a patch yet): describe the problem and impact, list
+Linux kernel security team at security@kernel.org, henceforth "the
+security list". This is a closed list of trusted developers who will
+help verify the bug report and develop a patch in case none was already
+proposed.
+
+While the security list is closed, the security team may bring in
+extra help from the relevant maintainers to understand and fix the
+security vulnerability.
+
+Note that the main interest of the kernel security list is in getting
+bugs fixed and getting patches reviewed, tested, and merged; CVE
+assignment, disclosure to distributions, and public disclosure happen
+on different lists with different people, as described below.
+
+Here is a quick overview of the various lists:
+
+ =============================== ===== =================== ===============
+ List address                    Open? Purpose             Members
+ =============================== ===== =================== ===============
+ security@kernel.org                no | Reporting         Trusted kernel
+                                       | Patch development developers
+ ------------------------------- ----- ------------------- ---------------
+ linux-distros@vs.openwall.org      no | Coordination      Distribution
+                                       | CVE assignment    representatives
+                                       | Backporting
+                                       | Testing
+ ------------------------------- ----- ------------------- ---------------
+ oss-security@lists.openwall.com   yes | Disclosure        General public
+ =============================== ===== =================== ===============
+
+The following sections give a step-by-step guide to reporting and
+disclosure.
+
+Contacting the security list
+----------------------------
+
+As it is with any bug, the more information provided the easier it will
+be to diagnose and fix; please review the procedure outlined in
+Documentation/admin-guide/reporting-issues.rst if you are unclear about
+what information is helpful. Any exploit code is very helpful and will
+not be released without consent from the reporter unless it has already
+been made public. Reporters are encouraged to propose patches, participate
+in the discussions of a fix, and test patches.
+
+The security team does not assign CVEs, nor does it require them
+for reports or fixes. CVEs may be requested when the issue is reported to
+the linux-distros list.
+
+**Disclosure.** The security list strongly prefers to have patches posted
+for review and testing on public mailing lists and and merged into the
+appropriate public git repository as soon as they become available.
+However, in exceptional cases, you or an affected party may request that
+the patch be withheld for some days; as a rule, the maximum is 7 days.
+Only in truly exceptional cases will the security list consider deferring
+the publication of a fix beyond this, and the only valid reason for doing
+so would be to accommodate the logistics of QA and large scale rollouts
+that require release coordination.
+
+Please note that although a fix is public, there may still be value
+in withholding the details of its security relevance and/or how to exploit
+it for another while; see below for when and how to properly disclose the
+security impact of your findings publicly.
+
+**List rules.** Please send plain text emails without attachments where
+possible. It is much harder to have a context-quoted discussion about a
+complex issue if all the details are hidden away in attachments. Think of
+it like regular patch submission (see Documentation/process/submitting-patches.rst)
+even if you don't have a patch yet; describe the problem and impact, list
 reproduction steps, and follow it with a proposed fix, all in plain text.
 
-Disclosure and embargoed information
-------------------------------------
-
-The security list is not a disclosure channel.  For that, see Coordination
-below.
-
-Once a robust fix has been developed, the release process starts.  Fixes
-for publicly known bugs are released immediately.
-
-Although our preference is to release fixes for publicly undisclosed bugs
-as soon as they become available, this may be postponed at the request of
-the reporter or an affected party for up to 7 calendar days from the start
-of the release process, with an exceptional extension to 14 calendar days
-if it is agreed that the criticality of the bug requires more time.  The
-only valid reason for deferring the publication of a fix is to accommodate
-the logistics of QA and large scale rollouts which require release
-coordination.
-
-While embargoed information may be shared with trusted individuals in
-order to develop a fix, such information will not be published alongside
-the fix or on any other disclosure channel without the permission of the
-reporter.  This includes but is not limited to the original bug report
-and followup discussions (if any), exploits, CVE information or the
-identity of the reporter.
-
-In other words our only interest is in getting bugs fixed.  All other
-information submitted to the security list and any followup discussions
-of the report are treated confidentially even after the embargo has been
-lifted, in perpetuity.
-
-Coordination
-------------
-
-Fixes for sensitive bugs, such as those that might lead to privilege
-escalations, may need to be coordinated with the private
-<linux-distros@vs.openwall.org> mailing list so that distribution vendors
-are well prepared to issue a fixed kernel upon public disclosure of the
-upstream fix. Distros will need some time to test the proposed patch and
-will generally request at least a few days of embargo, and vendor update
-publication prefers to happen Tuesday through Thursday. When appropriate,
-the security team can assist with this coordination, or the reporter can
-include linux-distros from the start. In this case, remember to prefix
-the email Subject line with "[vs]" as described in the linux-distros wiki:
-<http://oss-security.openwall.org/wiki/mailing-lists/distros#how-to-use-the-lists>
-
-CVE assignment
---------------
-
-The security team does not normally assign CVEs, nor do we require them
-for reports or fixes, as this can needlessly complicate the process and
-may delay the bug handling. If a reporter wishes to have a CVE identifier
-assigned ahead of public disclosure, they will need to contact the private
-linux-distros list, described above. When such a CVE identifier is known
-before a patch is provided, it is desirable to mention it in the commit
-message if the reporter agrees.
-
-Non-disclosure agreements
--------------------------
+**Confidentiality.** While embargoed information may be shared with trusted
+individuals in order to develop a fix, such information will not be
+published alongside the fix or on any other disclosure channel without the
+permission of the reporter. This includes but is not limited to the
+original bug report and followup discussions (if any), exploits, CVE
+information or the identity of the reporter. All such other information
+submitted to the security list and any follow-up discussions of the report
+are treated confidentially even after the embargo has been lifted, in
+perpetuity.
 
 The Linux kernel security team is not a formal body and therefore unable
 to enter any non-disclosure agreements.
+
+Once a patch has been developed, you are encouraged to contact the
+linux-distros list.
+
+Contacting the linux-distros list
+---------------------------------
+
+Fixes for particularly sensitive bugs (such as those that might lead to
+privilege escalations) may need to be coordinated with the private
+linux-distros mailing list (linux-distros@vs.openwall.org) so that
+distribution vendors are well prepared to release a fixed kernel as soon
+as possible after the public disclosure of the upstream fix. This
+includes verifying the reported issue, testing proposed fixes,
+developing a fix (if none is known yet), and backporting to older kernels
+and other versions.
+
+The linux-distros list can also help with assigning a CVE for your issue.
+
+**Disclosure.** The linux-distros list has a strict policy of requiring
+reporters to post about the security issue on oss-security within 14 days
+of the list being contacted regardless of whether a patch is available or
+not. It is therefore preferable that you don't send your initial bug
+report to the linux-distros list unless you already have a patch for the
+issue.
+
+**List rules.** The main rules to be aware of when contacting the
+linux-distros list are:
+
+* Don't post about issues that are already public. If your issue has a
+  public patch, but the security impact is not generally known, then you
+  may still post about it.
+
+* The submitter can suggest an embargo end-date, but as a rule, embargoes
+  should not be longer than 7 days, or at most 14 days in exceptional
+  cases. Keep in mind that vendors may prefer to release new kernel
+  packages and/or updates Tuesday through Thursday.
+
+* When the embargo ends, the issue must be disclosed immediately on
+  the oss-security list (see below).
+
+* Prefix your subject with the string "[vs]" to avoid getting rejected
+  by the spam filter.
+
+For the full list of rules, see:
+https://oss-security.openwall.org/wiki/mailing-lists/distros#list-policy-and-instructions-for-reporters
+
+**Confidentiality.** Please note that, as opposed to the security list, any
+and all material submitted to the list must be made public once the
+security issue is publicly disclosed, so please do not post information
+to the linux-distros list that cannot be made public.
+
+Contacting the oss-security list
+--------------------------------
+
+When your security issue is public, or you wish to make your issue public,
+you can write to the oss-security list (oss-security@lists.openwall.com).
+This is a public list (anybody can subscribe and view the list archives)
+and it is not restricted to Linux kernel issues.
+
+The oss-security list typically does not assign CVEs or accept requests for
+CVE assignments.
+
+**List rules.** Please do not cross-post to other lists when writing to
+this list. Make sure to read the other list rules before posting:
+https://oss-security.openwall.org/wiki/mailing-lists/oss-security
+.
+
+..
+    If you modify this document, please consider the following:
+    
+    1) The most important information should be at the top (preferably in
+    the opening paragraph). This means contacting <security@kernel.org>;
+    if somebody doesn't read any further than that, at least the security
+    team will have the report.
+    
+    2) Make the differences between the lists extremely clear. The old
+    version did make an attempt at this, but the lines were not drawn
+    clearly enough.
+    
+    3) Emphasize some of the posting rules which can be confusing to new
+    people (e.g. the fact that posting to linux-distros means you must
+    propose an embargo date and that this cannot under any circumstances
+    be more than 14 days).
+    
+    4) The document should be a "step-by-step process" as much as possible,
+    so that you can use it as a guide while reporting an issue instead of
+    having to search back and forth for the thing you're looking for.
-- 
2.35.1.46.g38062e73e0

