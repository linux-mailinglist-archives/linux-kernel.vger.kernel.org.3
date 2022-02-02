Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D4BE4A7A34
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 22:24:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347498AbiBBVYM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 16:24:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbiBBVYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 16:24:10 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 590CFC061714
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 13:24:10 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id a8so412601pfa.6
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 13:24:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BzO4x0egfL+lkgiS2KouKfqLrj3n7wywW/JicE40S5U=;
        b=EgxhRhjfIGWrGUq350wVEc1i/OZ+YrTYVF7kqrszFu4GlGi1H0Eq7z87hk8Suro3mu
         jh9dljYpRoW9TznUkvre7B9lBRJ+wkk5olfhDNUyZ1A0H3Kd91MOb3sSvaFYcvZyTwph
         LH5hGty/A0L1l37YOEVmn3KwioIEVHZmMAUWc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BzO4x0egfL+lkgiS2KouKfqLrj3n7wywW/JicE40S5U=;
        b=AHEoh08nZXHvLseF6m9PP3zkoXCgpEYHIM9Mw4+cHZltrWSg2V4keZSbcfi/gGGi0m
         1+eKrB3h7tE686x8BUwxWu9nHJC+e9VaXGvHjWGH4ylbCwd4Lk2vsI8hhGw1BJ2U6qZi
         cRZCKAjTfop6q+Wc0hY+PSU7R/PmMxD/WdX6U5K4rb/Jy2/fNsZAKXi1St9Ok/FrXevf
         MkZg2c3tt25OLIWzIrdFdndFZJ7reGNoMT1uo3eyXoQPMBox8KwAyDDoVP1HvKTu28Pl
         O7GZbgw7ZWso5f1hm/UbXI7oDK1uqaMKy+nW6CFs93Rpd8HfCTJ0MRXG+kgc1WNSsVmh
         axdw==
X-Gm-Message-State: AOAM533ssyH+AZS70JkFI40cJLLi7bGLzrXS87Wb6kX8V5D1QurlLBmJ
        P3m/t/krMwAVlMgY7K1Ph7Twxg==
X-Google-Smtp-Source: ABdhPJw2mY35yY30htTIyURARV2lwbwXWo9JdHo/Rhjfq2KKmY/oRs7iA2c6EKIvCKRbK8C2pAQDjg==
X-Received: by 2002:a05:6a00:230e:: with SMTP id h14mr31840769pfh.10.1643837049816;
        Wed, 02 Feb 2022 13:24:09 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:f1c4:10b6:b4ef:16e5])
        by smtp.gmail.com with ESMTPSA id on9sm7627983pjb.16.2022.02.02.13.24.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 13:24:09 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     pmaliset@codeaurora.org, mka@chromium.org,
        quic_rjendra@quicinc.com,
        Shaik Sajida Bhanu <sbhanu@codeaurora.org>,
        kgodara@codeaurora.org, konrad.dybcio@somainline.org,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        sibis@codeaurora.org, swboyd@chromium.org,
        Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 00/14] arm64: dts: qcom: sc7x80: A smattering of misc dts cleanups + herobrine-rev1
Date:   Wed,  2 Feb 2022 13:23:34 -0800
Message-Id: <20220202212348.1391534-1-dianders@chromium.org>
X-Mailer: git-send-email 2.35.0.rc2.247.g8bbb082509-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is "v2" of my "smattering of misc dts cleanups" series
plus v3 of the tail end of the series adding herobrine-rev1. I've set
the version number to the larger of the two to (I hope) help
allevitate confusion.

For the cleanups, there's not a lot holding this series together
except that it fixes a smattering of random dts stuff that I noticed
recently. There are not a lot of dependencies and some of the patches
could be reordered if desired.

Hopefully these look OK and can be applied quickly to avoid conflicts
with other work going on.

For herobrine-rev1, it can be noted that it's likely
that with the introduction of -rev1 we can drop -rev0 support, but
we'll keep it for now (though we won't try to "fit it in" and share
code with it). This series is confirmed to boot atop the top of
the linux qualcomm tree, commit a5ee6b7720cb ("Merge branches
'arm64-defconfig-for-5.18', 'arm64-for-5.18', 'dts-for-5.18',
'arm64-fixes-for-5.17' and 'dts-fixes-for-5.17' into for-next")

Changes in v3:
- Removed extra blank lines
- ("Fix sort order of dp_hot_plug_det") new for v3.
- ("Add edp_out port and HPD lines") new for v3.
- ("Move pcie1_clkreq pull / drive str to boards") new for v3.
- ("sc7280-idp: Disable pull from pcie1_clkreq") new for v3.
- ("Remove dp_hot_plug_det pull from SoC dtsi file") new for v3.
- ("Add a blank line in the dp node") new for v3.
- Rebased atop dts cleanup patches.
- Add regulator suffix as per dts cleanup patches.
- Set PCIe bias / pull as per dts cleanup patches.
- Add dp_hot_plug_det pull as per dts cleanup patches.
- Setup SD card same as dts cleanup patches.
- ("sc7280: Add the CPU compatible to the soc@0 node") new for v3.
- ("Remove "qcom,sc7280" from top-level") patch new for v3.

Changes in v2:
- Herobrine compatible on one line, not two
- Wording change in comments for components enabled per-board
- Always sort "bias" above "drive-strength" in pinctrl.
- Properly sort "hub_en" pinctrl.
- Two comments moved from multiline to single line.
- Space after "/delete-property/"

Douglas Anderson (14):
  arm64: dts: qcom: sc7180-trogdor: Add "-regulator" suffix to
    pp3300_hub
  arm64: dts: qcom: sc7280-herobrine: Consistently add "-regulator"
    suffix
  arm64: dts: qcom: sc7280: Properly sort sdc pinctrl lines
  arm64: dts: qcom: sc7280: Clean up sdc1 / sdc2 pinctrl
  arm64: dts: qcom: sc7280-idp: No need for "input-enable" on sw_ctrl
  arm64: dts: qcom: sc7280: Fix sort order of dp_hot_plug_det /
    pcie1_clkreq_n
  arm64: dts: qcom: sc7280: Add edp_out port and HPD lines
  arm64: dts: qcom: sc7280: Move pcie1_clkreq pull / drive str to boards
  arm64: dts: qcom: sc7280: Disable pull from pcie1_clkreq
  arm64: dts: qcom: sc7280: Move dp_hot_plug_det pull from SoC dtsi file
  arm64: dts: qcom: sc7280: Add a blank line in the dp node
  arm64: dts: qcom: sc7280: Add herobrine-r1
  arm64: dts: qcom: sc7280: Add the CPU compatible to the soc@0 node
  arm64: dts: qcom: sc7280: Remove "qcom,sc7280" from top-level of
    boards

 arch/arm64/boot/dts/qcom/Makefile             |   1 +
 arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi  |   2 +-
 arch/arm64/boot/dts/qcom/sc7280-crd.dts       |   2 +-
 .../qcom/sc7280-herobrine-herobrine-r0.dts    |  97 +--
 .../qcom/sc7280-herobrine-herobrine-r1.dts    | 313 +++++++
 .../arm64/boot/dts/qcom/sc7280-herobrine.dtsi | 785 ++++++++++++++++++
 arch/arm64/boot/dts/qcom/sc7280-idp.dts       |   2 +-
 arch/arm64/boot/dts/qcom/sc7280-idp.dtsi      |  99 +--
 arch/arm64/boot/dts/qcom/sc7280-idp2.dts      |   2 +-
 arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi    | 547 ++++++++++++
 arch/arm64/boot/dts/qcom/sc7280.dtsi          | 182 ++--
 11 files changed, 1845 insertions(+), 187 deletions(-)
 create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi

-- 
2.35.0.rc2.247.g8bbb082509-goog

