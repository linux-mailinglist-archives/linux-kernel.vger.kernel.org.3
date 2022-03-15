Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03F584DA530
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 23:19:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352173AbiCOWUr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 18:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352174AbiCOWUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 18:20:45 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8E095C647;
        Tue, 15 Mar 2022 15:19:31 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id i8so483922wrr.8;
        Tue, 15 Mar 2022 15:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8T8z6iflW4XiGgdmUlJWREss0zwpqrW7ArvyzTkY4zM=;
        b=lxEl0y0ShtAvyYuhvNC8Q/4+oXxFjSyp28eUVJDpMW6CQEjUnM6BMGVmpYW3th8nkd
         euW34T+fWPWl284pgF6SHEkSvIGa4Hbb0QhBRT/qPaUvE5l0HwSkfbAPUnjiV4Ir/uzD
         NGrLammWYvTAXL3fCpJLmXqqCELSnRwjI+wauZiAp5GexK4nrqLKfSPwakEC9azelsta
         mVN6gTlo3j3fS+kGTEx1suFgJ3kvKl2jsj55HiMPSqfUm2ZjAUmnN9H8wt3/0xsMM8Cb
         uedz/YRd7rRlnsOY+ROrjiV6OFypkesLWvJhNaLbx3L3hip8k3oVsjR4y+808zdcRwPe
         AdDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8T8z6iflW4XiGgdmUlJWREss0zwpqrW7ArvyzTkY4zM=;
        b=cQEzYT4J+cmnvdMzIyX6pT/19Y0uz88K59wcinbXz+9DZK3xMBDxE/IG36cY+LPNo9
         tA70npqVokB4BFEdG3mMbdi6DUkPwWxw+oGJJMckZ7Jd9D0WWDlV9PkinxAIHGs0Xm80
         tzevVcFTWRLSxaVd0AGHPAfzR1oE/lm7p400kxE66yur47qejKr+MnHWRFDDLyh6wqac
         j2lqyCHa1upTPeavyueGTjBK28gQe6uHGMuWa54iSeEtuEXMBGd8PR7mcqeC2p+YqoDB
         5PddydIJZvnzZxsDQVF1xfcCnXekV+eDYGgWTldG35RF/MRIPTIoSR3mX7jQXyxdvkCZ
         x5OA==
X-Gm-Message-State: AOAM5313dZavEW6FkhGoLO7v020svYNpTdjxKqfMqqOwdJiHnoUFwT3Q
        FQLEDgJLvFqLu2hIjqN5hpQ=
X-Google-Smtp-Source: ABdhPJyXK/m628DIv4EB8bxcG/ulR9do+Vkrf7eORkrGXSrrF/fzSZiewYbv/kCVjR8iw1vQkAVUvg==
X-Received: by 2002:a5d:4e51:0:b0:203:dc47:24c2 with SMTP id r17-20020a5d4e51000000b00203dc4724c2mr1236474wrt.628.1647382770264;
        Tue, 15 Mar 2022 15:19:30 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id i15-20020a05600011cf00b001edc2966dd4sm159780wrx.47.2022.03.15.15.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 15:19:29 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Ben Skeggs <bskeggs@redhat.com>, Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/nouveau: Fix spelling mistake "endianess" -> "endianness"
Date:   Tue, 15 Mar 2022 22:19:29 +0000
Message-Id: <20220315221929.2959700-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

There is a spelling mistake in a nvdev_error error message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/gpu/drm/nouveau/nvkm/engine/device/base.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/device/base.c b/drivers/gpu/drm/nouveau/nvkm/engine/device/base.c
index 88d262ba648c..62efbd0f3846 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/device/base.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/device/base.c
@@ -2935,7 +2935,7 @@ nvkm_device_ctor(const struct nvkm_device_func *func,
 		/* switch mmio to cpu's native endianness */
 		if (!nvkm_device_endianness(device)) {
 			nvdev_error(device,
-				    "Couldn't switch GPU to CPUs endianess\n");
+				    "Couldn't switch GPU to CPUs endianness\n");
 			ret = -ENOSYS;
 			goto done;
 		}
-- 
2.35.1

