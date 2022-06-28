Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A96355D3B7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344342AbiF1Jqt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 05:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343770AbiF1Jqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 05:46:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3DD125C72;
        Tue, 28 Jun 2022 02:46:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 73E05617C0;
        Tue, 28 Jun 2022 09:46:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 357E2C341D2;
        Tue, 28 Jun 2022 09:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656409590;
        bh=E1S37wDKTg+xS0E091LgAEWJ/wC5uO4LpBsUrtsrhqg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nq+0AY3LCA0eoc4pLTKACsNle3YgbtmWHzZjyu3omVZgbS6g9Ga+k1qfSd9P6I8vy
         /LEOo3hLEILda4Cy4B27lhFo4ditj4Gl+nKUe1IaBXQSJbQmANAPDSbcc0mbsEMQ4L
         YJIHjA6c1R7cSx1QUmFP8WxiPe3V7Sxp6rBjP9c4QMXHblo0ZC16TKGPkVrvtURkie
         pKYOPRzxYowoRNvh/LOBg/mlCVaQ35iGnEj3Ots023/0bSDALfYJOM9xMSy7BRLhxe
         Hq40GV0sON0Itzgzqltku6pZRb/4LZ82nJJrkYFR04FRJ+Cly6nq6GUM+Pf22dpr7/
         wnLs/UF7vk0dQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1o67nf-005HFQ-T9;
        Tue, 28 Jun 2022 10:46:27 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
        Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 13/22] drm: scheduler: add a missing kernel-doc parameter
Date:   Tue, 28 Jun 2022 10:46:17 +0100
Message-Id: <e0a1fd8942a0e13ecf391ccd5634759d2281e2c2.1656409369.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1656409369.git.mchehab@kernel.org>
References: <cover.1656409369.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a description for struct device at drm_sched_init(), in order
to solve this warning:

	drivers/gpu/drm/scheduler/sched_main.c:999: warning: Function parameter or member 'dev' not described in 'drm_sched_init'

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH 00/22] at: https://lore.kernel.org/all/cover.1656409369.git.mchehab@kernel.org/

 drivers/gpu/drm/scheduler/sched_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index 76fd2904c7c6..b45bd8473e9e 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -987,6 +987,7 @@ static int drm_sched_main(void *param)
  *		used
  * @score: optional score atomic shared with other schedulers
  * @name: name used for debugging
+ * @dev: pointer to struct device
  *
  * Return 0 on success, otherwise error code.
  */
-- 
2.36.1

