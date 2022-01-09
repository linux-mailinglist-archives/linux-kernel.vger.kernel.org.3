Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 898DB488A39
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 16:33:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234605AbiAIPdN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 10:33:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234160AbiAIPdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 10:33:11 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47F41C06173F;
        Sun,  9 Jan 2022 07:33:11 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id c126-20020a1c9a84000000b00346f9ebee43so5779593wme.4;
        Sun, 09 Jan 2022 07:33:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=iDd3o808yP7X72T6NzrCF0U4nmksu/IQWoASd3p64DE=;
        b=Rwocg3ISJZmmd4OExeBAWyILA3YMSmy8ziMH8efgpxikhEt1Fi+yxjiJIMAlSSnJV5
         QZyvXqXOp4taFUkQMppcVGH6aYy/NSlqBPpvwe7jdYrB55WnbSxdTjkeeRXVOo9xhX4K
         WzLrNXfpTTOGiVtvRVm57FBpwJbANqX0/G8F/SSod+B8QFQVxWEyUi8iOUe+t0c7dTPi
         SNIenYntpK850n25wzv16wwBOOctQuBNEpR9tQU1txBOWZKvHW6w9VKz7ISPj7fRPKIH
         NB6HNe2q4zzW5DBL2WdHXgoOFd2zjkkSAyVssiozvXN4RtDWaNP2yKkyLkVRr/NFERvP
         Ehfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=iDd3o808yP7X72T6NzrCF0U4nmksu/IQWoASd3p64DE=;
        b=plg8qN2mV5wzHz3JOyyhZrlVA9SDSquX4rf663d9TaCEHbT9REHmtTOOwCk+zxS5rV
         alnWcdYaxbMTCUpEX+h/oJC4NnKeehcqPT9/mwk2kaawdLIdwaGZVY3rUmb2zUrtrRH0
         cGBPPLV2dBKvYFR8UDkgXGCec/NHwKE0FQIoV5U2qop0S32bLgoNDJ7MhXF04xbyC0s6
         FcJ0xgIq4llea9I44GUPG0B8PAdGxk1ZNE/F3N1oJn6sH1vQKChbCt0s+oioAS04w79k
         Jf+xXSgHXwS9zLDIRnGUe7AUAhsvTneNyUgeRZKjg87WaBqPTWBXxfLX/SXr5VCbWZ5I
         ZzQA==
X-Gm-Message-State: AOAM530fRbDAK+tJqPnjK7N5QTm8mAXsrMyCjRuRR+SKnT3k8nGfmJPT
        KBh9+3PQi5JNzxqRtn/VfVM=
X-Google-Smtp-Source: ABdhPJx9cHQbVJeErPiVzJrAJ3ii+2lsZitJtx5VsqLgiHkKLMiSgxyynJB98c1XTm1heqpZURaNPA==
X-Received: by 2002:a1c:f316:: with SMTP id q22mr18595850wmq.33.1641742389598;
        Sun, 09 Jan 2022 07:33:09 -0800 (PST)
Received: from standask-GA-A55M-S2HP ([188.123.115.255])
        by smtp.gmail.com with ESMTPSA id b5sm4437340wrr.19.2022.01.09.07.33.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jan 2022 07:33:09 -0800 (PST)
Date:   Sun, 9 Jan 2022 16:33:07 +0100
From:   Stanislav Jakubek <stano.jakubek@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH] dt-bindings: vendor-prefixes: add Thundercomm
Message-ID: <20220109153307.GA9842@standask-GA-A55M-S2HP>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add vendor prefix for Thundercomm (https://www.thundercomm.com/)

Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index a13d6a19c2b4..f79c30183e7e 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1205,6 +1205,8 @@ patternProperties:
     description: THine Electronics, Inc.
   "^thingyjp,.*":
     description: thingy.jp
+  "^thundercomm,.*":
+    description: Thundercomm Technology Co., Ltd.
   "^ti,.*":
     description: Texas Instruments
   "^tianma,.*":
-- 
2.25.1

