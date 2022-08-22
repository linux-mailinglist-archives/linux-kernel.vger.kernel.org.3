Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DACA59CC68
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 01:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238744AbiHVXoy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 19:44:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237365AbiHVXow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 19:44:52 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D915B3ECFA;
        Mon, 22 Aug 2022 16:44:51 -0700 (PDT)
Date:   Mon, 22 Aug 2022 23:44:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1661211889;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WV9QZiLIcQCEPcsHDa1Hku7ALUOPpRGLHJuLTkGtF1g=;
        b=dzotY1cGYg7VXaX7XNZNIeAnSzFqR4+7z6TMoLLu+a991v63iMLWCSJiZkF051dq4mgUfF
        chaCdAAElLzyLHiboJas+GS7nfTd2D+pBNjt/O1xTYFEBJb3nQJ6GJwwJvnHRLBFbEFnY7
        rZVEKsilBgSUHq1R8EgwW4zz5xyvNVGWR+QiE45StxTh43rYAt+Ch5z5BkckC2l2yAe+4k
        czxCCYtOzolDudackg+8nfqi/q2BVoASsaSpp4CKD7CNdT4ibi/5zknAqDLKqdhAKZzq6x
        PMwnHnLFoQpEPu/4lz4fZZuuhoJIcMrH5QIy+SrMYJ6CEZe7GbfqaXFGTv6AWw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1661211889;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WV9QZiLIcQCEPcsHDa1Hku7ALUOPpRGLHJuLTkGtF1g=;
        b=sDNXFOe7f9z7PopRQ/cj9+NFNySSAJHER8aDMjL7oQ7sRjIxd2X+qSzXj/LflvSK8jies4
        XKPTBfX+WMHFTbAQ==
From:   "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpu: Add new Raptor Lake CPU model number
Cc:     Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <YwO49TDHnLcOyE+F@agluck-desk3.sc.intel.com>
References: <YwO49TDHnLcOyE+F@agluck-desk3.sc.intel.com>
MIME-Version: 1.0
Message-ID: <166121188787.401.17379235294060223774.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     81779270304dd556e1bb9e62561115714c15fa6a
Gitweb:        https://git.kernel.org/tip/81779270304dd556e1bb9e62561115714c15fa6a
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Mon, 22 Aug 2022 10:12:21 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Mon, 22 Aug 2022 16:35:53 -07:00

x86/cpu: Add new Raptor Lake CPU model number

Note1: Model 0xB7 already claimed the "no suffix" #define for a regular
client part, so add (yet another) suffix "S" to distinguish this new
part from the earlier one.

Note2: the RAPTORLAKE* and ALDERLAKE* processors are very similar from a
software enabling point of view.  There are no known features that have
model-specific enabling and also differ between the two.  In other words,
every single place that list *one* or more RAPTORLAKE* or ALDERLAKE*
processors should eventually list all of them.

Note3: This is being merged before there is an in-tree user.  Merging
this provides an "anchor" so that the different folks can update their
subsystems (like perf) in parallel to use this define and test it.

[ dhansen: add a note about why this has no in-tree users yet ]

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lkml.kernel.org/r/YwO49TDHnLcOyE+F@agluck-desk3.sc.intel.com
---
 arch/x86/include/asm/intel-family.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
index def6ca1..aeb3802 100644
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -27,6 +27,7 @@
  *		_X	- regular server parts
  *		_D	- micro server parts
  *		_N,_P	- other mobile parts
+ *		_S	- other client parts
  *
  *		Historical OPTDIFFs:
  *
@@ -112,6 +113,7 @@
 
 #define INTEL_FAM6_RAPTORLAKE		0xB7
 #define INTEL_FAM6_RAPTORLAKE_P		0xBA
+#define INTEL_FAM6_RAPTORLAKE_S		0xBF
 
 /* "Small Core" Processors (Atom) */
 
