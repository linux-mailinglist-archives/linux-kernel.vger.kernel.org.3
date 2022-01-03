Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BBCC48367C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 18:56:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233960AbiACR4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 12:56:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233911AbiACR4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 12:56:43 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D8B1C061784
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jan 2022 09:56:43 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id j18so71324206wrd.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jan 2022 09:56:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=neH7i+26OYLpeC5cMlHViFNMwrfPO3xPJ5Z7DAt5pN8=;
        b=XvTHDJevsy0ZSrMi+se2sklxBwlITB/hybQLSG/lMV6WXD0xQn+yILwcirk/NVHH8N
         y5cSTYrKo/Z515VeTJsDn3ON6gufP4KRJNeoc3luWerqUVvGFkKB06JcyTcrTCIl9l/M
         ygPKlJgUlChyH36b8GV0ox/Isxi8z+lV1ckPQPQwDphX+q42mcFH3qe18mDTe+OGrF2+
         QyVmUvkcCSigenymoDPRF6E8uDgEnoyqfXlM77ZRQn26WSGFn9RyGSrbmDd1zy/Dm7LT
         0Y5Wfi/pkxGViP79Io2eyNB5PH2dc04N5zhpKGpYuXUmB0YGFnVUWaNDI0AXO5xtoZjW
         vcVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=neH7i+26OYLpeC5cMlHViFNMwrfPO3xPJ5Z7DAt5pN8=;
        b=UnI35PbXM3GRLKEVmwjoUhWgCtBkHP7jp7XeoNbk+fpZ6J5YGHHVB2r6Wie63zjKzH
         F8V7s7TwEPQ4oI5JtiRk7vOvLTAXYfIvtRvAEzkCTMl+nyA6uyxh2okNPzVuwCfZb9S5
         AJBl/R8Psk5NAmf8g3crvJEd5BtLm1r9DtYGvHxhBQDoYoIyd4COlvb/wswup4TDeiiO
         WcS348RZ3oi6s/Z7QB7Zk5G9GuaCZ23KYHCjKk4LeITSZlIUqimz/qRrT11mee8/V2KK
         vFIiUNYIYOP3NqZxcIZ3MuloQspDnCvwRQQvCZNfdgQjy2YRzj19NXwzpnjBHeSG0Za1
         3Wsg==
X-Gm-Message-State: AOAM5316JqvvcimmKbef0RIo79Dk4wEE9UMSf4n1abqkfW3EYaH5tnmo
        vNJUqzn9CU7IagyHCMCThbuksg==
X-Google-Smtp-Source: ABdhPJw7NRuoQzYialN/ofxRojlC+rMlNFgTAaoktigERArvcxUcZfxMwsO4ZIqBe2qOY/2d56FPug==
X-Received: by 2002:a05:6000:2a4:: with SMTP id l4mr40910111wry.460.1641232601515;
        Mon, 03 Jan 2022 09:56:41 -0800 (PST)
Received: from localhost.localdomain ([2001:861:44c0:66c0:7c9d:a967:38e2:5220])
        by smtp.gmail.com with ESMTPSA id f13sm35763228wri.51.2022.01.03.09.56.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jan 2022 09:56:40 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     davem@davemloft.net, devicetree@vger.kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-oxnas@groups.io,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next 1/3] dt-bindings: net: oxnas-dwmac: Add bindings for OX810SE
Date:   Mon,  3 Jan 2022 18:56:36 +0100
Message-Id: <20220103175638.89625-2-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220103175638.89625-1-narmstrong@baylibre.com>
References: <20220103175638.89625-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add SoC specific bindings for OX810SE support.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 Documentation/devicetree/bindings/net/oxnas-dwmac.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/oxnas-dwmac.txt b/Documentation/devicetree/bindings/net/oxnas-dwmac.txt
index d7117a22fd87..27db496f1ce8 100644
--- a/Documentation/devicetree/bindings/net/oxnas-dwmac.txt
+++ b/Documentation/devicetree/bindings/net/oxnas-dwmac.txt
@@ -9,6 +9,9 @@ Required properties on all platforms:
 - compatible:	For the OX820 SoC, it should be :
 		- "oxsemi,ox820-dwmac" to select glue
 		- "snps,dwmac-3.512" to select IP version.
+		For the OX810SE SoC, it should be :
+		- "oxsemi,ox810se-dwmac" to select glue
+		- "snps,dwmac-3.512" to select IP version.
 
 - clocks: Should contain phandles to the following clocks
 - clock-names:	Should contain the following:
-- 
2.25.1

