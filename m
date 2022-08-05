Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D2BB58AE21
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 18:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241231AbiHEQ21 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 12:28:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241218AbiHEQ2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 12:28:22 -0400
Received: from mx01.ayax.eu (mx01.ayax.eu [188.137.98.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 613F8EE3A
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 09:28:19 -0700 (PDT)
Received: from [192.168.192.146] (port=51430 helo=nx64de-df6d00)
        by mx01.ayax.eu with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <gszymaszek@short.pl>)
        id 1oK0BC-0007q1-E6; Fri, 05 Aug 2022 18:28:08 +0200
Date:   Fri, 5 Aug 2022 18:28:05 +0200
From:   Grzegorz Szymaszek <gszymaszek@short.pl>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Greg KH <gregkh@linuxfoundation.org>,
        Phillip Potter <phil@philpotter.co.uk>
Cc:     Philipp Hortmann <philipp.g.hortmann@gmail.com>,
        Grzegorz Szymaszek <gszymaszek@short.pl>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH v2 3/4] staging: r8188eu: drop the DRV_NAME macro
Message-ID: <f8d7b4ba4533a315ebd6711f17bbfd81e99ccf5a.1659715931.git.gszymaszek@short.pl>
Mail-Followup-To: Grzegorz Szymaszek <gszymaszek@short.pl>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Greg KH <gregkh@linuxfoundation.org>,
        Phillip Potter <phil@philpotter.co.uk>,
        Philipp Hortmann <philipp.g.hortmann@gmail.com>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
References: <cover.1659715931.git.gszymaszek@short.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1659715931.git.gszymaszek@short.pl>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DRV_NAME macro is not used anywhere; KBUILD_MODNAME should be used
instead. Remove the macro declaration.

Link: https://lore.kernel.org/lkml/Yuy7Lc%2FTJMinuupA@kroah.com/
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Grzegorz Szymaszek <gszymaszek@short.pl>
---
V1 -> V2: Split v1-0003 into v2-0003 and v2-0004. Remove the DRV_NAME
          macro, since KBUILD_MODNAME should be used instead

 drivers/staging/r8188eu/include/drv_types.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/r8188eu/include/drv_types.h b/drivers/staging/r8188eu/include/drv_types.h
index f51b83515953..f659eac70b32 100644
--- a/drivers/staging/r8188eu/include/drv_types.h
+++ b/drivers/staging/r8188eu/include/drv_types.h
@@ -10,8 +10,6 @@
 #ifndef __DRV_TYPES_H__
 #define __DRV_TYPES_H__
 
-#define DRV_NAME "r8188eu"
-
 #include "osdep_service.h"
 #include "wlan_bssdef.h"
 #include "rtw_ht.h"
-- 
2.35.1
