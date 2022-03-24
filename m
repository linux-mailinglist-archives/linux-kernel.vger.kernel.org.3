Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96BD44E69FA
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 21:50:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354650AbiCXUuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 16:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348762AbiCXUuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 16:50:02 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A87F310FC9
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 13:48:29 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id a16-20020a17090a6d9000b001c7d6c1bb13so1281124pjk.4
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 13:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GG7xcgP8KogrXkBePaXl+4bClRR1k79q93eHVgdUvSk=;
        b=D3Q8y529PwqyfS5PVX8DwsdCUg0U/LWDSxTMXKN6D0PD01vTbFT6LgGJTZgHaBVYP8
         uEZrF0KxgnmfRGCjQZ6p3UPGc1YMoV63ECt2oHJSTXejl94bw6Rzu7R+hQrIoiia4rza
         FiIfuUAlomLatVAKjESElnRw8s3fyDpN9nmCE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GG7xcgP8KogrXkBePaXl+4bClRR1k79q93eHVgdUvSk=;
        b=Nal70PKrohfghhSenJWJJLDEn/JlJZ3XUTroZKPHdhf3eLA4BD0O6S3r3F8911UUsN
         3Fh30b7Bx3Kn1rj2wJIR8uhPFtAzB9L1FGNzFNiRCDUlc+H9I1IN4QuWEz19UGE4ePjf
         IxA5u/lkcC/zHDv5cahEmJDY1SkTI54leOfuwlO23BB0cmrVpfJhsK4yKFsLgnaPQYKj
         WEUQ+qtGY4oSZMY4WcNnIhnodFEUdwP5j3730TXYSPts/V9dUxeAIP1M40N2Bj6YERnx
         2SNzOTIEsx/VT6/InNHebYgz1V85bRBrDNVzvr//cfTYxYcYrTf9x/kORHbuz/vRGDzH
         T5aw==
X-Gm-Message-State: AOAM532yg8RO4WoMuJRGrGXdSR64fyi7C98TC1Uxbg0IYvo1HT0q35ph
        ZMQG8ApHRa+DTgJyTU6xUGetMQ==
X-Google-Smtp-Source: ABdhPJy6Z5zGJlS8f1aZx1sYZGuE4IYgYVKHa+bduhmaJPIor9q/oCOZxzUIkEbIlSy52NtFmexsBQ==
X-Received: by 2002:a17:902:c40e:b0:154:80a7:95c9 with SMTP id k14-20020a170902c40e00b0015480a795c9mr8184844plk.28.1648154909060;
        Thu, 24 Mar 2022 13:48:29 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:690f:642:3ebe:c89d])
        by smtp.gmail.com with UTF8SMTPSA id nn15-20020a17090b38cf00b001bfceefd8cfsm10249927pjb.48.2022.03.24.13.48.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Mar 2022 13:48:28 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v2] panel-edp: drm/panel-edp: Add AUO B133UAN01
Date:   Thu, 24 Mar 2022 13:48:25 -0700
Message-Id: <20220324134819.v2.1.I816014b6c62da5a33af5021f3cc35cea66552c00@changeid>
X-Mailer: git-send-email 2.35.1.1021.g381101b075-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the AUO B133UAN01 13.3" WUXGA panel.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---

Changes in v2:
- autodetect and configure the panel based on the EDID data instead of
  relying on a compatible string and hardcoded mode settings.

 drivers/gpu/drm/panel/panel-edp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index e15e62f235d8..db4eea1d7f67 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -1847,6 +1847,7 @@ static const struct panel_delay delay_100_500_e200 = {
 static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x405c, &auo_b116xak01.delay, "B116XAK01"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x615c, &delay_200_500_e50, "B116XAN06.1"),
+	EDP_PANEL_ENTRY('A', 'U', 'O', 0x8495, &delay_200_500_e50, "B133UAN01.0"),
 
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0786, &delay_200_500_p2e80, "NV116WHM-T01"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x07d1, &boe_nv133fhm_n61.delay, "NV133FHM-N61"),
-- 
2.35.1.1021.g381101b075-goog

