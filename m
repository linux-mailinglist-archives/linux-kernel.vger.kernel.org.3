Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4307B55D6EB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233445AbiF0I24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 04:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233560AbiF0I2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 04:28:49 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24BF562C7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 01:28:48 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id fd6so11866408edb.5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 01:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zKH3Tesbl/NGDeaepzYHkR+mNGiL5G7Vu+6CzYaCN2o=;
        b=F25vIrBxmoT+FqoFT+BJgJXfFRfmp5rXW6x++VWyI+l1agAgoTzazB0zSRZvFk4WGQ
         Gi0Gzy1OfPiwBWLawwQMt1DTfBPSjoxyzEyb6nb1SuZj3gKM4/PjwkHYuClu1aHpn3X+
         CJ573A4j6mKreJO7Vo4+UIC6dwNmDEXX6Cn8DYoR5Y3oCsihFLDtqwEXmqEJRnfVgAr1
         J5r+C9+rco5T/OyoUanoNQnBXH/QJYokCltWCVLwz6aA1SNfcwyF9mJm3xKU5sPn16tD
         XooSPjZh6cOa/VnZysy0VBrxTAhSruv4TBorYxJbtrG2Fv/omMWxXYVFE3E3OGlO5FaY
         Baxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zKH3Tesbl/NGDeaepzYHkR+mNGiL5G7Vu+6CzYaCN2o=;
        b=xFc8SWJPSJjCuLfk/qBXN4HfNqPaTJ4yWuYWxOL8ia+TuDEsaSvFl9p+ZVAjVUI5wT
         GnpUsb4fchBjn4QH/PhbLxT0/fwWNEMn1OEw3NQ1E68JWSCnsQ/8Taj0b/VxDR9C7PcU
         o9BdFzne6+zDDZF4qTAhek+P5HsMLMM0LIwxEN8ihwqLPAx/84Fvu2OEF/mK/k9YOqO4
         uqdAhoTcwh5dOOHegC0i4spq2YE3+NldYp6N1Sz6pMXDC+Z2dTbzJmhH4sQRSQx1tn1U
         9RR5jsxoLh+JKK/EtaWHUsWO/HfzgeZ3CQyVy2Bi3Z8D+4v/dhB1fTHrhER2BFQ04n0n
         OdZA==
X-Gm-Message-State: AJIora82GznhnfqrH6J+lLvFFU6CxOeNRQ+neoD3+ZBH4OzTte+4ku+g
        ItVXZ7jpfj9jhmTt0fFOTGH6sA==
X-Google-Smtp-Source: AGRyM1tlVPIJ6klFHkYwpNQXzMcs+I+DRlK2Z0x6pNXWJZeMS6/VYBEC8jkniI09RJJvpD0+4c2M0w==
X-Received: by 2002:a05:6402:2402:b0:435:3418:61b5 with SMTP id t2-20020a056402240200b00435341861b5mr14505258eda.82.1656318526712;
        Mon, 27 Jun 2022 01:28:46 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id o9-20020aa7c7c9000000b004356e90d13esm7056364eds.83.2022.06.27.01.28.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 01:28:46 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org, soc@kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [GIT PULL 2/2] ARM: dts: cleanup for v5.20
Date:   Mon, 27 Jun 2022 10:28:42 +0200
Message-Id: <20220627082842.50508-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220627082842.50508-1-krzysztof.kozlowski@linaro.org>
References: <20220627082842.50508-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

These cleanups were part of my set, which partially was taken by other
maintainers.  For some here I have acks, but for most not.

It also includes documenting compatibles for Aspeed boards, for which I was not
sure whether they will be applied by Aspeed maintainer or not.

The series bring us closer to clean `make dtbs_check`.

Best regards,
Krzysztof


The following changes since commit f2906aa863381afb0015a9eb7fefad885d4e5a56:

  Linux 5.19-rc1 (2022-06-05 17:18:54 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/dt-cleanup-5.20

for you to fetch changes up to 2f7a7f941d770c03942fefe1d91ce954cb329c7e:

  Merge branch 'for-v5.20/aspeed-dts-cleanup' into for-v5.20/dts-cleanup (2022-06-27 10:19:57 +0200)

----------------------------------------------------------------
Cleanup of ARM DTS for v5.20

Series of cleanups for ARM DTS:
1. White-spaces, gpio-key subnode names, USB DWC3/EHCI node names,
2. Add board-level compatibles to Aspeed evaluation boards.

----------------------------------------------------------------
Krzysztof Kozlowski (18):
      ARM: dts: pxa: adjust whitespace around '='
      ARM: dts: aspeed: adjust whitespace around '='
      ARM: dts: at91: adjust whitespace around '='
      ARM: dts: axm: adjust whitespace around '='
      ARM: dts: spear: adjust whitespace around '='
      ARM: dts: alpine: adjust whitespace around '='
      ARM: dts: ecx: adjust whitespace around '='
      ARM: dts: lpc: adjust whitespace around '='
      ARM: dts: nuvoton: adjust whitespace around '='
      ARM: dts: ste: adjust whitespace around '='
      ARM: dts: sti: adjust whitespace around '='
      ARM: dts: sd: adjust whitespace around '='
      ARM: dts: animeo: align gpio-key node names with dtschema
      ARM: dts: animeo: correct gpio-keys properties
      ARM: dts: ast2500-evb: fix board compatible
      ARM: dts: ast2600-evb: fix board compatible
      ARM: dts: ast2600-evb-a1: fix board compatible
      Merge branch 'for-v5.20/aspeed-dts-cleanup' into for-v5.20/dts-cleanup

Serge Semin (2):
      ARM: dts: lpc18xx: Harmonize EHCI/OHCI DT nodes name
      ARM: dts: stih407-family: Harmonize DWC USB3 DT nodes name

 arch/arm/boot/dts/alpine.dtsi                     |   2 +-
 arch/arm/boot/dts/animeo_ip.dts                   |  10 +-
 arch/arm/boot/dts/aspeed-ast2500-evb.dts          |   2 +-
 arch/arm/boot/dts/aspeed-ast2600-evb-a1.dts       |   1 +
 arch/arm/boot/dts/aspeed-ast2600-evb.dts          |   2 +-
 arch/arm/boot/dts/aspeed-bmc-portwell-neptune.dts |   6 +-
 arch/arm/boot/dts/aspeed-bmc-quanta-s6q.dts       |   6 +-
 arch/arm/boot/dts/at91-kizbox3-hs.dts             |   2 +-
 arch/arm/boot/dts/at91-sam9x60ek.dts              |   2 +-
 arch/arm/boot/dts/at91-sama5d27_som1.dtsi         |   2 +-
 arch/arm/boot/dts/at91-sama5d27_som1_ek.dts       |   4 +-
 arch/arm/boot/dts/at91-sama5d27_wlsom1_ek.dts     |   2 +-
 arch/arm/boot/dts/at91-sama5d2_icp.dts            |   4 +-
 arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts         |   6 +-
 arch/arm/boot/dts/at91-sama5d2_xplained.dts       |   6 +-
 arch/arm/boot/dts/axm5516-cpus.dtsi               |  32 ++--
 arch/arm/boot/dts/ecx-common.dtsi                 |  10 +-
 arch/arm/boot/dts/lpc18xx.dtsi                    |   6 +-
 arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi     |   2 +-
 arch/arm/boot/dts/nuvoton-npcm750.dtsi            |   2 +-
 arch/arm/boot/dts/pxa300-raumfeld-common.dtsi     |  10 +-
 arch/arm/boot/dts/sam9x60.dtsi                    |   2 +-
 arch/arm/boot/dts/sd5203.dts                      |   2 +-
 arch/arm/boot/dts/spear1310-evb.dts               |   2 +-
 arch/arm/boot/dts/spear1340-evb.dts               |   2 +-
 arch/arm/boot/dts/spear1340.dtsi                  |   2 +-
 arch/arm/boot/dts/spear300-evb.dts                |   2 +-
 arch/arm/boot/dts/spear310-evb.dts                |   2 +-
 arch/arm/boot/dts/spear320-evb.dts                |   2 +-
 arch/arm/boot/dts/spear320-hmi.dts                |   2 +-
 arch/arm/boot/dts/spear320.dtsi                   |   2 +-
 arch/arm/boot/dts/ste-ab8500.dtsi                 |   6 +-
 arch/arm/boot/dts/ste-hrefv60plus.dtsi            |   4 +-
 arch/arm/boot/dts/stih407-family.dtsi             | 176 +++++++++++-----------
 arch/arm/boot/dts/stih407.dtsi                    |   4 +-
 arch/arm/boot/dts/stih410.dtsi                    |   4 +-
 arch/arm/boot/dts/stihxxx-b2120.dtsi              |   8 +-
 37 files changed, 170 insertions(+), 171 deletions(-)
