Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C8D75A2B48
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 17:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230516AbiHZPay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 11:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238115AbiHZPaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 11:30:15 -0400
Received: from mout.web.de (mout.web.de [217.72.192.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED17A468
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 08:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1661527768;
        bh=jFRtf1LxuJEWwKyH8LZdvn6lgdX6hA/+rjd0sWNk1dc=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
        b=G/iLjyvG9KKOCRRyrYr18cnrBy23tEwHJKaTBV/hpnZtHVjztZknU1PrnWhzwnGxz
         A7PDbdlB7qfI7DDzloKKrXGRodI+4oNr0xCefJpo6y1U4U5bVjc0JRdzEPv/mxZz5K
         LWPpb3sICfbcO8pEER8nc5rniEdx+uC5yc5+bWo4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from gecko ([46.223.150.91]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MTOha-1oqndU36tQ-00TsNO; Fri, 26
 Aug 2022 17:29:28 +0200
Date:   Fri, 26 Aug 2022 15:29:27 +0000
From:   Lukas Straub <lukasstraub2@web.de>
To:     linux-um <linux-um@lists.infradead.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] um: Cleanup syscall_handler_t cast in syscalls_32.h
Message-ID: <20220826152927.193d262c@gecko>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/2_zsh.QdJpcK7WunS7oTK32";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Provags-ID: V03:K1:QdtO+UEvnn0+3Wht8DQQuaf+2LUmJ9JpRJiEPU6tg1PTlJne/6t
 HKNdsHH8xM/KyoCz2WzVb04dpI2J6stfSv18fleCxeR1aAuhjrLAOVll1f/lNWtp+8/6tnz
 hyRbKSS6LWC5iebLb9cNqaBkbf4avhVwMmeCPG3pPzLC/eNASZwWSyRHSzm1v/MhnlfjdWH
 8wTxiXb2fgop9cpPM3yIw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WD7bjhK1kxQ=:JVHT/zaZYxtUCU3DhPGABS
 sf+gG06sqhmVQ8vLuTtUVP9Q98Mag3NjzgugTDs5KMlPqktWYdK4dDSkTRzuuVMsx2CSyjXRh
 7A6xtzM+0UuJuAbH9HlHoKP06FNYohgH2OlNJHI75NulVLVN+XQa/R73xQSxPFPhPGBug5uB2
 LFNOu4GqJ3Jzc3CbL7MtYvzTPE7iJcjN0FAQVOg8bqv/9BN1dlRpKitrnhWf800cnaUVfRUAc
 KdSBdNh386BlHESf7jk5vUByjvmkg67D/di3Ok2S44ogdVen3xq8MmVZoEcAmgDlV3aJj8B+6
 Vx1/IC5Tt2rEA5OzkWDOEEDYHBjw818Hug2zmk3/pNLL/q50XipffHwXhte1iYpXsx28Rbs+T
 2FMK5a6CMOTD6sFnM5Xk6YtMIEcH8XjJNE/avMNAM7fPpaI5Kx3mhWg+gk69IH7vWrV2iwTpf
 z+ykyetWJaLcdtAc+LbfiwQRIBpQ1mZ6rcnaTtKy6Eyhu1k95E1NQ7DIF2Ro1rarb1OIOSiq1
 CyYEdCKfgXQzXSlmxw0/vXF0VL3+r3XWl9hC9bWnSruxo66bFieUALpqoDSh5ft/MBofnMYLO
 H96uF1NlRYokKnGglCH+AnuQZ0WhK1ayIJ7fahqQAX2ej50gryHiqrF2ODC7ZyoX/dvavAc3P
 y/Fr4jv1SIG04VGYpKGDowNYcBMcwCC5bu6xOeW8SjHC2b5AelrlOupnCatp8MSKmbaFAURVY
 2z1YvT4NVeiBTb25+QszcYGBqD8QMdeLgX7NrPKFO/79IRRLwgcSRGKzNaUhDweau57cywUQB
 Hmw21vK/lIbJs1/bxNXT39Fx3Urd6Mi2ZErb3i5GyVSlY/pd444u/Jbt80se8ISZEYyQCYfKW
 4aUPgBbi0aHdwvXEuP58D6ECwj6E5hgSTyvGmjthAgTOXqztGLjKvjgg2KH/bqyfVipKu4RCk
 ebWtUsYtbdUlCau6YgB1tYYQ7qt3fVPn+qUOUUufV+Cb51T1sb25x7Vb1ONYPj2ftOr92vNNX
 gnbj+2I131B2kqJ+5/Xoq38jXNBvtBkHXnHpukoTb8Cc7iVvX3JFZGJUpcbGQgsPGT76zZ9VV
 +23Dn8mKk8LrtMaHWBlPtMLb31erF5syKJC4gIrHr5g5AeFs8vBYikVIw==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/2_zsh.QdJpcK7WunS7oTK32
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Like in f4f03f299a56ce4d73c5431e0327b3b6cb55ebb9
"um: Cleanup syscall_handler_t definition/cast, fix warning",
remove the cast to to fix the compiler warning.

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
---
 arch/x86/um/shared/sysdep/syscalls_32.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/x86/um/shared/sysdep/syscalls_32.h b/arch/x86/um/shared/s=
ysdep/syscalls_32.h
index 68fd2cf526fd..f6e9f84397e7 100644
--- a/arch/x86/um/shared/sysdep/syscalls_32.h
+++ b/arch/x86/um/shared/sysdep/syscalls_32.h
@@ -6,10 +6,9 @@
 #include <asm/unistd.h>
 #include <sysdep/ptrace.h>
=20
-typedef long syscall_handler_t(struct pt_regs);
+typedef long syscall_handler_t(struct syscall_args);
=20
 extern syscall_handler_t *sys_call_table[];
=20
 #define EXECUTE_SYSCALL(syscall, regs) \
-	((long (*)(struct syscall_args)) \
-	 (*sys_call_table[syscall]))(SYSCALL_ARGS(&regs->regs))
+	((*sys_call_table[syscall]))(SYSCALL_ARGS(&regs->regs))
--=20
2.37.2


--Sig_/2_zsh.QdJpcK7WunS7oTK32
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAmMI5tcACgkQNasLKJxd
sli58g//YFp2irBcbLtEWRCL8FVxCc/fDmNk99rBRasiEUeEQ+l21SkJqqUUIhYe
SxNDovCVZC5pFDJZbSc+a3Gd+GQGNoQojL9V6U4B6JA2r98nzOYg7Demxin2fvm5
BA0ONTLJ4e7J156JSqX9z8lw//sk3vetdhRCFB7qh8fsUlm7dN5je4HxLfG+HRKH
tNWQb8Gp5P29mNDq4YRh95Xv+hMgKbOTPVb/vMLsXv9ZRVU+U2wVK/9vDtf96KgP
7NI8/g1LgcyQ9Efk+jiVjCIrqG20smACCp6mE6yPIuumZIJ7FkqujTd//BdptYns
c6HejzHgNbi2wpSuueV667SE4nKatPmXfqr26ZsVM1MoonImQ6ThN/3Tcb6c5Xtl
SPeafkPv/9UzREQzTdbLy5pW0pzFmyCeqJfTPMzemA553WxNQwfIWrZjbt1Kyuh0
Mx9aKuQ+XK5nquLwG4EdktA3gi6q+KK88UflateXMX4HCyhPuolGNvgY4He1EnVi
IPrabG4xn07xMZXKfBi9VdyDRU8C9VbdmqvY6mA8IBLlszWAZz2lMrveuCnxoMlw
TgWthGHqpm7ec73DL4xhPsUUif4q+lLf2N22ezViwiO+BKCvAVTt7sqnpHWrK6M+
PDWDvhuQYsNvcCJn1Zvw97YQyH/GM0jErNFZKPHDfnc7xOLvmt8=
=jB+v
-----END PGP SIGNATURE-----

--Sig_/2_zsh.QdJpcK7WunS7oTK32--
