Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2813510E87
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 04:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357047AbiD0CGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 22:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349881AbiD0CGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 22:06:51 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B2A04BB86
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 19:03:42 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id k4so358415plk.7
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 19:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Wc+2XZPEQYFH8y8VTjcF8pWwSz487fhH3cfdOdvAYWY=;
        b=mZ8usUoirqcoTx9Hs24a9CJ/Vus3WeuHhFuyQW79gUnyF0wurc/Bx6DpY9EEYitYiy
         x5OBFxn8PVsSVmB6f4nEvvHOMR5x7akAdh5p/MaEh2aopCQAWSZ2X2q56b0xG/M04sZF
         1BteDlHlgMMv6dDVmdphUnP04lkZfHxtWaNgg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Wc+2XZPEQYFH8y8VTjcF8pWwSz487fhH3cfdOdvAYWY=;
        b=bP3Q+eDvb9+jt8Q7wk0y6zmBas3Jabe+y7h2vvsg1+59vAq3TFiEjh8KbT1Nr7Xouv
         VvtkeAl0m2jjI1rC7t+Dti6zW3Elp84RIE6rSeZ89O5iKjAtDLJ4X4UU4ncZWSSSop04
         O8M4JqT02gVOsJ4MNz947ql8AbBKv8OFNHPobgrwIWjyB3t5smDd7cJQi1a/5LBwXnai
         CloZSiFOtmt1w514t4ZnH35Pkz/EE7SA1ZG9nezJXm3hBd4zxI3XA7aUisdWtTEr02L3
         MGmWDjIITm6J4GFdrnxkm4la45TSKu3xiv9FVHdsNOyQZ2XdQUX5uoPk4n5NU2Kdwm19
         ZbVw==
X-Gm-Message-State: AOAM531yMEgVthpCB22h2sJqBuZlNC4qJAP23N2lxZdSuE3LH1+Ja6pW
        WCYAxflUZhUep/gr1x93vJwNdQAtKuSLCA==
X-Google-Smtp-Source: ABdhPJwbzaogkQCtlbv1RZNPvF9OcQIiCWJ5G1M9CMws5WnO3sCYZskphMfOjbW7oZHd3/44RVMyZw==
X-Received: by 2002:a17:90a:3d02:b0:1ca:7f92:1bf1 with SMTP id h2-20020a17090a3d0200b001ca7f921bf1mr41124131pjc.177.1651025021797;
        Tue, 26 Apr 2022 19:03:41 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:482e:60bc:84d1:bf5c])
        by smtp.gmail.com with ESMTPSA id g15-20020a056a0023cf00b004e17e11cb17sm18324197pfc.111.2022.04.26.19.03.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 19:03:41 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        linux-arm-msm@vger.kernel.org,
        "Joseph S. Barrera III" <joebar@chromium.org>,
        Douglas Anderson <dianders@chromium.org>
Subject: [PATCH v2 0/3] arm64: dts: qcom: sc7180-trogdor: Simplify!
Date:   Tue, 26 Apr 2022 19:03:36 -0700
Message-Id: <20220427020339.360855-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.36.0.rc2.479.g8af0fa9b8e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a couple patches to simplify sc7180-trogdor dtsi files further.
There will be logical conflicts with the wormdingler patch because it
will need to have similar changes done for the swizzle and include, but
that can be cleaned up later or I can resend if the wormdingler patch
gets merged first. Either way nothing will be broken from what I can
tell.

I compiled these and diffed the dtbs before and after and found no
changes.

Changes from v1 (https://lore.kernel.org/r/20220325234344.199841-1-swboyd@chromium.org):
 * Another patch to move around sc7180.dtsi includes
 * Fixed trackpad for trogdor-r1 and pompom
 * Made spi0/spi6 patch not as aggressive

Stephen Boyd (3):
  arm64: dts: qcom: sc7180-trogdor: Simplify trackpad enabling
  arm64: dts: qcom: sc7180-trogdor: Simplify spi0/spi6 labeling
  arm64: dts: qcom: Only include sc7180.dtsi in sc7180-trogdor.dtsi

 arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi   | 11 +----------
 .../boot/dts/qcom/sc7180-trogdor-homestar-r2.dts      |  2 +-
 .../boot/dts/qcom/sc7180-trogdor-homestar-r3.dts      |  2 +-
 .../boot/dts/qcom/sc7180-trogdor-homestar-r4.dts      |  2 +-
 arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi |  7 -------
 .../qcom/sc7180-trogdor-lazor-limozeen-nots-r5.dts    |  2 +-
 .../qcom/sc7180-trogdor-lazor-limozeen-nots-r9.dts    |  2 +-
 .../dts/qcom/sc7180-trogdor-lazor-limozeen-r4.dts     |  2 +-
 .../dts/qcom/sc7180-trogdor-lazor-limozeen-r9.dts     |  2 +-
 arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r0.dts  |  2 +-
 arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1.dts  |  2 +-
 .../boot/dts/qcom/sc7180-trogdor-lazor-r3-kb.dts      |  2 +-
 .../boot/dts/qcom/sc7180-trogdor-lazor-r3-lte.dts     |  2 +-
 arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3.dts  |  2 +-
 .../boot/dts/qcom/sc7180-trogdor-lazor-r9-kb.dts      |  2 +-
 .../boot/dts/qcom/sc7180-trogdor-lazor-r9-lte.dts     |  2 +-
 arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9.dts  |  2 +-
 arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor.dtsi    |  7 ++++---
 arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom.dtsi   |  9 ++++-----
 arch/arm64/boot/dts/qcom/sc7180-trogdor-r1.dts        |  9 ++++-----
 arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi          |  8 ++++----
 21 files changed, 32 insertions(+), 49 deletions(-)

Cc: "Joseph S. Barrera III" <joebar@chromium.org>
Cc: Douglas Anderson <dianders@chromium.org>

base-commit: f238ff81e8946540e1a7c1496aa92fa2386893dc
-- 
https://chromeos.dev

