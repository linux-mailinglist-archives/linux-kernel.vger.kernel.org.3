Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5FA6574C17
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 13:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238897AbiGNL2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 07:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238861AbiGNL2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 07:28:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB4B459261
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 04:27:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0006CB824B7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 11:27:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0621BC341C8;
        Thu, 14 Jul 2022 11:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657798075;
        bh=+SPLt9VP2GO4YubuyjOhsJ0inE13AM1tjfBKmcp7OXw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BQeDMfu+l230j+0OepCir8xMrGwiGH3Z6tgemP5TgJTMlzRrOh5n1/Sz8kljQnNaX
         2TiWrCP4JKunT7ru4hRcfMFhuN4ddTQtYilKNEDFB8LomvHnmZy9NwXVph6AiZZ7Ps
         wgHxAYrJnI4DPg2CqTm9zAIjuhqtenomSS/APSPorZux2eBasWq0oRcYIlpaLlanWa
         kkjJqO37k9JRbzRaJMZeW4H/cP5PA0j7Z7kJONI1uo23YRMpyPIzwFi+znC3EMFdDy
         10vOjsXXQ3p1nJkHdj3c8LmZLUVh5Bo95wnz+/wgGZWgTPwKqsgWZzDM7PA3Py5vQS
         VVzLgQuXaRupA==
From:   Lee Jones <lee@kernel.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: [PATCH 5/8] docs: ABI: sysfs-devices-soc: Update Lee Jones' email address
Date:   Thu, 14 Jul 2022 12:25:30 +0100
Message-Id: <20220714112533.539910-6-lee@kernel.org>
X-Mailer: git-send-email 2.37.0.144.g8ac04bfd2-goog
In-Reply-To: <20220714112533.539910-1-lee@kernel.org>
References: <20220714112533.539910-1-lee@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Going forward, I'll be using my kernel.org for upstream work.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Lee Jones <lee@kernel.org>
---
 Documentation/ABI/testing/sysfs-devices-soc | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-devices-soc b/Documentation/ABI/testing/sysfs-devices-soc
index ea999e292f111..5269808ec35f8 100644
--- a/Documentation/ABI/testing/sysfs-devices-soc
+++ b/Documentation/ABI/testing/sysfs-devices-soc
@@ -1,6 +1,6 @@
 What:		/sys/devices/socX
 Date:		January 2012
-contact:	Lee Jones <lee.jones@linaro.org>
+contact:	Lee Jones <lee@kernel.org>
 Description:
 		The /sys/devices/ directory contains a sub-directory for each
 		System-on-Chip (SoC) device on a running platform. Information
@@ -14,14 +14,14 @@ Description:
 
 What:		/sys/devices/socX/machine
 Date:		January 2012
-contact:	Lee Jones <lee.jones@linaro.org>
+contact:	Lee Jones <lee@kernel.org>
 Description:
 		Read-only attribute common to all SoCs. Contains the SoC machine
 		name (e.g. Ux500).
 
 What:		/sys/devices/socX/family
 Date:		January 2012
-contact:	Lee Jones <lee.jones@linaro.org>
+contact:	Lee Jones <lee@kernel.org>
 Description:
 		Read-only attribute common to all SoCs. Contains SoC family name
 		(e.g. DB8500).
@@ -59,7 +59,7 @@ Description:
 
 What:		/sys/devices/socX/soc_id
 Date:		January 2012
-contact:	Lee Jones <lee.jones@linaro.org>
+contact:	Lee Jones <lee@kernel.org>
 Description:
 		Read-only attribute supported by most SoCs. In the case of
 		ST-Ericsson's chips this contains the SoC serial number.
@@ -72,21 +72,21 @@ Description:
 
 What:		/sys/devices/socX/revision
 Date:		January 2012
-contact:	Lee Jones <lee.jones@linaro.org>
+contact:	Lee Jones <lee@kernel.org>
 Description:
 		Read-only attribute supported by most SoCs. Contains the SoC's
 		manufacturing revision number.
 
 What:		/sys/devices/socX/process
 Date:		January 2012
-contact:	Lee Jones <lee.jones@linaro.org>
+contact:	Lee Jones <lee@kernel.org>
 Description:
 		Read-only attribute supported ST-Ericsson's silicon. Contains the
 		the process by which the silicon chip was manufactured.
 
 What:		/sys/bus/soc
 Date:		January 2012
-contact:	Lee Jones <lee.jones@linaro.org>
+contact:	Lee Jones <lee@kernel.org>
 Description:
 		The /sys/bus/soc/ directory contains the usual sub-folders
 		expected under most buses. /sys/bus/soc/devices is of particular
-- 
2.37.0.144.g8ac04bfd2-goog

