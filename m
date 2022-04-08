Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D4744F91A8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 11:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbiDHJK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 05:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232587AbiDHJKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 05:10:42 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E675111D78D;
        Fri,  8 Apr 2022 02:08:38 -0700 (PDT)
Date:   Fri, 08 Apr 2022 09:08:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649408917;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a+9a9sX+AtnfbLsfaAjyC7PbSX1PutNOnfHgO4MQy9Y=;
        b=0b/UdOA65NGtE7G3E5v/kKPesG6Syz2TYWVe8RU7SjyptIZED8oQit55b9tgLxNKN6nPCp
        BgLPN8g8XReEUjNI49w4Zcaym+ybF8PYn5UGUKs/MEdzzVl+2RxzHevtVZcE0QF1LfHx7a
        5TUqoFjigLybKV5g2rVFMED/pYoCCfN5UrJ9qA9AbREx0JVuM9X6JeGjKVCD8fduDMvVXp
        FYPRVeDMJ1amMSJD/mVeHmHKjjb2yHZF2gQD+8LqQIeCQRTQfNfJ+cXzhNCwgH4ac/XQKS
        Y4MG19jktDJ1vASBNEjp2L1C23tJvgujx8KwNX5AtBTE4RIM+MvXTuqIPIFg3g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649408917;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a+9a9sX+AtnfbLsfaAjyC7PbSX1PutNOnfHgO4MQy9Y=;
        b=/S9Jb7s3tMpul8Ja7m/mBLzIvX3wT44SVEQjcH1796Pd0im50bC8FhhJ+UPXcIb9T9ze6P
        oC7R5HCgO5kiZtBw==
From:   "tip-bot2 for Michael Roth" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] virt: sevguest: Add documentation for SEV-SNP CPUID
 Enforcement
Cc:     Michael Roth <michael.roth@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220307213356.2797205-47-brijesh.singh@amd.com>
References: <20220307213356.2797205-47-brijesh.singh@amd.com>
MIME-Version: 1.0
Message-ID: <164940891648.389.595050059106700206.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     92a99584d965b930988b28f36d925bd9675828b3
Gitweb:        https://git.kernel.org/tip/92a99584d965b930988b28f36d925bd9675828b3
Author:        Michael Roth <michael.roth@amd.com>
AuthorDate:    Thu, 24 Feb 2022 10:56:25 -06:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 07 Apr 2022 16:47:12 +02:00

virt: sevguest: Add documentation for SEV-SNP CPUID Enforcement

Update the documentation with information regarding SEV-SNP CPUID
Enforcement details and what sort of assurances it provides to guests.

Signed-off-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20220307213356.2797205-47-brijesh.singh@amd.com
---
 Documentation/virt/coco/sevguest.rst | 29 +++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+)

diff --git a/Documentation/virt/coco/sevguest.rst b/Documentation/virt/coco/sevguest.rst
index 625de22..bf593e8 100644
--- a/Documentation/virt/coco/sevguest.rst
+++ b/Documentation/virt/coco/sevguest.rst
@@ -118,6 +118,35 @@ be updated with the expected value.
 
 See GHCB specification for further detail on how to parse the certificate blob.
 
+3. SEV-SNP CPUID Enforcement
+============================
+
+SEV-SNP guests can access a special page that contains a table of CPUID values
+that have been validated by the PSP as part of the SNP_LAUNCH_UPDATE firmware
+command. It provides the following assurances regarding the validity of CPUID
+values:
+
+ - Its address is obtained via bootloader/firmware (via CC blob), and those
+   binaries will be measured as part of the SEV-SNP attestation report.
+ - Its initial state will be encrypted/pvalidated, so attempts to modify
+   it during run-time will result in garbage being written, or #VC exceptions
+   being generated due to changes in validation state if the hypervisor tries
+   to swap the backing page.
+ - Attempts to bypass PSP checks by the hypervisor by using a normal page, or
+   a non-CPUID encrypted page will change the measurement provided by the
+   SEV-SNP attestation report.
+ - The CPUID page contents are *not* measured, but attempts to modify the
+   expected contents of a CPUID page as part of guest initialization will be
+   gated by the PSP CPUID enforcement policy checks performed on the page
+   during SNP_LAUNCH_UPDATE, and noticeable later if the guest owner
+   implements their own checks of the CPUID values.
+
+It is important to note that this last assurance is only useful if the kernel
+has taken care to make use of the SEV-SNP CPUID throughout all stages of boot.
+Otherwise, guest owner attestation provides no assurance that the kernel wasn't
+fed incorrect values at some point during boot.
+
+
 Reference
 ---------
 
