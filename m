Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96F64533497
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 03:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242967AbiEYBHa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 21:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242968AbiEYBH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 21:07:26 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9225362BC0;
        Tue, 24 May 2022 18:07:25 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id w130so23501209oig.0;
        Tue, 24 May 2022 18:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W4ChPu9K2A+ApAAnCGmLFYbppMwTYDYHUppJvbxFFTE=;
        b=c0Xbbdr3WamfsTqXRYAGBrc0oZ5Vu9ISCOfDAIGnYxY+21LbvIaDwb2YapKz+GIb5p
         aG5t5G6m3p+OXxEVTEvg8lQDUewaP8R1g4Or1lI452drIl+nT/hQQ6XN4WuZi3xyGBch
         c2lJUC8HDeaANKLA+DSuV+r3p1BEpbyVHsJlNqSozoM43iFMZWSTsvAPqfbOxKWYcwKe
         7wrj0RikJF/pulumymOIGorfsJAJBOfEfeTB1OjQyunWXugelqJ7xOSnuMM046DCfSXH
         m8lsdE3L9i49uVN8rjgk7Cm0PSFSaGXZLjpddBY6J/rcfrfdMtwaToeDdXrHeUJ0cw0+
         tK7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=W4ChPu9K2A+ApAAnCGmLFYbppMwTYDYHUppJvbxFFTE=;
        b=wlagoKab6EL9UWBxvwnrCAzBdXBx6YuGKEI/4Ecmi/qzPYamCxhCaxZQ44LaBOx99a
         dwGi2Jg09t7f5X8tdyIuA8F/crtPtA0D/44B8Vaar3/GQOmbxCq+1bVy8biInFVuvvgq
         MRp/vFn2VsrGXN1oSJQVOb7X9yJqRG2O3s9ppyrCIr2PlvPORurbY2sprtsTYAFDmDZ/
         puI9A8BvHlUoSZ2nZ+nmxdRZotSPE2E96tRAo1cA/MRl/QxeYLaga3/kIdc9CiwCHQRB
         V11j0IOECyKkhOTzWKsWu8dYIYlY4vhaFcemTTlnhaKcdv3fuF3/Ry+AL4pH8sZ9y2bi
         JNvw==
X-Gm-Message-State: AOAM533Ba9/m05z9JKzJEk0ikMbwDVgBUQj9OGtwBOx6NrwYgLi2B3zh
        ZFm49LpEr5sxl/J+aJYD/5KFb2OIG4Yhbg==
X-Google-Smtp-Source: ABdhPJzTg8WRKl6V7L00YbtSk0U8D/4nrn2J6YLU791CxeWr06S+M/5ZqC2t6HbrPkEyMGHaYjrCkQ==
X-Received: by 2002:a05:6808:2018:b0:32b:6b66:bb49 with SMTP id q24-20020a056808201800b0032b6b66bb49mr4034103oiw.218.1653440844694;
        Tue, 24 May 2022 18:07:24 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o83-20020acabe56000000b0032603df9d24sm5705983oif.47.2022.05.24.18.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 18:07:24 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     linux-hwmon@vger.kernel.org
Cc:     Jean Delvare <jdelvare@suse.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v2 2/3] dt-bindings: trivial-devices: Add lt7182s
Date:   Tue, 24 May 2022 18:07:16 -0700
Message-Id: <20220525010717.4000736-2-linux@roeck-us.net>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220525010717.4000736-1-linux@roeck-us.net>
References: <20220525010717.4000736-1-linux@roeck-us.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Analog Devices LT7182S Dual Channel Step-Down Switcher.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Added patch

 Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index c11520347a9d..e35213bb1c07 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -41,6 +41,8 @@ properties:
           - adi,adp5585-02
             # Analog Devices ADP5589 Keypad Decoder and I/O Expansion
           - adi,adp5589
+            # Analog Devices LT7182S Dual Channel 6A, 20V PolyPhase Step-Down Silent Switcher
+          - adi,lt7182s
             # AMS iAQ-Core VOC Sensor
           - ams,iaq-core
             # i2c serial eeprom (24cxx)
-- 
2.35.1

