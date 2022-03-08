Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7CCA4D12DF
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 09:52:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240827AbiCHIxD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 03:53:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345255AbiCHIww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 03:52:52 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD3974090E;
        Tue,  8 Mar 2022 00:51:51 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id dr20so37504624ejc.6;
        Tue, 08 Mar 2022 00:51:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=weKpcHAcnZbt3XokDlK6GEAJ8PK3dGcUQJAFMx5soSc=;
        b=YcCGih06qdszN3WESTIuZ81II8HBzbpwHe8fbppflLOAsMDS32mq8z8ZH6k101gg8z
         Marfr2hHyKsthm618MBbMYiVdVA7p0nKmGsFmQBjx+pqSw9gF14RDOnfoDL7znJLh3ZM
         p5ZRtxA/H8YeBjfDSHrX+jCNFrR81JY5F48pVVyyx4/qiqepfzkfiDTPkEG/IXA8ztEA
         H5c1LJ0rlF4nOjxRkG+gH8CO4M7pwFEX3PilXFw3o5yk43xLoeAtgC5WkLxXahZsmVcz
         y3EYfnSdy0N6VLdceHkl9iCcx4XMiZULWNJUb/isBhSNlKrS9IzI7eb3J630YL80ojMI
         G7+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=weKpcHAcnZbt3XokDlK6GEAJ8PK3dGcUQJAFMx5soSc=;
        b=7cf/uGO1brkO3wqKM7vlEsnlyIghkIu3QLqa5AA5xO0Q3IUFMHRVyKEseM+4I6sJEw
         Uk+AZ2gQnN8LRcCKMs/hpMyJhvmfFqbVigb7Q+C1skUlmAR1OiH+Muwmbi7jqOdnnTV/
         pXRSBJo+WlrkjpWgp/Y8epK/y6LQ/krRWQx/AICfL7l5t/4jhK7B0UcTHER9Y6ndNLUJ
         NFZ/4ZbG71s+ek1RwcMv0lq4Mc0MLh/0L/BMVB3KBvzI1ALbPqPeeM7MwzQg3JbblWnd
         3QETvmIGSbp3q1gCdafmee5XUwS2QmtRQH8F3OqkFubw1Q0/cLguoYQCKhAgz4hGno0R
         f2PQ==
X-Gm-Message-State: AOAM530i99xAKP+XnkcqEzypAXn+hNs44dzB3GL/3L7B0bD52LmgnTp8
        tZLBLdRdOyEYs5JgQhdYGNsXEEN9Tz4=
X-Google-Smtp-Source: ABdhPJx9TgI8fo2rPRv7i3Gr41qIyvnF3isNGnqAzJKtTTygfNkGSUPBDjqZvpo8BnuURfm23fu/gg==
X-Received: by 2002:a17:906:4a96:b0:6c5:5ea9:5366 with SMTP id x22-20020a1709064a9600b006c55ea95366mr12075447eju.473.1646729510133;
        Tue, 08 Mar 2022 00:51:50 -0800 (PST)
Received: from felia.fritz.box (200116b82626c9000cc91df728b27ead.dip.versatel-1u1.de. [2001:16b8:2626:c900:cc9:1df7:28b2:7ead])
        by smtp.gmail.com with ESMTPSA id z22-20020a17090655d600b006d229436793sm5558656ejp.223.2022.03.08.00.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 00:51:49 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>, linux-renesas-soc@vger.kernel.org
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: rectify entry for ROHM MULTIFUNCTION BD9571MWV-M PMIC DEVICE DRIVERS
Date:   Tue,  8 Mar 2022 09:51:36 +0100
Message-Id: <20220308085136.30753-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 983b62975e90 ("dt-bindings: mfd: bd9571mwv: Convert to json-schema")
converts bd9571mwv.txt to rohm,bd9571mwv.yaml, but missed to adjust its
reference in MAINTAINERS.

Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about a
broken reference.

Repair this file reference in ROHM MULTIFUNCTION BD9571MWV-M PMIC DEVICE
DRIVERS.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
Lee, please pick this minor non-urgent clean-up patch. Thanks.

 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index dc984c050086..c1eed1a2ffc9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16695,7 +16695,7 @@ M:	Marek Vasut <marek.vasut+renesas@gmail.com>
 L:	linux-kernel@vger.kernel.org
 L:	linux-renesas-soc@vger.kernel.org
 S:	Supported
-F:	Documentation/devicetree/bindings/mfd/bd9571mwv.txt
+F:	Documentation/devicetree/bindings/mfd/rohm,bd9571mwv.yaml
 F:	drivers/gpio/gpio-bd9571mwv.c
 F:	drivers/mfd/bd9571mwv.c
 F:	drivers/regulator/bd9571mwv-regulator.c
-- 
2.17.1

