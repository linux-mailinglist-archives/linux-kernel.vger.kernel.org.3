Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71DC8565D9F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 20:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbiGDSx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 14:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbiGDSxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 14:53:23 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 635ABFC9;
        Mon,  4 Jul 2022 11:53:22 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id l40-20020a05600c1d2800b003a18adff308so6218222wms.5;
        Mon, 04 Jul 2022 11:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T1YetwhZb3OgibIUGFFuv352SwQk2UY8NZnYhEM765U=;
        b=lNmrkBXzGPjuvDVI9s8mP5gy3z8tuSbD3fF5goEhL+xcTBkDvxLphfho2IGzOMVnFE
         PRS4P3AwX8EKEkrn5c9JBZX7JrNoc0o2mKo8QFgx/CTByvzT282a6O5kjKgRyOAqx/rl
         Iepu4fPVQ1F7LnhPqKkuYTowGsthDaO4IE7nGUtszRw5+x3Wfz3yJA2eb1LoHb/GmBzi
         7GIvfxBSrRgw+l3YG3dV8+Mn29s/ewYutcOlpfAVPI6Ss5SyrFXrAy0jYtPMSmrvmR7O
         EXNaMbXXzPcgf4Q0khCAgh9C+poLbndlE1zaveKYow1JLUsBpRU42bcDdrwS994bYRy+
         sAKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T1YetwhZb3OgibIUGFFuv352SwQk2UY8NZnYhEM765U=;
        b=Azr0QlJfld3Ub6pU8qziTQLZ/+9V1yZuOVeWjXFcBJ8QNR9C9cMpfunCPqY6hWiazy
         XKIDTBvvYyvDHR6ZoDccNIMgMKqAZ0ToOtugyfEc2nUyrnEpOBX9MvfBUZYd4nai822/
         k4BuA+GO11aLtgpAaFY+Ri6lKJ4wiIsOvobe7DoY3BYAU4wpWXozYS27/6C4uSFLELYj
         eNN/ixEFLgalMe3kdDCHzg0KZqCkMPa1FIy2lwslOaPEhscrWA0JfSHuJA6eqI07Rpgi
         U+3KoPRgyt+ZWguNflBjvX4eiZUFiOaADMhsnaFUcfwxQEKcdR70RBExl+wRgXxKyn6d
         GzhA==
X-Gm-Message-State: AJIora/zq4AWcZeaos0iGetkOTVLi8HwwTZJ4QbgYE1Zyn5Qg+iwuHHM
        DluxySeyEx80pGR86HqANbw=
X-Google-Smtp-Source: AGRyM1vrBQHyhEqZZoyA4hn6r7CWyFalKKLaQYe4c6q+MWprWZDioffoMIe1RQn59/cE20iBV1Leyg==
X-Received: by 2002:a05:600c:2315:b0:3a1:772e:b9a6 with SMTP id 21-20020a05600c231500b003a1772eb9a6mr29213575wmo.34.1656960800853;
        Mon, 04 Jul 2022 11:53:20 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id by13-20020a056000098d00b0021b89f8662esm7273877wrb.13.2022.07.04.11.53.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 11:53:20 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] fs/ntfs3: remove duplicated assignment to variable r
Date:   Mon,  4 Jul 2022 19:53:19 +0100
Message-Id: <20220704185319.592631-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.35.3
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

The assignment to variable r is duplicated, the second assignment
is redundant and can be removed.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 fs/ntfs3/run.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/ntfs3/run.c b/fs/ntfs3/run.c
index 7609d45a2d72..aba8ab1b9fcb 100644
--- a/fs/ntfs3/run.c
+++ b/fs/ntfs3/run.c
@@ -563,7 +563,6 @@ bool run_insert_range(struct runs_tree *run, CLST vcn, CLST len)
 	e = run->runs + run->count;
 	r = run->runs + index;
 
-	r = run->runs + index;
 	if (vcn > r->vcn)
 		r += 1;
 
-- 
2.35.3

