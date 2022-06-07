Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0317853F648
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 08:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237090AbiFGGjT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 02:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237051AbiFGGjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 02:39:15 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79F48AFADA;
        Mon,  6 Jun 2022 23:39:13 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 25so21353824edw.8;
        Mon, 06 Jun 2022 23:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=DhVbPa5JD/NCAPIDfgE7j6St2qeisk9kSNwgf4Fl99c=;
        b=GMaEKUFbn+aH2o0C8GzroJhWj06s5tKA/rK8dCUAKGrNaf5UFH6QgYSMQiAteuVjgF
         yFI5qyq2PjHlTpKb1zE69kTIpJjTPNnQnfE+SijcjQp+U8HWBKQZ/O4gs8iPyTs7uVKI
         HjFngo1ZzO3pmuuiUUoqMhO6e0oYgdCJs9GW0yQQgEg+jsnFe5ap5Uz2gcJxWg1dpU/T
         6s7QcHHj6kTbaaPE2Lt55hhvGDWMKKqsPqOKOy/j8+PuDeBsrAcNQz3HAMQCGfieLPRr
         gkkMcnoAcrBU6mdY683Q8MwOKaJfrW+Czzz5e0uyJaZTWcT/d2rtyFvwpe8xUv+4xZt1
         wKAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=DhVbPa5JD/NCAPIDfgE7j6St2qeisk9kSNwgf4Fl99c=;
        b=siNzBXzwuXdfdiZAcD9B0mvI7Dadb78y4na/SQdpAI5kk++y5xTA8GueczjRV7Qp5+
         tm2Mx2MFvPV2c+/G2TMA4LGGONeavLBbgojKSMbbCryplOvnTq0fdIvqn6E6G3aKQBgh
         uCBCdh1qpiHL60J7M9Hn3VhBO5rO19i+B1gN4XEcGJKP8jfGf7myjTumsENycbV8B1Pi
         ldVIKToHm0wfZBc0ALkeKWfwTwjPERlObBJdZdL9L8fR7HzAaybhZi1akmhoBgf+w1ew
         ePFnU01KKFLp6eOMgA/KrN8HolUj3V4LrGfBtsNMTC19tT69w4fGD+gT9fq+r+nio0Ph
         zgAw==
X-Gm-Message-State: AOAM532DS+U/Pzs63phZyq9B6Wf9CypQ/QeuBtcpWmxNCo10B3TrHj/s
        GtdbSpQsfldB/EaG4U9MkRo=
X-Google-Smtp-Source: ABdhPJwso8u2gUVGYAfvtXiqZjs3JrvdBEQntAn3TPnL/iDpiO6kkqbnerZdiO7xHOaIV9nSGWhBjQ==
X-Received: by 2002:a05:6402:1f0f:b0:42d:d4a5:a38c with SMTP id b15-20020a0564021f0f00b0042dd4a5a38cmr30730996edb.140.1654583951528;
        Mon, 06 Jun 2022 23:39:11 -0700 (PDT)
Received: from felia.fritz.box (200116b8261d85004489eb5274e8e310.dip.versatel-1u1.de. [2001:16b8:261d:8500:4489:eb52:74e8:e310])
        by smtp.gmail.com with ESMTPSA id g3-20020aa7dd83000000b0042bc5a536edsm9631538edv.28.2022.06.06.23.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 23:39:10 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: remove an obvious typo in MAPLE TREE
Date:   Tue,  7 Jun 2022 08:38:34 +0200
Message-Id: <20220607063834.7004-1-lukas.bulwahn@gmail.com>
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

Commit c6e2362e9289 ("Maple Tree: add new data structure") adds the maple
tree and a corresponding MAINTAINERS section, but slips in an obvious typo.

Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about a
broken reference.

Remove this obvious typo in MAPLE TREE.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
Liam, Matthew, please ack.
Andrew, please pick this minor non-urgent fix into your mm-next tree.

 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8eaf234d663c..572f50739fb2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11792,7 +11792,7 @@ F:	include/linux/maple_tree.h
 F:	include/trace/events/maple_tree.h
 F:	lib/maple_tree.c
 F:	lib/test_maple_tree.c
-F:	tools/testing/_adix-tree/linux/maple_tree.h
+F:	tools/testing/radix-tree/linux/maple_tree.h
 F:	tools/testing/radix-tree/maple.c
 
 MARDUK (CREATOR CI40) DEVICE TREE SUPPORT
-- 
2.17.1

