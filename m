Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC36B4834DD
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 17:40:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234631AbiACQkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 11:40:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234621AbiACQkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 11:40:06 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B7ACC061792;
        Mon,  3 Jan 2022 08:40:06 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id z9so68081045edm.10;
        Mon, 03 Jan 2022 08:40:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ojj3JoMdycerIw0d/UxApbq5HUpT7xWvP5YgT79gkVY=;
        b=TFzj0ZSMTa3hnEDtT/XXW8Row18g8J2GgE4ihZIeiLLgwinpikb1bjmFtsye3RjBSa
         8A7EqKH6i7s1mTRgeltxYPFqqfSvhYEEkyDeSZu9NwHtlJ39rzqKu8s/qnz6FHMZTFdB
         9qz2SEhw4pq6EDMwA8pRXbI6gQrXZGJI0NPl6fhAClFSScuNTTZj+V4O4ae9JbYRzrYI
         yO4k2Wytx2z84hdtJVM4NrEhQejcRow1FaiUzLPNA6hvqnnVONIGzxrSSJHjsEQOCBlU
         6i6Svho3FcEgU7CIQz2nntEcEBlbBmU7IEINQ+cWwS4nn2O3xzKjAVFcNOGhpElBDeQw
         jvJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ojj3JoMdycerIw0d/UxApbq5HUpT7xWvP5YgT79gkVY=;
        b=CSNcto3TRbaWE8jGEbjFdSbhGpwLUTsQB9fgBfumnanZFvBiaZBlIOK+2hqgzKg3ri
         Bz1QTLRLcPkcZ5NEuR1Wq5mYeNfJf6uNZtdpIOzRzpzCn/pp4dITsi3i+CXMq9gkMttA
         /LYll4yleKaKUqv7mwY34ZT8ORYSS+/iXTLPbll4dooFGGH+C4nzImOJdRnDIGPNZghz
         r4krCVqhaZel8zd9fTPTgmW8sJ0RXdypYJHs4/Ih/1EK+ktDvwXeo41jRveXUpJD15yj
         mlQc9ttWbXDZDaIv2fgSlDXHKPAHXHo1W+DxVwPO34dwVRvnwPbIpQmzaRHiFI3gDJIq
         0ayA==
X-Gm-Message-State: AOAM533eG8E9bPQIHj1qk5YE2mFI14nAxtQnATs9ecq0GXYgbR6iXrDH
        rSZr8vsC/RURSBBeGQYYZLVjDAEKDBLLZM+o
X-Google-Smtp-Source: ABdhPJx3UBgodYsd+FuF9pGaQocd2DWemM2LohjQS8m8f0suxzXluEs0Of1L3OVVTxIuH/3VluM7/A==
X-Received: by 2002:a17:906:58c8:: with SMTP id e8mr35892370ejs.444.1641228005142;
        Mon, 03 Jan 2022 08:40:05 -0800 (PST)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id oz20sm10724068ejc.60.2022.01.03.08.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jan 2022 08:40:04 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>,
        Benoit Masson <yahoo@perenite.com>
Subject: [PATCH v2 2/9] dt-bindings: arm: amlogic: add X96-AIR bindings
Date:   Mon,  3 Jan 2022 16:39:49 +0000
Message-Id: <20220103163956.6581-3-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220103163956.6581-1-christianshewitt@gmail.com>
References: <20220103163956.6581-1-christianshewitt@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add board bindings for the Amediatech X96-AIR STB which ships with
model variants distiguished by Ethernet configuration: models using
an external Gigabit PHY have a -gbit suffix, while models using an
internal 10/100 PHY have no suffix.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 Documentation/devicetree/bindings/arm/amlogic.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/amlogic.yaml b/Documentation/devicetree/bindings/arm/amlogic.yaml
index 31df120d73b0..b5b995941d3b 100644
--- a/Documentation/devicetree/bindings/arm/amlogic.yaml
+++ b/Documentation/devicetree/bindings/arm/amlogic.yaml
@@ -170,6 +170,8 @@ properties:
       - description: Boards with the Amlogic Meson SM1 S905X3/D3/Y3 SoC
         items:
           - enum:
+              - amediatech,x96-air
+              - amediatech,x96-air-gbit
               - bananapi,bpi-m5
               - hardkernel,odroid-c4
               - hardkernel,odroid-hc4
-- 
2.17.1

