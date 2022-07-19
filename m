Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E0B657A97D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 23:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240644AbiGSVwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 17:52:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240612AbiGSVwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 17:52:00 -0400
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D52CF61DA5;
        Tue, 19 Jul 2022 14:51:58 -0700 (PDT)
Received: by mail-io1-f46.google.com with SMTP id h145so12946553iof.9;
        Tue, 19 Jul 2022 14:51:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XOtlQvN9qURJ7YCNsoS0tTTQu8LGfesaRB0+2MadP3M=;
        b=LUfCLES56PinZiQhkBfhJWlceGehYzXR+uP0DJIKZcLOj8riPKm1Lr0XE2ADhLSmoH
         9P2BJejVt2YLK+nX78z4VCx8qxfT5RsBwPxKjCSCyYOVtR4GDXNuHSCXaAyzvWNbL1ce
         yXmjd0AK5h6ncEOAKYmAafwvPxgGW1u4QtTB5rblHyxVBZ/vCbuRSiTSy51g3FMof1FD
         hmg6Le8gS/pMF4oKNDzI5CSkSap89w/lYALiA1yFACsk34cR7/IldxdM9I//ooZpnCo+
         JINO5mMYSb6imr2ctwLoezKsTWhLtNXPAhkxxkCLdkNC2dKgNgpgcWKh/ggsQ2cNZB4S
         9aAw==
X-Gm-Message-State: AJIora9Z1jdB5E4d1e+RFNRLfTB2tlqHHzxuKu64xh4V9YIr8+UpJRU7
        4rsG3EdBAdaGb1WFWLy4uNTjAOYhSw==
X-Google-Smtp-Source: AGRyM1sUjLLfxdK9YtkqDUTklQ+t4pjGaftzONx6t0TN95Cpdy7+y07kDpdmMOQ8le8bApF21jYZaw==
X-Received: by 2002:a05:6638:339b:b0:33f:5a4c:4d8e with SMTP id h27-20020a056638339b00b0033f5a4c4d8emr17873648jav.93.1658267518056;
        Tue, 19 Jul 2022 14:51:58 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.248])
        by smtp.googlemail.com with ESMTPSA id l14-20020a92290e000000b002dd06902010sm553046ilg.42.2022.07.19.14.51.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 14:51:57 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Cristian Pop <cristian.pop@analog.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: iio/dac: adi,ad5766: Add missing type to 'output-range-microvolts'
Date:   Tue, 19 Jul 2022 15:51:52 -0600
Message-Id: <20220719215152.1877776-1-robh@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'output-range-microvolts' is missing a type definition. '-microvolts' is
not a standard unit (should be '-microvolt'). As the property is already
in use, add a type reference.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/iio/dac/adi,ad5766.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5766.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5766.yaml
index a8f7720d1e3e..29bd16dab546 100644
--- a/Documentation/devicetree/bindings/iio/dac/adi,ad5766.yaml
+++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5766.yaml
@@ -22,6 +22,8 @@ properties:
       - adi,ad5767
 
   output-range-microvolts:
+    $ref: /schemas/types.yaml#/definitions/int32-array
+    maxItems: 2
     description: Select converter output range.
 
   reg:
-- 
2.34.1

