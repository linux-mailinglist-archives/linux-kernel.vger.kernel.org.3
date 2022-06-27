Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A698B55C4BB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233253AbiF0I2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 04:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233555AbiF0I2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 04:28:49 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 217EAB24
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 01:28:47 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id ay16so17521968ejb.6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 01:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PTln65IiWVFNI8/zs4JVrceMHpafS1zMofC+vruC3r4=;
        b=e/Jz9vr6NuUOQgCo1uUznJgL19mPh39TCDjsuXf4BGdZc8mhm9xsuNJjwIFPZtb56K
         m7YlT2KAoycYxIAvdXREbvjlE9/1bBj1J5VWE6q29H63i0NBRO2zedqEb9d0s22m8491
         EY0wKxcnjZ0xmKHdqaYlpTYt4fkbvj/2abnUm5b4Bk0yUdRTEO55eo4AKb47PnuiAhLw
         L+e+gbIB/HU9nqGC/aZgEp9KbH6C1T3bGj2bFMw3+VIxI8ki2ZE0F4KJGbVEkIjZozEh
         y6FZGGqx+psxgZRHzkKQ6wYSt4RuzX6GvwVXmGYVpyutkSjYzzUcCLjALAg0rXvDjptA
         GnUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PTln65IiWVFNI8/zs4JVrceMHpafS1zMofC+vruC3r4=;
        b=kUJi163pKCIbG7Ofs2D+bGuoLyXqI5o3CEKEYLdrUWBKj70DFmfaU/+IZ1+KtJmQIF
         wIcBaFBRW2rrA+PBDFYZ8KmwQu5elwCdrFzca8i8s/T+YBnH+TA22jLSQu1+NovNlUxy
         mUVlM+82tK+woqhgHv17cPgZWpAxG7ZczdsM1BSvBD2/osPUV+1NOWhhKY9OxrY4E+4m
         U4YvQc2ObR2fG1MD5e+MKi1l0taxfyCcl/sHNpA+6qPlx6cBGATMvS601/65kG4SjdTp
         uNXh3oRhUAVbwTjD+5Oaxe9l4JtZ9V62IfldB0W3KCyMNRUHWAGUZqf7an5zNOYrL7mr
         OLcg==
X-Gm-Message-State: AJIora+M1Du5A3od5rbRJE4+Gr77YqLO6/KOYW3ApTqA01weH7Ec/Zdz
        TKlHGvva5/NYdmjCPI46qm0y0g==
X-Google-Smtp-Source: AGRyM1sUEuXrrmm9VnutdGTV08Io2RWyQq9OFou8JEFVz3+lo/yFQYCJCyPLiZXgjRUjD276CjkIfw==
X-Received: by 2002:a17:906:8501:b0:711:bf65:2a47 with SMTP id i1-20020a170906850100b00711bf652a47mr11904262ejx.150.1656318525636;
        Mon, 27 Jun 2022 01:28:45 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id o9-20020aa7c7c9000000b004356e90d13esm7056364eds.83.2022.06.27.01.28.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 01:28:45 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org, soc@kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [GIT PULL 1/2] arm64: dts: cleanup for v5.20
Date:   Mon, 27 Jun 2022 10:28:41 +0200
Message-Id: <20220627082842.50508-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

It also includes parts of very old patchset from Serge, in similar style.

The series bring us closer to clean `make dtbs_check`.

Best regards,
Krzysztof


The following changes since commit f2906aa863381afb0015a9eb7fefad885d4e5a56:

  Linux 5.19-rc1 (2022-06-05 17:18:54 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/dt64-cleanup-5.20

for you to fetch changes up to 87ccc38e2f8e55853ddfe633d9934bc7ca74b21c:

  arm64: dts: apm: Harmonize DWC USB3 DT nodes name (2022-06-27 10:15:20 +0200)

----------------------------------------------------------------
Cleanup of ARM64 DTS for v5.20

Series of cleanups for ARM64 DTS: White-spaces, gpio-key subnode names,
USB DWC3/EHCI node names.

----------------------------------------------------------------
Krzysztof Kozlowski (11):
      arm64: dts: amd: adjust whitespace around '='
      arm64: dts: apm: adjust whitespace around '='
      arm64: dts: lg: adjust whitespace around '='
      arm64: dts: marvell: adjust whitespace around '='
      arm64: dts: hisilicon: adjust whitespace around '='
      arm64: dts: sprd: adjust whitespace around '='
      arm64: dts: microchip: adjust whitespace around '='
      arm64: dts: apm: correct gpio-keys properties
      arm64: dts: broadcom: align gpio-key node names with dtschema
      arm64: dts: hisilicon: align gpio-key node names with dtschema
      arm64: dts: hisilicon: correct gpio-keys properties

Serge Semin (1):
      arm64: dts: apm: Harmonize DWC USB3 DT nodes name

 arch/arm64/boot/dts/amd/amd-overdrive-rev-b0.dts   |   4 +-
 arch/arm64/boot/dts/amd/amd-overdrive-rev-b1.dts   |   4 +-
 arch/arm64/boot/dts/apm/apm-merlin.dts             |   2 +-
 arch/arm64/boot/dts/apm/apm-mustang.dts            |   2 +-
 arch/arm64/boot/dts/apm/apm-shadowcat.dtsi         |   6 +-
 arch/arm64/boot/dts/apm/apm-storm.dtsi             |  10 +-
 .../bcm4908/bcm4906-tplink-archer-c2300-v1.dts     |   8 +-
 .../broadcom/bcm4908/bcm4908-asus-gt-ac5300.dts    |   8 +-
 arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts  |  14 +-
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi          |   8 +-
 arch/arm64/boot/dts/hisilicon/hi3670.dtsi          |   2 +-
 arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts     |  12 +-
 arch/arm64/boot/dts/hisilicon/hip05-d02.dts        |   6 +-
 arch/arm64/boot/dts/hisilicon/hip06.dtsi           |   6 +-
 arch/arm64/boot/dts/hisilicon/hip07.dtsi           |   6 +-
 arch/arm64/boot/dts/lg/lg1312.dtsi                 |  38 ++--
 arch/arm64/boot/dts/lg/lg1313.dtsi                 |  38 ++--
 .../boot/dts/marvell/armada-7040-mochabin.dts      |   4 +-
 arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi |   2 +-
 .../boot/dts/marvell/armada-8040-puzzle-m801.dts   |   4 +-
 arch/arm64/boot/dts/marvell/cn9130-db.dtsi         |   2 +-
 .../boot/dts/microchip/sparx5_pcb134_board.dtsi    | 200 ++++++++++-----------
 .../boot/dts/microchip/sparx5_pcb135_board.dtsi    |  48 ++---
 arch/arm64/boot/dts/sprd/sc9836.dtsi               |  10 +-
 arch/arm64/boot/dts/sprd/sc9863a.dtsi              |   4 +-
 arch/arm64/boot/dts/sprd/whale2.dtsi               |   2 +-
 26 files changed, 224 insertions(+), 226 deletions(-)
