Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B0CD4EAB51
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 12:34:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235195AbiC2KgX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 06:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235184AbiC2KgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 06:36:21 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55CDF2CCA6;
        Tue, 29 Mar 2022 03:34:36 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id ke15so13980910qvb.11;
        Tue, 29 Mar 2022 03:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aANeBL0m3LmSP3dECp2J5wZnDSo6Du/pm89aOfFASWU=;
        b=jdPD1Ok/EP0MAsV+pBnwl4krVmzQYmhR3yct0VzqtGV/iet2+Bh0aMTVyAOKffqzdj
         zFxIjHrI79PA0/EkcykYHBUMpZ+UN3/tEof+ad/4vFuZf3YPWkrlKugYJ+eC/nad5iPw
         TkqVpjGGyXtlLJUwAISpOgQTQkoC/SZW8ywZoDDO4TyZ2FUSHcJ81Oy0QhWLM60pytoT
         Wfkv9Aezj+CKhJ+H+uxHVAgw2lpsEJHAYowKQWNIlI72d9ePriR8P9NdHzaLBOBEisZe
         DR6l71NqmCmUYRrSM3Z5uAHOQTdtxNnMEbdPCyFode4/wnPl30QvgK3Z4PolMhmguVpY
         vfvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aANeBL0m3LmSP3dECp2J5wZnDSo6Du/pm89aOfFASWU=;
        b=FU4ooZkZk6LcdgscbmDBuhmxc6G5l2hIEoj0O+aJlCq+enoVXK2BoAPbAZWB8+UaVK
         x0moTI16kUuZscFHzFFC4vEhnXyy9E32Df1EfoTcoxkq9mzMyi2lbmsFjdoYyoEdbhHH
         S2tTj6EeWRjdU/s7+BpDOqK/Js6/3YiOOekxipIdm5v/VJnvv0ntOKH9+cv/amewnpwo
         ZrMAZWRcVWUwHB0wWy1RWiAaDfsJtUE4nRzP+1bBZR+5qlaZtlr1FC1VInlfAhy5hpf+
         4BD5gI8G1MTHuVrrZRbSsPrj5gqcIQSSA16bAizd5F6XuGfisKBUeVSTFeCxHdiy8NNU
         z3Jg==
X-Gm-Message-State: AOAM533sEbHwNnH2hy+9gNJNNrTo9HcBwjcq8qXflf1VQc+dBVqf0Fjg
        8BUipVFOG68e5TYKAR3mU6E=
X-Google-Smtp-Source: ABdhPJz31/qk/lbKvZcxtFiVePIvBfOpXdDxA9FpgWoHvH6i5FkLDwV3L4gLJuzuwYPhfVr2xY7cWQ==
X-Received: by 2002:a05:6214:22c:b0:432:6b2b:95d0 with SMTP id j12-20020a056214022c00b004326b2b95d0mr25374527qvt.63.1648550075469;
        Tue, 29 Mar 2022 03:34:35 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id a14-20020a05620a066e00b0067d36cc5b12sm8941753qkh.87.2022.03.29.03.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 03:34:35 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: lv.ruyi@zte.com.cn
To:     robdclark@gmail.com
Cc:     sean@poorly.run, quic_abhinavk@quicinc.com, airlied@linux.ie,
        daniel@ffwll.ch, dmitry.baryshkov@linaro.org,
        bjorn.andersson@linaro.org, lv.ruyi@zte.com.cn, greenfoo@u92.eu,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] drm: msm: add null pointer check
Date:   Tue, 29 Mar 2022 10:34:16 +0000
Message-Id: <20220329103416.2376616-1-lv.ruyi@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lv Ruyi <lv.ruyi@zte.com.cn>

kzalloc is a memory allocation function which can return NULL when some
internal memory errors happen. Add null pointer check to avoid
dereferencing null pointer.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Lv Ruyi <lv.ruyi@zte.com.cn>
---
 drivers/gpu/drm/msm/disp/msm_disp_snapshot_util.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/msm/disp/msm_disp_snapshot_util.c b/drivers/gpu/drm/msm/disp/msm_disp_snapshot_util.c
index 5d2ff6791058..acfe1b31e079 100644
--- a/drivers/gpu/drm/msm/disp/msm_disp_snapshot_util.c
+++ b/drivers/gpu/drm/msm/disp/msm_disp_snapshot_util.c
@@ -176,6 +176,8 @@ void msm_disp_snapshot_add_block(struct msm_disp_state *disp_state, u32 len,
 	va_list va;
 
 	new_blk = kzalloc(sizeof(struct msm_disp_state_block), GFP_KERNEL);
+	if (!new_blk)
+		return;
 
 	va_start(va, fmt);
 
-- 
2.25.1

