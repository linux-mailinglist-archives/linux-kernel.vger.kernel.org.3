Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 502CC53C9DD
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 14:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244336AbiFCMUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 08:20:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244317AbiFCMUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 08:20:02 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA70D26AE1
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 05:20:01 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id l20-20020a17090a409400b001dd2a9d555bso7100820pjg.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jun 2022 05:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Fq2Ar1e2ZR5JL+WTMutSf70OTR0Z9U3rGO5z4u4hDlY=;
        b=leCQRj2GwhtOylMw1bAfwDMhy6jYfoPNNBT+/pC7WbhCEwkiwIB+kn3gcxTPMHoODi
         4lxYLey53F2hBU31d1o+2My7iNvffZykNuGWBB5lKXJLO8Q0RLdwE9r42Wp7pwsYmijL
         yogb4eSJEa7Q1Zovhgca7xTZId2xmY+uh5gS/JnRVZtA52krzdvyrSlDzF1tMuaIbegv
         0IvtgDfEeyfY5Fb9eyD1iWwgOBr5Pv68alCksoLJUX793m+c/YA8Dyd5bW5WTsAk0ETY
         vC3OXVLbnqIDdpop66aAEwof9cwOgFGDPBD6pz6wAxlHsSYjzX1Ufv2XhQ970yZoqK+O
         HGbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Fq2Ar1e2ZR5JL+WTMutSf70OTR0Z9U3rGO5z4u4hDlY=;
        b=ei7TDEWUt+uubi4z+hFSJOAyYpo74MoIZM+ihPn250v95SUwHmMi1eQAgpBOVbCWa1
         pUUBIUUpwxeGMXLoQSUc05OFYBlayQ9Z5lr6UiwjhGd8Y7TlV4qyP9F7xVd2qi/GrEfW
         yVJzyLQou0U2RAXpO/RIqQ8ySnvk8juu8+ctS7uLO2PGdMmrcpF73V8iobEuxFIkcJX5
         ik6w8IvxpDBsdCFe6tybgMwv3SsN5jtCKmMfsLHmn2rc2XqW8VJkFv7/G6IUx5W/pgJg
         fd1jbVF8Ut4vqzN72lJbYFx+CKSoS6lUoJlYxanyMmzSGdTtmL7UMYiOjq5uYW2Dh0uq
         iTDw==
X-Gm-Message-State: AOAM531CxFljR1COpcaAzILoq7u1h9E4q1qKXxPGAcCLGnPizCGP1dG5
        tZAIHzQQtgHElNZ8Q5nSb1k=
X-Google-Smtp-Source: ABdhPJxBYPtYCDgqbR6kISfLKqqf59ArnoO4o+YdZk3hIgGrcdmUvi5l49pGytbuVS7RPisd2T9M5g==
X-Received: by 2002:a17:90b:38c4:b0:1e6:89f9:73da with SMTP id nn4-20020a17090b38c400b001e689f973damr8476735pjb.220.1654258801381;
        Fri, 03 Jun 2022 05:20:01 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id ju10-20020a17090b20ca00b001df264610c4sm5439385pjb.0.2022.06.03.05.19.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 05:20:00 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Russell King <linux@armlinux.org.uk>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: mxs: Fix refcount leak in mxs_machine_init
Date:   Fri,  3 Jun 2022 16:19:48 +0400
Message-Id: <20220603121950.24422-1-linmq006@gmail.com>
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

of_find_node_by_path() returns remote device nodepointer with
refcount incremented, we should use of_node_put() on it when done.
Add missing of_node_put() to avoid refcount leak.

Fixes: 2046338dcbc6 ("ARM: mxs: Use soc bus infrastructure")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
changes in v2:
- update Fixes tag.
v1 Link: https://lore.kernel.org/r/20220603120314.15488-1-linmq006@gmail.com
---
 arch/arm/mach-mxs/mach-mxs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-mxs/mach-mxs.c b/arch/arm/mach-mxs/mach-mxs.c
index 25c9d184fa4c..7d957cadd3e9 100644
--- a/arch/arm/mach-mxs/mach-mxs.c
+++ b/arch/arm/mach-mxs/mach-mxs.c
@@ -393,6 +393,7 @@ static void __init mxs_machine_init(void)
 
 	root = of_find_node_by_path("/");
 	ret = of_property_read_string(root, "model", &soc_dev_attr->machine);
+	of_node_put(root);
 	if (ret)
 		return;
 
-- 
2.25.1

