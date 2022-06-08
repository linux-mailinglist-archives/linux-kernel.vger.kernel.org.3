Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DABE1543FF9
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 01:40:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbiFHXkC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 19:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233809AbiFHXj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 19:39:58 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA2B716B2F5
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 16:39:50 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id hh4so16046688qtb.10
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 16:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=qQ2RizqshOjzvB3iH/wwzC+NVOLya1wNYtoVU7GxDvM=;
        b=UAUcZUkiV3VZQTR71Swi9iSLP2iNUgDgdZHzGDfJ1q/EFyU2zOn3EEmie/e/d8eyrk
         BCOb4HzXqzi46EUby2v8egnyivPyJ7IOpkpbUgurwodmXHMd2jq472sLIjoalYSwQxJO
         4YxfrIRcr9xYU16fuugZ8uiVRNZdTkZQ5gpERziLKwu4cAfIa2ye+Iq/EB/Upc+nwD/b
         Qr8CG2/CjIe6vW19WYbiVvTvibQB/Nc9ON1c0nmBWGmLiB5d0N8DNXHJeZLE4sJmxDqx
         uOIBbgt+OPOL5bndMn27FUTwT/Qh0ZyJHEztS4IoOPqfcby1uaM4OWWT+HBGl4wCGOtN
         ReaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=qQ2RizqshOjzvB3iH/wwzC+NVOLya1wNYtoVU7GxDvM=;
        b=iwboSroQW1UodPWhKXhgZN5dRWs+BW8G4T503vHZewqikyBUKr+/5sIc6rpzZDysFC
         agtv9cDmT/X1ty8tF7jX8s2ktbP7rRkTygb4TBvY6VGURvQah9E6DQ+AZEZZqF533Hb7
         8TyCbpPdCPQO+3zMQkUD0IdQtDwJudyfInSDgbW+50FRZzjjkVIL/uPnxInT9AAfRLVv
         cGgL1eXgoFmSsviP2W7Tpaccr+nQPq+D/i0bMLurLFtQF4SckY8guS9dR45yyCnaLiRz
         0pT/TcmGgKnbDgS6EC5WE7ZTPQvh2Dn9lUs8RY1gPJUu6rVJ70ykhJtupElP/leB9yAU
         kNmA==
X-Gm-Message-State: AOAM530KI37yRU/dITX7Z0YydhVcIai+wQgehqxsfcHpuzwJZ/hI1ll2
        PVSwddebQtDpwGQ8F0GLYkO4TQDRhWZtJSjHKA5SOg==
X-Google-Smtp-Source: ABdhPJwtH2lhtilN1G9Xw/rEf0VpiHf/XCVrIWgDPfCF0plfDp6bJ/WTYHxyxCYLxZFEeB0dzqn7AnVcRfYOD7c28rY=
X-Received: by 2002:a05:622a:5ce:b0:304:c37f:e7c5 with SMTP id
 d14-20020a05622a05ce00b00304c37fe7c5mr29342704qtb.398.1654731589495; Wed, 08
 Jun 2022 16:39:49 -0700 (PDT)
MIME-Version: 1.0
From:   Atul Khare <atulkhare@rivosinc.com>
Date:   Wed, 8 Jun 2022 16:39:39 -0700
Message-ID: <CABMhjYp4ChJ3KfP=jQmA5nnv7YB=Kkanjb2KwDEVWSS+Sn5m1g@mail.gmail.com>
Subject: [PATCH v2 2/2] dt-bindings: sifive: add gpio-line-names
To:     Palmer Dabbelt <palmer@rivosinc.com>,
        Atul Khare <atulkhare@rivosinc.com>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-riscv@lists.infradead.org, Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes device tree schema validation messages like 'gpio-line-names'
does not match any of the regexes: 'pinctrl-[0-9]+' From schema: ...
sifive,gpio.yaml'.

The bindings were missing the gpio-line-names element, which was
causing the dt-schema checker to trip-up.

Signed-off-by: Atul Khare <atulkhare@rivosinc.com>
---
Changes since v1 [1]: Rebased on latest version
[1]: https://tinyurl.com/yvdvmsjd
---
---
 Documentation/devicetree/bindings/gpio/sifive,gpio.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpio/sifive,gpio.yaml
b/Documentation/devicetree/bindings/gpio/sifive,gpio.yaml
index 939e31c48081..787ce7300118 100644
--- a/Documentation/devicetree/bindings/gpio/sifive,gpio.yaml
+++ b/Documentation/devicetree/bindings/gpio/sifive,gpio.yaml
@@ -47,6 +47,9 @@ properties:
     default: 16

   gpio-controller: true
+  gpio-line-names:
+    minItems: 1
+    maxItems: 32

 required:
   - compatible
--
2.34.1
