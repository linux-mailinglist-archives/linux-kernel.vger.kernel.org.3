Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C30154B8FE7
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 19:10:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237456AbiBPSKn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 13:10:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237455AbiBPSKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 13:10:41 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09F3B2B0B1A
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 10:10:28 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id f37so5354882lfv.8
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 10:10:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IcjZSFFwvzH/2up3CoXhhR79DVF3xC2YmgnlBmig55Y=;
        b=w0bfYwr/yIGgKsMa1Lc2zzEf7dvcqLF1kzRhwu0wytHvdRAS+simDuAOgxyM7Vwzu9
         tlA5U3ssSqPOn3EMDTDRu2aq9oU+7vOWm6Roq0/pqSQOMdVBM3gbeduVwjmbT2DHWVMb
         q9D5CEfQHC+J+H/Y7rnP2d/ViEGlk215M49G6LxjPZ3Yv1Gz1UZBEOmnRjhgIuqmvUgU
         C8Eiuf2J1pQ6sjyI8nRt/GyZ2yP3Kbqx5fXJXA3lcicj7pPDK7CF//nRb9Wy/Et7Qb1y
         iIZdq5bvjNBVYdqRcmCwQjysllfixuxZE6Oo5rcbxX4XfaY1rB9fH43GUQvoq0ccjNTB
         HcQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IcjZSFFwvzH/2up3CoXhhR79DVF3xC2YmgnlBmig55Y=;
        b=qmffeHr/gDpLUxQnD89tst+Wq1P2G99mtT/GoR+0CwnA5+zHExjvvpZcleUEc0Z272
         kvSU8XI/8Tz1xbcnoB3no99VPX4ngIaH64hGTxbPncb8G8QEODNgsV9UBwoKt/tMPQms
         0+LNMNZSzWE3D3Z1H9ijOo7hD4/3m5G7im6YOaUgxIUCZD0nY/hG4WRYWvHQPud/NSGE
         xdIlGZJqWd3TVMcu6ponUl2HXReZwWquxOK5wqDON/VGoNLP7ecNHRHm6/lMYtX02eYC
         uXUqzaGX4/ZEJqrIeFYDFiwY8m7c5NxPPlCY38uKDRO9OtZXoSTLpHM2q7lJn+C6+4dw
         nDog==
X-Gm-Message-State: AOAM531rTi9XU40W4MLHviROV60mNsoGIaGcJkGc9udRzZxiW6lwCt/X
        Yf2n7A4mlvAtEDmYg7MwIhB46w==
X-Google-Smtp-Source: ABdhPJyHHJ2z98x3FxWyYQVGxbdwLK7ZNxTg/1MKt2UFEenBVMHIcz9Wxy7OW5QZqcMRz5JB8DYs3Q==
X-Received: by 2002:a05:6512:1507:b0:443:7e88:ce57 with SMTP id bq7-20020a056512150700b004437e88ce57mr2877346lfb.659.1645035026383;
        Wed, 16 Feb 2022 10:10:26 -0800 (PST)
Received: from cobook.home (nikaet.starlink.ru. [94.141.168.29])
        by smtp.gmail.com with ESMTPSA id y18sm567909ljd.13.2022.02.16.10.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 10:10:25 -0800 (PST)
From:   Nikita Yushchenko <nikita.yoush@cogentembedded.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Subject: [PATCH] arm64: dts: renesas: ulcb-kf: fix wrong comment
Date:   Wed, 16 Feb 2022 21:10:04 +0300
Message-Id: <20220216181003.114049-1-nikita.yoush@cogentembedded.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix comment referencing salvator board, likely a copy-paste leftover.

ulcb-kf.dtsi has nothing to do with salvator.

Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
---
 arch/arm64/boot/dts/renesas/ulcb-kf.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/renesas/ulcb-kf.dtsi b/arch/arm64/boot/dts/renesas/ulcb-kf.dtsi
index d122e645a892..40147920bdf7 100644
--- a/arch/arm64/boot/dts/renesas/ulcb-kf.dtsi
+++ b/arch/arm64/boot/dts/renesas/ulcb-kf.dtsi
@@ -413,7 +413,7 @@ &sound_clk_pins
 		     &sound_pcm_pins>;
 
 	ports {
-		/* rsnd_port0/1 are on salvator-common */
+		/* rsnd_port0/1 are defined in ulcb.dtsi */
 		rsnd_port2: port@2 {
 			reg = <2>;
 			rsnd_for_pcm3168a_play: endpoint {
-- 
2.30.2

