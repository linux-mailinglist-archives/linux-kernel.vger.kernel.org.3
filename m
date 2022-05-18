Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDDF852C0BE
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 19:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240696AbiERRFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 13:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240633AbiERRFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 13:05:13 -0400
X-Greylist: delayed 600 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 18 May 2022 10:05:09 PDT
Received: from mail.tintel.eu (mail.tintel.eu [IPv6:2001:41d0:a:6e77:0:ff:fe5c:6a54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7BB220AE47;
        Wed, 18 May 2022 10:05:09 -0700 (PDT)
Received: from localhost (localhost [IPv6:::1])
        by mail.tintel.eu (Postfix) with ESMTP id CA07B445ABAE;
        Wed, 18 May 2022 18:48:13 +0200 (CEST)
Received: from mail.tintel.eu ([IPv6:::1])
        by localhost (mail.tintel.eu [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id RKoNBK3NpmRD; Wed, 18 May 2022 18:48:13 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
        by mail.tintel.eu (Postfix) with ESMTP id 32557445ABB7;
        Wed, 18 May 2022 18:48:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.tintel.eu 32557445ABB7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux-ipv6.be;
        s=502B7754-045F-11E5-BBC5-64595FD46BE8; t=1652892493;
        bh=8TYYWlp36PJZz0znUcyncTtGf0o330pGPoWuYtnZaiQ=;
        h=From:To:Date:Message-Id:MIME-Version;
        b=Q//Wt+ARQFRjk6lORJavdbHkpbrYpFy8i/pr2Y2QWzM3s/r2vfvPs+yzA647GYd5d
         jqErIWO32sC7B5OU+VVBK75EcCYNh6OCn0KR+xlanZiC7UxLtRwq+AN04rMBwpR2zs
         /OMRJX8TAgokCE3vGCuHAqMT5vyqazzJy76AFuvM=
X-Virus-Scanned: amavisd-new at mail.tintel.eu
Received: from mail.tintel.eu ([IPv6:::1])
        by localhost (mail.tintel.eu [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id wYX7m51qgy59; Wed, 18 May 2022 18:48:13 +0200 (CEST)
Received: from taz.sof.bg.adlevio.net (unknown [IPv6:2001:67c:21bc:20::10])
        by mail.tintel.eu (Postfix) with ESMTPS id D631D445ABAE;
        Wed, 18 May 2022 18:48:12 +0200 (CEST)
From:   Stijn Tintel <stijn@linux-ipv6.be>
To:     linux-mips@vger.kernel.org
Cc:     tsbogend@alpha.franken.de, linux-kernel@vger.kernel.org
Subject: [PATCH] MIPS: Octeon: add SNIC10E board
Date:   Wed, 18 May 2022 19:48:10 +0300
Message-Id: <20220518164810.2432678-1-stijn@linux-ipv6.be>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Rspamd-Pre-Result: action=no action;
        module=multimap;
        Matched map: IP_WHITELIST
X-Rspamd-Queue-Id: D631D445ABAE
X-Rspamd-Pre-Result: action=no action;
        module=multimap;
        Matched map: IP_WHITELIST
X-Spamd-Result: default: False [0.00 / 15.00];
        IP_WHITELIST(0.00)[2001:67c:21bc:20::10];
        ASN(0.00)[asn:200533, ipnet:2001:67c:21bc::/48, country:BG]
X-Rspamd-Server: skulls
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CN6640-SNIC10E-G and CN6640-SNIC10E-1.1-G PCIe NICs are based on
this board.

Signed-off-by: Stijn Tintel <stijn@linux-ipv6.be>
---
 arch/mips/include/asm/octeon/cvmx-bootinfo.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/include/asm/octeon/cvmx-bootinfo.h b/arch/mips/inc=
lude/asm/octeon/cvmx-bootinfo.h
index 6c61e0a63924..c1c0b3230e0a 100644
--- a/arch/mips/include/asm/octeon/cvmx-bootinfo.h
+++ b/arch/mips/include/asm/octeon/cvmx-bootinfo.h
@@ -253,6 +253,7 @@ enum cvmx_board_types_enum {
 	CVMX_BOARD_TYPE_REDWING =3D 43,
 	CVMX_BOARD_TYPE_NIC68_4 =3D 44,
 	CVMX_BOARD_TYPE_NIC10E_66 =3D 45,
+	CVMX_BOARD_TYPE_SNIC10E =3D 50,
 	CVMX_BOARD_TYPE_MAX,
=20
 	/*
@@ -369,6 +370,7 @@ static inline const char *cvmx_board_type_to_string(e=
num
 		ENUM_BRD_TYPE_CASE(CVMX_BOARD_TYPE_REDWING)
 		ENUM_BRD_TYPE_CASE(CVMX_BOARD_TYPE_NIC68_4)
 		ENUM_BRD_TYPE_CASE(CVMX_BOARD_TYPE_NIC10E_66)
+		ENUM_BRD_TYPE_CASE(CVMX_BOARD_TYPE_SNIC10E)
 		ENUM_BRD_TYPE_CASE(CVMX_BOARD_TYPE_MAX)
=20
 			/* Customer boards listed here */
--=20
2.35.1

