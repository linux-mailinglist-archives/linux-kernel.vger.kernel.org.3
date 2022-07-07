Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4009356A2EB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 14:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235932AbiGGM4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 08:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235854AbiGGM4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 08:56:00 -0400
Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com [209.85.215.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 243292E9E1
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 05:55:06 -0700 (PDT)
Received: by mail-pg1-f195.google.com with SMTP id r22so11450634pgr.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 05:55:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=djYDp0B0gztHKzMN1HyH5UR5VL/m7SL/hwecWzC/xyU=;
        b=sFPqsHzBXVjoXe7aW0S1MW9HoKBwMgv7Ph0GMD5n0zOYcFIczeLEQazqS2fk/6LK5m
         ratPwqDjXrVKAsHXXdG5zr4sJhH4YkW4X/M+cEH5S65fcfLBAlxdpLvfXqPtMCMg+DPD
         D/E53qcQ60qlREMU5bIJBNUSLRZnS6jTHhIjhcQ6snbsJy3j7r7XSSjnfjtv/r+V27O+
         w5c1Qmfne0TepvWqegDrGL8WFSbzYnlo/FMFGqJZZp6oFZTsT/cJUDkmR+1pGop8+K24
         c9E31TaVVJ7CflX4mdUHLyplkyIsC3Kar5tIvP0eRUY3vfqi2GZHShra9uYjUrTMd03S
         N6QQ==
X-Gm-Message-State: AJIora81itObzGQNGzoJIdW1x8wsxcO4c8uvkZWwKAn7orr4nmXAXWKd
        NtK6i0dYbgdPqakOczpePYWvLucz8Q==
X-Google-Smtp-Source: AGRyM1tsQHYY3ss6PLRUQEO52WR2JENZTdnZeq5P0fawokSFx6PG2+gxT2yTdaO76TadjVUsI29k2Q==
X-Received: by 2002:a63:105d:0:b0:40d:a82d:ef0e with SMTP id 29-20020a63105d000000b0040da82def0emr40249055pgq.57.1657198505371;
        Thu, 07 Jul 2022 05:55:05 -0700 (PDT)
Received: from localhost.localdomain ([156.146.53.107])
        by smtp.gmail.com with ESMTPSA id u7-20020a170902e80700b0016bf28cc606sm6103044plg.156.2022.07.07.05.54.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 05:55:05 -0700 (PDT)
From:   sunliming <sunliming@kylinos.cn>
To:     harry.wentland@amd.com, alexander.deucher@amd.com,
        airlied@linux.ie, daniel@ffwll.ch
Cc:     amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        sunliming@kylinos.cn, kelulanainsley@gmail.com,
        kernel test robot <yujie.liu@intel.com>
Subject: [PATCH] drm/amd/display: Remove redundant header file references.
Date:   Thu,  7 Jul 2022 20:54:46 +0800
Message-Id: <20220707125446.379104-1-sunliming@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following includecheck warning:

drivers/gpu/drm/amd/display/dc/os_types.h: drm/drm_print.h is included more than once.

Reported-by: kernel test robot <yujie.liu@intel.com>
Signed-off-by: sunliming <sunliming@kylinos.cn>
---
 drivers/gpu/drm/amd/display/dc/os_types.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/os_types.h b/drivers/gpu/drm/amd/display/dc/os_types.h
index 795dd486b6d6..6b88ae14f1f9 100644
--- a/drivers/gpu/drm/amd/display/dc/os_types.h
+++ b/drivers/gpu/drm/amd/display/dc/os_types.h
@@ -39,8 +39,6 @@
 #include <drm/display/drm_dp_helper.h>
 #include <drm/drm_print.h>
 
-#include <drm/drm_print.h>
-
 #include "cgs_common.h"
 
 #if defined(__BIG_ENDIAN) && !defined(BIGENDIAN_CPU)
-- 
2.25.1

