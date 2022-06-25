Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CCCA55A553
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 02:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232006AbiFYANY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 20:13:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbiFYANW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 20:13:22 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4705C20F61
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 17:13:20 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id g10-20020a17090a708a00b001ea8aadd42bso4274157pjk.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 17:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0TjCZxNeURxvfJlBGLiL6m2P8w/St+OKVS0jmgudiNY=;
        b=WH2pfcsnmA0g9dVGchBGxzu0ZB/E/YZ500twZrFG8iTbtS77b/TGQkrG7deqcHCdFP
         krc/+62q47vIuR/uTVOGZnA6M4UxrcIo7SY5raTlqRQS3RCMAX6R/p+miZfjam/R1167
         zZa5V1U9WE2Vb9g05QSXvaHkhKLUgBJFFPtII=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0TjCZxNeURxvfJlBGLiL6m2P8w/St+OKVS0jmgudiNY=;
        b=k2ECRxSFOx81f3XpAV198Y0TF0BRXolp+AfAQPqXvcQ46S+QxuNJszy+gOf++pWo5S
         UZvw14p9H1CQPJL3P+Tv1ay7iaDYF8WdDKftLguUGkauHlDCGtZfrUZTdipVrO/LFKBn
         HMLmX6Q4mBmGP906KtW7nLbymRz6c9EflDBmoM0SN7MdoT8Lmu7l2dOtAeYPn48fNZYT
         14FHuil9tmHkHDD7PfF23H+GwubAtq1UAF7TAO/mcvqWZ38ZDUznQzInI7XYwHMQaWVq
         Iy8B56CAJ1D4q9f22KGxmnR7Y7xZotFtTo1yVuNHXudkzakTNJA0BfBhu4TpArJUQ5Es
         kKYA==
X-Gm-Message-State: AJIora8AU4utE2Jko7HgKR+bS2NX2MZ2i/7Nu01HOu1XMDdG7ZFVT/A/
        cVUdgJUl6QNLx+LqOObeqIp7U7cnDUfD0w==
X-Google-Smtp-Source: AGRyM1u5gNBZSz9VALVIyN+xtr9yQR6lttni1iE0wVlXyu1GQcCM/x6X7eefyM4ILpQb5tEGaoE4SQ==
X-Received: by 2002:a17:903:110c:b0:168:fa61:1440 with SMTP id n12-20020a170903110c00b00168fa611440mr1553981plh.149.1656116000090;
        Fri, 24 Jun 2022 17:13:20 -0700 (PDT)
Received: from joebar-glaptop.lan (c-71-202-34-56.hsd1.ca.comcast.net. [71.202.34.56])
        by smtp.gmail.com with ESMTPSA id e14-20020a170902ef4e00b0016a275623c1sm2372303plx.219.2022.06.24.17.13.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 17:13:19 -0700 (PDT)
From:   "Joseph S. Barrera III" <joebar@chromium.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Alexandru M Stan <amstan@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        "Joseph S. Barrera III" <joebar@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH v12 0/5] arm64: dts: qcom: sc7180: Add five new trogdor-based boards
Date:   Fri, 24 Jun 2022 17:10:04 -0700
Message-Id: <20220625001009.417452-1-joebar@chromium.org>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds five new trogdor-based boards to upstream.
The patches should be applied *after* applying
https://lore.kernel.org/all/20220602190621.1646679-1-swboyd@chromium.org/
(arm64: dts: qcom: Remove duplicate sc7180-trogdor include on lazor/homestar)

The patches do *not* expect
https://lore.kernel.org/all/20220518172525.3319993-1-swboyd@chromium.org/
(sc7180-trogdor: Split out keyboard node and describe detachables)
to be applied.

The compatibles in this series are documented by Doug's series
https://lore.kernel.org/r/20220520143502.v4.5.Ie8713bc0377672ed8dd71189e66fc0b77226fb85@changeid

Version 9 included many corrections to the series change descriptions,
based on fetching earlier versions of the series and diffing each patch.

Changes in v12:
- Replace 'include sc7180.dtsi' with 'include sc7180-trogdor.dtsi'
  in sc7180-trogdor-ti-sn65dsi86.dtsi.

Changes in v11:
- Add 'include sc7180-trogdor.dtsi' to sc7180-trogdor-pazquel-* files.
- Add 'include sc7180-trogdor.dtsi' to sc7180-trogdor-kingoftown-* files.
- Restore 'include sc7180.dtsi' to sc7180-trogdor-ti-sn65dsi86.dtsi.

Changes in v10:
- Move "okay" for ap_tp_i2c to proper location.
- Remove 'include sc7180.dtsi' from *all* sc7180-trogdor-pazquel* files.
- Remove 'include sc7180.dtsi' from *all* sc7180-trogdor-kingoftown* files.

Changes in v9:
- Restore two lines accidentally removed from ap_sar_sensor.
- Simplify trackpad enabling (51d30402be75).
- Correct errors in series change history.

Changes in v8:
- Incorporate the deletion of the usb_c1 node from 9f9fb70a7294.

Changes in v7:
- Accidentally removed two lines from ap_sar_sensor.
- Only include sc7180.dtsi in sc7180-trogdor.dtsi (19794489fa24).
- Remove #include of <arm/cros-ec-keyboard.dtsi>.
- Restore changes requested by Doug.
- Restore mrbland patch.
- Simplify spi0/spi6 labeling (d277cab7afc7).
- Simplify trackpad enabling (51d30402be75).

Changes in v6:
- Accidentally deleted changes requested by Doug.
- Add #include of <arm/cros-ec-keyboard.dtsi>.
- Copy changes to ap_sar_sensor from v5.4.
- Remove mrbland patch.
- Only include sc7180.dtsi in sc7180-trogdor.dtsi (19794489fa24).
- Simplify spi0/spi6 labeling (d277cab7afc7).
- Simplify trackpad enabling (51d30402be75).

Changes in v5:
- Add comment that compatible will be filled in per-board.
- Order nodes by name.
- Remove extra newline
- Replace _ in node name with -

Changes in v4:
- Cleaned up rt5682s files
- Restored camcc definition
- Fix description (no downstream bits removed).
- Add missing version history.

Changes in v3:
- Removed camcc definition
- First inclusion in series.

Changes in v2:
- Add word wrapping to patch description.
- First inclusion in series.
- Fix whitespace around "en_pp3300_dx_edp".
- Remove "Author" from patch description.
- Word wrap patch description.

Joseph S. Barrera III (5):
  arm64: dts: qcom: sc7180: Add wormdingler dts files
  arm64: dts: qcom: sc7180: Add quackingstick dts files
  arm64: dts: qcom: sc7180: Add mrbland dts files
  arm64: dts: qcom: sc7180: Add pazquel dts files
  arm64: dts: qcom: sc7180: Add kingoftown dts files

 arch/arm64/boot/dts/qcom/Makefile             |  18 +
 .../dts/qcom/sc7180-trogdor-kingoftown-r0.dts |  44 ++
 .../dts/qcom/sc7180-trogdor-kingoftown-r1.dts |  17 +
 .../dts/qcom/sc7180-trogdor-kingoftown.dtsi   | 225 ++++++++++
 .../qcom/sc7180-trogdor-mrbland-rev0-auo.dts  |  22 +
 .../qcom/sc7180-trogdor-mrbland-rev0-boe.dts  |  22 +
 .../dts/qcom/sc7180-trogdor-mrbland-rev0.dtsi |  53 +++
 .../qcom/sc7180-trogdor-mrbland-rev1-auo.dts  |  22 +
 .../qcom/sc7180-trogdor-mrbland-rev1-boe.dts  |  24 ++
 .../boot/dts/qcom/sc7180-trogdor-mrbland.dtsi | 344 +++++++++++++++
 .../sc7180-trogdor-pazquel-lte-parade.dts     |  22 +
 .../qcom/sc7180-trogdor-pazquel-lte-ti.dts    |  22 +
 .../qcom/sc7180-trogdor-pazquel-parade.dts    |  17 +
 .../dts/qcom/sc7180-trogdor-pazquel-ti.dts    |  17 +
 .../boot/dts/qcom/sc7180-trogdor-pazquel.dtsi | 221 ++++++++++
 .../sc7180-trogdor-quackingstick-r0-lte.dts   |  38 ++
 .../qcom/sc7180-trogdor-quackingstick-r0.dts  |  26 ++
 .../qcom/sc7180-trogdor-quackingstick.dtsi    | 318 ++++++++++++++
 .../dts/qcom/sc7180-trogdor-ti-sn65dsi86.dtsi |   1 +
 .../sc7180-trogdor-wormdingler-rev0-boe.dts   |  22 +
 .../sc7180-trogdor-wormdingler-rev0-inx.dts   |  22 +
 .../qcom/sc7180-trogdor-wormdingler-rev0.dtsi |  53 +++
 ...0-trogdor-wormdingler-rev1-boe-rt5682s.dts |  29 ++
 .../sc7180-trogdor-wormdingler-rev1-boe.dts   |  28 ++
 ...0-trogdor-wormdingler-rev1-inx-rt5682s.dts |  29 ++
 .../sc7180-trogdor-wormdingler-rev1-inx.dts   |  22 +
 .../dts/qcom/sc7180-trogdor-wormdingler.dtsi  | 408 ++++++++++++++++++
 27 files changed, 2086 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-kingoftown-r0.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-kingoftown-r1.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-kingoftown.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-mrbland-rev0-auo.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-mrbland-rev0-boe.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-mrbland-rev0.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-mrbland-rev1-auo.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-mrbland-rev1-boe.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-mrbland.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel-lte-parade.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel-lte-ti.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel-parade.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel-ti.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-quackingstick-r0-lte.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-quackingstick-r0.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-quackingstick.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev0-boe.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev0-inx.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev0.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev1-boe-rt5682s.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev1-boe.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev1-inx-rt5682s.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev1-inx.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler.dtsi

-- 
2.31.0

