Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 638D54BCFD6
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 17:26:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241408AbiBTQ0B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 11:26:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241219AbiBTQ0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 11:26:00 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A76034670;
        Sun, 20 Feb 2022 08:25:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1645374311;
        bh=BfygSnNwPAsAKQCAw5L3JdsdO7mVJKJ8bDLaDqAzUrA=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=jhXEhKTAGfZ0I7cNJxZJ2P/QrnsTw78fF5fvO2CqWCnngzAnCim4irlBjyBkHumYO
         3acpO1GBeYyrrgpjQXxW0LpKS4b9DUb5eIccEYgMR8CIcHHKmDhUB4udzKY+yvoYDE
         lEcOAvJshuiaBiur04jcaCvHWgY0oIF7hc96xOhA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from esprimo-mx.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1N6siz-1oK5TU0287-018MRL; Sun, 20 Feb 2022 17:25:11 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     pali@kernel.org
Cc:     jdelvare@suse.com, linux@roeck-us.net, David.Laight@ACULAB.COM,
        linux-hwmon@vger.kernel.org, linux-assembly@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] hwmon: (dell-smm) Improve assembly code
Date:   Sun, 20 Feb 2022 17:25:01 +0100
Message-Id: <20220220162501.13591-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YYE3Y1t7E/v+TbPbO3Pew4TlRjvWWgsfwHnXN7m7LxHEo/guQfa
 g77mgYXSlVA9wvthfRFmMR4v/jPD/Ci5yuUbd50imTZNPCVDqtZbZdIj6ieEQg30oPcRymH
 J/arJBCX7oLIyjIDUyObG6m5zDT7lrnOgHqwNVqM4CNiYXT+u18OSXpA2Bb7EK0ok8ejis6
 FN1Zu6iCWV2PjyNOoZSnQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4lABhImsNQo=:79pPa9/6WmoEcx6HgOn7P9
 +a9uhjlPzPnctIYNCnfDlYQ4TLdtcpAWtzDn9HoVHUMZhThn5gkXUjt5YWwyRAue/C6xEC5Nm
 Ol7xkJO2ujQe6HCCl7rhfXCtNv1/O/CopYaSOXKCJhS9mRvAR7FnNZYN04y0eAtiFvN2x9xwQ
 kTOLdLctYnon9FNrYVmqUHBrirw2cbX9Jjk8pCUwOUnqovgsQob3XYlCdZftLlgImVgPJm1I7
 DGeFTzEhhx63yrTJs8wx6nYG6FYLgQgJAheR8pL550SzxRInd5i9JlMxB8rlShe56EdNtXcSr
 9QkgIsrgOuB7kcE1GMnqLd128igvAdqCPfKf+W0AeN/GApfX4GNcBLdmwJkra1WnYf+wR+4lp
 KdDNGHohlrGFoSO0NHN+gYrIXb9QUJetpDBgAvAXGN33n0qSzAUoO70VeTUCDDazQk7RDqhDM
 oF2y4o2UcqVOJ/ePSbrIilvH+4bK+fR+Vm2rUVbjgcMpoxodrDX+6zckXwrjGH7QDInwC+r88
 9fH4qJSW0cqD+aIMRHBDKymrLy4n6WzHby/mqnck2QI+ptZrk9aYeifSgbD7XPV5NFaAJswey
 Mh5g+5K8UPFRwvilxKbEY9JcLU2fQXM9efks8d8qk2eyZAK23Exc7yTUgSyMuplRfmoSQxhYi
 GP09/fEk2iXsBrkYRrfDMzysqmkzhew5VW6JlhKQrNMmXTP45JxWAtuC35wdd5o4nd21E0pm4
 4Y3KmxHTs3QYgOhrzb3FkiQDg6Pky2NyZ3DJYXLCJai74dL42lRcb4Yy8Qg9Pz4z6TMPUyP5U
 qi4OPyLeFBmpGwtMcpTiftFEMJ/0rRQsYIkOI1faI1aUnH9WcuENqlBIxIrOrGMuKMxiLKNwL
 mv52D9/QxXkIIYTapS/PAGdNT4gKMKpKoHVedvo2izcQCu+GFY8BgfsZdvm8S0+JpZgkHhk9l
 +YWBTuksD4xtA7BAT80J+r42prs4SPg7r2pcEEQfd7VfFtQyOwyFbqRN9lX5BmzpCrPS58Pw+
 lQ9nCGe65Tj7C8UW7vcP11J7DAMSgep4jTx9dotrrLpkPt1CJB1FsTHSa6+Nvg+nKduFeRF1f
 nONiyrlRuRZeDM=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new assembly code works on both 32 bit and 64 bit
cpus and allows for more compiler optimisations by not
requiring smm_regs to be packed. Since clang runs out
of registers on 32 bit x86 when using CC_OUT, we need
to execute "setc" ourself.
Also modify the debug message so we can still see
the result (eax) when the carry flag was set.

Tested with 32 bit and 64 bit kernels on a Dell Inspiron 3505.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
Changes in v3:
- make carry an unsigned char
- use "+a", ... for output registers
- drop "cc" from clobbered list

Changes in v2:
- fix clang running out of registers on 32 bit x86
- modify debug message
=2D--
 drivers/hwmon/dell-smm-hwmon.c | 78 ++++++++--------------------------
 1 file changed, 18 insertions(+), 60 deletions(-)

diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon=
.c
index c5939e68586d..38d23a8e83f2 100644
=2D-- a/drivers/hwmon/dell-smm-hwmon.c
+++ b/drivers/hwmon/dell-smm-hwmon.c
@@ -119,7 +119,7 @@ struct smm_regs {
 	unsigned int edx;
 	unsigned int esi;
 	unsigned int edi;
-} __packed;
+};

 static const char * const temp_labels[] =3D {
 	"CPU",
@@ -164,74 +164,32 @@ static int i8k_smm_func(void *par)
 	struct smm_regs *regs =3D par;
 	int eax =3D regs->eax;
 	int ebx =3D regs->ebx;
+	unsigned char carry;
 	long long duration;
-	int rc;

 	/* SMM requires CPU 0 */
 	if (smp_processor_id() !=3D 0)
 		return -EBUSY;

-#if defined(CONFIG_X86_64)
-	asm volatile("pushq %%rax\n\t"
-		"movl 0(%%rax),%%edx\n\t"
-		"pushq %%rdx\n\t"
-		"movl 4(%%rax),%%ebx\n\t"
-		"movl 8(%%rax),%%ecx\n\t"
-		"movl 12(%%rax),%%edx\n\t"
-		"movl 16(%%rax),%%esi\n\t"
-		"movl 20(%%rax),%%edi\n\t"
-		"popq %%rax\n\t"
-		"out %%al,$0xb2\n\t"
-		"out %%al,$0x84\n\t"
-		"xchgq %%rax,(%%rsp)\n\t"
-		"movl %%ebx,4(%%rax)\n\t"
-		"movl %%ecx,8(%%rax)\n\t"
-		"movl %%edx,12(%%rax)\n\t"
-		"movl %%esi,16(%%rax)\n\t"
-		"movl %%edi,20(%%rax)\n\t"
-		"popq %%rdx\n\t"
-		"movl %%edx,0(%%rax)\n\t"
-		"pushfq\n\t"
-		"popq %%rax\n\t"
-		"andl $1,%%eax\n"
-		: "=3Da"(rc)
-		:    "a"(regs)
-		:    "%ebx", "%ecx", "%edx", "%esi", "%edi", "memory");
-#else
-	asm volatile("pushl %%eax\n\t"
-	    "movl 0(%%eax),%%edx\n\t"
-	    "push %%edx\n\t"
-	    "movl 4(%%eax),%%ebx\n\t"
-	    "movl 8(%%eax),%%ecx\n\t"
-	    "movl 12(%%eax),%%edx\n\t"
-	    "movl 16(%%eax),%%esi\n\t"
-	    "movl 20(%%eax),%%edi\n\t"
-	    "popl %%eax\n\t"
-	    "out %%al,$0xb2\n\t"
-	    "out %%al,$0x84\n\t"
-	    "xchgl %%eax,(%%esp)\n\t"
-	    "movl %%ebx,4(%%eax)\n\t"
-	    "movl %%ecx,8(%%eax)\n\t"
-	    "movl %%edx,12(%%eax)\n\t"
-	    "movl %%esi,16(%%eax)\n\t"
-	    "movl %%edi,20(%%eax)\n\t"
-	    "popl %%edx\n\t"
-	    "movl %%edx,0(%%eax)\n\t"
-	    "lahf\n\t"
-	    "shrl $8,%%eax\n\t"
-	    "andl $1,%%eax\n"
-	    : "=3Da"(rc)
-	    :    "a"(regs)
-	    :    "%ebx", "%ecx", "%edx", "%esi", "%edi", "memory");
-#endif
-	if (rc !=3D 0 || (regs->eax & 0xffff) =3D=3D 0xffff || regs->eax =3D=3D =
eax)
-		rc =3D -EINVAL;
+	asm volatile("out %%al,$0xb2\n\t"
+		     "out %%al,$0x84\n\t"
+		     "setc %0\n"
+		     : "=3Dmr" (carry),
+		       "+a" (regs->eax),
+		       "+b" (regs->ebx),
+		       "+c" (regs->ecx),
+		       "+d" (regs->edx),
+		       "+S" (regs->esi),
+		       "+D" (regs->edi));

 	duration =3D ktime_us_delta(ktime_get(), calltime);
-	pr_debug("smm(0x%.4x 0x%.4x) =3D 0x%.4x  (took %7lld usecs)\n", eax, ebx=
,
-		 (rc ? 0xffff : regs->eax & 0xffff), duration);
+	pr_debug("smm(0x%.4x 0x%.4x) =3D 0x%.4x carry: %d (took %7lld usecs)\n",
+		 eax, ebx, regs->eax & 0xffff, carry, duration);

-	return rc;
+	if (carry || (regs->eax & 0xffff) =3D=3D 0xffff || regs->eax =3D=3D eax)
+		return -EINVAL;
+
+	return 0;
 }

 /*
=2D-
2.30.2

