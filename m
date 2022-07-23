Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF8B57EC8B
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 09:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237002AbiGWHnE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 03:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235984AbiGWHnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 03:43:00 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F45D4C617;
        Sat, 23 Jul 2022 00:42:58 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id ez10so11977360ejc.13;
        Sat, 23 Jul 2022 00:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GHH6iYGdl9sRkae4YTPPmdcP2BrajZ72JH5y9Uk/yV0=;
        b=gxzK1AZgXF5WEa1n1YxQilGgJyvuui488+6M/dA9ooGTr2KSq5xFbMax/4xQyudR6/
         +HdHoF3LaKVmx4nwXVRd1j3VsKtNLsL8iSuQq+1ix/QIOStvUmcs0K38nHcdPiTZSmVN
         kLuEnTfzBYPaQ/ItrHclAj7wYbQ8LZIBzHt3Mz19gKqF7/oC6+VyjHhsyD/zHC4ly7is
         kiG9jBB82RnULe2NmGhsyl4Umxiv5Q8M932wh3UErvfqIR+AsfUffejxlvOhVXvdfy3q
         PTDtceRE4+Slpl/R9kTcnydgMrlM/PHG6gq9SFs6ih+S2HgF2Id4RlF7zCtVRE/2PamH
         MttQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GHH6iYGdl9sRkae4YTPPmdcP2BrajZ72JH5y9Uk/yV0=;
        b=OcJdIRqjPa9yxDnUda+Ex0XoabqywegqvvbSQqBo5o8+W/Q8Dv6NTINGsa+UGSB9WP
         UWfBlq3NBxAfmLgN1etrv9+I78ASvF7YEFKYNGEv4LZzQQ+Pzkm0/svpO7nTQD0yORx8
         /LuEu8SdrOGvKu5HZxx5N96RXWqCtuJpXkdr/D+JzBbpXIRdVjhtCL/hFcd1HEQA9ZVt
         9/LazMMsQELT9sWenQMEECA5vqFwd/wu4Z8rxdqzb6CHO8SukrjRLvunWjuBqtpPRhV/
         fHyYMD1Xi0g2onMfgEoeasx0NAyWQvYmoCM50ARrz1mAbNYcE7Vn24PE/03jyH2a0HGf
         bSbQ==
X-Gm-Message-State: AJIora8xQckuBYOtc4aA7Kibydj3o2agF7pqm37TI4imEvU8gJ4n20Xt
        8l5Xzl5FYSlM6vr2G0bKt0s=
X-Google-Smtp-Source: AGRyM1tyXavPgp/LHT2drmRUVvMeD4sunh2IXFQGoJe/tJ/n7LgFSbTnybImwu9ar2xmDnQUWcRaIA==
X-Received: by 2002:a17:907:97cd:b0:72f:2df:274f with SMTP id js13-20020a17090797cd00b0072f02df274fmr2636803ejc.766.1658562176638;
        Sat, 23 Jul 2022 00:42:56 -0700 (PDT)
Received: from ubuntu.fritz.box ([155.133.219.250])
        by smtp.gmail.com with ESMTPSA id ky4-20020a170907778400b0072aadbd48c7sm2819204ejc.84.2022.07.23.00.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Jul 2022 00:42:56 -0700 (PDT)
From:   Daniel Kestrel <kestrelseventyfour@gmail.com>
To:     kestrelseventyfour@gmail.com
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/3] dt-bindings: vendor-prefixes: Add AVM
Date:   Sat, 23 Jul 2022 09:42:45 +0200
Message-Id: <20220723074247.32523-2-kestrelseventyfour@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220723074247.32523-1-kestrelseventyfour@gmail.com>
References: <20220723074247.32523-1-kestrelseventyfour@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add vendor prefix for AVM Computersysteme Vertriebs GmbH (http://www.avm.de/en)

Signed-off-by: Daniel Kestrel <kestrelseventyfour@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 294093d45a23..0be52bb27f2b 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -153,6 +153,8 @@ patternProperties:
     description: avia semiconductor
   "^avic,.*":
     description: Shanghai AVIC Optoelectronics Co., Ltd.
+  "^avm,.*":
+    description: AVM Computersysteme Vertriebs GmbH
   "^avnet,.*":
     description: Avnet, Inc.
   "^awinic,.*":
-- 
2.17.1

