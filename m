Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAA714DBECD
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 06:55:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbiCQF4Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 01:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiCQF4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 01:56:15 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44DEB2DCBFF
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 22:30:44 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id o26so1845025pgb.8
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 22:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=Gfg0sfM1yOZcobziVscETOqEbK+m4KH2STWY/RhzvKM=;
        b=p/DaaFIBXMKLYKdMeigqMEbkNzz2UmwkZ1EFHnR+vGLGHiUzJ+oKoWCc75yRbblKlU
         XY6wS1b4XYolAjRWWIbz2PyAx1bgYIMsc/BNIwUvTkGVTrriASyMjIxrZlTWbEkWFKc+
         UXp4FsH2NtXkPBUVp8Hjm6oD+oW2I+mh6qhDStIhDHojgZEvqp48XO9zh0KiOf1HRfoK
         3rmwCExGHErobvapU73Qay5djJ77vuKl037+x+eIuxYIb6IQBBkHSZEuQQzhEnbiHm4s
         zHWtECJsTTjb2A09PYM3BfQlKkWw1gwtBiNSPD8mj3xWLFyCUcVjn8ySAgg4nMNupmoQ
         uTcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Gfg0sfM1yOZcobziVscETOqEbK+m4KH2STWY/RhzvKM=;
        b=i87FYNvJ0Fo9PE15NMKKryG9IjUzpzRq5lZTMpqGRKXpxLUIGP2vBAQrIlSZMvi3LV
         SHAh8379f91eFjqeD+6tWE5DtfTef4EFL1kbha14BZh/5UVFUdmEwNnxe6wZH7rBFF1L
         O+HMWyWdafPo1VZ10Q5cbXgljSN6ObSWSH4Lao3teQASSejbKTGt7OIgXVmdVmnzW7Pj
         5+vkgyqs82tqo2aHIosnlq/ytK7Jn+TfVWENKOYHNlfDAy++TqOM0B0xCcRzEBeDioJZ
         ElRF1Atuc5iLYD1X+mU1yWhU6u8xbpldwkBSCLAbO307Pp8ZWoBNzfJWGGrlWzhIKYpw
         vIAA==
X-Gm-Message-State: AOAM533YAlXh3awEsJohj84F/c+L1hIstBGp5WW1dJ/gBIBaWFb0rzZG
        GW0gFXFLI087kwabyTCx78DAQ7RVCQg=
X-Google-Smtp-Source: ABdhPJzkf6aRGNT4PCjsIj3xSQL7MwoZQSgaVrVC2ZHHBuegkwTvvtn8/goU3JG9vEQ+mi8RqnmORg==
X-Received: by 2002:a63:1743:0:b0:381:42cf:187 with SMTP id 3-20020a631743000000b0038142cf0187mr2089420pgx.397.1647490701303;
        Wed, 16 Mar 2022 21:18:21 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com ([12.154.207.45])
        by smtp.gmail.com with ESMTPSA id h13-20020a056a00170d00b004f757a795fesm5047654pfc.219.2022.03.16.21.18.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 21:18:20 -0700 (PDT)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     broonie@kernel.org, shengjiu.wang@nxp.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Xiubo.Lee@gmail.com, festevam@gmail.com, lgirdwood@gmail.com,
        shengjiu.wang@gmail.com
Subject: [PATCH] MAINTAINERS: Add Shengjiu to maintainer list of sound/soc/fsl
Date:   Wed, 16 Mar 2022 21:18:06 -0700
Message-Id: <20220317041806.28230-1-nicoleotsuka@gmail.com>
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

Shengjiu has been actively working on latest FSL platforms and
keeping upstream effort as well, while I have been working on
other subsystem lately and cannot guarantee audio patch review
in the near term. So replacing with him in the maintainer list.

Cc: Shengjiu Wang <shengjiu.wang@gmail.com>
Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 46ffe05eaeb7..bf7a0ae10d06 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7779,10 +7779,10 @@ F:	drivers/net/ethernet/freescale/fs_enet/
 F:	include/linux/fs_enet_pd.h
 
 FREESCALE SOC SOUND DRIVERS
-M:	Nicolin Chen <nicoleotsuka@gmail.com>
+M:	Shengjiu Wang <shengjiu.wang@gmail.com>
 M:	Xiubo Li <Xiubo.Lee@gmail.com>
 R:	Fabio Estevam <festevam@gmail.com>
-R:	Shengjiu Wang <shengjiu.wang@gmail.com>
+R:	Nicolin Chen <nicoleotsuka@gmail.com>
 L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
 L:	linuxppc-dev@lists.ozlabs.org
 S:	Maintained
-- 
2.17.1

