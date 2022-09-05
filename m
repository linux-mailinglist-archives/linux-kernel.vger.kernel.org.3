Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9180E5AD01D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 12:33:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237813AbiIEKaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 06:30:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237798AbiIEK3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 06:29:54 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22760167F7;
        Mon,  5 Sep 2022 03:29:51 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id az27so10731521wrb.6;
        Mon, 05 Sep 2022 03:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=M1AP6Atmetovg7lAnags9GJU89MAMFpSOvpMrYiFWV0=;
        b=EkRe7f7iRcc4Rl24NStMSAU/XVqygbgvTjibv4/zcOwWvmwxlsEP6+OAuEYJM5JB5A
         qaGoZg4MRKZRS3Uys7qZqxUvtb7BM4DXMXh3B8ZpJyezXRo8IkcgGLrKR7UTa5sdJKTv
         wLrqIm7brKphtGhEG6LCrVMEla5XTrZSyF+bdQuM4FQ1dQjyPLuID4bg9tobo35uWm+p
         BuF+d5jQFKmMZv4mpZRQLB55WLVAg9kYJIJz1FQSVAm/x4+OtV81nePfw51AvQB2ycpy
         Q0Ys9S1RzExTKPaO8C/7JgLEgwrm4J77Mf7MmZfnvOlJRECVdUTT+BSCL1md8XSWppOb
         VGhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=M1AP6Atmetovg7lAnags9GJU89MAMFpSOvpMrYiFWV0=;
        b=XpMVm+DHKQ5SEf6Toyd6mgc8BHx3jo0B1yu1kNz2iIYMeX6f6CQ8KcVwS5YbcUdy5W
         gYvcvgT2UeA+Y6pFeozzxhhizRQgLVPpzj+T80STlcMTRsSp/ZaSpiwR3YtF6GE0iGKU
         Y51xYPmIA788Jnb4mewLixDSaFy/iS9eCyKNkWFDGdUtAbLlS1B46IQS5ysBjEWY2RYe
         qgENo3xSTbRYHR72SBScgTyCtL2PBtFxuce5tLjnD97WoDlXsT8LXnHZ8Buzj0QllCoL
         EJssNaSx8oL8Pi970grt7DUp1wAUtVvB0u2f24HWEndu9x2/kPqmbRmQdy8P4cYYnrLL
         Qxvg==
X-Gm-Message-State: ACgBeo3VzhryEF1nHB21PPlHE68XjphyGRt8Foyl7Dch1pRjFioRRkH5
        Ptkbm4IgGDzy2ksfOSObSCY=
X-Google-Smtp-Source: AA6agR6hzC/4RA4uscoKQWC5XbeWIsVFwm75CCLd+HhKy8eJjogkni+nvy/NtAPyLPRPsv2RAbiNLg==
X-Received: by 2002:a05:6000:813:b0:226:da5a:84a9 with SMTP id bt19-20020a056000081300b00226da5a84a9mr20315871wrb.309.1662373790044;
        Mon, 05 Sep 2022 03:29:50 -0700 (PDT)
Received: from felia.fritz.box (200116b8268cc400942297814b5b37b6.dip.versatel-1u1.de. [2001:16b8:268c:c400:9422:9781:4b5b:37b6])
        by smtp.gmail.com with ESMTPSA id az3-20020a05600c600300b003a6a3595edasm10589190wmb.27.2022.09.05.03.29.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 03:29:48 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] media: MAINTAINERS: rectify entry in SAA7146 VIDEO4LINUX-2 DRIVER
Date:   Mon,  5 Sep 2022 12:29:39 +0200
Message-Id: <20220905102939.19766-1-lukas.bulwahn@gmail.com>
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

Commit e33fdb5a0249 ("media: saa7146: deprecate hexium_gemini/orion, mxb
and ttpci") moves some media drivers to the staging subsystem, and
unfortunately only partially adjusts the entry in MAINTAINERS.

Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about a
broken reference.

As the files matching include/media/drv-intf/saa7146* are moved to
drivers/staging/media/deprecated/saa7146/common, this directory is already
covered by the existing file entry
drivers/staging/media/deprecated/saa7146/.

Repair this file reference in SAA7146 VIDEO4LINUX-2 DRIVER.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 228d3a9ddc34..72e119158612 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17982,7 +17982,6 @@ L:	linux-media@vger.kernel.org
 S:	Maintained
 T:	git git://linuxtv.org/media_tree.git
 F:	drivers/staging/media/deprecated/saa7146/
-F:	include/media/drv-intf/saa7146*
 
 SAFESETID SECURITY MODULE
 M:	Micah Morton <mortonm@chromium.org>
-- 
2.17.1

