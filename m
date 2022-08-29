Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3878C5A5222
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 18:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbiH2QuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 12:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbiH2QuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 12:50:17 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB20D4E623
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 09:50:15 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id u9-20020a17090a1f0900b001fde6477464so2143463pja.4
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 09:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=WdT08CN76zbi8+HJMBir9MGBrfnlLBceDmXsuG7Luf4=;
        b=EMjaz9gf/N0gQmFFKxu/k4K51Yv5rhEtOECIFUfnOwlSFz//c1if/lWbGti1g++PgF
         vovlJeXhMuV/Kg32YDwUDEF2qq5gzLr1/Low3JTovpnfvOOJn17fKdur0SaqG1lfllLQ
         sahRUUv5AtWW0Bfnm4cchhFM6e1XsIB9U7LBI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=WdT08CN76zbi8+HJMBir9MGBrfnlLBceDmXsuG7Luf4=;
        b=mVifPjDBd4cQKSh8lggxRRseuB92v+JChzOXp04u6Sd9FdJ8cXcPUWKgOQFyMGRyxO
         ISH+yLSu2tOyu5SYLKWVzDiQF1bVZ+6yKBTcjk975ZfT8xkYW0MIg2L0EB8BrRR7x83u
         oXnjL5EhsAbldAKrRzkAvjf/xTbdyOKDAvY6LQpfYtReHyfdx3xuJWOMxH3TTLApgjKc
         yq+6PvlhCFqvL/3RHLiKQqQxjtgzltXKozCkAgfZabbc81osvXA5T/PMTbOYOEkCehQG
         VQsF3n+GgMRMu8vYcb4gxRNi+6hmKTTnIHHrXxI63uFxFQ3AfPOwpnQLsV97E1YhpEGe
         neSQ==
X-Gm-Message-State: ACgBeo3xowvP7/5jQ8pW3YTpRO9IEy7lpeq2zMxa8qKtlBWLvgKwFeAc
        v6QDIu6SOU8gT/TBu/RJT7oBcw==
X-Google-Smtp-Source: AA6agR5ONM0EJ0ckVKXOoExo0SlM47RX05dxXydyqejOpni7qbFt3KJIbwDyhyRMfhnfw1mtUBmLUA==
X-Received: by 2002:a17:902:f684:b0:172:d54d:6f9e with SMTP id l4-20020a170902f68400b00172d54d6f9emr17386370plg.174.1661791815325;
        Mon, 29 Aug 2022 09:50:15 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:3a97:5017:7e33:8964])
        by smtp.gmail.com with ESMTPSA id l1-20020a170902f68100b001729db603bcsm7864238plg.126.2022.08.29.09.50.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 09:50:14 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Johan Hovold <johan@kernel.org>,
        Andrew Halaney <ahalaney@redhat.com>,
        Mark Brown <broonie@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/6] arm64: dts: qcom: Fix broken regulator spec on RPMH boards
Date:   Mon, 29 Aug 2022 09:49:46 -0700
Message-Id: <20220829164952.2672848-1-dianders@chromium.org>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prior to commit efb0cb50c427 ("regulator: qcom-rpmh: Implement
get_optimum_mode(), not set_load()") several boards were able to
change their regulator mode even though they had nothing listed in
"regulator-allowed-modes". After that commit (and fixes [1]) we'll be
stuck at the initial mode. Discussion of this (again, see [1]) has
resulted in the decision that the old dts files were wrong and should
be fixed to fully restore old functionality.

This series attempts to fix everyone. I've kept each board in a
separate patch to make stable / backports work easier.

Affected boards were found with:
  rpmh_users=$(git grep -l -i rpmh -- arch/arm*/boot/dts/qcom)
  set_modes=$(grep -l regulator-allow-set-load ${rpmh_users})
  but_no_allowed_modes=$(grep -l -v regulator-allowed-modes ${set_modes})

Fix was applied with:
  for f in ${but_no_allowed_modes}; do
    sed -i~ -e \
      's/^\(\s*\)regulator-allow-set-load;/\1regulator-allow-set-load;\n\1regulator-allowed-modes =\n\1    <RPMH_REGULATOR_MODE_LPM\n\1     RPMH_REGULATOR_MODE_HPM>;/'\
      $f
  done

Then results were manually inspected. In one board I removed a
"regulator-allow-set-load" from a fixed regulator since that was
clearly wrong.

v2 of this series adds tags and also rebases atop Johan's series [2]
as requested [3]. This ends up turning the series into a 6-part series
instead of a 7-part one.

It should also be noted that as of the v2 posting that the related
regulator fixes have all landed in the regulator tree.

[1] https://lore.kernel.org/r/20220824142229.RFT.v2.2.I6f77860e5cd98bf5c67208fa9edda4a08847c304@changeid
[2] https://lore.kernel.org/r/20220803121942.30236-1-johan+linaro@kernel.org/
[3] https://lore.kernel.org/r/YwhwIX+Ib8epUYWS@hovoldconsulting.com/

Changes in v2:
- Added note about removing regulator-allow-set-load from vreg_s4a_1p8
- Rebased atop ("...: sa8295p-adp: disallow regulator mode switches")
- Rebased atop ("...: sc8280xp-crd: disallow regulator mode switches")

Douglas Anderson (6):
  arm64: dts: qcom: sa8155p-adp: Specify which LDO modes are allowed
  arm64: dts: qcom: sa8295p-adp: Specify which LDO modes are allowed
  arm64: dts: qcom: sc8280xp-crd: Specify which LDO modes are allowed
  arm64: dts: qcom: sm8150-xperia-kumano: Specify which LDO modes are
    allowed
  arm64: dts: qcom: sm8250-xperia-edo: Specify which LDO modes are
    allowed
  arm64: dts: qcom: sm8350-hdk: Specify which LDO modes are allowed

 arch/arm64/boot/dts/qcom/sa8155p-adp.dts            | 13 ++++++++++++-
 arch/arm64/boot/dts/qcom/sa8295p-adp.dts            | 12 ++++++++++++
 arch/arm64/boot/dts/qcom/sc8280xp-crd.dts           |  6 ++++++
 .../boot/dts/qcom/sm8150-sony-xperia-kumano.dtsi    |  6 ++++++
 .../arm64/boot/dts/qcom/sm8250-sony-xperia-edo.dtsi |  6 ++++++
 arch/arm64/boot/dts/qcom/sm8350-hdk.dts             | 12 ++++++++++++
 6 files changed, 54 insertions(+), 1 deletion(-)

-- 
2.37.2.672.g94769d06f0-goog

