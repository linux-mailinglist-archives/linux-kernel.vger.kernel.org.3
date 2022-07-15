Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D03CE578388
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 15:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235336AbiGRNTk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 09:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235152AbiGRNTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 09:19:37 -0400
Received: from smtpbg.qq.com (biz-43-154-54-12.mail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0B25B36;
        Mon, 18 Jul 2022 06:19:30 -0700 (PDT)
X-QQ-mid: bizesmtp80t1658150360t8pqe7jr
Received: from localhost.localdomain ( [171.223.96.21])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 18 Jul 2022 21:19:19 +0800 (CST)
X-QQ-SSF: 01000000002000E0U000C00A0000020
X-QQ-FEAT: MB/sfHAJ7zngxfje4S1PQzvCa25c10g9kz5pxgbqSLeTl9U0Ls0lDUCGGmIUl
        +aOiING8KwD3Wc652/+QS8EYnshxGmiYOo8hzNwNxju/qhNJKoOFaUUUgRBvNgzvb+yNeQq
        sHSgicMvMeKhd4NvlxlWqgux+jLvHBgB+r767+u/fl2Z/IOXHBrPBhvwNkqHNu36kVCY2fn
        Ea+EDZ5gJszrQ7pKBpTX/9++W1371hUBepTlTKBjmi100XUcIWbU8w4KbXmCkhwSBNSuj90
        akzkdPJ1khQzOaOXerRaWamHG8haygU8evau/WsqSBe4mfq5fFLf/m0nWmVz6nsBP19xm/k
        oySZaRWDk1dk7TMZHOt4feWz2rMV/eQvwNGqe8Adex2+boaLa+frz4lU8gaPTaabwH2g9gV
        CFsYrkL6lqw=
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     mchehab@kernel.org
Cc:     linus.walleij@linaro.org, peter.ujfalusi@gmail.com,
        hverkuil-cisco@xs4all.nl, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] media: platform: omap: Fix comment typo
Date:   Fri, 15 Jul 2022 13:17:22 +0800
Message-Id: <20220715051722.30451-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,RDNS_DYNAMIC,
        SPF_PASS,T_SPF_HELO_TEMPERROR autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The double `the' is duplicated in line 110, remove one.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 drivers/media/platform/ti/omap/omap_voutlib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/ti/omap/omap_voutlib.c b/drivers/media/platform/ti/omap/omap_voutlib.c
index fdea2309ee37..0ac46458e41c 100644
--- a/drivers/media/platform/ti/omap/omap_voutlib.c
+++ b/drivers/media/platform/ti/omap/omap_voutlib.c
@@ -107,7 +107,7 @@ EXPORT_SYMBOL_GPL(omap_vout_try_window);
 /* Given a new render window in new_win, adjust the window to the
  * nearest supported configuration.  The image cropping window in crop
  * will also be adjusted if necessary.  Preference is given to keeping the
- * the window as close to the requested configuration as possible.  If
+ * window as close to the requested configuration as possible.  If
  * successful, new_win, vout->win, and crop are updated.
  * Returns zero if successful, or -EINVAL if the requested preview window is
  * impossible and cannot reasonably be adjusted.
-- 
2.35.1

