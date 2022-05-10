Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C71CF520D2E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 07:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236691AbiEJFYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 01:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231875AbiEJFYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 01:24:41 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9E46225
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 22:20:42 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id gj17-20020a17090b109100b001d8b390f77bso1125538pjb.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 May 2022 22:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yiAVlYJ6ztlaDoBnlRQCGr+0qKRwQo5un6vTJF3zwII=;
        b=FwajoCxnVrzvs7zHittmhKbuSW7XGOtckqrhWHEEv6UMPnWBd8LN9/o77ThMfLy4WA
         ynLmWEkXlbZEmCzV0qmPLQZxI2A9oMf0njaIpuQk47v7cAjifFoc0CxmQVsjreMkOUcm
         jQMdHNmpi/JeG7OAMRCHmAxXGRJlq4vLr5OSU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yiAVlYJ6ztlaDoBnlRQCGr+0qKRwQo5un6vTJF3zwII=;
        b=4qbj1Ue44kUwN1NmTnPrnOGUyQMQh66r+QSab8ynwZayy5GgIcwFl2qFGvFcjovFcM
         cuOms8YjVW+TAPZTLpuUzcYvlfF0F5621VImWsB58dKMz8QhmNNLy6i4Bx9pFQFnb8WH
         CG/zaYnwnqtSdwak7o/Eub2P5nyBmXwPdv8Ekt2fohtDxJzSDLpg3N/4IpHQh21nVpuX
         KaN4YL1ZWPDK8G+zQ/j2X0hFipTwmg8OuvbjSoy6l7i8YWEWs9bgb/kOgTK9tBy6Pf/h
         2aa03Sofp3OyHYLqpjDUJSy8fhT/qyMxoNpdQLMtfYAXKR2RzJbspnzx9S3J32ltvVJ4
         ZlvA==
X-Gm-Message-State: AOAM530YWrgPEvnFeY89ORPE0FSPIMKwywbhZxtQL7OXaki67RdxdD3B
        NKYTv+a1j4FQcluJ5MhwBS7yB4pJoHZrJw==
X-Google-Smtp-Source: ABdhPJwjxXu3ddCJhjoeoEoaYD7lnb8OWIcUfXchwaz/AQ8XpTwpemaQQMCGOyJ1gvv8Tz/eeC5c3Q==
X-Received: by 2002:a17:90b:33c6:b0:1dc:ba92:41bb with SMTP id lk6-20020a17090b33c600b001dcba9241bbmr21041517pjb.26.1652160042077;
        Mon, 09 May 2022 22:20:42 -0700 (PDT)
Received: from localhost ([2401:fa00:9:14:4f4c:708e:ab00:6543])
        by smtp.gmail.com with UTF8SMTPSA id bi10-20020a170902bf0a00b0015e8d4eb1fcsm898377plb.70.2022.05.09.22.20.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 May 2022 22:20:41 -0700 (PDT)
From:   Eizan Miyamoto <eizan@chromium.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Eizan Miyamoto <eizan@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH] arm64: dts: mt8173: add aliases for mt8173 mmc device nodes
Date:   Tue, 10 May 2022 15:20:30 +1000
Message-Id: <20220510152020.1.I6094f0a935212eabc7d9348d6cb5a2517ccc2514@changeid>
X-Mailer: git-send-email 2.36.0.512.ge40c2bad7a-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Doing this makes them get enumerated in a deterministic order so that
the assigned name in /dev that the mmc devices get assigned is
consistent across reboots.

See ead9f7d7ea9 ("arm64: dts: qcom: sc7180: Assign numbers to eMMC and
SD") for similar work.

Signed-off-by: Eizan Miyamoto <eizan@chromium.org>
---

 arch/arm64/boot/dts/mediatek/mt8173.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
index 6b02cff605fbe..9f3cd54116de9 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -55,6 +55,10 @@ aliases {
 		serial1 = &uart1;
 		serial2 = &uart2;
 		serial3 = &uart3;
+		mmc0 = &mmc0;
+		mmc1 = &mmc1;
+		mmc2 = &mmc2;
+		mmc3 = &mmc3;
 	};
 
 	cluster0_opp: opp_table0 {
-- 
2.36.0.512.ge40c2bad7a-goog

