Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CB704C3590
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 20:16:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233455AbiBXTQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 14:16:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233456AbiBXTQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 14:16:43 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B319238904
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 11:16:12 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id l25so4309641oic.13
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 11:16:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n40igkM5fpLZE91wSpHa85KT0DIax0l2iCyVpysGJcc=;
        b=CzbgbwcVGX/WBH4XbrVbhqDUPdTI9ZHKQWSiHWJyt3saQW/NNWRgDAx+ambOI6/gYy
         WRUNWx4uXp8eU0gbNmuRHgN2DCrlNxAps4mDLs34bVqxsQhc0F6P8KczHctuOHAyw4NQ
         uEBQhlY8ng/tyr684AZO6AVCkgbnY0DHryBUC0LHHMAWQT8gIqAWpiSkVRvFqkGnxrSP
         PXFpwWCk+39h4HW2ydih+hOCGW4bIdw916DQnSGQWn30OgWLDjexpPl5bdoS52+8A+K4
         vnmq0LI+ErF4X/JNTUzphCrP+04w3WtqMVQ91bG/YW3n7dpUVkOAScYljG9GSiwyhKJc
         SGsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n40igkM5fpLZE91wSpHa85KT0DIax0l2iCyVpysGJcc=;
        b=c0VPgaO8La+EhV5lX7s8h26ytswtD82NjiNtuvJjSqX55MBUj+cB70YgkV1ZCXJU5x
         T+pp7bXl5rTDurFFhVdiN/O3EdHC2AOFknyIs1AN3QReDrNvQcuWlgh2qbEqD3XoHz7g
         z2/3eLA27W/MGcxSsQHpZRFb1wFu9zKxYfUV/n5qUddpLpbZpXDO9/8pCoAWyw2KDfQY
         NGUWZv9tWm+yI/4ruInIsk/Zqe6mfDKQMdD9ouZH7OUXVW0cheos85XvTlDCK57xTKg5
         uF63yNhawE8ehKI61IbjVVW2NdI/Srq8SABzPm8PB3amOvnmbBdo51aXPpJsV2v6KMqN
         o+gg==
X-Gm-Message-State: AOAM530WKyqGpHVqyvBSZHNLVh9HJrp6fT5Lnhop6fA83SEEN4gbWzWc
        GWDKTza6sd0UmZJ06hap64Q=
X-Google-Smtp-Source: ABdhPJyQKFGospMUmtjTUcVamd2qh9gUUUs4aJXtYL05staz72GZsPMYAdf2vzZDxTEY9Ymhmuz1+Q==
X-Received: by 2002:a05:6808:ecd:b0:2cd:90e5:25cb with SMTP id q13-20020a0568080ecd00b002cd90e525cbmr7785276oiv.128.1645730171832;
        Thu, 24 Feb 2022 11:16:11 -0800 (PST)
Received: from localhost.localdomain (189-47-54-110.dsl.telesp.net.br. [189.47.54.110])
        by smtp.gmail.com with ESMTPSA id w3-20020a056830110300b005af14392276sm79509otq.62.2022.02.24.11.16.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 11:16:10 -0800 (PST)
From:   Magali Lemes <magalilemes00@gmail.com>
To:     airlied@linux.ie, alexander.deucher@amd.com,
        christian.koenig@amd.com, daniel@ffwll.ch, harry.wentland@amd.com,
        Rodrigo.Siqueira@amd.com, sunpeng.li@amd.com, Xinhui.Pan@amd.com
Cc:     siqueirajordao@riseup.net, mwen@igalia.com, maira.canal@usp.br,
        isabbasso@riseup.net, Magali Lemes <magalilemes00@gmail.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] Address a few compilation warnings
Date:   Thu, 24 Feb 2022 16:15:47 -0300
Message-Id: <20220224191551.69103-1-magalilemes00@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

This patchset addresses a few warnings reported by the Kernel Test Robot and
sparse.

Magali Lemes (4):
  drm/amd/display: Adjust functions documentation
  drm/amd/display: Add conditional around function
  drm/amd/display: Use NULL instead of 0
  drm/amd/display: Turn functions into static

 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c   | 4 +++-
 .../gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c  | 2 +-
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_smu.c  | 4 ++--
 drivers/gpu/drm/amd/display/dc/core/dc.c                    | 6 +++---
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c           | 2 +-
 drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c | 4 ++--
 drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c     | 4 +---
 .../gpu/drm/amd/display/dc/irq/dcn315/irq_service_dcn315.c  | 2 +-
 8 files changed, 14 insertions(+), 14 deletions(-)

-- 
2.25.1

