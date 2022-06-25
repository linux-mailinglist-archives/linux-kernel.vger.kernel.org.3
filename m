Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CEF855A613
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 04:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231602AbiFYC2L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 22:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231438AbiFYC2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 22:28:09 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6876658D
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 19:28:07 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 184so3944847pga.12
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 19:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e0KZ4pSV9Pz4I9RocveqdgJZcOs2Lx4VgN1fPL0oZg4=;
        b=hGvQveNSOI6QKIeySuo4v47HX4FTj4hkSGUFWbMSehWCa9F9gpqwLvMyoCNgltOSZy
         18ODnekVRLVCADMtgKqcDYM3nCJe6fij2VRwQhuJGL2GtmlcnvHk+wQ7BkIALe4It6N+
         LFUowIFp+m649XB5ainNrYE8ZZQVM1ejF7xmM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e0KZ4pSV9Pz4I9RocveqdgJZcOs2Lx4VgN1fPL0oZg4=;
        b=8R0x4yF/oJE160lBYAyuWC/mshih21zkN6tci57Yq6iVJ6tdOxMUEYflLh4JXeWPrB
         OdvcEhlLjex369N9rVg26hUz6V6BeNDcGmy4B+ggrz2fgwXuBg0kfNmqolfQAxD5wqKz
         KkSX8MPGTs3P4Msrp1PWyzdhSzswC53ZF5oKuLVDLz0NLrRRrq8znTpajozq8hDcJMy6
         o5LA3RCcvkhLCRDU1uY/kTxZ06xiULkh4+sA1uh/alDlCM+3P1iaTAwLxkJajKLLNJSH
         /tDrC9w152RldtmR1qxLOLZ6Zgn+5aTQ59I9KDGetkX/fAkvB7VDVMs4YMqQTl4ysWbS
         qvxg==
X-Gm-Message-State: AJIora+3INs8qDxHx90EdkYqjxst9rCq8MKNi8mv/vRSPT2E5wz4r6oJ
        cT2h1h9DtvFHSgthWlPpPFfKFD9rs1/apA==
X-Google-Smtp-Source: AGRyM1tr4Q/7wjlN61u7kg3rDxbkGGiiklXgznHKI+DLKjFY82VlUuDvmlBWjo3iJc/dwOrOm532CA==
X-Received: by 2002:aa7:91d3:0:b0:525:1f61:dacf with SMTP id z19-20020aa791d3000000b005251f61dacfmr2267840pfa.40.1656124086235;
        Fri, 24 Jun 2022 19:28:06 -0700 (PDT)
Received: from joebar-glaptop.lan (c-71-202-34-56.hsd1.ca.comcast.net. [71.202.34.56])
        by smtp.gmail.com with ESMTPSA id r20-20020a170902c7d400b001678898ad06sm2463928pla.47.2022.06.24.19.28.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 19:28:05 -0700 (PDT)
From:   "Joseph S. Barrera III" <joebar@chromium.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Alexandru M Stan <amstan@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        "Joseph S. Barrera III" <joebar@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH v13 0/5] arm64: dts: qcom: sc7180: Add five new trogdor-based boards
Date:   Fri, 24 Jun 2022 19:27:11 -0700
Message-Id: <20220625022716.683664-1-joebar@chromium.org>
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

Changes in v13:
- Remove 'include sc7180-trogdor.dtsi' in sc7180-trogdor-ti-sn65dsi86.dtsi.
- Add compile-time test for duplicate include in sc7180-trogdor.dtsi.

Changes in v12:
- Replace 'include sc7180.dtsi' with 'include sc7180-trogdor.dtsi'
  in sc7180-trogdor-ti-sn65dsi86.dtsi.

Changes in v11:
- Add 'include sc7180-trogdor.dtsi' to sc7180-trogdor-pazquel-* files.
- Restore 'include sc7180.dtsi' to sc7180-trogdor-ti-sn65dsi86.dtsi.
- Add 'include sc7180-trogdor.dtsi' to sc7180-trogdor-kingoftown-* files.

Changes in v10:
- Remove 'include sc7180.dtsi' from *all* sc7180-trogdor-pazquel* files.
- Move "okay" for ap_tp_i2c to proper location.
- Remove 'include sc7180.dtsi' from *all* sc7180-trogdor-kingoftown* files.

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
 .../sc7180-trogdor-wormdingler-rev0-boe.dts   |  22 +
 .../sc7180-trogdor-wormdingler-rev0-inx.dts   |  22 +
 .../qcom/sc7180-trogdor-wormdingler-rev0.dtsi |  53 +++
 ...0-trogdor-wormdingler-rev1-boe-rt5682s.dts |  29 ++
 .../sc7180-trogdor-wormdingler-rev1-boe.dts   |  28 ++
 ...0-trogdor-wormdingler-rev1-inx-rt5682s.dts |  29 ++
 .../sc7180-trogdor-wormdingler-rev1-inx.dts   |  22 +
 .../dts/qcom/sc7180-trogdor-wormdingler.dtsi  | 408 ++++++++++++++++++
 arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi  |   6 +
 27 files changed, 2091 insertions(+)
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

