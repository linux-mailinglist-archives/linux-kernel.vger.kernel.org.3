Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14DB154825E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 10:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbiFMIvn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 04:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240558AbiFMIvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 04:51:41 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 547DEB1DD;
        Mon, 13 Jun 2022 01:51:40 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id x5so6165931edi.2;
        Mon, 13 Jun 2022 01:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=3rvOcjBqs1stdMUxQr8PedtmVi6/pRZU8HZK/5D9mX0=;
        b=jeybOxuqIIOR+8rj1ITlZhxbNOJ7NpncY4wTlVF4S+WdfBPfdn5KF4/XiAhyiEnAVt
         uqWGKsIVz/7jLISM/+OIZKgg/zz8Oe2V8g4LnKe22dm5J3OgTBGEBuQ/+vv5gdp4X5Cr
         UXYZ/LsTwtngw8W3twsx8J15f9V2JnV5TZ5abxjoxIncQsf33tx1IYXPRsqIsFJu2nWk
         TpC8Ry8qJkPsHj9V/Lut9jnTitKGhSTyAnuBm//jevuXmFLSrcXXos/FwXYUJ7dc9Oco
         UTgC8tQQHqBkjb2dwCIZky5QunFnwZ2/KW9OWiYoXxmyNEariCeT/C4z52Gd8OwWm97N
         q/pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3rvOcjBqs1stdMUxQr8PedtmVi6/pRZU8HZK/5D9mX0=;
        b=U1gAI7/NKDUg7OO8TFemkQzDgDzDXd8Ae0Lt7GgJtI6ShwuAi/sxuuMzPey1FvLaQx
         ko148OFZK8436MDWMQTvRd7X6D6pk1l72z2KBIhJJ6MC8Ae3nG19+RpfjytVKxsHpAQv
         5n0+WmDEtBYeJfmqAv70OOPu9Oc8DzLLRjXQV1DWzV3o2iZ8I9fK6EVYOTig6w7e2joN
         eaRqtt/r4FBiAL3wE/XyPo3VXdwJjv+lbtlWD7UZlATiE2O5Aq7MsviGEgJtE7ERH9nV
         6bFA1OQCkhb9zyVkytcrxi9p5XkSS6cYsg2mRenmPUBcoBCnTC76uDdvYLSTkBve0zLf
         ePkQ==
X-Gm-Message-State: AOAM530WMFk9b7R7hOxNZBrU1FiWDBWnIPz2AmZQgy6OfAtBgNkeqSTB
        aVgGGaHtmuWvhJek2g633uDxfVdbblY=
X-Google-Smtp-Source: ABdhPJxvbKo+0ZKTIuYmeCYp3MTRhPEPP1M9mite+BnQUo4qt7+h9LN39t7ONWltk2NywAvSyLUJVw==
X-Received: by 2002:a05:6402:2789:b0:42d:ce10:1d6 with SMTP id b9-20020a056402278900b0042dce1001d6mr64339618ede.188.1655110298718;
        Mon, 13 Jun 2022 01:51:38 -0700 (PDT)
Received: from felia.fritz.box (200116b8260df50089ef6db2443adc92.dip.versatel-1u1.de. [2001:16b8:260d:f500:89ef:6db2:443a:dc92])
        by smtp.gmail.com with ESMTPSA id q8-20020a056402040800b0042dd4f9c464sm4477714edv.84.2022.06.13.01.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 01:51:38 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: add include/dt-bindings/clock to COMMON CLK FRAMEWORK
Date:   Mon, 13 Jun 2022 10:51:00 +0200
Message-Id: <20220613085100.402-1-lukas.bulwahn@gmail.com>
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

Maintainers of the directory Documentation/devicetree/bindings/clock
are also the maintainers of the corresponding directory in
include/dt-bindings/clock.

Add the file entry for include/dt-bindings/clock to the appropriate
section in MAINTAINERS.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
Michael, Stephen, please pick this MAINTAINERS addition to your section.

 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 475e28365385..2e7d1e885aed 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4970,6 +4970,7 @@ Q:	http://patchwork.kernel.org/project/linux-clk/list/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git
 F:	Documentation/devicetree/bindings/clock/
 F:	drivers/clk/
+F:	include/dt-bindings/clock/
 F:	include/linux/clk-pr*
 F:	include/linux/clk/
 F:	include/linux/of_clk.h
-- 
2.17.1

