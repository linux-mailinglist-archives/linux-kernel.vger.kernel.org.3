Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBD90557E5B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 16:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231984AbiFWO6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 10:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231556AbiFWO6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 10:58:44 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B496725285
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 07:58:42 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id u15so13980225ejc.10
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 07:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y3C1rVPk3dPdQBmkyB1J9bluo/i+1VAHektHpfoJOfg=;
        b=eVaMHAr2oC82IAagxnteHFSDcz7RlK0q2TZUuHIizv2N5Kq5o9RBYn/2V1MywyL6i3
         QdvHiX21MNjDcFOs1BNL08YsmRqqaK2gHafg2vinVJWoSAzyueB8pPLhYNI5LG0nB9r/
         vV5y7JVBLEqNCeAkpLHApqchL5gU6ZszSf9o9VN3nXvz8xfZ5Dck4nLvPRMdeXuEmjQj
         qipaYGlOKb/1pUDtZIDAwncuSheh1K6YvswOOoQ2j9RZRr0gxegpYYBEeNAe3YydJ/hb
         SnVN4vWa+HZ1pqlzp2+Si1/DLDAUNA7xyvZQLkPZw57CKTEt0lN3p7t8bcF2jYk6fAjv
         9j7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y3C1rVPk3dPdQBmkyB1J9bluo/i+1VAHektHpfoJOfg=;
        b=7O3CUCXBnay8F78qewHTTBVVCtfsJbvvHvNZfOsvhyOrtiwEGOWgEwEIBFg+zem8Hf
         U2a95Fe4XJorOpAUS7xpTnOMQ9c7BULVF22rMuj0dknmBq21nx4JuSSG2NMjlJu+pMM1
         xYaqCiEimeGXgnJUF3jJLEkm/HIqAYQmestR358V+PfYjs4xI+5sDRa3Eet+FiikHXEY
         MznX0+EPZUACf8LsQwarfD1cCgK33oefg9ggSvfpDxs8XUv4jS+B/HtfVITy6mSQISOU
         H9p4F42NadYG29johRBd3Zbo7hStbuWTo7cDZ4Dus+FAlVGO6AnKQ9rjxr1L0zEs/4+n
         legw==
X-Gm-Message-State: AJIora+909L5A6Qd6AcJM2XKbu3WIsmoHKKGop+kzxWl/IQ+6ehFuVKz
        NX+nODcvr72TZ97K8RKrmMoYRQ==
X-Google-Smtp-Source: AGRyM1sci6mwJozc2hMmlhymIpKJZRmDhVDXZoRmJzbimMA7FpKYPx4rRJO+hTuNriUckbfyZ4eqSA==
X-Received: by 2002:a17:907:9816:b0:726:2b90:4bab with SMTP id ji22-20020a170907981600b007262b904babmr939600ejc.544.1655996321231;
        Thu, 23 Jun 2022 07:58:41 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id c18-20020a05640227d200b0042617ba6396sm18238783ede.32.2022.06.23.07.58.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 07:58:40 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-arm-msm@vger.kernel.org
Subject: [GIT PULL] dt-bindings: qcom for v5.20
Date:   Thu, 23 Jun 2022 16:58:37 +0200
Message-Id: <20220623145837.456817-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

Hi Rob and Bjorn,

I am fixing/improving quite a lot of Qualcomm bindings and I produced several
separate patchsets. They wait on mailing list for quite a long time, in some
cases two months, so I decided to grab all them and send in one organized pull.

All patches here got Rob's ack.

This also brings compatibles for Qualcomm boards, therefore it might be
desirable to merge everything through Bjorn's tree, however at this point I
want to just get it merged as fast as possible, because I am really afraid they
will miss the v5.20 cycle.  Therefore the pull is towards Rob, but maybe
First-comes-first-served is also good approach.

Best regards,
Krzysztof


The following changes since commit f2906aa863381afb0015a9eb7fefad885d4e5a56:

  Linux 5.19-rc1 (2022-06-05 17:18:54 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-dt.git tags/dt-bindings-qcom-5.20

for you to fetch changes up to f9702486c77ba74f65859098e3d8e4bdb2e8a745:

  dt-bindings: arm: qcom: add missing SM6350 board compatibles (2022-06-22 10:11:34 +0200)

----------------------------------------------------------------
Devicetree bindings for Qualcomm for v5.20

Cleanup, fixes and additions of missing pieces for Qualcomm bindings.
These are address dtbs_check warnings and do not bring new hardware
(new compatibles are added for existing boards/hardware).

----------------------------------------------------------------
Krzysztof Kozlowski (24):
      dt-bindings: soc: qcom,rpmh-rsc: simplify qcom,tcs-config
      spi: dt-bindings: qcom,spi-geni-qcom: allow three interconnects
      dt-bindings: soc: qcom: aoss: document qcom,sm8450-aoss-qmp
      dt-bindings: soc: qcom: qcom,smd-rpm: add power-controller
      dt-bindings: nvmem: qfprom: add IPQ8064 and SDM630 compatibles
      dt-bindings: leds: qcom-wled: fix number of addresses
      dt-bindings: arm: qcom: fix Alcatel OneTouch Idol 3 compatibles
      dt-bindings: arm: qcom: fix Longcheer L8150 compatibles
      dt-bindings: arm: qcom: fix MSM8916 MTP compatibles
      dt-bindings: arm: qcom: fix MSM8994 boards compatibles
      dt-bindings: arm: qcom: add missing MSM8916 board compatibles
      dt-bindings: arm: qcom: add missing MSM8994 board compatibles
      dt-bindings: arm: qcom: add missing SM8150 board compatibles
      dt-bindings: arm: qcom: add missing SM8250 board compatibles
      dt-bindings: arm: qcom: add missing SM8350 board compatibles
      dt-bindings: vendor-prefixes: add Shift GmbH
      dt-bindings: arm: qcom: add missing MSM8998 board compatibles
      dt-bindings: arm: qcom: add missing MSM8992 board compatibles
      dt-bindings: arm: qcom: add missing QCS404 board compatibles
      dt-bindings: arm: qcom: add missing SDM630 board compatibles
      dt-bindings: arm: qcom: add missing SDM636 board compatibles
      dt-bindings: arm: qcom: add missing SDM845 board compatibles
      dt-bindings: arm: qcom: add missing SM6125 board compatibles
      dt-bindings: arm: qcom: add missing SM6350 board compatibles

 Documentation/devicetree/bindings/arm/qcom.yaml    | 108 +++++++++++++++++++--
 .../bindings/leds/backlight/qcom-wled.yaml         |   9 +-
 .../devicetree/bindings/nvmem/qcom,qfprom.yaml     |   2 +
 .../bindings/soc/qcom/qcom,aoss-qmp.yaml           |   1 +
 .../bindings/soc/qcom/qcom,rpmh-rsc.yaml           |  33 +++----
 .../devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml |   3 +
 .../bindings/spi/qcom,spi-geni-qcom.yaml           |   5 +-
 .../devicetree/bindings/vendor-prefixes.yaml       |   2 +
 8 files changed, 133 insertions(+), 30 deletions(-)
