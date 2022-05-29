Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8951537212
	for <lists+linux-kernel@lfdr.de>; Sun, 29 May 2022 20:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231577AbiE2SGP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 14:06:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbiE2SGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 14:06:11 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABBA264BD6;
        Sun, 29 May 2022 11:06:10 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id u3so11970300wrg.3;
        Sun, 29 May 2022 11:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=egOqVJUvNJLIiV7jwC1/3AK6X0edWl7/LSTpDO7/hxw=;
        b=iiPG0jYLC3KBNhr/u8+qCRThSj4O9RQg/wByapvQyntKOpUOgTfPpP10Q6Vi6uRxqS
         jbQadlB+dSaPF4XhRWx1tw+S+/MOsmjQSU4fy6nv2FWUjlc3hRbMAg3gEQLjJCcDPUFC
         RRqteZnBhBjcbFHaIgzWhOxrqb4c9KoZyzgehw4quG7y9Jyl9KnsZ/Hvuk/wW4GeFWA+
         s6RP0LDjSCB3UeWbzuPBq+ezsJwR22WKZ23MGKnbUtPqU2MBsvxrllQnDR98+lcCvJqH
         sBc6fqX0umsujotzrjy3eQ6ttUbTO+caMbcLMi/6wvf1/Dny2w7XoMqdjQ+NR9jW6vMa
         3rnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=egOqVJUvNJLIiV7jwC1/3AK6X0edWl7/LSTpDO7/hxw=;
        b=YLbijnlKATCc8+UCAPKFaMQuQ1uxr/4meuX5YnqbZAxejmVwULMOvgw+cQ6t7XFQFV
         HvzkcoU5klnhbfLFhOqTkmjnjUCRaJiVWqBMktqXNkrtljh45SeM+FXlPi2QD8SOKRhN
         Ax3XaESTeZmorDnl9Ii6h6kvS5/q0v+tZ7VIXLqVVg2zVQ3ZRBcKB29/DQkyI8BztHRZ
         mVw42S6kpPMfroH9/oL7dHETYm1UBhzhQ1eN8HRhvw0VMJ6OL5DhfP0i4QLjMBdR+PSP
         9qH/jqxvwVWRIFN4oeP1ngO5KWsrRDarGgcRQQ9EQ4JJEyQNJ2fAv0nTmPDfMaS5EuEI
         M4dA==
X-Gm-Message-State: AOAM530QuX9eGj+jyC0R2/H/PkDMZL5tEzZHc+lZRKJVO6rvAIUN1gb4
        h4rfVdWTMUE6WaWKAKSjZ+I=
X-Google-Smtp-Source: ABdhPJwxNisg9lbeEIOBcPGM5wnGOuNoVK2NmwHGZY/ZrI+8SGNGwNuQeMoYPKVxGZFA6B5ZdkHE3g==
X-Received: by 2002:a05:6000:1843:b0:20e:79ca:3e12 with SMTP id c3-20020a056000184300b0020e79ca3e12mr37523479wri.150.1653847569072;
        Sun, 29 May 2022 11:06:09 -0700 (PDT)
Received: from localhost.localdomain ([188.163.112.60])
        by smtp.gmail.com with ESMTPSA id q7-20020a056000136700b002100f2e6a7dsm7008516wrz.93.2022.05.29.11.06.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 May 2022 11:06:08 -0700 (PDT)
From:   Svyatoslav Ryhel <clamor95@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Svyatoslav Ruhel <clamor95@gmail.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Anton Bambura <jenneron@protonmail.com>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/3] Support Sharp LQ101R1SX03 and HannStar HSD101PWW2 panels
Date:   Sun, 29 May 2022 21:05:45 +0300
Message-Id: <20220529180548.9942-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for Sharp LQ101R1SX03 and HannStar HSD101PWW2
display panels that are used by Asus Transformer tablets, which we're
planning to support since 5.17 kernel.

Changelog:
v5: - previously patches were sent by Dmitry and he asked me to resend them

v4: - Added r-b from Rob Herring that he gave to the LQ101R1SX01 DT patch
      of v2. I missed to add it to the v3 by accident.

v3: - No changes. Re-sending for 5.18. Device-trees of devices that use
      these panels were merged to 5.17, so we're missing the display support.

v2: - Added ack from Rob Herring to the HSD101PWW2 binding.

    - Updated LQ101R1SX01 binding, like it was suggested by Rob Herring,
      making LQ101R1SX03 directly compatible with the LQ101R1SX01.
      Such that ["sharp,lq101r1sx03", "sharp,lq101r1sx01"] could be
      used in DT. This removes need to update panel driver with the new
      compatible.

    - Improved commit message of the LQ101R1SX03 patch.

    - Added my s-o-b to all patches.

Anton Bambura (1):
  dt-bindings: sharp,lq101r1sx01: Add compatible for LQ101R1SX03

Svyatoslav Ryhel (2):
  dt-bindings: display: simple: Add HannStar HSD101PWW2
  drm/panel: simple: Add support for HannStar HSD101PWW2 panel

 .../bindings/display/panel/panel-simple.yaml  |  2 ++
 .../display/panel/sharp,lq101r1sx01.yaml      |  7 ++++-
 drivers/gpu/drm/panel/panel-simple.c          | 28 +++++++++++++++++++
 3 files changed, 36 insertions(+), 1 deletion(-)

-- 
2.25.1

