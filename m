Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 993EC4E7F38
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 06:58:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbiCZF7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 01:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbiCZF7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 01:59:39 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB0A02194
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 22:58:03 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id e5so10295744pls.4
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 22:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Hp0jNfOr8K57kc3PTbt73qfXMrfQ8MYWDBaHWdkvGpg=;
        b=bMMS4xxwRsa9RGMVqHkndB9L/aMyleFkj5V5Q3fjshStbrZMLpyxo4J9D+/IflYkDM
         pdDr0YpqmDVMtrf10YKJEWBCAg6mwlyRRfbzbhqNZ/E71KsYpcguIfVLT8haOWMwcNLI
         33A2K9RgvaPiWagzhQFVvDh3sXdWyrT9NgLwwrrPQBy9HhJ/OsFbbhnz3HjJ8cbizWa1
         lSoWyEpMyPazxiQonqyBtQk4iex02x0Fpco29sOAhwNA10u2bFJrQO2OOH0E151rKiwf
         JvLm1FaHLB1UV9rQQ5Z13yfWpqfTb3I9ZT2PMHNFdimWB/AvOoacCKWk+eOQ0QkCENVv
         GUUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Hp0jNfOr8K57kc3PTbt73qfXMrfQ8MYWDBaHWdkvGpg=;
        b=15Dn6fnptBroZskxmbK3HVKbfocgp4TTAIF3S1l3FIZnAb/8JsvRKPu9+H6OHvm0z1
         KxpGQXKxscaOjvcv0R22GNhp/CXYddjPcqnfpL1qVYticFEo/6Rr1I9UmT8EvsQhKPax
         k5RhJdFkAqdbNEXzqi1vrS8K98veX9RmtoKNJnZ4J+H8VKOmotQ1xT/JACNSUl9FLoO1
         mhuTJM0ERUMX452XKeuOdQCxkJzF7Fx6yhHa5Wg44nbexqhZ4lfdWKOO0Uwo0YuT1xM3
         CUXt7Fefr/4BtYomm5bQVupCmb1gcpHIzsLHQVcDMKavNWGMMW5hZNgkwWUiHEyS6Ing
         sS4A==
X-Gm-Message-State: AOAM5300MKhKMWqyf9lpkukpCpffP29cZj7hxddpcnwZI8Z7Jo7dRIR2
        lL8m+AHH2Bj5Qndq4dyyAsQtGA==
X-Google-Smtp-Source: ABdhPJzQZZSOf1jPHjrBcwPyl6LygKsiZMtHXWnMYpIRw0h5BRz/GUBBLmwMca27506uMzRko74bDA==
X-Received: by 2002:a17:90a:19d5:b0:1bc:a5db:b655 with SMTP id 21-20020a17090a19d500b001bca5dbb655mr28879529pjj.46.1648274283159;
        Fri, 25 Mar 2022 22:58:03 -0700 (PDT)
Received: from localhost.localdomain ([223.233.78.42])
        by smtp.gmail.com with ESMTPSA id b2-20020a056a000a8200b004e1414f0bb1sm9505067pfl.135.2022.03.25.22.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 22:58:02 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org
Cc:     bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        agross@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        bjorn.andersson@linaro.org
Subject: [PATCH v4 0/2] arm64: dts: Add PCIe support for SM8150 SoC
Date:   Sat, 26 Mar 2022 11:27:52 +0530
Message-Id: <20220326055754.1796146-1-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.35.1
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

Changes since v3:
-----------------
- v3 can be found here: https://lore.kernel.org/linux-arm-msm/20220302203045.184500-1-bhupesh.sharma@linaro.org/
- Broke down the patchset into 3 separate patchsets for each tree,
  so that the patch(es) can be easily reviewed and merged by respective
  maintainers.
- This patchset adds the 'linux-arm-msm' related dts support for SM8150 SoC.

Hi Bjorn,

This series adds dts support for PCIe controllers and PHYs found on 
SA8155p ADP board from Qualcomm.

This series has been tested on SA8155p ADP board with QCA6696 chipset connected
onboard.

Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>

Bhupesh Sharma (2):
  arm64: dts: qcom: sm8150: Add PCIe nodes
  arm64: dts: qcom: sa8155: Enable PCIe nodes

 arch/arm64/boot/dts/qcom/sa8155p-adp.dts |  15 ++
 arch/arm64/boot/dts/qcom/sm8150.dtsi     | 243 +++++++++++++++++++++++
 2 files changed, 258 insertions(+)

-- 
2.35.1

