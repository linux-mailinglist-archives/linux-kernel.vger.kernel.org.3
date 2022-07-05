Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 752E15670A8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 16:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233419AbiGEON2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 10:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233644AbiGEOMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 10:12:50 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD907D10A;
        Tue,  5 Jul 2022 07:06:52 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id h23so21784069ejj.12;
        Tue, 05 Jul 2022 07:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=655N3qL9/ebVsPTeBcEUzQlcpFCqTAWHIeHqk+2bjbM=;
        b=lWqhyHsxDdhyUSDYhQmUw0kcWbHIK6EhQVjAn4qoYIf0DY2n5UdrvJB0bYum0UQyX1
         5xDiJuf2QL4dUcnntahpDFYZmsf8f+WIzqb4FDHvwAqSC7QZ0pRGmNjRZBDLiNbKQWiv
         L1Imb10d4j33vv26sCeYUkrQjpKIVEanrN0Q03pAk1UJ6tTUOoxdNYD0gVL+m27tFKUs
         6bTUVyO9aLwktmBE/SCUKslz0iJufGQrrgEVNB0LykYm/2ZgO6TtAR8J60CWbur7RjgT
         4VS5yv/i6KXnpO1l/8HBrlnx3gqzKskWJEcwHksDu9Agjiy/fwzo8fa71QND2G4gUohv
         oJjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=655N3qL9/ebVsPTeBcEUzQlcpFCqTAWHIeHqk+2bjbM=;
        b=hro4LynfIJZK9VbASVReC6eOt3oJxqigehdOq3tOoUgyjuiny9qyNDMubWJkrbciQC
         TPKQPHduIg4xfIb0BJvSbNHJy7l/+/h34DYYcIvlmP/k/BrkYWLZV9wYtWAVZQTxKZFf
         hZY+AiAmZRK0z67tGcERtyaZg1x/zWn838v+LgtnBPU3yRaLuvXHMnBsrAx0RsTbGLR2
         B9Hy4A6+IVOa6EErp7h3vog1uArbKQJYnxecStDO/QeW4n6vmySbYXEo+KtXvmpml2v3
         pmw6h3K7wDK2k5+qRztMG4cmSl4I6HwFH92QjmckcQp8d4EJh5PJHclXyWDP7VyU3eYj
         bNcA==
X-Gm-Message-State: AJIora8ZBTsMl/fvm4+9QYhEuL2euRjZkGRhoQ4LARJU964L9OceO+8M
        hja0HExr0mxsN6qUrEYMvSK3enBaO1U=
X-Google-Smtp-Source: AGRyM1t8C4aHb1xJ3h51cb34Khl7C6W7J+XA+GA2TGOZIA1Q4y8zvMgjfgxb/wZhu6f5otiUgvc2GQ==
X-Received: by 2002:a17:906:51d9:b0:722:eeb2:e7f2 with SMTP id v25-20020a17090651d900b00722eeb2e7f2mr33864135ejk.519.1657029987704;
        Tue, 05 Jul 2022 07:06:27 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.googlemail.com with ESMTPSA id ku5-20020a170907788500b0072aee605e0esm399709ejc.60.2022.07.05.07.06.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 07:06:27 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH 00/13] Add ipq806x missing bindings
Date:   Tue,  5 Jul 2022 15:39:04 +0200
Message-Id: <20220705133917.8405-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series try to add some of the missing bindings for ipq806x.

This still lacks of the cpu bindings and all the bindings required
to scale cpu clk or L2. These will come later as the driver and
documentation require some changes.

So for now we try to add bindings that can directly applied without
making changes to any drivers.

Christian Marangi (13):
  ARM: dts: qcom: add multiple missing pin definition for ipq8064
  ARM: dts: qcom: add gsbi6 missing definition for ipq8064
  ARM: dts: qcom: add missing rpm regulators and cells for ipq8064
  ARM: dts: qcom: disable smb208 regulators for ipq8064-rb3011
  ARM: dts: qcom: add missing snps,dwmac compatible for gmac ipq8064
  ARM: dts: qcom: enable usb phy by default for ipq8064
  ARM: dts: qcom: reduce pci IO size to 64K for ipq8064
  ARM: dts: qcom: fix dtc warning for missing #address-cells for ipq8064
  ARM: dts: qcom: add smem node for ipq8064
  ARM: dts: qcom: add sic non secure node for ipq8064
  ARM: dts: qcom: fix and add some missing gsbi node for ipq8064
  ARM: dts: qcom: add speedbin efuse nvmem binding
  ARM: dts: qcom: remove redundant binding from ipq8064 rb3011 dts

 arch/arm/boot/dts/qcom-ipq8064-rb3011.dts |  21 +--
 arch/arm/boot/dts/qcom-ipq8064.dtsi       | 206 ++++++++++++++++++++--
 2 files changed, 198 insertions(+), 29 deletions(-)

-- 
2.36.1

