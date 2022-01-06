Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBBD04869C4
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 19:25:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242797AbiAFSZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 13:25:36 -0500
Received: from mail-oi1-f178.google.com ([209.85.167.178]:37745 "EHLO
        mail-oi1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242738AbiAFSZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 13:25:33 -0500
Received: by mail-oi1-f178.google.com with SMTP id i9so4913762oih.4;
        Thu, 06 Jan 2022 10:25:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ROhiqgevVte3w9ZQRyTbiiTLhBkKsROrcWCYs8eyZw0=;
        b=05MdQ/98asJDl5xeRqgi8xpUr+K2o3BYPbNw1bdZYewQj57P1/iLLrqf3g74wr0Fe6
         bn/jRhJkGtp2kzuvZQ70ojUFXCherA9/H11GUhGqKjmmC0eUfLs43KlV0DEKrsBmLLHX
         cp/+5NVL7Rryu1zAuzLWL+JR8GerGjfxB3ykmQ1hqhbHcllI3CFZ8RvjZj0j3Xm2a/A2
         pRWVVmqO5iMoVlcskcwimxIkCaiHR3gm4R1O1LzsFk5rotaB3r8ToYXkjSpV7wfwlyYz
         9xzHQ4+k4NnIOmmRYegveQE4GQxyzuRh2C0wFcxDcNQmBlZ3lO7bcsGRw0fHSVWWPvVq
         x9Aw==
X-Gm-Message-State: AOAM533DS3CpG3kQ7oRALRmcOhqT4Nl4GSvaycsLrXfIvamQvvNf2yX7
        7HSEkY29bMql7xv2QZK2hA==
X-Google-Smtp-Source: ABdhPJzWdvktrVHm/YGEZoFOpv41u8A7/EWOskNlFFIVkbidNaxh1owVVt++IBOvWIBSDh+gZlylCQ==
X-Received: by 2002:a05:6808:bca:: with SMTP id o10mr7294911oik.50.1641493532369;
        Thu, 06 Jan 2022 10:25:32 -0800 (PST)
Received: from xps15.herring.priv (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.googlemail.com with ESMTPSA id r13sm484949oth.21.2022.01.06.10.25.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 10:25:31 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: iio/magnetometer: yamaha,yas530: Fix invalid 'interrupts' in example
Date:   Thu,  6 Jan 2022 12:25:12 -0600
Message-Id: <20220106182518.1435497-4-robh@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'interrupts' does not take a phandle, so remove it in the example.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/iio/magnetometer/yamaha,yas530.yaml     | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/magnetometer/yamaha,yas530.yaml b/Documentation/devicetree/bindings/iio/magnetometer/yamaha,yas530.yaml
index 4b0ef1ef5445..9438fffaf0ba 100644
--- a/Documentation/devicetree/bindings/iio/magnetometer/yamaha,yas530.yaml
+++ b/Documentation/devicetree/bindings/iio/magnetometer/yamaha,yas530.yaml
@@ -96,7 +96,7 @@ examples:
           vdd-supply = <&ldo1_reg>;
           iovdd-supply = <&ldo2_reg>;
           reset-gpios = <&gpio6 12 GPIO_ACTIVE_LOW>;
-          interrupts = <&gpio6 13 IRQ_TYPE_EDGE_RISING>;
+          interrupts = <13 IRQ_TYPE_EDGE_RISING>;
         };
     };
 
-- 
2.32.0

