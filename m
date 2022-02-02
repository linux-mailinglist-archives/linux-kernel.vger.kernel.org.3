Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C777C4A6D9F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 10:15:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237854AbiBBJPz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 04:15:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232788AbiBBJPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 04:15:53 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93FA5C061714;
        Wed,  2 Feb 2022 01:15:53 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id e8so37112466wrc.0;
        Wed, 02 Feb 2022 01:15:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6p2dGIbQwImBA0dySet08I3gW/cnu8l/C4kG33NOFAA=;
        b=EfbeggMuOhCBlQ73k9TCTmIrugE97UGBb6OyVHVz15FjAHW689OQ6CZIFWorQ7Sw0G
         QzxE6IBfaOcxxre16drQ7XUh4yil4GWJlaBw/CFjKu4caaYc3hYuGOV3dMfvT4iwc5AF
         i1P6iKrSp8A0QWbWAiSk1s3xOyjvy90/QLdXuZbtgxkPLHs93cTXiQt1/DsoROr5Q5ZJ
         LUsDD9lbS2QKiG/o9jCGgTHo35S5oShw72G0GaUfGZCzmHmWHM/KoiFJYkOL8R2RZxMM
         JPtvytjkGWUG3UXbGr/jFADyTcsM6UDDiMr0jPH4sk6+thzXcAWEsoN0Tdt1MK2Varh3
         TC6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6p2dGIbQwImBA0dySet08I3gW/cnu8l/C4kG33NOFAA=;
        b=dIeKfddK2814gVwDflP9oRHsdnpwZz75tj0xDV/lx/3EmSbe6291wA8B8tY4AgiKcD
         X9J+2VwBCTSuFUCz8ubv0ZQnI8CmuPV4xeMdGdgQmkWmhZSmOsPDUNKCHIwlLZBszEYN
         qp/AE/KrdTTW0crgWw7VTteSqhbLEQEQHfyIoM+7DDRF3bE/HKisahdrvOWdgCM/rXTG
         l4pOzalHMrQMfncYTdFcAAluH2SzWxYMaP3kCbp+ma1eDFItlQexpKVYgQFlC80/w/Pd
         Cblw1/lQhAVaG5CqGA0ObnxCFbLVFc8zaAZgriNpqCWcZw48qVSqksXvMGLquy2XnbZs
         AvmQ==
X-Gm-Message-State: AOAM530d4akyA/8efawB6yw3DwT+YjfJ3fCwGbsLfIhAITG977z7OBRd
        EKQQ5Zd1poeLrPQP3EYAxqg=
X-Google-Smtp-Source: ABdhPJz9o1UANCdn2LBDLwxh/VFwIVUGbN4l4E29CfmPx4tBYBNNLPaV9Lam9AS1o8nxAFF2t9kIzA==
X-Received: by 2002:a5d:47cf:: with SMTP id o15mr24418696wrc.577.1643793352172;
        Wed, 02 Feb 2022 01:15:52 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id n2sm19441878wrw.63.2022.02.02.01.15.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 01:15:51 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] pinctl: doc: Fix spelling mistake "resisitors" -> "resistors"
Date:   Wed,  2 Feb 2022 09:15:51 +0000
Message-Id: <20220202091551.580372-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a spelling mistake in the documentation. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 .../devicetree/bindings/pinctrl/brcm,bcm11351-pinctrl.txt       | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/brcm,bcm11351-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/brcm,bcm11351-pinctrl.txt
index 4eaae32821ae..e047a198db38 100644
--- a/Documentation/devicetree/bindings/pinctrl/brcm,bcm11351-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/brcm,bcm11351-pinctrl.txt
@@ -85,7 +85,7 @@ Optional Properties (for I2C pins):
 - function:			String. Specifies the pin mux selection. Values
 				must be one of: "alt1", "alt2", "alt3", "alt4"
 - bias-pull-up:			Integer. Pull up strength in Ohm. There are 3
-				pull-up resisitors (1.2k, 1.8k, 2.7k) available
+				pull-up resistors (1.2k, 1.8k, 2.7k) available
 				in parallel for I2C pins, so the valid values
 				are: 568, 720, 831, 1080, 1200, 1800, 2700 Ohm.
 - bias-disable:			No arguments. Disable pin bias.
-- 
2.34.1

