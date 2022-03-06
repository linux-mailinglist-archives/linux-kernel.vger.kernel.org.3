Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7651B4CED3E
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Mar 2022 19:47:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233207AbiCFSsZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 13:48:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbiCFSsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 13:48:23 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAC091A5;
        Sun,  6 Mar 2022 10:47:27 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id c19so7325091ede.8;
        Sun, 06 Mar 2022 10:47:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lwg/pddAO16qV15CnyAabUKBRQX3ay3xuq2q4yhI9t4=;
        b=RUvGiVKlhspLCSCDihKOA+Lr9CoJ5xQMRQMweViZW53De6Vj53MDSySjrIPL5Q3ZpR
         xNBMz9eLoyp7nDNHDj2ZaVA6+hzPg5e3szc/jl5/ss+pJcsc6Rb2G/n4esrhN02X4r+L
         8zvMsosqXmC1cSk8OC6vZmaVv40k6HyUFQkYqewQWFK5jf8tP2nrvwo1PIex5eW9pJL6
         3xoOFxnYEJTg84T6L642RqbwEi2yiJm23SkVxRlXc03NHmCfQzbH/baM85QfVr9Aenql
         lWXmys97yl++18ltT5P3RkET7DA5up6pDW+xPEO5DqtjPeWycGHoDqQ3LW7Kd+8c32t4
         Qf+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lwg/pddAO16qV15CnyAabUKBRQX3ay3xuq2q4yhI9t4=;
        b=8A4Su80FMPbBOZ76PpzJP9xTJyrOFgMnsHoj+3631M+2tm9X+0aPPmN7ITV4Uqkl0y
         awBbJNXPn3fahBtGz+DP+XkAcWriwUV8oE8GmeWMs/RMGB0TArBtexgwofOV5c3sWgk1
         dxTpwrTvuHST34Pe7xwfbiTQh2f5rPxLS36KoHIslDj+Hc5GYj4U5AV5Uqck8fJFSODd
         dY5EIVWCrkpDaG7Qw/gVud5A0CiMFItzuJxenwdRcBorPTTI20HoDWzJbKI2zgHB3rj9
         mFRcD5QrZhL35o1VRCoJtVxyvFepnDWmZngo+J7gYTMQ9P+CjOSm0KOGvH9AN7sYf3Zp
         YWbg==
X-Gm-Message-State: AOAM530oQC9Pmx3MQotiteJAM8MN4rCjIBr+DmTUZJ6oLKi+qxT9nUd0
        i8VBqB+yLUeyxDxa2zwPiZo=
X-Google-Smtp-Source: ABdhPJwtMlrOGkI+BC776o44n/6t/CFmVbqF0hvGK+LP7dAuSZLVp4mO+nAKbjQQYpjvvq5PFUYTHQ==
X-Received: by 2002:a50:da86:0:b0:416:2c1f:170f with SMTP id q6-20020a50da86000000b004162c1f170fmr5712113edj.86.1646592446469;
        Sun, 06 Mar 2022 10:47:26 -0800 (PST)
Received: from tom-desktop.station (net-188-217-57-126.cust.vodafonedsl.it. [188.217.57.126])
        by smtp.gmail.com with ESMTPSA id m19-20020a1709062ad300b006d1289becc7sm3944371eje.167.2022.03.06.10.47.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Mar 2022 10:47:25 -0800 (PST)
From:   Tommaso Merciai <tomm.merciai@gmail.com>
Cc:     tomm.merciai@gmail.com, linuxfancy@googlegroups.com,
        Richard Leitner <richard.leitner@skidata.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: usb: usb251xb: add documentation for boost-up property
Date:   Sun,  6 Mar 2022 19:47:20 +0100
Message-Id: <20220306184720.5350-1-tomm.merciai@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for the optional property boost-up.

Signed-off-by: Tommaso Merciai <tomm.merciai@gmail.com>
---
 Documentation/devicetree/bindings/usb/usb251xb.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/usb251xb.txt b/Documentation/devicetree/bindings/usb/usb251xb.txt
index 1a934eab175e..29b5d6521f3c 100644
--- a/Documentation/devicetree/bindings/usb/usb251xb.txt
+++ b/Documentation/devicetree/bindings/usb/usb251xb.txt
@@ -67,6 +67,8 @@ Optional properties :
 	power. The value is given in ms in a 0 - 510 range (default is 100ms).
  - swap-dx-lanes : Specifies the ports which will swap the differential-pair
 	(D+/D-), default is not-swapped.
+ - boost-up: Property control USB electrical drive strength. There are 4 possible
+	modes: normal (0x00), low (0x01), medium (0x10), high (0x11). Normal default.
 
 Examples:
 	usb2512b@2c {
-- 
2.25.1

