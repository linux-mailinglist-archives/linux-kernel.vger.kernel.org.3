Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 241D056B78E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 12:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237764AbiGHKmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 06:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237691AbiGHKmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 06:42:23 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DB6D804A9;
        Fri,  8 Jul 2022 03:42:22 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id bk26so14901801wrb.11;
        Fri, 08 Jul 2022 03:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JNLK2rDLllywqVSRYR5bhiW0euJmRmqXRdRAao8DCak=;
        b=hNAlF244GSZTujP2eVPybCkbb6vohkncV87L8NOv0gg1xt+UCrMJIcl4Ov97BPJrHE
         QIySBdjZPDvE41kXki8bZiZUEEwu6bwpg1+mDOcwyWb55VlPwjH+S9LjurjkdqQ86WV5
         CTPVmo1lndtXxro61uo530WATKGF9/B9Z/3jTnn+55IbeFwNAZLtYj36CVV7l72wiQvv
         wvMEAWSuDCHAX1CG9qTwiFRcdeb8lM+MRKE00a7rjS0DHQ+hKmocBcFFtMwNkVwLYD2K
         P+jt5L4OtKwrswNHIYRXnjbSc+J9KSfzd6JK64FpP21KCYBDi4yxU5ZbHbGbGQendhiT
         zSow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JNLK2rDLllywqVSRYR5bhiW0euJmRmqXRdRAao8DCak=;
        b=waYYbO2KbueDhmCAVoxBOtssVn7DDyNS2AQH3CRiEXmYiUKBpJk2G7idNN9KuqoFAK
         mF+4kAgyx6ANXh5MFM6UIHr9Z1U04w9aKhd+yPTbXlwxjTbZTBecT+fwPgjSPKHpxPwG
         kdrUK8ygEFqLEhH4hdI1olFUFPbU1U4nBisBSsaCNJJnP7WkKUE+NCtNgJp+t3i58R9t
         4cjaoHx910iQcxCAvY6lB7ggR9RXbb0rEIwjmGgj4UCNk2IGvvsf6eV3NgEtNwTTzWRN
         zPbkotWTj1Rxz3hpR41g0tMjYzs1G/CRGY68NFw6TxlFa6o9UGnq0jXqgI2vSB7H8MLQ
         LGjA==
X-Gm-Message-State: AJIora+zyaUcheWa6MYNiNdtVWJ2RmbhwhIXMYqSo9CXkc9FnIYoTD+i
        iLO2mcyqq74g+Ol/d8AMvL8=
X-Google-Smtp-Source: AGRyM1t8n+yXqdXi4Z0qUnAyHliZ8oHhKlMiBBcwPTRakdev7E/nceSPKxhKk0l2w3v6C5FKiE4+4w==
X-Received: by 2002:a5d:4649:0:b0:21b:c48e:3ce2 with SMTP id j9-20020a5d4649000000b0021bc48e3ce2mr2726765wrs.312.1657276940772;
        Fri, 08 Jul 2022 03:42:20 -0700 (PDT)
Received: from localhost (92.40.203.220.threembb.co.uk. [92.40.203.220])
        by smtp.gmail.com with ESMTPSA id o9-20020a1c7509000000b003a050a391e8sm1594074wmc.38.2022.07.08.03.42.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 03:42:20 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     paul@crapouillou.net, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com
Cc:     linux-mips@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 01/11] ASoC: jz4740-i2s: Remove unused 'mem' resource
Date:   Fri,  8 Jul 2022 11:42:54 +0100
Message-Id: <20220708104304.51415-2-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20220708104304.51415-1-aidanmacdonald.0x0@gmail.com>
References: <20220708104304.51415-1-aidanmacdonald.0x0@gmail.com>
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

This isn't used and doesn't need to be in the private data struct.

Acked-by: Paul Cercueil <paul@crapouillou.net>
Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 sound/soc/jz4740/jz4740-i2s.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/jz4740/jz4740-i2s.c b/sound/soc/jz4740/jz4740-i2s.c
index ecd8df70d39c..c4c1e89b47c1 100644
--- a/sound/soc/jz4740/jz4740-i2s.c
+++ b/sound/soc/jz4740/jz4740-i2s.c
@@ -93,7 +93,6 @@ struct i2s_soc_info {
 };
 
 struct jz4740_i2s {
-	struct resource *mem;
 	void __iomem *base;
 
 	struct clk *clk_aic;
-- 
2.35.1

