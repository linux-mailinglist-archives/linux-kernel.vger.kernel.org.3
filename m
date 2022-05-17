Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC9652A5AA
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 17:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349658AbiEQPIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 11:08:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234068AbiEQPIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 11:08:41 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F9AE3B562
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 08:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1652800118; x=1684336118;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7m2XYwtoguE1rr8a0hZclV93DDxQXRnyoanZTRu0XsU=;
  b=ylOFob0XkvMIsIjhqElDvfOgGN8Xu2HekcdhNB9orGZJYBlXihW+EkPW
   uiWyy0wEPVvBJWmtpi7eZ8yEGxSBIhm7d9o5t/l+UAZe87depbuNIWFTl
   jyhAnij5CFdvAdfwZN2ejtotdTM9gSuSf1RsxhAhAX3306Uw5yh3EPDnY
   tItgC5R67L9kgtPEkfaa9ejOe4ZLfPM9gZJ18G4RDctunoyE7iBwxqJaa
   aaJYOup+elWL/eb6wbwyui6gSxD12GvgWOv2/5AhBd/+lYZyLA4RnEoQi
   bxHUizGaeROIM6bS+eW5EQeikZxUsDhxln6SiyOO3z3eoc8P8hma+lThS
   A==;
X-IronPort-AV: E=Sophos;i="5.91,233,1647327600"; 
   d="scan'208";a="159435231"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 May 2022 08:08:37 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 17 May 2022 08:08:37 -0700
Received: from ROU-LT-M43238L.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Tue, 17 May 2022 08:08:34 -0700
From:   <nicolas.ferre@microchip.com>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        <arm@kernel.org>, <soc@kernel.org>
CC:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Linux Kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>
Subject: [GIT PULL] ARM: at91: soc for 5.19 #2
Date:   Tue, 17 May 2022 17:08:32 +0200
Message-ID: <20220517150832.89451-1-nicolas.ferre@microchip.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Organization: microchip
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicolas Ferre <nicolas.ferre@microchip.com>

Arnd, Olof,

Here is one more soc patch for 5.19. It goes on top of previous PR from last
week and fixes one patch queued in this presious series.

Please pull. Thanks, best regards,
  Nicolas

The following changes since commit 6041558ebf1fc87d1e0bdeb51e985807dab06bed:

  ARM: at91: debug: add lan966 support (2022-05-13 13:42:03 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/at91/linux.git tags/at91-soc-5.19-2

for you to fetch changes up to 46a65cd376f9f754149be33b32244cabcf376982:

  ARM: at91: pm: Fix rand build error (2022-05-17 16:40:34 +0200)

----------------------------------------------------------------
AT91 SoC #2 for 5.19:

- One Kconfig fix for random build error

----------------------------------------------------------------
YueHaibing (1):
      ARM: at91: pm: Fix rand build error

 arch/arm/mach-at91/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
Nicolas Ferre
