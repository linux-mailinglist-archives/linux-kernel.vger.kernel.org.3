Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A69F4F0712
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 05:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234066AbiDCDI6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 23:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234495AbiDCDI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 23:08:56 -0400
X-Greylist: delayed 415 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 02 Apr 2022 20:06:50 PDT
Received: from mail.tintel.eu (mail.tintel.eu [IPv6:2001:41d0:a:6e77:0:ff:fe5c:6a54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBBA438DB1;
        Sat,  2 Apr 2022 20:06:50 -0700 (PDT)
Received: from localhost (localhost [IPv6:::1])
        by mail.tintel.eu (Postfix) with ESMTP id 004144407640;
        Sun,  3 Apr 2022 04:59:53 +0200 (CEST)
Received: from mail.tintel.eu ([IPv6:::1])
        by localhost (mail.tintel.eu [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id FPQdfFrD67em; Sun,  3 Apr 2022 04:59:52 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
        by mail.tintel.eu (Postfix) with ESMTP id AF200443A8BC;
        Sun,  3 Apr 2022 04:59:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.tintel.eu AF200443A8BC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux-ipv6.be;
        s=502B7754-045F-11E5-BBC5-64595FD46BE8; t=1648954792;
        bh=cob7IhTPnKgDjCS6j35aXVOPak/SkzGLuDDAOZT0P1Y=;
        h=From:To:Date:Message-Id:MIME-Version;
        b=pBsjR0/UiQTtUlNmoVVGPs6Uzo5yPOBHVV8ZufJ7EO6fgu35Xc9BK00FcEThfFAr0
         9MuE0TqS9qyi3gis0p1AKRIdoRglWKy91BzRwK3j7U6oton6qEEdJmPVmTze+NHO0e
         HXUdWaYo7at9GKbJjfaHMBDumITX/Hp473fU9Q0s=
X-Virus-Scanned: amavisd-new at mail.tintel.eu
Received: from mail.tintel.eu ([IPv6:::1])
        by localhost (mail.tintel.eu [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id umedI9jnahRL; Sun,  3 Apr 2022 04:59:52 +0200 (CEST)
Received: from taz.sof.bg.adlevio.net (unknown [IPv6:2001:67c:21bc:20::10])
        by mail.tintel.eu (Postfix) with ESMTPS id 6DFB84407640;
        Sun,  3 Apr 2022 04:59:52 +0200 (CEST)
From:   Stijn Tintel <stijn@linux-ipv6.be>
To:     linux-mips@vger.kernel.org
Cc:     tsbogend@alpha.franken.de, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] MIPS: Octeon: support all interfaces on CN66XX
Date:   Sun,  3 Apr 2022 05:59:50 +0300
Message-Id: <20220403025950.837085-2-stijn@linux-ipv6.be>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220403025950.837085-1-stijn@linux-ipv6.be>
References: <20220403025950.837085-1-stijn@linux-ipv6.be>
MIME-Version: 1.0
X-Rspamd-Pre-Result: action=no action;
        module=multimap;
        Matched map: IP_WHITELIST
X-Rspamd-Queue-Id: 6DFB84407640
X-Rspamd-Pre-Result: action=no action;
        module=multimap;
        Matched map: IP_WHITELIST
X-Spamd-Result: default: False [0.00 / 15.00];
        ASN(0.00)[asn:200533, ipnet:2001:67c:21bc::/48, country:BG];
        IP_WHITELIST(0.00)[2001:67c:21bc:20::10]
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

CN66XX_PASS1_0 has 7 interfaces, other revisions have 8 interfaces.

Signed-off-by: Stijn Tintel <stijn@linux-ipv6.be>
---
 arch/mips/cavium-octeon/executive/cvmx-helper.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/mips/cavium-octeon/executive/cvmx-helper.c b/arch/mips/=
cavium-octeon/executive/cvmx-helper.c
index b22f664e2d29..6f49fd9be1f3 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-helper.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-helper.c
@@ -61,6 +61,12 @@ int cvmx_helper_get_number_of_interfaces(void)
 {
 	if (OCTEON_IS_MODEL(OCTEON_CN68XX))
 		return 9;
+	if (OCTEON_IS_MODEL(OCTEON_CN66XX)) {
+		if (OCTEON_IS_MODEL(OCTEON_CN66XX_PASS1_0))
+			return 7;
+		else
+			return 8;
+	}
 	if (OCTEON_IS_MODEL(OCTEON_CN56XX) || OCTEON_IS_MODEL(OCTEON_CN52XX))
 		return 4;
 	if (OCTEON_IS_MODEL(OCTEON_CN7XXX))
--=20
2.35.1

