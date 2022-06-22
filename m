Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47D0B556E2C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 00:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356187AbiFVV7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 17:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244112AbiFVV71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 17:59:27 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00EA3EE30
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 14:59:18 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id i64so17277002pfc.8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 14:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8siI/lLc2nLNx8FsNQ2lGqGWrHp1NmoTI0mwEHPoRDQ=;
        b=jnK2syri+t8agaUJJuKxnc4PvNimABVzx/hMCNzSy4l7UU3MqmIKP2sMhSTgI4OFJV
         APIEHEyJ68FfNP3u90w88YAFZaOvIB12o8tngNo2QrzPgFT2fTpHEdfGxi/iuc5gRX5c
         Q4R+Dio1niqKl2HEoSUcgms62FgRwwDbGHiJY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8siI/lLc2nLNx8FsNQ2lGqGWrHp1NmoTI0mwEHPoRDQ=;
        b=Thv5twi9U0Rqt07KwORT0iiMqfZrtvewGwg4dl0RuWIVIxgt4BU62ZdEQ6ZA4LNFK4
         1VKEfVVd5z2EJiImn4mO9Hs1NuMXaOYn0c3qdGQ9RJNGfw3IlhsQ4MIEOSQqnl9cQ57o
         Q3mLRtDDQBOOzEcjqjVxvsqua4GUFfSrmcdWrTCxGyNK5MxxMa9LmZhSCaXv7H/tmCzP
         wC4uidNc0g+5513M0EehhoO3NtzQM6hsnhXdK7eXPcBvIel4s3MVBcWFbtqVm3boUzZD
         Uvr5jlwPCHJYJaqObygLSY4G44n9FRsBvDPg75A4eGv0xOIEnGZsIFvz1ohk/HnnCeOs
         V25g==
X-Gm-Message-State: AJIora/RJNHCf5tlM4M3qKcqha569H/dzltjNp+q/SXMnH2RHrJ2mq+c
        6WCq5vDJXQTEVMjx9juzl0UhWmkNRXulxA==
X-Google-Smtp-Source: AGRyM1tRP8qOdBmSSJjI3JaaCymV9JUuET7vjHVH/kuIYQVeHzT1VkVWWOvR1vA/Z71UyyITT8bWKg==
X-Received: by 2002:a63:2055:0:b0:404:3941:e05e with SMTP id r21-20020a632055000000b004043941e05emr4706603pgm.66.1655935158109;
        Wed, 22 Jun 2022 14:59:18 -0700 (PDT)
Received: from joebar-glaptop.lan (c-71-202-34-56.hsd1.ca.comcast.net. [71.202.34.56])
        by smtp.gmail.com with ESMTPSA id nk15-20020a17090b194f00b001ec9d45776bsm255916pjb.42.2022.06.22.14.59.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 14:59:17 -0700 (PDT)
From:   "Joseph S. Barrera III" <joebar@chromium.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Alexandru M Stan <amstan@chromium.org>,
        "Joseph S. Barrera III" <joebar@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH v10 0/5] arm64: dts: qcom: sc7180: Add five new trogdor-based boards
Date:   Wed, 22 Jun 2022 14:58:00 -0700
Message-Id: <20220622215805.1121982-1-joebar@chromium.org>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
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

Changes in v10:
- Remove 'include sc7180.dtsi' from *all* sc7180-trogdor-pazquel* files.
- Remove 'include sc7180.dtsi' from *all* sc7180-trogdor-kingoftown* files.
- Move "okay" for ap_tp_i2c to proper location.

Changes in v9:
- Restore two lines accidentally removed from ap_sar_sensor.
- Simplify trackpad enabling (51d30402be75).
- Simplify trackpad enabling (51d30402be75).

Changes in v8:
- Incorporate the deletion of the usb_c1 node from 9f9fb70a7294.

Changes in v7:
- Restore changes requested by Doug.
- Restore changes requested by Doug.
- Only include sc7180.dtsi in sc7180-trogdor.dtsi (19794489fa24).
- Simplify spi0/spi6 labeling (d277cab7afc7).
- Simplify trackpad enabling (51d30402be75).
- Restore mrbland patch.
- Only include sc7180.dtsi in sc7180-trogdor.dtsi (19794489fa24).
- Simplify spi0/spi6 labeling (d277cab7afc7).
- Simplify trackpad enabling (51d30402be75).
- Only include sc7180.dtsi in sc7180-trogdor.dtsi (19794489fa24).
- Simplify spi0/spi6 labeling (d277cab7afc7).
- Remove #include of <arm/cros-ec-keyboard.dtsi>.
- Accidentally removed two lines from ap_sar_sensor.
- Simplify spi0/spi6 labeling (d277cab7afc7).
- Remove #include of <arm/cros-ec-keyboard.dtsi>.

Changes in v6:
- Only include sc7180.dtsi in sc7180-trogdor.dtsi (19794489fa24).
- Simplify spi0/spi6 labeling (d277cab7afc7).
- Simplify trackpad enabling (51d30402be75).
- Accidentally deleted changes requested by Doug.
- Accidentally deleted changes requested by Doug.
- Remove mrbland patch.
- Copy changes to ap_sar_sensor from v5.4.
- Add #include of <arm/cros-ec-keyboard.dtsi>.
- Add #include of <arm/cros-ec-keyboard.dtsi> from v5.4.

Changes in v5:
- Replaced _ in node name with -
- Ordered nodes by name
- Remove extra newline
- Add comment that compatible will be filled in per-board
- Replace _ in node name with -
- Order nodes by name.
- Add comment that compatible will be filled in per-board.

Changes in v4:
- Cleaned up rt5682s files
- Restored camcc definition
- Added missing version history
- Add missing version history
- Add missing version history
- Fix description (no downstream bits removed).
- Add missing version history.
- Fix description (no downstream bits removed).
- Add missing version history.

Changes in v3:
- Removed camcc definition
- First inclusion in this series
- First inclusion in series.

Changes in v2:
- Word wrapped patch description.
- Removed "Author" from patch description.
- Fixed whitespace around "en_pp3300_dx_edp"
- Add word wrapping to patch description.
- Remove "Author" from patch description.
- Fix whitespace around "en_pp3300_dx_edp".
- First inclusion in series.

Joseph S. Barrera III (5):
  arm64: dts: qcom: sc7180: Add wormdingler dts files
  arm64: dts: qcom: sc7180: Add quackingstick dts files
  arm64: dts: qcom: sc7180: Add mrbland dts files
  arm64: dts: qcom: sc7180: Add pazquel dts files
  arm64: dts: qcom: sc7180: Add kingoftown dts files

 arch/arm64/boot/dts/qcom/Makefile             |  18 +
 .../dts/qcom/sc7180-trogdor-kingoftown-r0.dts |  43 ++
 .../dts/qcom/sc7180-trogdor-kingoftown-r1.dts |  16 +
 .../dts/qcom/sc7180-trogdor-kingoftown.dtsi   | 224 ++++++++++
 .../qcom/sc7180-trogdor-mrbland-rev0-auo.dts  |  22 +
 .../qcom/sc7180-trogdor-mrbland-rev0-boe.dts  |  22 +
 .../dts/qcom/sc7180-trogdor-mrbland-rev0.dtsi |  53 +++
 .../qcom/sc7180-trogdor-mrbland-rev1-auo.dts  |  22 +
 .../qcom/sc7180-trogdor-mrbland-rev1-boe.dts  |  24 ++
 .../boot/dts/qcom/sc7180-trogdor-mrbland.dtsi | 344 +++++++++++++++
 .../sc7180-trogdor-pazquel-lte-parade.dts     |  21 +
 .../qcom/sc7180-trogdor-pazquel-lte-ti.dts    |  21 +
 .../qcom/sc7180-trogdor-pazquel-parade.dts    |  16 +
 .../dts/qcom/sc7180-trogdor-pazquel-ti.dts    |  16 +
 .../boot/dts/qcom/sc7180-trogdor-pazquel.dtsi | 221 ++++++++++
 .../sc7180-trogdor-quackingstick-r0-lte.dts   |  38 ++
 .../qcom/sc7180-trogdor-quackingstick-r0.dts  |  26 ++
 .../qcom/sc7180-trogdor-quackingstick.dtsi    | 318 ++++++++++++++
 .../sc7180-trogdor-wormdingler-rev0-boe.dts   |  22 +
 .../sc7180-trogdor-wormdingler-rev0-inx.dts   |  22 +
 .../qcom/sc7180-trogdor-wormdingler-rev0.dtsi |  53 +++
 ...0-trogdor-wormdingler-rev1-boe-rt5682s.dts |  29 ++
 .../sc7180-trogdor-wormdingler-rev1-boe.dts   |  28 ++
 ...0-trogdor-wormdingler-rev1-inx-rt5682s.dts |  29 ++
 .../sc7180-trogdor-wormdingler-rev1-inx.dts   |  22 +
 .../dts/qcom/sc7180-trogdor-wormdingler.dtsi  | 408 ++++++++++++++++++
 26 files changed, 2078 insertions(+)
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

