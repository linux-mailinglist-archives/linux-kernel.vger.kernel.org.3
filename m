Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E096E57F623
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 19:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbiGXRY6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 13:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbiGXRY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 13:24:56 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CFDCE02B;
        Sun, 24 Jul 2022 10:24:55 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id by8so10668338ljb.13;
        Sun, 24 Jul 2022 10:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h1IRoPhmqB4vRuNc5zew/8aHo6kz9NSrPIQo4CT95z0=;
        b=HFBAY/RSVMwHp41yLNBcJR9Mlei4cUeuWcTq1wQ6+67GOfUZ5rZKFcdaXyVwAPZqeU
         +yckvJQPuphDXHZ+P73laCgp2pjKac/obFahk3ECHOcPPuf1+7ePfT/OkzNpKbs7LVn6
         pcOZrRW4jvpMrbVEJe9ZiC68tksSsaUaXO0FOSZY6EGlkWaRHGAd416tvcDP5Rr8akTw
         ZW3p3kQKBuNq9dF9HAA0cbqSgXiHWxiwD0iYpnvJ/NdxrkTZEopI4e5QXVFuyIdv/8TF
         6MqmpiY8/kqhto4VbfGfc9tabnJ99ayvbXiIt2XEgb7TtEOwStTv7ATWoFDHhh4OLBUC
         zelw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h1IRoPhmqB4vRuNc5zew/8aHo6kz9NSrPIQo4CT95z0=;
        b=1NCTnr5dU9oa4r0g5hzeMg938qk664jcHgFKBJrakrbTCdQ5FwcI6adEZb8ZTLNWDm
         mjjK7OWM1WpclhcAB3b9Gw2hBYHmuXwk8yfUwRCufya6MTOojyQm1VmyIgDE2mp/FQSj
         lk85eJbqTzOcgqIlOJh+2xhEg4d6i963ApzPdAWLdUzVYDvd1sDh9pC6Hd+lh2lJJt92
         ZkXPE/Q2PZZH7kac4HvJyf1ld6x8i8EAshR6M+iJq0on3HrTiqK7hdfc4RQ5+ZGFN8+z
         tRTB/lsXqMt/Cz7zJYvovhBjNBZOwLk95cxOFSvtLB3hQYHTU8xQMW0UleCPeaHyB5oH
         U4kg==
X-Gm-Message-State: AJIora9q+ng8Cie+rLv68Y3n//nqQGL9hfXrTsgReRYX3BadGkCmGuiD
        7HjZL00v02W3tga9pNo88izx9r+KS8RgH9TJgIk=
X-Google-Smtp-Source: AGRyM1sPpY4z7OHtGSans/kY3N5H0W/udHQiB1vf1+1mAeXFF+Kb98lTgd6rrVkoovRDxlCt9dESew==
X-Received: by 2002:a2e:3109:0:b0:25a:8a0c:40e2 with SMTP id x9-20020a2e3109000000b0025a8a0c40e2mr2868595ljx.26.1658683493774;
        Sun, 24 Jul 2022 10:24:53 -0700 (PDT)
Received: from i-vetokaappi.home.lan (dsl-hkibng42-5673c7-93.dhcp.inet.fi. [86.115.199.93])
        by smtp.gmail.com with ESMTPSA id d7-20020a19f247000000b0048a73d83b7csm1928322lfk.133.2022.07.24.10.24.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Jul 2022 10:24:53 -0700 (PDT)
From:   =?UTF-8?q?Matti=20Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        =?UTF-8?q?Matti=20Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>,
        devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stephen Boyd <sboyd@codeaurora.org>
Subject: [PATCH v3 0/3] Initial Samsung Galaxy Tab 4 10.1 (SM-T530) support
Date:   Sun, 24 Jul 2022 20:24:38 +0300
Message-Id: <20220724172442.87830-1-matti.lehtimaki@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree node for pm8226 GPIOs and support for the Samsung Galaxy
Tab 4 10.1 (SM-T530) tablet which is based on apq8026.

Changes in v3:
  - Fix sdhc_2 bus width
  - Reorder includes

Changes in v2:
  - Change codename to matisse-wifi
  - Remove msm-id from device dts
  - Rename pm8226 gpio node

Matti Lehtimäki (3):
  ARM: dts: qcom: pm8226: Add node for the GPIOs
  dt-bindings: arm: qcom: Document samsung,matisse-wifi device
  ARM: dts: qcom: Add support for Samsung Galaxy Tab 4 10.1 (SM-T530)

 .../devicetree/bindings/arm/qcom.yaml         |   1 +
 arch/arm/boot/dts/Makefile                    |   1 +
 .../dts/qcom-apq8026-samsung-matisse-wifi.dts | 469 ++++++++++++++++++
 arch/arm/boot/dts/qcom-pm8226.dtsi            |  10 +
 4 files changed, 481 insertions(+)
 create mode 100644 arch/arm/boot/dts/qcom-apq8026-samsung-matisse-wifi.dts

-- 
2.34.1

