Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E40284E78FF
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 17:36:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359708AbiCYQhb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 12:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343957AbiCYQh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 12:37:28 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D29A60A9D
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 09:35:52 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id b15so6855468pfm.5
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 09:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=59DdM1OMuwdp9CVjs5LMT5Vj5xWvhECtRS/Ocfq4B1Q=;
        b=OeMJ6CesmRYIII7XnopnggyoVqEsoanvgZspmVWHcn13nBPGB61sUAt+1nIikJT28a
         U++VArf8YYxy97kp3clOgRBNCBNKz+8Cw58RCRUc2U4nCXH60c0AEw46or+Ii0MUpxgG
         bSZ19ACwHJW+vwpKiPF+kOqklysC4UlrjdANGlKSd6Uq50wQRVRhFDI4fBH1B9HdG9FV
         ZLsZNRC7IXcfLR2n/XtzvsqEw/pLP3Cpn0M5v4PqMpMC34z7hQakWZuNOycLT/kmsPrS
         pJMhFcxrMvgwMb5A1r8xya+HKXppRXthH0d+6R3fheVMRflJxyqXR5DHGPpqVVqbOIhe
         OTkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=59DdM1OMuwdp9CVjs5LMT5Vj5xWvhECtRS/Ocfq4B1Q=;
        b=QxE/KTdy8cqfDA1Ak70VRAt3egc0SYOWRByp7YzFdkE+w/vGkjSI3C25b/DdOaUar5
         ptDa892+o+7+ZnPlmu5/8XRbx3MDDHkmzTE/mItPJGLCvwkN/wHjFZ35ToQbcWCLTm9M
         nniPng1kwRTGG0S+9Ssh4nNaIFO2zygEZAUhH3TqsZxbi+BWoQzxeWSVb8QIpu56JVq/
         uVXypB/sReKIjpc/yGnEdzCH4BmTjuJZ+uy1WxE3JVUw4hpEPCvxrtRxFlx0VWN8B81u
         3HU8ZZQawqSUBbu4SYY7Kr8aaDLYmo0pRNVWJV0evovonKSCRKs7ZkBrp9O3J6XF+TVc
         0Fxw==
X-Gm-Message-State: AOAM531sChmvmtnxe92TEoD8k3Rwk2ibyhuhGRuJqLIl4nZycgTMHPLC
        efNSMuGfKDot2OChdDWsC+RGSg==
X-Google-Smtp-Source: ABdhPJyRd0wOThIIONBwFapt4DjMaBqvYAaaNG1ntcedGtasnkDrMUT40oNbvBljkaaV3CvasQwthg==
X-Received: by 2002:a05:6a00:16cd:b0:4e1:366:7ee8 with SMTP id l13-20020a056a0016cd00b004e103667ee8mr10889715pfc.9.1648226151493;
        Fri, 25 Mar 2022 09:35:51 -0700 (PDT)
Received: from localhost.localdomain ([223.233.78.42])
        by smtp.gmail.com with ESMTPSA id j6-20020a17090a588600b001c699d77503sm6264948pji.2.2022.03.25.09.35.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 09:35:51 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org
Cc:     bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        agross@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        bjorn.andersson@linaro.org
Subject: [PATCH v4 0/2] Add ethernet dts nodes for Qualcomm SA8155p-ADP board
Date:   Fri, 25 Mar 2022 22:05:35 +0530
Message-Id: <20220325163537.1579969-1-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.35.1
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

Changes since v3:
-----------------
- v3 can be seen here: https://lore.kernel.org/lkml/20220303084824.284946-4-bhupesh.sharma@linaro.org/T/
- Bjorn has accepted a couple of patches from v3 already, so drop them
  from this v4 version.
- Dropped the EMAC GDSC quirk patch from this series, as Bjorn has
  already submitted a fix via [1].
- Keep only 'linux-arm-msm specific dts' patches in this subset, so that
  they can be easily reviewed and merged.

Changes since v2:
-----------------
- v2 can be seen here: https://lore.kernel.org/linux-arm-msm/20220302110508.69053-1-bhupesh.sharma@linaro.org/T
- Fixed review comments from Dmitry - created a new [PATCH 2/6]
  to fix some identation issues with sm8150 gcc driver.

Changes since v1:
-----------------
- v1 can be seen here: https://lore.kernel.org/netdev/20220126221725.710167-1-bhupesh.sharma@linaro.org/t/
- Fixed review comments from Bjorn - broke the v1 series into two
  separate series - one each for 'net' tree and 'arm clock/dts' tree
  - so as to ease review of the same from the respective maintainers.
- This series is intended for the 'arm msm clock/dts' tree.
- Other changes:
  - Dropped [PATCH 7/8] from v1.
  - Added more background on the emac gdsc issue, requiring it to be in
    ALWAYS_ON state in [PATCH 5/5].
  - Collected Ack from Rob for [PATCH 1/5].
  - Broke down v1's [PATCH 3/8] into 3 separate patches (one each for emac,
    pci and ufs gdsc defines) - one of which is carried as [PATCH 2/5]
    in this series, which is used to enable emac GDSC.

The SA8155p-ADP board supports on-board ethernet (Gibabit Interface),
with support for both RGMII and RMII buses.

This patchset adds the support for the same.

Note that this patchset is based on an earlier sent patchset
for adding PDC controller support on SM8150 (see [2]).

[1]. https://lore.kernel.org/lkml/YjxkNzJMGt0f2XYF@kroah.com/T/
[2]. https://lore.kernel.org/linux-arm-msm/20220226184028.111566-1-bhupesh.sharma@linaro.org/T/

Cc: Bjorn Andersson <bjorn.andersson@linaro.org>

Vinod Koul (2):
  arm64: dts: qcom: sm8150: add ethernet node
  arm64: dts: qcom: sa8155p-adp: Enable ethernet node

 arch/arm64/boot/dts/qcom/sa8155p-adp.dts | 146 +++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/sm8150.dtsi     |  27 +++++
 2 files changed, 173 insertions(+)

-- 
2.35.1

