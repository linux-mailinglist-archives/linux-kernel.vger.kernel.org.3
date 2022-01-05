Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6A48485864
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 19:32:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242971AbiAEScp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 13:32:45 -0500
Received: from mail-oi1-f178.google.com ([209.85.167.178]:41787 "EHLO
        mail-oi1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242965AbiAEScm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 13:32:42 -0500
Received: by mail-oi1-f178.google.com with SMTP id j185so196500oif.8;
        Wed, 05 Jan 2022 10:32:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PocIE64uh5JWgCvEKQyp40PlRHiC6zkaJ1QlGpl9xKU=;
        b=JUipW7MJV74hcF8N+k2MkQfR4dkUt7oN1EuakbkA2P8AlwKQ+NgjZIHahL/4S781ty
         LIymMJ45wbKZxV5jtz+uo8w4elN1I20FpIts71N82s0R6nP60hjD8nBRcrmNFo9nT4sB
         edR2X4dNq5Blra1gwJeRDFXCvQl9La7F+YpW5VcZFL7MZMc1aG6JZecK6CLw9H346EQ+
         ObUeUrJupYzax0b0Gsz022Yl8pvk7msyE18b32epFu4zq8+GtXY9no6vKG/bhVVknK6b
         ygRU2s0Bef4OlV/n0yiau2wzJWr6PgWLJjlw4lfjuoySk+DF/tIf4kZCtflvDE/Sb2J7
         A4Yw==
X-Gm-Message-State: AOAM531urxO28mjbMAZXiyyNuGzokKZ4f8cru2WDZWu+oULf3AmdRa4r
        ea0jrkYPc6i5hzsm7nD5OHE3Kqu13A==
X-Google-Smtp-Source: ABdhPJykB5ackdaXQiOPGwz844X8p5yd3R8iTmPVHMtuKKIL4nIPpSkTH/9OQuR5AoAFRXH9cdVvKg==
X-Received: by 2002:a05:6808:ab2:: with SMTP id r18mr3548171oij.25.1641407561688;
        Wed, 05 Jan 2022 10:32:41 -0800 (PST)
Received: from xps15.herring.priv (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.googlemail.com with ESMTPSA id p23sm8800781otf.37.2022.01.05.10.32.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 10:32:41 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     Mark Brown <broonie@kernel.org>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: spi-mux: Add reference to spi-peripheral-props.yaml schema
Date:   Wed,  5 Jan 2022 12:32:33 -0600
Message-Id: <20220105183234.3426649-1-robh@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The spi-mux serves as both a SPI peripheral and controller, so add a
reference to spi-peripheral-props.yaml in addition to
spi-controller.yaml. This is necessary to avoid unevaluatedProperties
warnings once those are fully enabled.

Cc: Mark Brown <broonie@kernel.org>
Cc: Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc: linux-spi@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/spi/spi-mux.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-mux.yaml b/Documentation/devicetree/bindings/spi/spi-mux.yaml
index 51c7622dc20b..7ea79f6d33f3 100644
--- a/Documentation/devicetree/bindings/spi/spi-mux.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-mux.yaml
@@ -31,6 +31,7 @@ description: |
 
 allOf:
   - $ref: "/schemas/spi/spi-controller.yaml#"
+  - $ref: "/schemas/spi/spi-peripheral-props.yaml#"
 
 maintainers:
   - Chris Packham <chris.packham@alliedtelesis.co.nz>
-- 
2.32.0

