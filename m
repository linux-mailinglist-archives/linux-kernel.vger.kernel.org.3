Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EFCB4BD0DD
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 20:10:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244617AbiBTTJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 14:09:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236189AbiBTTJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 14:09:38 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0A7C41604;
        Sun, 20 Feb 2022 11:09:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1645384135;
        bh=LQgFGAyQQbGhBIR9wMKcuCNlULtnlYlQUCnb+RrhN9Y=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=CxnX/vVK+PVm+KDstcNjfVPWq8JZc5z3mE8ZiN9vf6W2NnbfkXkuS0AcwS3TR8LY0
         vfaR7QScY3a/hJLHqaC+pGWqvQ/wc0nRGTYtWILXrfjAs7dijy305sIypIOIhe/biQ
         dZm/h4RdiKV+bKsHzpKVvrPDejLjHxhwOIqR8ZJE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from esprimo-mx.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MPokD-1nYq7o1j6p-00Mpx4; Sun, 20 Feb 2022 20:08:55 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     pali@kernel.org
Cc:     jdelvare@suse.com, linux@roeck-us.net, David.Laight@ACULAB.COM,
        linux-hwmon@vger.kernel.org, linux-assembly@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4] hwmon: (dell-smm) Improve assembly code
Date:   Sun, 20 Feb 2022 20:08:51 +0100
Message-Id: <20220220190851.17965-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Vaz8xXOJTRRs694EoBhLMoi8+ULMAMUxQ3JE1tFJZyT4HGnrdFc
 pjazxjaDfp0YPm8tjEMRbNRvbgWjtpRnGANTOoF1Jn10ROKcXegZQUaloe6jxi4scYACkM4
 K7Jo50D2hiwRngIuKlXcOn3gWhgi8HUZ6Yl3mqP1LH8J3EWdUBwl4IBKGLh+qIrNXU97s+r
 t+w3rNxxYtQRyoi1vUoYw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:IGTPfHMag6U=:nz0z7RvODghxenzVhWHulg
 61DG4O47CNHCDNa6hVlmmpmugy3C4BIUJXU8jS+HRBn0ngIoTMwvd9CcmlBlPeYn2tMAjPbVB
 8lM96NGGQeUIc97wYXVH+dcSg89VXzPrZnF0u6S/vNIlsazpINUlTCVBtk0i/mZTtY++dxuAn
 mvkjMWdTdY1cKpy36dgt5e5vUlL03Kz/GR96Vd5UU8R3/nUaCCN/zSmG0Apq2oSCktKR+GuvX
 l63piY3MTWk2pbtAlC1EBLo7CWdQTpCfoQT0IRJ6ybhvKn+a56FqaZ/b48T7OtiR4szSX4Hpf
 WGTNxr7dl7u80mVfTWWvesTN8UFs4DkuoaPniDL9rL2Ft/itaXqwoxqIrfJ1SKD4+ttKzrDGo
 ZNfnjf+N7wrjUkfD55966pgpemuT5qojZVUa5trfSZy6sEgJ9BdSVGAXACD7r3FB1iSB1JgwU
 eDoJzXPmSBlWA9oUJAk+lMJCGVb1Wrsknn1QN3P6/Wq/Cxo3W7Uu2Z9oOmCBrFg+gAsOhylwA
 2PBJpQ1jltYym8uJRZudjO/3s/9lruq1YMkJy2PCK+AiEk4mKfGCvwjHMYuiVY1g6LJ0IZDtT
 L8+6YOxSveHOzeGm+HXxj/y6nbz5MMjhO2qA0uTziE0yLHs/0oh6/QDa/Ubhl4HhJVP8y6mgi
 X4+1ZPlVxNZxPjyY1YcUOsIG7BX/1vcZDWNfSH4uNiN8fkFOZAkcwWpeOnoR9E1hxqRbHd6Gi
 A9uR9/dQSS+vHKPwsDpQUt5K3LPjH7DgjTlMM+L5xYlWQFefR+NORcJE3286YureIFKLweWgI
 eCQpeXm5Nhd33DHvFuPzR0YEqbRRGNwQ7QgdEejrh2+XdsDlZ7aOf1v06Pmgcm0nxbah1/hx/
 /mJShDbgyK2m0NHZHyy7VYtFYX5vU0oIykzL7Fz676k+iGZtLAFDTUY/z3duclFKTkbkIDOCT
 AR81tVAQERlfAFCaCrW/h6TJUj/Ouop5lFktBFo82CVIHpE94/R7Fa2EZ97eULvgKINmctSUR
 zxBUVkjiaekMW+8r0EAmrx6FP4hFI7uv4YSHxGx7xiL13/sm7EcrP7Cm8JsXgyV44Ootivl8r
 dvlpHjfNNen3w8=
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new assembly code works on both 32 bit and 64 bit
cpus and allows for more compiler optimisations.
Since clang runs out of registers on 32 bit x86 when
using CC_OUT, we need to execute "setc" ourself.
Also modify the debug message so we can still see
the result (eax) when the carry flag was set.

Tested with 32 bit and 64 bit kernels on a Dell Inspiron 3505.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
Changes in v4:
- reword commit message

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

