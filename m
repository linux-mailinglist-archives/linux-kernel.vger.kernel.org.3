Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0930248EF2E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 18:23:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243844AbiANRWC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 12:22:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243842AbiANRV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 12:21:59 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B39AC061574;
        Fri, 14 Jan 2022 09:21:58 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id u21so36403205edd.5;
        Fri, 14 Jan 2022 09:21:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=DZsFo02ItcgUoJXp2q+L6CGSHBvAOzzqvn0C/GK76PI=;
        b=dSd5aAWtTZqFxTds/o5F02gYjXz19ShtCPoGo2h20yCaGii3RRceSruaBLMvcy/SFD
         NBadKk1qKfuDsw3cEBLcX+hK4ZrWznMkmOepzUOYGIilCfyUp5wswbpRxsMSZMuT/48T
         QaTSUTzNdbWJMlPHtpJN/PSshhbxeLMYbH4tCH7LsVyP7bqPsg8Bb08eZNrSoQScx8WU
         Hn67Q9nAWSZtFqnE2bN/sM14BkQq4ksE5lR+3C4UIsJaZ8KezQtNkvS/D5gfziThJCGr
         IoWpJul/Ov+i4ThKUQaL+Dmco4oUqhLuv0u7ab3qEPtz6MpcLISy2Q5cOoKk52TC4KUI
         m8Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=DZsFo02ItcgUoJXp2q+L6CGSHBvAOzzqvn0C/GK76PI=;
        b=kuegJjIITychNeRluoBDK9GtQywi6WN3BUEr/Tk22APjHjPr55sYOPtVXRhbBEDlfM
         VTfwzsF4Ix8IjY3SuSwHeCCpFXbB2jExQllBAmioiTXKuEwb1MqACj0zB6muL253DUK7
         PevTD4bbWiUojaJ4pQjhcdel0d+4d6ApMMBKmOxDrElrauI3JQnMNceX0FC5tiJKT1pn
         LddRKIOOKz2CXTNmu2zKV5j/GpYoGVjtSq3ks0TILUwU2TLeLXWqPfS1SoGOwYf6KMIv
         eH84X7yHz/ElVC4dg6/ofr8+kxJMrYHvkDke5syVArOLm6ukfV016XFxEbqRWVHznxqI
         Ogpg==
X-Gm-Message-State: AOAM532sPfex04FQY8FJ/oSh4mBqiQdFgwd5VF0NZQK4Qdgw1Xm6rLAL
        pRDla6BOHXC8JgTbXUH56OFOGocPdbo=
X-Google-Smtp-Source: ABdhPJx6bv/2btgpI8Q3cOwV3QOCXU57QgSmeqqxf/pX4aVveM2EgjIkKiMaMTSeEWEyTyvlcG/thg==
X-Received: by 2002:a50:9549:: with SMTP id v9mr9925330eda.335.1642180917228;
        Fri, 14 Jan 2022 09:21:57 -0800 (PST)
Received: from standask-GA-A55M-S2HP ([188.123.115.255])
        by smtp.gmail.com with ESMTPSA id u1sm2581703edp.19.2022.01.14.09.21.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jan 2022 09:21:56 -0800 (PST)
Date:   Fri, 14 Jan 2022 18:21:55 +0100
From:   Stanislav Jakubek <stano.jakubek@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: trivial-devices: make comment indentation
 consistent
Message-ID: <20220114172155.GA3677@standask-GA-A55M-S2HP>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Makes the comment indentation consistent across the board.

Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
---
 Documentation/devicetree/bindings/trivial-devices.yaml | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index 9af1b0f4ecea..eee751713cb5 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -77,7 +77,7 @@ properties:
           - delta,ahe50dc-fan
             # Delta Electronics DPS-650-AB power supply
           - delta,dps650ab
-          # Delta Electronics DPS920AB 920W 54V Power Supply
+            # Delta Electronics DPS920AB 920W 54V Power Supply
           - delta,dps920ab
             # 1/4 Brick DC/DC Regulated Power Module
           - delta,q54sj108a2
@@ -123,13 +123,13 @@ properties:
           - ibm,cffps2
             # Infineon IR36021 digital POL buck controller
           - infineon,ir36021
-          # Infineon IR38060 Voltage Regulator
+            # Infineon IR38060 Voltage Regulator
           - infineon,ir38060
             # Infineon IR38064 Voltage Regulator
           - infineon,ir38064
-          # Infineon IR38164 Voltage Regulator
+            # Infineon IR38164 Voltage Regulator
           - infineon,ir38164
-          # Infineon IR38263 Voltage Regulator
+            # Infineon IR38263 Voltage Regulator
           - infineon,ir38263
             # Infineon SLB9635 (Soft-) I2C TPM (old protocol, max 100khz)
           - infineon,slb9635tt
-- 
2.25.1

