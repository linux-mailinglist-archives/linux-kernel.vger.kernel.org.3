Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE524D6269
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 14:30:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348915AbiCKNbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 08:31:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348912AbiCKNbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 08:31:09 -0500
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E412D76DE;
        Fri, 11 Mar 2022 05:30:06 -0800 (PST)
Received: by mail-pj1-x1042.google.com with SMTP id gj15-20020a17090b108f00b001bef86c67c1so8162046pjb.3;
        Fri, 11 Mar 2022 05:30:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pRT2vtnm29iAprJsPjMBatssABOILDZBrV5iTTWq+Hs=;
        b=ENCIBn0uvk28e2LVz0Ss+m/AlTRy25LCdlrkevth+f6DGfg84UfkB/qPbfa5XAdqU9
         Jr2i29r+iRceu/u+x6agCFnMQby4kfA/RREZ9VdHtT4e67+5Ymd1VtllJUt1A5rGzXT5
         ubWx95UshffRDE5v8ad5wAec3RWPrbfPat4Dp3w3PaQLrMMrx75X1DatdkpU0kVacwmZ
         rF2hZUW6LNN9kIEYYKsz62DpGkLo5uRsQOLvoegTDCdlJBN51RuYfTsGMRQUmunB9yXX
         PFwFI+g24Ci6U6l3WwCF0mLSq6+gOHpzwpCZAJhjTnwW57nqx1acOqor+XrZqzkn//4d
         Qi7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pRT2vtnm29iAprJsPjMBatssABOILDZBrV5iTTWq+Hs=;
        b=DSG+B2uRBez+SGPv5+AslnxhZEm+Pv3NTtvcGvp8yqtbJbCW8vEgTP6jxbeYBEVFip
         hI4Wc9/bY4SrIYidxMghJz9x/sOpoEwqsDvOmt/TsBw+ZkIejhFElxakXq9RzSEgkJwG
         To/f35l0+jwkOOXBAiDl8ndxlnOxIvL9oFbo79PYtFVdSUrS9F4E/qMT3/nredz66rZT
         jTXak/oUe4t6LOP8fk/jVq9wxjrMSuMd9jWCmMoex/y60DuAmTvkUOSaHs0dpIlybAH3
         qqESVY9n5zsPkwGV3QDjUMbdnjNvCj41PQOxw6dVGzzR0fQxWasuolpivsFNdpPTclsT
         laGw==
X-Gm-Message-State: AOAM531VC0ciH2w+TOKwPMz0clThNNPf1tVxgZsup7xnzbLIP3T2KJ1H
        1eTBOmJtRsd2G3q5Wkx88HA=
X-Google-Smtp-Source: ABdhPJxenPwgGlrnVQpIyB8C+0aKGdPE9C9FUEKB1MIc+t8cBUDL/v/ipBnvuJsc5jE2ta88bwakEQ==
X-Received: by 2002:a17:90b:240e:b0:1b9:2963:d5a1 with SMTP id nr14-20020a17090b240e00b001b92963d5a1mr21747022pjb.227.1647005405874;
        Fri, 11 Mar 2022 05:30:05 -0800 (PST)
Received: from localhost.localdomain ([211.212.143.131])
        by smtp.gmail.com with ESMTPSA id l17-20020a056a0016d100b004c34686e322sm11319934pfc.182.2022.03.11.05.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 05:30:05 -0800 (PST)
From:   Steve Lee <steve.lee.analog@gmail.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ryans.lee@maximintegrated.com,
        Steve Lee <steve.lee.analog@gmail.com>
Subject: [V2 2/2] ASoC: dt-bindings: max98390: add reset gpio bindings
Date:   Fri, 11 Mar 2022 22:29:06 +0900
Message-Id: <20220311132906.32292-2-steve.lee.analog@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220311132906.32292-1-steve.lee.analog@gmail.com>
References: <20220311132906.32292-1-steve.lee.analog@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 This adds support for the reset gpio binding.

Signed-off-by: Steve Lee <steve.lee.analog@gmail.com>
---
 Documentation/devicetree/bindings/sound/maxim,max98390.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/maxim,max98390.yaml b/Documentation/devicetree/bindings/sound/maxim,max98390.yaml
index e5ac35280da3..4bf61fb6056a 100644
--- a/Documentation/devicetree/bindings/sound/maxim,max98390.yaml
+++ b/Documentation/devicetree/bindings/sound/maxim,max98390.yaml
@@ -31,6 +31,9 @@ properties:
     minimum: 1
     maximum: 8388607
 
+  reset-gpios:
+    maxItems: 1
+
 required:
   - compatible
   - reg
@@ -39,6 +42,7 @@ additionalProperties: false
 
 examples:
   - |
+    #include <dt-bindings/gpio/gpio.h>
     i2c {
       #address-cells = <1>;
       #size-cells = <0>;
@@ -47,5 +51,6 @@ examples:
         reg = <0x38>;
         maxim,temperature_calib = <1024>;
         maxim,r0_calib = <100232>;
+        reset-gpios = <&gpio 9 GPIO_ACTIVE_LOW>;
       };
     };
-- 
2.17.1

