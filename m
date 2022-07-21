Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F7CA57C42B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 08:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232050AbiGUGKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 02:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbiGUGKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 02:10:03 -0400
Received: from mail-m973.mail.163.com (mail-m973.mail.163.com [123.126.97.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9A6D97AC29
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 23:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=8fb4x
        1akCvlUXUMioyKceSFntPYEMvNKMVv5UYR2aeY=; b=QCIr1DZn8/FhJ/NS0YKTG
        BK1SqIc5VDjk2PyHZakZqCcFiEnIrV2vg1n9WId4mydKguhOHv9zSUyCiw/LT5/K
        lU3M7SQgdCodo/K58NmDDuzIv3DO6bEUwV6UEitZgtJOlitQBi+yNncvp9yy7CWX
        EOjyTic5gIfUrivRCXsNiQ=
Received: from localhost.localdomain (unknown [112.97.57.47])
        by smtp3 (Coremail) with SMTP id G9xpCgBHzl6r7dhiL36xQQ--.2111S2;
        Thu, 21 Jul 2022 14:09:50 +0800 (CST)
From:   Slark Xiao <slark_xiao@163.com>
To:     alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, daniel@ffwll.ch, airlied@linux.ie
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Slark Xiao <slark_xiao@163.com>
Subject: [PATCH] drm/amd: Fix typo 'the the' in comment
Date:   Thu, 21 Jul 2022 14:09:46 +0800
Message-Id: <20220721060946.46462-1-slark_xiao@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: G9xpCgBHzl6r7dhiL36xQQ--.2111S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZFykXFWUXw15Kw4rAFWkZwb_yoW8uFW3pF
        W8Krs2kFyDZa42q347Ga4YvFn5JayqgFWrCFnrW398u3W5AFy8ZFnxKrW8JrWkKr4xCr42
        yrn8W3yY9r1qqr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0z_xR6AUUUUU=
X-Originating-IP: [112.97.57.47]
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/1tbiGQ5FZFyPdl3FkwAAsY
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace 'the the' with 'the' in the comment.

Signed-off-by: Slark Xiao <slark_xiao@163.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 2 +-
 drivers/gpu/drm/amd/include/atombios.h    | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index ff659d4f772b..8adeb7469f1e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -47,7 +47,7 @@
  * for GPU/CPU synchronization.  When the fence is written,
  * it is expected that all buffers associated with that fence
  * are no longer in use by the associated ring on the GPU and
- * that the the relevant GPU caches have been flushed.
+ * that the relevant GPU caches have been flushed.
  */
 
 struct amdgpu_fence {
diff --git a/drivers/gpu/drm/amd/include/atombios.h b/drivers/gpu/drm/amd/include/atombios.h
index 1f9df4e7509b..15943bc21bc5 100644
--- a/drivers/gpu/drm/amd/include/atombios.h
+++ b/drivers/gpu/drm/amd/include/atombios.h
@@ -3255,8 +3255,8 @@ ucMaxNBVoltageHigh:     Voltage regulator dependent PWM value. High 8 bits of  t
 ucMinNBVoltageHigh:     Voltage regulator dependent PWM value. High 8 bits of the value for the min voltage.Set this one to 0x00 if VC without PWM or no VC at all.
 
 
-usInterNBVoltageLow:    Voltage regulator dependent PWM value. The value makes the the voltage >=Min NB voltage but <=InterNBVoltageHigh. Set this to 0x0000 if VC without PWM or no VC at all.
-usInterNBVoltageHigh:   Voltage regulator dependent PWM value. The value makes the the voltage >=InterNBVoltageLow but <=Max NB voltage.Set this to 0x0000 if VC without PWM or no VC at all.
+usInterNBVoltageLow:    Voltage regulator dependent PWM value. The value makes the voltage >=Min NB voltage but <=InterNBVoltageHigh. Set this to 0x0000 if VC without PWM or no VC at all.
+usInterNBVoltageHigh:   Voltage regulator dependent PWM value. The value makes the voltage >=InterNBVoltageLow but <=Max NB voltage.Set this to 0x0000 if VC without PWM or no VC at all.
 */
 
 
-- 
2.25.1

