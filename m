Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 501EB57B054
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 07:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236983AbiGTF26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 01:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236380AbiGTF2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 01:28:55 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 010196B24D
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 22:28:54 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id z12-20020a056830128c00b0061c8168d3faso11640873otp.7
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 22:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kali.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EMgpxkjfCt/FmhZrl9x4hRcunizKW+tN6Bk2IeNKyKQ=;
        b=mXDtJvCawto79rB7epMR3MTBCkXqOxcR2YF3HQVBJgdLefbXGdDYYVX+3iwCnR5Mf7
         VEqRnPf4H/2R88zSUO22vRfxokdnmEEKrJk6PG1/tKgx/OJBCmX7sGV61qruC7rB430x
         7CAev2Xyi69EYDiAQ60ZWrv7YtPg1f3HGmUIa2zNHbiN8PJ4pBv720dwwrKz+SMB2WWP
         TLf8Ll4xDBz2uN77dnhIOVT65JG8jcm1qesrhwCSSSQ3wSslEElEd+BWWtDPI1s0dBF+
         UINLvN8W06ST0O88tzQBdIutvtfHJviILJ4gwTLIBWQtZcgA2embjoQwqcKSZWKo9p8K
         msRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EMgpxkjfCt/FmhZrl9x4hRcunizKW+tN6Bk2IeNKyKQ=;
        b=LqGTGMG6BWGat36f3use/Hma4nugxxxMpyAyEQRXp603D5ACx69D1EMBi5rzMQCe/k
         1tc0cxLooAKt2ty9haZ8hNLNGTPQHBWHYHZN3pe/EAuQTBEbtdTC8HeIk9f8DgP7TWid
         zY/H1DA6qBsDuskTqi7P8Gtm5tEn6r+T5pJQuuMwWqf6yXSwFeMIq2M0eeu1fgkdYChJ
         ITplFCwdStZchKkcPMOr8oPExT+N9ZwyV1rCU81XxUhb4CHZi+39XvO4mKJMhqnDzZAx
         /TjK37F1XLT261odSgPmz/T/CVdYX9EAPDl8kdy5xrmO/rS57JCtDJc5HZt+N+DIi3Iz
         +mIg==
X-Gm-Message-State: AJIora8D+6wurOW6t+AFDCwgwGfrdvamJ11aoajRG4rkwSx7he0DARzW
        Xv60fLo5V3EDrqFXqW140tXNbIp8ISBliAf1XoY=
X-Google-Smtp-Source: AGRyM1vn6Kpt3wQVlvK6egDGD+IJjzOjhDu0CYKIWARQfRD4PH+9F6xopwxjGmj7em0OMzbMS5PiFA==
X-Received: by 2002:a9d:6d08:0:b0:61c:bbc4:7996 with SMTP id o8-20020a9d6d08000000b0061cbbc47996mr1010758otp.277.1658294934326;
        Tue, 19 Jul 2022 22:28:54 -0700 (PDT)
Received: from localhost (cpe-173-173-107-246.satx.res.rr.com. [173.173.107.246])
        by smtp.gmail.com with ESMTPSA id be35-20020a05687058a300b0010be134ac60sm8579140oab.19.2022.07.19.22.28.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 22:28:53 -0700 (PDT)
From:   Steev Klimaszewski <steev@kali.org>
To:     steev@kali.org
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/panel-edp: add IVO M133NW4J-R3 panel entry
Date:   Wed, 20 Jul 2022 00:28:40 -0500
Message-Id: <20220720052841.1630-1-steev@kali.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an eDP panel entry for IVO M133NW4J-R3.

Due to lack of documentation, use the delay_200_500_e50 timings for now.

Signed-off-by: Steev Klimaszewski <steev@kali.org>

---
I'm basing my information gathering off what I could find for the IVO
M133NW4J panels on panelook.com.  R0 is glossy, and mine is not.  R2
says it is discontinued, and I am just guessing that I have the R3 as
the Thinkpad X13s just came out, roughly a month ago.
---
 drivers/gpu/drm/panel/panel-edp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index 5024ba690abf..8f89226e9db5 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -1883,6 +1883,7 @@ static const struct edp_panel_entry edp_panels[] = {
 
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x114c, &innolux_n116bca_ea1.delay, "N116BCA-EA1"),
 
+	EDP_PANEL_ENTRY('I', 'V', 'O', 0x854b, &delay_200_500_p2e100, "M133NW4J-R2"),
 	EDP_PANEL_ENTRY('K', 'D', 'B', 0x0624, &kingdisplay_kd116n21_30nv_a010.delay, "116N21-30NV-A010"),
 	EDP_PANEL_ENTRY('K', 'D', 'B', 0x1120, &delay_200_500_e80_d50, "116N29-30NK-C007"),
 
-- 
2.30.2

