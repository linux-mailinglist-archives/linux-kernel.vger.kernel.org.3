Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D63E44E35F5
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 02:27:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234589AbiCVB1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 21:27:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234503AbiCVB07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 21:26:59 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC624E0EC;
        Mon, 21 Mar 2022 18:25:33 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id g19so16938067pfc.9;
        Mon, 21 Mar 2022 18:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=svKeoLbw/Rh/+w0dWnKtX9ir9NmoZ2RCvIsO83FTo+k=;
        b=ii6ygNdxXF2YuMjx62GY/8lyC742aCoMJuNxD7GB602IPDTF3bwhqy5sRIcpp/gf9R
         aRfk/igL0j3xPZf8vUlPeERF5MoHg3sel33OehBQY2TArO+cMC7d54kL0Ih/Y2Go/Pd8
         9vAuGi2Qw97uN4xE9yuNwBgG2/ArTRa+H/ZdkdZZ4yesBiqNsLhu6rNyE5JKYYul3aZD
         lw6aUWZvf8mX/DBioT0JE3QkcxFDtba1kAWLtyzXxcPvD138JcruxZfpw9fiYa+OyR3+
         KgKj6aFyK5J00kYFuvBxGVNqgq6BJFafs2+PCFxYzez+se3EKCaDhHIjxhfsNmKw8eht
         X7yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=svKeoLbw/Rh/+w0dWnKtX9ir9NmoZ2RCvIsO83FTo+k=;
        b=3rQYlNiHRV3vFyjILr1R7g6mHAOV59jq2w835SFYjGGHVNB2gWwiuGxgqzhUqBtU6r
         JCcFlJvr6070vj78KwKSYdMrxTuxoWx5aLl3Bn08R1ZTRYwg3JLgtgAWo3GX1ai1WsF1
         eqdi06XIgySo5IG59VCUlTZj5As0ZkORI+d198xQMn7IdLqZP/cF//sjqVZ1mfzskxqE
         YsXt4+YgY8RO3MCd7cSfnnvx8OemAcJDLJnwphAGvHgV0C2ZueUhkYiznfDOikmq6L2T
         6V9PpoDawoMduojfSmCt8oiUBPvUhD19c2zDfsDpB7LwGWmNmSOwbSMEfTdYLRi5w3X5
         y57w==
X-Gm-Message-State: AOAM530ypz/eoyUFIdJkUFmXh5llqvgez/f9GSYr6kzQ1asTGMYd/iht
        yVUIA+qBnk6CnLEU0jIFc9PJhnIOXcMX26Bw
X-Google-Smtp-Source: ABdhPJx89klCKoXhRGT7afcgmBcOslDABbniHk+l6vDRIv723MOLQCCNT26OWRB++AlmY1gihMWOVw==
X-Received: by 2002:a05:6a00:2484:b0:4fa:997e:3290 with SMTP id c4-20020a056a00248400b004fa997e3290mr9036621pfv.37.1647912333030;
        Mon, 21 Mar 2022 18:25:33 -0700 (PDT)
Received: from localhost.localdomain (60-250-49-31.hinet-ip.hinet.net. [60.250.49.31])
        by smtp.gmail.com with ESMTPSA id z16-20020a637e10000000b00382b21c6b0bsm1230539pgc.51.2022.03.21.18.25.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 18:25:32 -0700 (PDT)
From:   Ivy Jian <ivyjian417@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     dianders@chromium.org, Ivy Jian <ivyjian417@gmail.com>,
        Pan Sheng-Liang <sheng-liang.pan@quanta.corp-partner.google.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH] arm64: dts: qcom: switch panel compatible to "edp-panel" for limozeen
Date:   Tue, 22 Mar 2022 09:25:26 +0800
Message-Id: <20220322092524.1.Ied05fc4b996737e3481861c6ab130a706f288412@changeid>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

some panel can't light up with new board with ps8640, switch compatible
panel define to make it workable.

Signed-off-by: Pan Sheng-Liang <sheng-liang.pan@quanta.corp-partner.google.com>
Signed-off-by: Ivy Jian <ivyjian417@gmail.com>
---

 .../boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r9.dts     | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r9.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r9.dts
index 4e35aec6a1e5..c44ed54af690 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r9.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r9.dts
@@ -20,7 +20,7 @@ / {
 /delete-node/&ap_ts;
 
 &panel {
-	compatible = "innolux,n116bca-ea1", "innolux,n116bge";
+	compatible = "edp-panel";
 };
 
 &sdhc_2 {
-- 
2.25.1

