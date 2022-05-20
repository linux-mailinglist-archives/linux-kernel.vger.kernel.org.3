Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4205E52EB89
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 14:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348997AbiETMFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 08:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243571AbiETMFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 08:05:34 -0400
Received: from sonic310-19.consmr.mail.sg3.yahoo.com (sonic310-19.consmr.mail.sg3.yahoo.com [106.10.244.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D272414FCAB
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 05:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com.tw; s=s2048; t=1653048329; bh=m5qRjrtAwTm45gVOBmuBl6oIrvjG2+lMVTnZgN9reTs=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=A0gteQS1PF0/daIGYsgG/I6crpjZEyjjrvV+KF+jZuHDui6JKsqF1JSBXvHwaxww7YbybGPjugZ1B4CeaBXQ3Zo01qfTplBwBUjWTnbbG9vL1y2eP701Z1OCAgouFwhs22U9Jj2mCb6NE1VrbGRgCarQDW7ic9nArQAflmdLOVMuLypkQLLLZHIYHVoum5edrV6Go30SyeW7ZLviU751j6tUyMTyd6OHaE21eowCHwt83uHdtCVMUoTXXI0/vL1bNWzZrC3Gnej0JEmtfyzVzrvqfXgDFQdPG/Z7ijh148kgrQNEj1hgygLR3bmRioh7I3NHhfVETw2+0CC84vwBuA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1653048329; bh=06F7/vuVcJCwHQ8t+q1qQlgeAL2a0CDJc/jIwwKCbXg=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=HBYJ5YJaT/uPIx/ecePDpkljo+DxLn0uh9t8moksnSXyUbKfYV7KcEfB533wROlXVm66zbuFTt0NbBESRV+6m6jF+VivK8N5SOvTJe5SmodH2nG22FMTdDdOYGfEUlWcjugRJJhWMmAlfHaU5X8ZCexKcMkVP1kW6XS9oZU1z5ctV+e8lVUdlGZWCyPXhLWuuzbHMOFyn9XFxw3+cL4fP7SxQYSYa40Kac2EExFYIqsFntcxI5q8zFRiy1E/bBSBsssufHqd2jv5DNSJUxpRAbXdznnHiL0Rz6BGV7xywBh2gfM0+RupbpYCQH3ATZmI3oZkEtHWhb4755Rkf8DexA==
X-YMail-OSG: Kg1CpzUVM1mA9kP8_PyUkMj0BiSVgKciuua.QitQfA5QZ1sfb9s15.DzepEIG6P
 SOhNeekzoezlbdyAQ.rlStP9vnhmUNy6yPmVqqm4fCpCklZ_QZEZ0mtL9iAyrut6dz4omFmxOkCX
 SNIBPtc1Rkxam5.oBxX11Nh4mYEEAjbkk_BZfTDsvWReI3goDvqpkYAA3_5hITTIsIFw4NUh7wQf
 FDWFWXfIL8IBhSPe23IxidA1MHVPhCI8KFND6fDao0sE1oSmeKlgMtj4tF.shh7RWhb6N6g.wk03
 2mBit_eLJJJT7GF5lZ7wfjI6mJr1v4LfUBKEw.j.CmHgCCMi.Xro3Dcy5ufIJZftsrYwOBIZ_7Az
 L9uARsXVEGZVfyh5Lz5flhtpCMdMEjq5ofaaRc2sLet_AMVGp.xyX5GgZsWUGoG3hkXDF31Nra0P
 zbRQ9jdvBgxZTw27dfsMEsczAKwJEzqArXBCMKatqoA5LDB48Hi1ezTzERMdzKrKueuNFgrudSL0
 oUnYbvoIXLabvK5WmJT5wwuGfN3Er9_eBwi8vRLJeiFI2FdvcB080fJD7Ak9xZ2clHv9UF3M4rfI
 lsUAhqG.LBmV1a.qD4MCQVR6kY3osKwZ5UAo9T9tc0XOYSz5I6scfwAREtYenZ4KZKWiMHdL2gRK
 AuC5UW9mHFbrZy9Isc7xUiaGUcyhVuaejpv4WoDVEtyuTe2hFIUM1EZMuOXAoS11QTAKTx8lWI74
 GQm2HGh0YV9pTDrMMDNZHFFa.sbBhoEh_Kzw1mjvZtIgI7Re0BKZopvXg4eBAdvIattLkp09hLNI
 1D3_gLCMpehmDxnUIDJ.PXE3UnmPAnPiWFj_8dUbOAmoWV.upFLgd4o3Azx89j85u6lCgC9lga1x
 UYGG35I0bl3.JsFLLpwDjG15uwG7KMrld1BDgL3ErsM5toKLomO4HBgzPmDzR6x7iwsEoHV7ndbE
 CgyMPZPnadGVwRShMC1SJud6oGZJ2kFSVeqI7S9GWWi0iwWCbZ6aGznok4pE1dS8b2QU07JZBQ0B
 3ZL02WPLiJrzADFjKPsfNdXR8n1vrqyLrrjVTiAYr52_WkWOalNzb_N4iZNPfF6zL2ITAgMHiwOE
 .xv.SrUC09xm0eMT0qWHp5jKhKcxhc1c4DjpaVwYphCf.pMRDdX0gg7K8g1tTp88STd04cYLjm8I
 trh_MduZzT1iLuTvUaJMuzW0JpfZ3TDcROTFlbI9hvqFplCTiBL0Nu6RpbzK1bnIjvhlUTO4o4oM
 6xDSoxLC33qhwW0ZDEDcfy.AZbaC0qMuYNZFsWsEfG0ZC2mQ5.RQPb1gG15IqGgJYH.29TjtB8TO
 BnaWJJv5hw1dvhYNr4P_B.2fPLAOZ2aqSG2yA4.Bi7eNhvu1R.MjBxMy3y6YJA35riK6ZJBfJ0ti
 _XElCqjmy0gNvvLsgVyNJfq6jcxmGiU.Gy5cvwXo0vKpOnVpyh_3WhkXBWRO0qa.G0ew1D_jP2Bu
 n9ZaI2RchEAE4doX7tI7DcqbWgkp95zuK.7AGtTowQeMzgZTtIEbMkaU3B9qa0Yrfv4HFUuXWEue
 A1gvZQSdFMWAqUX8.pBQAOCJycZNymq23vU7P7sD7.4TmN8srDhBuNbqORkWw2jG47q9BSHA0QLm
 j9mr2aID7u8yRoe8zV8rw.wrjnSEXKX2jPm1o.108ec1nlMy0P4fRjJRFUZT_FOUQF1YizzZvlN7
 bYcA1QZMhjIPmEKBruIZ6qldoQME5axU3qP6Pd6DXaSTe3no7sxmdsnxMVI2SoDYYGEqhuWWdFcI
 Ucuur2VeI22l_uvDyIc96yf8Yts7ZjeoJ9j8U1xtvTBxwqi46aPZsMJTBtPcqe6QqLr7BJC06UL5
 opvvsCSNAvsUVrThcNgqAc_ngmC3qQLrQquWwOMgg85S.N1n5hy4Gi93O59jsRbEcujIKSEwaTZ1
 Bd04OqP9ZEvem2I.cYdGYlNhTyn_m5ZZQ9DDpSGwOrwOoyYDZmgdbkrgodSWZFjRuefqUU9q9ROL
 9dnT4N5OaR8TuufYX3zSH2tQJVX4ZuDqDiupzKin.tBZyVjS3S7vb8iTCZFLIS4UNHCZwCfbgTdg
 97ZxluR1X7_0nWMG.MijAB9xjpqv9hmr4jsDpMEz_FiL23G2KDYEkHQ9uOWdC9Y2Ir9uBkryM22p
 D5ZaXO8E.LUcWieBowrIGXA3oXi0VoNpsA635w6rjo5lgRypUbG2U8SYuo8GeopPiQgObNdyHHWS
 SVeTJeS7v.mW5zRDJjuYY_exHw3Lk2QS19gd24jcjD0muz9apL6QVHkSwFD5dHXiUeqcU7czqgHk
 i98go95Nfl9hkjALpAO85WgQ-
X-Sonic-MF: <ae40515@yahoo.com.tw>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.sg3.yahoo.com with HTTP; Fri, 20 May 2022 12:05:29 +0000
Received: by hermes--canary-production-gq1-5cd7967f4d-rdzjx (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 0e81e43a2f3cdb966d184af1e1a1edda;
          Fri, 20 May 2022 12:05:22 +0000 (UTC)
From:   Alec Su <ae40515@yahoo.com.tw>
To:     agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, sboyd@codeaurora.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, y.oudjana@protonmail.com,
        Alec Su <ae40515@yahoo.com.tw>
Subject: [PATCH v3 0/2] Add support for Xiaomi Mi 5s Plus
Date:   Fri, 20 May 2022 12:04:47 +0000
Message-Id: <20220520120449.12996-1-ae40515@yahoo.com.tw>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20220520120449.12996-1-ae40515.ref@yahoo.com.tw>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds the device tree for Xiaomi Mi 5s Plus (xiaomi-natrium)
smartphone which is based on Snapdragon 821 SoC.

Changes since v2:
- Rename the node "synaptics" to "touchscreen".

Changes since v1:
- Adjust the sequence of the patches in this series.
- Remove the unnecessary line and properties in the device tree.
- Rename the nodes contain underscores.

Alec Su (2):
  dt-bindings: arm: qcom: Document xiaomi,natrium board
  arm64: dts: qcom: msm8996-xiaomi-natrium: Add support for Xiaomi Mi 5s
    Plus

 .../devicetree/bindings/arm/qcom.yaml         |   1 +
 arch/arm64/boot/dts/qcom/Makefile             |   1 +
 .../boot/dts/qcom/msm8996-xiaomi-natrium.dts  | 416 ++++++++++++++++++
 3 files changed, 418 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/msm8996-xiaomi-natrium.dts

-- 
2.35.3

