Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 260404834E3
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 17:40:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234695AbiACQkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 11:40:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234707AbiACQkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 11:40:13 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AF3DC061761;
        Mon,  3 Jan 2022 08:40:13 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id q14so130198166edi.3;
        Mon, 03 Jan 2022 08:40:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bQqNEXrT2MXdan5ZsVv1uva0kQxDujM7b0rj46hBiVY=;
        b=je6BG00Wk05INgxTy7W/4qdN+a5pAT7i4QbDSsWue7Ekla331t4f8vv9qR7CpPuut8
         gNR7yt4/wX5FD4sFzAw4jIwt/32+ENNQ5Puaq+kAstuSGF6Y/RgRuNC19fGZ4GrcUUyg
         h6mNmkseFQPkzVBEUOry9XOdejzFNx2OuOL6ul7rCvnX86BVhjG8aiy5iweceNmY5Y05
         HDHiOdvrQ2BKfWKdxDN8TpSoDJxZMfkaZzEYgfDUAfSVjxf3KQ/LGHwOpeIq1dz+ttCq
         doQYNfBE7FBiqIbZW2FxAdq5b6OnyXeucv+jSxfBDCfZMT8BaY9U/n8ExbIIPIDeLjZb
         q27w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bQqNEXrT2MXdan5ZsVv1uva0kQxDujM7b0rj46hBiVY=;
        b=BLPoAx45anCVakPuX1eh3J97ZxqJ+R+Z/AKdMO0hDP0AczSHLDku0m7JCQtX/2T89N
         d7Bj6FJAU3anBpjYzdtDTf3fznINMYVpDShwuDEeDxgCJiQpHMGXtHvbgd+/EQfGGoue
         Di5aAhNrVswruotMz8xZxpoFvr01jObSiiyB8ZZTOci30bhhGb4yCl5svpROLsafEKaz
         2CCZ3Q5u/BZFG51LvXoG1Sr7QYUpS9dO8GzfVh+3lJ6WMxrd+sqMZ3doRim76X5Uq1R5
         4fYmeeMv+VhIHZHzzm9rqCIZN88QADpc1NVm5UgWW6syvVKULVqT/iYjfnagmPrtRob9
         U8HA==
X-Gm-Message-State: AOAM5308QPiWcqo7lKB8aXuQXKBhBxvKm+lk1+aJKaqUyXgxL6b20epa
        cpZsM55OFE/jasadZYebK0M=
X-Google-Smtp-Source: ABdhPJzIKdTJJ02JiOO14GTgXAyke/OephTqfGHR44RLsFJAP2jLBTPjv7NSJT5mzyfnEmScVKnFZQ==
X-Received: by 2002:a17:906:d96a:: with SMTP id rp10mr35270813ejb.614.1641228011693;
        Mon, 03 Jan 2022 08:40:11 -0800 (PST)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id oz20sm10724068ejc.60.2022.01.03.08.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jan 2022 08:40:11 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>,
        Benoit Masson <yahoo@perenite.com>
Subject: [PATCH v2 5/9] dt-bindings: arm: amlogic: add A95XF3-AIR bindings
Date:   Mon,  3 Jan 2022 16:39:52 +0000
Message-Id: <20220103163956.6581-6-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220103163956.6581-1-christianshewitt@gmail.com>
References: <20220103163956.6581-1-christianshewitt@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add board bindings for the CYX A95XF3-AIR set-top box which ships
with model variants distiguished by Ethernet configuration: models
using external Gigabit PHY have a -gbit suffix, while models using
an internal 10/100 PHY have no suffix.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 Documentation/devicetree/bindings/arm/amlogic.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/amlogic.yaml b/Documentation/devicetree/bindings/arm/amlogic.yaml
index b5b995941d3b..2027ce81a834 100644
--- a/Documentation/devicetree/bindings/arm/amlogic.yaml
+++ b/Documentation/devicetree/bindings/arm/amlogic.yaml
@@ -173,6 +173,8 @@ properties:
               - amediatech,x96-air
               - amediatech,x96-air-gbit
               - bananapi,bpi-m5
+              - cyx,a95xf3-air
+              - cyx,a95xf3-air-gbit
               - hardkernel,odroid-c4
               - hardkernel,odroid-hc4
               - khadas,vim3l
-- 
2.17.1

