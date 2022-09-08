Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33CB15B2975
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 00:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbiIHWjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 18:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiIHWjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 18:39:15 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 306EB5071E
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 15:39:14 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oWQAy-0003rx-HP; Fri, 09 Sep 2022 00:39:12 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oWQAv-004hwu-MR; Fri, 09 Sep 2022 00:39:11 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oWQAw-00H0PY-NC; Fri, 09 Sep 2022 00:39:10 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     linux-kernel@vger.kernel.org,
        Kai Germaschewski <kai.germaschewski@gmx.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Marc Zyngier <maz@kernel.org>
Cc:     kernel@pengutronix.de
Subject: [PATCH 0/2] SPDX tags for copyright
Date:   Fri,  9 Sep 2022 00:38:48 +0200
Message-Id: <20220908223850.13217-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=831; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=jD7hd5wyWNvYu5P25FAExKHh4ndMLikkGeXZH0kpiC8=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBjGm7wKsUJQYXqD5Dr5plKnENgdwrEytjE7DR2S9RN 6hnVTwOJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYxpu8AAKCRDB/BR4rcrsCQt8B/ sG3egWb0I9Syh9cqWAy4URMtG8o4hpR9D8HEmETbElYtlYV/vxjBAc9hC58wLY+Qt6QBATeI4iO6SV Qdi8Vnwi9xtxiVM/JLPSeduduYlusxPZiPdstj6uq6efHdBr8NuRsZH5OkmvafqtGwOsrvS90im2uN bjBxjmPcVoMEKvSIHtwpCs+1QJnvRWOCeRhro+slww+n01UoJCdUTizHkCgkzmvEx5FbWH/7Vq8mo2 DSlYtsVvWIA0ePVzyluGBPSwIl+vV5WzSZTmeeZmlbGb3jnYOBlwphpzrG5WKqSjIx3+/ZoZAD9BVO 8/x5y/vZcH5HvZuGyY+ordQ61JLcRP
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

for Debian packaging having SPDX license tags already simplifies
creating the required copyright documentation considerably. Another
information that is needed for Debian packaging is the copyright
information. There is an SPDX way for copyright information, too. The
second patch converts scripts/kallsyms.c to that mechanism as an example
to maybe discuss if we want to do that in the kernel.

While the SPDX-FileCopyrightText is officially a free-form field, I
suggest to just stick to the format

	(<year> )?<copyright holder>

to simplify machine consumption even further.

Best regards
Uwe

Uwe Kleine-König (2):
  kallsyms: Specify license using SPDX
  kallsyms: Specify copyright using SPDX

 scripts/kallsyms.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

-- 
2.37.2

