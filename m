Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A98251D31D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 10:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350853AbiEFISd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 04:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351853AbiEFIS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 04:18:28 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68FFA67D3B
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 01:14:45 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id i5so8968362wrc.13
        for <linux-kernel@vger.kernel.org>; Fri, 06 May 2022 01:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/88PareT3FwqgQqeieGvN6EcUA+3T4c6k7+dT7Kdhd8=;
        b=r/cxdJ5nHqykOS3JTkfrKs4GPwUNikKhRZp8payZC+QEejHrBpvXEH58/a03wbuBG/
         VY18f5njTHTnREExBBbT8yoX8BkLGu7N16h+DjFCWqMFG3xDB270EhI1rlwGKAzuQlEN
         X3fTLBW0xyo+MKwnQPF2D0XC63IgshFLpfN68y6s4iSSCRDY94NOOTR/4QDZrwPWFo6l
         Qs+iZt42jCocGmcsWYUAXQffneDbJcE5NTusAxkvn0iaVptGu1ellbDdgE+kLysBhiQO
         lpxatkNrnyak7cyI+ooUnSqad9//ghnbngagLntZaL3SQupdnsIyot2DUFUPKNKMbVZG
         wj/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/88PareT3FwqgQqeieGvN6EcUA+3T4c6k7+dT7Kdhd8=;
        b=c7MeCJPJ6YfLKHxzOOIIS1ZOHW/tQ3yj95nSsk055JlugY51gbVUvPZTtRnSHFeXZG
         PfNc6PuHajoJgYic0DfV7eHKTEn788jVSx206crZWysa39t8pGmgVCBi93HiwH+TeoAe
         nnd+hUTTbPmtEwYyqu/gtwaH3HW29O8OW2fy+ulAT8Ecjz7IQE4bSVVRLDqTBp1byRHF
         uTKilhW47Ly/xtDKppfoaGCEGZr8tGaQ/l/mR8LP9LoCVVbhEr14kd4T7EAIgJ8QxX47
         Dp43G/sL1vI/PEA4kYxjH5WEMgVgpMu07ZafWq4FN+YyZEpDu5IuD5W2POfHWvXvGch6
         Nhnw==
X-Gm-Message-State: AOAM531yAzv/z5+ZAnWfB5zgOgvSd2YgJnGwjs9VAtgdPHzWdH7aNU/x
        g7RriMxmIeJwRzadZFpc2QU1Hw==
X-Google-Smtp-Source: ABdhPJwYp8Fq7iZ8niSaeSO+xK9EyZuxtnwlwi33jbqc92ETr6vConll0/LoWvaQT2kFOsd2gYwKyA==
X-Received: by 2002:a5d:5051:0:b0:20c:884b:2347 with SMTP id h17-20020a5d5051000000b0020c884b2347mr1684270wrt.224.1651824883839;
        Fri, 06 May 2022 01:14:43 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id c14-20020adffb0e000000b0020c6fa5a797sm3059657wrr.91.2022.05.06.01.14.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 May 2022 01:14:43 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org, soc@kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [GIT PULL 1/6] arm64: dts: various cleanup for v5.19
Date:   Fri,  6 May 2022 10:14:33 +0200
Message-Id: <20220506081438.149192-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Set of cleanup patches for various ARM64 archs.  Some of them were acked by
respective maintainers, some were waiting a bit so I decided to push through my
tree.

Best regards,
Krzysztof


The following changes since commit 3123109284176b1532874591f7c81f3837bbdc17:

  Linux 5.18-rc1 (2022-04-03 14:08:21 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/dt64-cleanup-5.19

for you to fetch changes up to 8dba791a7280542bc125b68b3547bfa2680bc1af:

  arm64: dts: broadcom: drop useless 'dma-channels/requests' properties (2022-05-04 10:26:56 +0200)

----------------------------------------------------------------
Minor cleanup of ARM64 DTS for v5.19

Align SPI NOR node names and freq-table-hz to DT schema. Drop
unused/undocumented dma-channels/dma-requests.

----------------------------------------------------------------
Krzysztof Kozlowski (5):
      arm64: dts: hisilicon: align 'freq-table-hz' with dtschema in UFS
      arm64: dts: microchip: align SPI NOR node name with dtschema
      arm64: dts: marvell: align SPI NOR node name with dtschema
      arm64: dts: stratix10/agilex: drop useless 'dma-channels/requests' properties
      arm64: dts: broadcom: drop useless 'dma-channels/requests' properties

 arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi          | 2 --
 arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi           | 2 --
 arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi        | 2 --
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi                  | 4 ++--
 arch/arm64/boot/dts/hisilicon/hi3670.dtsi                  | 4 ++--
 arch/arm64/boot/dts/intel/socfpga_agilex.dtsi              | 2 --
 arch/arm64/boot/dts/marvell/armada-3720-db.dts             | 2 +-
 arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts     | 2 +-
 arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts           | 2 +-
 arch/arm64/boot/dts/marvell/armada-7040-db.dts             | 4 ++--
 arch/arm64/boot/dts/marvell/armada-7040-mochabin.dts       | 2 +-
 arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dts | 2 +-
 arch/arm64/boot/dts/marvell/armada-8040-db.dts             | 4 ++--
 arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi         | 2 +-
 arch/arm64/boot/dts/marvell/armada-8040-puzzle-m801.dts    | 2 +-
 arch/arm64/boot/dts/marvell/cn9130-crb.dtsi                | 2 +-
 arch/arm64/boot/dts/marvell/cn9130-db.dtsi                 | 2 +-
 arch/arm64/boot/dts/marvell/cn9131-db.dtsi                 | 2 +-
 arch/arm64/boot/dts/microchip/sparx5_nand.dtsi             | 2 +-
 arch/arm64/boot/dts/microchip/sparx5_pcb125.dts            | 4 ++--
 arch/arm64/boot/dts/microchip/sparx5_pcb134_board.dtsi     | 4 ++--
 arch/arm64/boot/dts/microchip/sparx5_pcb135_board.dtsi     | 4 ++--
 22 files changed, 25 insertions(+), 33 deletions(-)
