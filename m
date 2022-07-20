Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E587357C0D4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 01:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbiGTXXw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 19:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiGTXXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 19:23:46 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FC5A4F6A4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 16:23:46 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id b9so135252pfp.10
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 16:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qfR3nLVFTpPA1Jo8g/Je7VqV/ARVjZfsoCJM7fq7n1Q=;
        b=fk92LRXo71Y0CPzDYBJaWRSrrPIdnW2K0E7OcNS0kun4eWarkJNZenVXQg6rq1fHNo
         rXGY5vBM5HgEQnOnqGH+H/PisEoSVo1xQetvC8EgO+Ks2tsk1EmNGROqQqXzmCu1CoeA
         HbIHShxSzNA4Mdgl4hihAREh+wfQ2RyBs94JY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qfR3nLVFTpPA1Jo8g/Je7VqV/ARVjZfsoCJM7fq7n1Q=;
        b=qjFgOf036ShzCQL88/RSzd4rRYoFQXFSBGKfCYhuvaH7NnON0A8jhPobecIC0fUpdB
         h0V8spXtkxje+AELZraKUZmatsNDWiOhOcZKYGr4iD8ac4Zodr/XlkWdDuMyhGwtzgvz
         du5LhnZZ/jvbbalYRAUHPypvfMrcyAXhs5/ueIcPSXGbQ7h7gWRxGLKeeQ9hkaZnXmTV
         uIbJNtJiMHEgkcVdk8U15u5PcVZ0usKIvmqE9Q5ocNZCCv7xMXInIkDOvWDbvZsTEwNy
         zZ2zURqs9eeC9qlHzMFbe/qEPH0sc+04APb/YjFH76af1Pl5lzfz249FgntwJXZ+fFWA
         xZ8A==
X-Gm-Message-State: AJIora85lWfUCBj1EeY53bGloMFhz/lqZjV2ZgY6KYZBkUg/9zgn6nkA
        dt70G8tZjpaL5KgQxSZz6KhmPSTxRwuW7BPq
X-Google-Smtp-Source: AGRyM1v2SZ2co4GgiSaGYwPciyT9GbzocP88EbzijPvszQAqdL25QsyvCrJhVJCFgHLbj0XBJQM2kg==
X-Received: by 2002:a63:2a95:0:b0:41a:27e5:1996 with SMTP id q143-20020a632a95000000b0041a27e51996mr15706166pgq.447.1658359425843;
        Wed, 20 Jul 2022 16:23:45 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:fdb4:f565:8767:5019])
        by smtp.gmail.com with ESMTPSA id z3-20020a623303000000b0052895642037sm175853pfz.139.2022.07.20.16.23.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 16:23:45 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     dri-devel@lists.freedesktop.org
Cc:     Douglas Anderson <dianders@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/panel-edp: Fix typo in kerneldoc comment (appers=>appears)
Date:   Wed, 20 Jul 2022 16:23:21 -0700
Message-Id: <20220720162314.1.Ieef5bc3848df40b71605b70bb571d6429e8978de@changeid>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ever since I got the spell-check working in my editor this one has
been bugging me. Fix it.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/gpu/drm/panel/panel-edp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index e6645d6e9b59..07a383dff548 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -53,7 +53,7 @@ struct panel_delay {
 	 * before the HPD signal is reliable. Ideally this is 0 but some panels,
 	 * board designs, or bad pulldown configs can cause a glitch here.
 	 *
-	 * NOTE: on some old panel data this number appers to be much too big.
+	 * NOTE: on some old panel data this number appears to be much too big.
 	 * Presumably some old panels simply didn't have HPD hooked up and put
 	 * the hpd_absent here because this field predates the
 	 * hpd_absent. While that works, it's non-ideal.
-- 
2.37.0.170.g444d1eabd0-goog

