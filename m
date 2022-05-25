Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC41533F70
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 16:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232715AbiEYOol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 10:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232038AbiEYOof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 10:44:35 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70BF4A7E21
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 07:44:33 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id n10so42159422ejk.5
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 07:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GC8ExN7zgyMEJWd9pL4zC+r85cZkPtnN1cqYEwb1TYQ=;
        b=iWzN+qaN44xR2/Ui8/XVBZAWL1dNaHgp8yovlEXubsFnybVGy66n2ADXP6AH90/Gl+
         Ed6MV5jipQDiHQylU2s/8hWxdE9rxrx8FIv/TYRZnJx4b6LCPlY3MhgFG2HGwZvnZ1M6
         oSgvSVLTAB8MsdiOgqIrn4NAWc5rBTeHuOm99rx58g/IhFhyxjOZRVHQIbn9dIBRRCUj
         2iu+zfDmyzLpQd4P+73ktua1wl67KzOj9FXV0eZWNh+jY1JBwL2udNTzMatX5zOAKLRw
         JJuiNVqWp60WD2uUMjxMxWdjwsK0w4jAriC1aJ2nkMhpbwOOrylSxkRVom0GoN25adzA
         H3qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GC8ExN7zgyMEJWd9pL4zC+r85cZkPtnN1cqYEwb1TYQ=;
        b=ICwXU79xnBtV8oyJfnrlutHG/KyCbduf4zVWsR5FmnozCE5N2QtcGZvszI/pbNNTkY
         AGfUU1bnxXkHowBre1537YtPTvhjrwUb97XT/OQnsMhOy4nYHqhvSXVOt2/a4XznGC/1
         qjMqSXKDBqTX3+WhKYy4zp079bVExIUrnJIX+tJKH3A094D9W0nAvxfoiOWPZYXtnw0m
         FN1Qv145sGZSFcrctCyipvxy9/iYH7mp3xQ3r8oYHYBheVS76mzmmcrtGPXKn7JZOmEt
         VeB4nxq1bEa1JCbD1PQaYnSfQ5y70purJR0kLhR0cbUAISRhhU7U2yY15AHvfDXAcWD+
         GY0A==
X-Gm-Message-State: AOAM530HtELc+EbnFfhHCJFiJxK+AGgC5GU1enRK1Ce6XgT9aMUBJccE
        vPG1IAcCoxigivTLX3Ojbjlrcg==
X-Google-Smtp-Source: ABdhPJxmnf+tkmH++ly72dkYx+WDxOisAzmzCy24zFOca1/p18mEgeDDhSek1pEVsT43mA8YMvb/zA==
X-Received: by 2002:a17:906:d550:b0:6ff:1eb1:69e9 with SMTP id cr16-20020a170906d55000b006ff1eb169e9mr255ejc.663.1653489871936;
        Wed, 25 May 2022 07:44:31 -0700 (PDT)
Received: from otso.. (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id r2-20020a170906550200b006f3ef214de1sm8159596ejp.71.2022.05.25.07.44.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 07:44:31 -0700 (PDT)
From:   Luca Weiss <luca.weiss@fairphone.com>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Luca Weiss <luca.weiss@fairphone.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        devicetree@vger.kernel.org,
        Georgi Djakov <georgi.djakov@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Odelu Kukatla <okukatla@codeaurora.org>
Subject: [PATCH v3 0/5] Add interconnect support for SM6350
Date:   Wed, 25 May 2022 16:43:56 +0200
Message-Id: <20220525144404.200390-1-luca.weiss@fairphone.com>
X-Mailer: git-send-email 2.36.1
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

This series adds interconnect support for the various NoCs found on
sm6350.

A more special modification is allowing child NoC devices, like done for
rpm-based qcm2290 which was already merged, but now for rpmh-based
interconnect.

See also downstream dts:
https://android.googlesource.com/kernel/msm-extra/devicetree/+/refs/tags/android-11.0.0_r0.81/qcom/lagoon-bus.dtsi

Luca Weiss (5):
  interconnect: qcom: icc-rpmh: Support child NoC device probe
  dt-bindings: interconnect: qcom: Split out rpmh-common bindings
  dt-bindings: interconnect: Add Qualcomm SM6350 NoC support
  interconnect: qcom: Add SM6350 driver support
  arm64: dts: qcom: sm6350: Add interconnect support

 .../interconnect/qcom,rpmh-common.yaml        |  43 ++
 .../bindings/interconnect/qcom,rpmh.yaml      |  22 +-
 .../interconnect/qcom,sm6350-rpmh.yaml        |  82 +++
 arch/arm64/boot/dts/qcom/sm6350.dtsi          | 109 ++++
 drivers/interconnect/qcom/Kconfig             |   9 +
 drivers/interconnect/qcom/Makefile            |   2 +
 drivers/interconnect/qcom/icc-rpmh.c          |   4 +
 drivers/interconnect/qcom/sm6350.c            | 493 ++++++++++++++++++
 drivers/interconnect/qcom/sm6350.h            | 139 +++++
 .../dt-bindings/interconnect/qcom,sm6350.h    | 148 ++++++
 10 files changed, 1034 insertions(+), 17 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,rpmh-common.yaml
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sm6350-rpmh.yaml
 create mode 100644 drivers/interconnect/qcom/sm6350.c
 create mode 100644 drivers/interconnect/qcom/sm6350.h
 create mode 100644 include/dt-bindings/interconnect/qcom,sm6350.h

-- 
2.36.1

