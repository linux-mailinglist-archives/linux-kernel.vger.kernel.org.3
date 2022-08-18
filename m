Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F57B59845A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 15:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245078AbiHRNkT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 09:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245143AbiHRNjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 09:39:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F0995A3DC;
        Thu, 18 Aug 2022 06:39:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B5B71616C0;
        Thu, 18 Aug 2022 13:39:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 954E2C43150;
        Thu, 18 Aug 2022 13:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660829947;
        bh=/mGgM3BkfqPfFdMup+OXsgoylE1pD7DYoqi4URB8twU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=epyDmNbkr34EBDr61R61CF0gTJmUUP9nSqgxyfp/kREKBeloUK7E9JFnHxms8RPGB
         YWdjB8p0G6N/MOJqnj34YTP/O3j0NLlkwAkjkjAuoeZZmbRz5YZLK+x7DaOz0zoUkv
         i/hF+fRei471IoUVvecDA20J9Gw4u1cISbqvLQyv+IBXtmpR+T/qWbMyiKtMtl71vY
         BtSofY8znmu1LwW1pJB3o4up+rWsvKaVDFVfYF2AeWI2+dKdsx8/Ou2OLF/CBukn2t
         9u2uyngKPXhc1t/UXo7npq+v36VFGnNT1M2k9wf6CujFTkkWWccwJHtsd7sH/vy3tF
         xdLpbwb6FlIcw==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1oOfjl-00AY7p-Ik;
        Thu, 18 Aug 2022 15:39:05 +0200
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>, corbet@lwn.net
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 10/13] docs: leds: add leds-qcom-lpg.rst to the index file
Date:   Thu, 18 Aug 2022 15:38:56 +0200
Message-Id: <14865c294b60fef58f660922889775bd57ce44c2.1660829433.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <cover.1660829433.git.mchehab@kernel.org>
References: <cover.1660829433.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Address this warning:
	Documentation/leds/leds-qcom-lpg.rst: WARNING: o documento não está incluído em nenhum toctree

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

See [PATCH 00/13] at: https://lore.kernel.org/all/cover.1660829433.git.mchehab@kernel.org/

 Documentation/leds/index.rst           | 1 +
 drivers/gpu/drm/scheduler/sched_main.c | 1 +
 include/drm/gpu_scheduler.h            | 1 +
 3 files changed, 3 insertions(+)

diff --git a/Documentation/leds/index.rst b/Documentation/leds/index.rst
index e5d63b940045..014e009b0761 100644
--- a/Documentation/leds/index.rst
+++ b/Documentation/leds/index.rst
@@ -25,4 +25,5 @@ LEDs
    leds-lp5562
    leds-lp55xx
    leds-mlxcpld
+   leds-qcom-lpg
    leds-sc27xx
diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index 68317d3a7a27..56c53a616816 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -994,6 +994,7 @@ static int drm_sched_main(void *param)
  *		used
  * @score: optional score atomic shared with other schedulers
  * @name: name used for debugging
+ * @dev: Device structure
  *
  * Return 0 on success, otherwise error code.
  */
diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
index addb135eeea6..f31988e03256 100644
--- a/include/drm/gpu_scheduler.h
+++ b/include/drm/gpu_scheduler.h
@@ -435,6 +435,7 @@ struct drm_sched_backend_ops {
  * @_score: score used when the driver doesn't provide one
  * @ready: marks if the underlying HW is ready to work
  * @free_guilty: A hit to time out handler to free the guilty job.
+ * @dev: Device structure
  *
  * One scheduler is implemented for each hardware ring.
  */
-- 
2.37.1

