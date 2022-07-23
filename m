Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9313557ECFC
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 11:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233296AbiGWJRF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 05:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231388AbiGWJRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 05:17:01 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1543A183AA;
        Sat, 23 Jul 2022 02:17:00 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id bp17so11133090lfb.3;
        Sat, 23 Jul 2022 02:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MpbRYZMbv+jsnwV7MLcEk0n+dTDfgsvtYSW0HPusRN8=;
        b=Qud1zLUs/DxmtSFhkAv3+CaeM83rll0gBLUF7bapo3ljdA8LTQOlOi10Au+WXGV6cc
         eroshfe8cdOs5eCNIlR0WRSYWjJSP1+KuJiRb8LkGwLQl3VEP/dzrPYvycS/DPRV0RXN
         P3fcrJ/Wp1Th4156zMfYxxSE/QA3dzBQWFkjFEhWNgUrOlMN0Fjv5kW7RIKhuGTPzmNu
         b4hDzQybOqDA9HNp7fLawfrxhxy4jLJOULGx5Y/oPjtbbeo1rU177Mx7F5OD80GLx3jQ
         NmWsnqfaxn/arR/14uYW3TsXugWWLbE72H5Zr9zPdoTt21gyPqI4DLZuEGUT8IIOqYkc
         jBAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MpbRYZMbv+jsnwV7MLcEk0n+dTDfgsvtYSW0HPusRN8=;
        b=Rt783eUbw6CLxvxETOulwkHm/HvLFqrVGnspohmUTR0KO6YsRZgascHMto0kqKnwMw
         Ur5csztN79yCyG0cysGw+vA9nhd0TY9RO2+eEdTK+qv/jYYuudUiADQegLeTvJsavlS2
         GVudIXjaOZFYewt9DBOvwsb28pfFhMZCU4UDXWhmk0gDzavhEj5DyVWcyRMNkbQco/nL
         XJ4c7rFEcJIUe0bXs2oBlXqySSUmWgHPO5VPSzE0rea6C/J3Pap+iv+EBHlLAJOkuFjV
         5RnJ5OCf8oEuhjvrnvHIhKhisSo1CTpI42SYIO63a898TNPiqeFX7kJS8NtspYfg3ogq
         yIHg==
X-Gm-Message-State: AJIora8roVQyAJtBxiAiLmUHd1qXmiLaAO5OKOpgLnNRHzeXinGH67Bo
        fM1Kwi1q0RdWaY3KCSudzWw=
X-Google-Smtp-Source: AGRyM1sWDymWFb5do1pFCZJUNtOlr5Nz4HXKKz4M3kn41Y+Jl+c6o0nmjoAfR59gir6JpKfQLtda4A==
X-Received: by 2002:a05:6512:1153:b0:48a:2836:692f with SMTP id m19-20020a056512115300b0048a2836692fmr1412627lfg.650.1658567818334;
        Sat, 23 Jul 2022 02:16:58 -0700 (PDT)
Received: from localhost.localdomain (82-209-154-112.cust.bredband2.com. [82.209.154.112])
        by smtp.gmail.com with ESMTPSA id q9-20020a056512210900b0048646c0af5csm1550636lfr.263.2022.07.23.02.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Jul 2022 02:16:57 -0700 (PDT)
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>
Cc:     Kent Gustavsson <kent@minoris.se>,
        Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: Update Microchip MCP3911 to Maintained
Date:   Sat, 23 Jul 2022 11:20:30 +0200
Message-Id: <20220723092030.260812-1-marcus.folkesson@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The actual status of the code is Maintained.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: Kent Gustavsson <kent@minoris.se>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio <linux-iio@vger.kernel.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 85147ee391d5..47dcbfabedf9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13085,7 +13085,7 @@ MICROCHIP MCP3911 ADC DRIVER
 M:	Marcus Folkesson <marcus.folkesson@gmail.com>
 M:	Kent Gustavsson <kent@minoris.se>
 L:	linux-iio@vger.kernel.org
-S:	Supported
+S:	Maintained
 F:	Documentation/devicetree/bindings/iio/adc/microchip,mcp3911.yaml
 F:	drivers/iio/adc/mcp3911.c
 
-- 
2.36.1

