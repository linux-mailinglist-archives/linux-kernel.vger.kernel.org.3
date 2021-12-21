Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E012547BF66
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 13:08:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234494AbhLUMIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 07:08:09 -0500
Received: from mail-qv1-f46.google.com ([209.85.219.46]:46685 "EHLO
        mail-qv1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbhLUMII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 07:08:08 -0500
Received: by mail-qv1-f46.google.com with SMTP id r6so7944373qvr.13;
        Tue, 21 Dec 2021 04:08:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UyRjgdZdH2u6AgkMVpICkiLuJLSjtBenDYwW+5rDy/s=;
        b=2eLFbpESDDYklhrjWrWBJJ6auoLKlyqRkq8BNoP/1D0lQ8MefQADvKga2jjXFidRJJ
         79hhKXFpCnF8O4tKqU+c29+LkVjQukJpppUtKiquIOB5qSrUtbbse/86aDUke1ZQ+YYf
         ppjie3s09Y7BtDU3VTxk+daBe6iPKSXHgzsDLdA9dQaReqUsCew4ggJjZu1FHEmVVuOg
         Xo9BU0PIcm48Tyd70i4Uro1VnC5H/vv8KpIM7jWDiZvmEWNgqsGbCp1f2m0Up8ng1hYc
         hsal2fWnh7RKta2aRIl7j/dH8jzLudKB2jKKz4hVDRVCO07ub75NlSzgdtf7u02bj+t8
         oJNA==
X-Gm-Message-State: AOAM530zAG8cO9LjSNjpVw7dfOY8SEe2poQNEj+7qBW0nVb0VoQ73FRu
        w97nd21gFKU1rC6D3IN22/f027tZZAUB
X-Google-Smtp-Source: ABdhPJxUCvfO3/6AgIojDhEJqT5ULj5uXBQ9FdiM/AissKFlNOuR0vIuj8OAkAeBe93rcL1bbKBHhg==
X-Received: by 2002:a05:6214:c8e:: with SMTP id r14mr1914861qvr.38.1640088487045;
        Tue, 21 Dec 2021 04:08:07 -0800 (PST)
Received: from xps15.. ([24.55.105.145])
        by smtp.googlemail.com with ESMTPSA id h1sm420885qta.54.2021.12.21.04.08.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 04:08:06 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH] regulator: dt-bindings: samsung,s5m8767: Move fixed string BUCK9 to 'properties'
Date:   Tue, 21 Dec 2021 08:07:43 -0400
Message-Id: <20211221120744.1118518-1-robh@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's no need for a fixed string like 'BUCK9' to be under
'patternProperties', so move it under 'properties' instead.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/regulator/samsung,s5m8767.yaml         | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/regulator/samsung,s5m8767.yaml b/Documentation/devicetree/bindings/regulator/samsung,s5m8767.yaml
index 80a63d47790a..6c8ad82bd69c 100644
--- a/Documentation/devicetree/bindings/regulator/samsung,s5m8767.yaml
+++ b/Documentation/devicetree/bindings/regulator/samsung,s5m8767.yaml
@@ -54,8 +54,9 @@ patternProperties:
     required:
       - regulator-name
 
+properties:
   # 9 buck
-  "^BUCK9$":
+  BUCK9:
     type: object
     $ref: regulator.yaml#
     unevaluatedProperties: false
-- 
2.32.0

