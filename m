Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABB934889AD
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 14:44:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235678AbiAINog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 08:44:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231659AbiAINof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 08:44:35 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB5B6C06173F;
        Sun,  9 Jan 2022 05:44:34 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id t28so14894199wrb.4;
        Sun, 09 Jan 2022 05:44:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=52m3cAr5ho39+A90qDDeWRtETep813HqexFom0iwyIA=;
        b=e3bBdvOXVqf6a9VJuxaIv3LLsrqXm7ts4Wfks+Ox112hGzp6vR0WibHBZjFiXZbHxY
         feYgMQLSCrHd+IQT4q4pAajXt2hEq0MzNEKJHL13ScBNmuHLcQFE92eAccQlCPyhF5qs
         Q1U1VmoqcciOsmPrqNPaeKoF6RWypcz70PK0B1YhzkndJ20L/XC0zNzVRJ2q+bRXpS9m
         YpmADOLrniM15wqEGmjf1E9FKzuKtQPAPpkk0siAKwadESFwLNeU4L0Y06NBPFy6l63Q
         t7jzzV9zVnOx0V3qO3bo2g9GRTQ/MEQp5D6T1sW6y57OoIcUKzyonbwoDBscqzjqswUy
         z7Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=52m3cAr5ho39+A90qDDeWRtETep813HqexFom0iwyIA=;
        b=Bhw3mIbZlqeLMg3kbWIUgs1c1xdvyjKM/4/cPNAvYfp4hWWRKNfp46DUvgjdZK4Szz
         nlDJKJIs9S+YV+7aTnmbQUgFDelqpV4WflOgjRcPmv2w3OrU7rjAt3EHHk41RmWw+1qK
         WraUdWQPxUri7EyUcUp3MUX7M7f08xAVBfIQEFHPvQVNft0LhXsSggBlbqglr5xM8oFV
         wGWiPFhb2ic2+v8S2hho0Nm/CulxBzW1YPBN30f6Mc5kT17QTnz+Cz9Ksg/34CpOoPre
         qZYCH0MjjZq51z6w4IlFt95+sEfhfHRAB635A9aFWGz41TkWyAIc1EHK4H2CbrrL0GZd
         WG2A==
X-Gm-Message-State: AOAM533eopso4aMJLqabPhgIhyPjRLqHLDth2GHU3c5kG982JBL0f5sJ
        OjBm9emawOvKbq9szO2ow5s=
X-Google-Smtp-Source: ABdhPJzqZvaI9Qr4opMxhBAw97xiC6bNnhQWCjPKZ19wN1BZ1YSkI1YbinnogShpjfQ82Jfbk+jR3w==
X-Received: by 2002:a05:6000:2cc:: with SMTP id o12mr63321517wry.285.1641735873458;
        Sun, 09 Jan 2022 05:44:33 -0800 (PST)
Received: from standask-GA-A55M-S2HP ([188.123.115.255])
        by smtp.gmail.com with ESMTPSA id k10sm4210912wrz.113.2022.01.09.05.44.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jan 2022 05:44:33 -0800 (PST)
Date:   Sun, 9 Jan 2022 14:44:31 +0100
From:   Stanislav Jakubek <stano.jakubek@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH] dt-bindings: vendor-prefixes: add 8devices
Message-ID: <20220109134431.GA4560@standask-GA-A55M-S2HP>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add vendor prefix for 8devices (https://www.8devices.com/)

Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index a13d6a19c2b4..d9a0c29971a6 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -25,6 +25,8 @@ patternProperties:
   # Keep list in alphabetical order.
   "^70mai,.*":
     description: 70mai Co., Ltd.
+  "^8dev,.*":
+    description: 8devices, UAB
   "^abb,.*":
     description: ABB
   "^abilis,.*":
-- 
2.25.1

