Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 240424F1E51
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 00:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350763AbiDDWGL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 18:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379143AbiDDQha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 12:37:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8561E094;
        Mon,  4 Apr 2022 09:35:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5450AB8185C;
        Mon,  4 Apr 2022 16:35:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E25DC34110;
        Mon,  4 Apr 2022 16:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649090131;
        bh=jY1ehkq5K86uPGP2fbD9b7UNiEgcBssb2Z6xVzhvgOc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c1KYp8ZqC9rHDWhrCuqapYynxk3RnSSvlNdipQ6aXQD08ljSkDKG0/7vibzlWpvxe
         I7AIeVNbErEvAp+HuVpENr8HAoyrv+dTTkexR9ekCmuaJS9A/jwSBTKISJq+SzSqYD
         yKpfpNOQCzqzkBX44ihK8QoazHscsXc5Wug0aaPOi35bo76Voqqks4XduPvsw+GFkX
         xP14agr0oyI7F0KxuwFiUWaitg1xpLaTjtmOBWMhdVV/P6hIz89k3Ju+gyyi26CT1M
         AC9bbm+Yg+sZFpUSzSdHFYhBOJL6nDdLcBBS2UTnS4lN6T56750t4RJ5uhjDKUWYKy
         MlfV1AsCRKcAw==
From:   Vinod Koul <vkoul@kernel.org>
To:     Rob Clark <robdclark@gmail.com>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jonathan Marek <jonathan@marek.ca>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org
Subject: [PATCH v6 09/14] drm/msm: Add missing num_dspp field documentation
Date:   Mon,  4 Apr 2022 22:04:31 +0530
Message-Id: <20220404163436.956875-10-vkoul@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220404163436.956875-1-vkoul@kernel.org>
References: <20220404163436.956875-1-vkoul@kernel.org>
MIME-Version: 1.0
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

Somehow documentation for num_dspp was missed, so add that

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/gpu/drm/msm/msm_drv.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
index 2a3280df7b12..bf2ccff97562 100644
--- a/drivers/gpu/drm/msm/msm_drv.h
+++ b/drivers/gpu/drm/msm/msm_drv.h
@@ -102,6 +102,7 @@ enum msm_event_wait {
  * @num_lm:       number of layer mixers used
  * @num_enc:      number of compression encoder blocks used
  * @num_intf:     number of interfaces the panel is mounted on
+ * @num_dspp:     number of dspp blocks used
  */
 struct msm_display_topology {
 	u32 num_lm;
-- 
2.34.1

