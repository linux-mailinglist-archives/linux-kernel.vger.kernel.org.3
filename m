Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB7E15A6C29
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 20:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231342AbiH3S3f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 14:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiH3S3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 14:29:33 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8ADA606B0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 11:29:30 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id x19so10305535pfr.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 11:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=FU+ZSlt3Sk8P5QdR6iQM+zCwA/rYcAEgbcQlERV36lo=;
        b=AVLiim4/w5eNujQh+FHqe0pG1E450AahPmNT7gwr7uneMFBOtATFS/aD2CQjgf9kml
         nOReDHrybn/RecLf1FL98oBhuifJCgGh7Yqif4fu+Wll9wIworADNFc31uiodiFTowHw
         0i86kuA/KKcMWSjCFICKQN8C/MHe0p+RnJuk8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=FU+ZSlt3Sk8P5QdR6iQM+zCwA/rYcAEgbcQlERV36lo=;
        b=YsiNPK0eSb7uymisU2byA3QwO8Jl7NNRprTgR2dbojkFfV0p37fpWS5G8tVwFi5Wr2
         nWeTLah8n4ZtfAQbeMNjs9xvfTIP//abou/HYcfb4NuC1jlG/sbzlmMGqfOfHRlXVCea
         eIixP0qcJElVBKfeo3dOrzDO5UyGv1csZ0BtBRs9AtHAxSwGa43osPNRH/cup8ZnbKSK
         TVQxYUD44ZlBabPdtp1CPTazxDE1k21ArrzSRpIHP7U/BNM/rIF7bhp369rLc2MV/+1N
         JLVKFOMIfzgWuxUn8qa8f4wSrMwa1XYy9Syo7jQ2H4x8UYU/bT2M9Y6TWYb0NKgLtA9+
         Btkg==
X-Gm-Message-State: ACgBeo3muHRz4GGdVOTrCN0QkbhYFAVEflQXp2Ys3hJ6kjoLh5Wexrgr
        86fTANm0OZ9ZxdK6zyqGhyDlDQ==
X-Google-Smtp-Source: AA6agR4/Oe6xii1sTCjsGZNxbvRtumssg8Ek7XhZXfjhbSUnofYieYWz7L2nXatt+BIfuwM+M9Y8MA==
X-Received: by 2002:aa7:8551:0:b0:538:22ec:d965 with SMTP id y17-20020aa78551000000b0053822ecd965mr12614278pfn.16.1661884170216;
        Tue, 30 Aug 2022 11:29:30 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:f016:d779:b6b0:fd9d])
        by smtp.gmail.com with ESMTPSA id u202-20020a6279d3000000b0052e37b32618sm9596358pfc.132.2022.08.30.11.29.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 11:29:29 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Sibi Sankar <quic_sibis@quicinc.com>,
        Jimmy Chen <jinghung.chen3@hotmail.com>,
        Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v9 0/3] arm64: dts: qcom: Add new board revision and LTE SKUs for sc7280-villager family
Date:   Tue, 30 Aug 2022 11:29:20 -0700
Message-Id: <20220830182923.3720287-1-dianders@chromium.org>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches add a new board revision for device Villager, and add
new LTE sku for both board revisions.

yaml issue has been clarified in [1] and [2], and 'status' has been
reordeded last since v4.

v9 is me squashing changes from my patches [3] [4] in. For patches I
touched I removed my Reviewed-by. I added my Signed-off-by to all
patches.

[1] https://lore.kernel.org/all/CAD=FV=WtKRFQr5jSQvsr08x9dgHrvenUWWtX_SKuCLuSvSH7WQ@mail.gmail.com/
[2] https://lore.kernel.org/all/d3d4d90b-85b5-5ad9-78e6-5a074c21af4f@linaro.org/
[3] https://lore.kernel.org/r/20220829084732.1.I9ef7f8b909a7afbef9ff2251a98c67033f37b516@changeid
[4] https://lore.kernel.org/r/20220829084732.2.I22e256d1ebac577a91fac44d1d12919be7111cd4@changeid/

Changes in v9:
- Squash https://lore.kernel.org/r/20220829084732.1.I9ef7f8b909a7afbef9ff2251a98c67033f37b516@changeid
- Squash https://lore.kernel.org/r/20220829084732.2.I22e256d1ebac577a91fac44d1d12919be7111cd4@changeid/

Changes in v7:
- Revise typo 'ARCG' to 'ARCH' in Makefile

Changes in v6:
- Remove v5 accidentally added sc7280-herobrine-herobrine-r1-lte.dts

Changes in v5:
- Revise rev0+ to rev0
- Add -r1 line to the Makefile
- Reorder '.dtb' in Makefile
- Put the "interconnects" line back

Changes in v4:
- ("...: Add herobrine-villager-r1") new for v4
- Reorder 'status' last

Changes in v2:
- ("...: document sc7280 and villager board") new for v2.

Jimmy Chen (3):
  dt-bindings: arm: qcom: document sc7280 and villager board
  arm64: dts: qcom: sc7280: Add herobrine-villager-r1
  arm64: dts: qcom: Add LTE SKUs for sc7280-villager family

 .../devicetree/bindings/arm/qcom.yaml         |  10 +
 arch/arm64/boot/dts/qcom/Makefile             |   2 +
 .../boot/dts/qcom/sc7280-chrome-common.dtsi   |  11 -
 .../boot/dts/qcom/sc7280-herobrine-crd.dts    |   1 +
 .../qcom/sc7280-herobrine-herobrine-r1.dts    |   1 +
 .../dts/qcom/sc7280-herobrine-lte-sku.dtsi    |  17 +
 .../dts/qcom/sc7280-herobrine-villager-r0.dts | 325 +----------------
 .../qcom/sc7280-herobrine-villager-r1-lte.dts |  14 +
 .../dts/qcom/sc7280-herobrine-villager-r1.dts |  16 +
 .../dts/qcom/sc7280-herobrine-villager.dtsi   | 326 ++++++++++++++++++
 arch/arm64/boot/dts/qcom/sc7280-idp.dts       |   1 +
 11 files changed, 392 insertions(+), 332 deletions(-)
 create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-lte-sku.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r1-lte.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r1.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-villager.dtsi

-- 
2.37.2.672.g94769d06f0-goog

