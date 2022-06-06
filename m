Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1850153EE1E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 20:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231768AbiFFStz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 14:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbiFFStw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 14:49:52 -0400
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 226E11B1F7F;
        Mon,  6 Jun 2022 11:49:52 -0700 (PDT)
Received: by mail-il1-f182.google.com with SMTP id y16so12566488ili.13;
        Mon, 06 Jun 2022 11:49:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kgkfRUJV9/BEnmPocysX/S7LexhHarrs/j/DCNaOkdQ=;
        b=iqoHN8LGnfgRL5Hhc6fMMi4d1oWRpwAnSf8CWju0PEI6Fw1ahqNq/vyAT4jjWdSY0N
         odIoIeOxpGyMzUJPcK7tt3/tSDmTeHYFymUMTwoGVGAut44psW333oq4i8m/pUvvCZZz
         f3tOPi69LvGZdyCf388Duzz/cjLYPg8lb6qzLysZU0qoVt/r8yHp5Rd0EjfhzJ+uEiiB
         AESgYK3+XLWt4QBivttLNFPyz9ssN51mTu/Tf5X3sTMdFLuKzqyFEwuB7/LEj1u/ytwo
         6voQ4u3DGZeATKk+kUfFWMcWl4RXV+xxtYF0Sl5sffvcMTiVexTWvfTuSHdGL0lwUg8C
         U+wA==
X-Gm-Message-State: AOAM532RPo0eV+iXrYaPyTbg0Zjqs7hmUjflhZ7bdMA/1sNAFgU2cAA7
        bwy0FB9xvtpfq+18HROjEw==
X-Google-Smtp-Source: ABdhPJyO6ukxCl1+GXv2jPhH0h2yHQcRDq45FddKd9mLHiE3sU0VZ9kd3aqgeQUkM5M+pLLavbqPPg==
X-Received: by 2002:a05:6e02:18c8:b0:2d3:ded5:9cd7 with SMTP id s8-20020a056e0218c800b002d3ded59cd7mr57368ilu.119.1654541391433;
        Mon, 06 Jun 2022 11:49:51 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.251])
        by smtp.googlemail.com with ESMTPSA id m7-20020a026a47000000b0032ea33f23a0sm5861784jaf.95.2022.06.06.11.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 11:49:51 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sean Young <sean@mess.org>
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] media: dt-bindings: rc: Allow 'ir-receiver' node names
Date:   Mon,  6 Jun 2022 13:49:43 -0500
Message-Id: <20220606184944.1067068-1-robh@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most existing 'gpio-ir-receiver' nodes use 'ir-receiver' for their node
name, so add it as an allowed node name.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/media/rc.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/media/rc.yaml b/Documentation/devicetree/bindings/media/rc.yaml
index d4c541c4b164..b11d14ab89c4 100644
--- a/Documentation/devicetree/bindings/media/rc.yaml
+++ b/Documentation/devicetree/bindings/media/rc.yaml
@@ -12,7 +12,7 @@ maintainers:
 
 properties:
   $nodename:
-    pattern: "^ir(@[a-f0-9]+)?$"
+    pattern: "^ir(-receiver)?(@[a-f0-9]+)?$"
 
   linux,rc-map-name:
     description:
-- 
2.34.1

