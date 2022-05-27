Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EBD053629D
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 14:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352403AbiE0Mci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 08:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353256AbiE0McX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 08:32:23 -0400
Received: from smtpbg.qq.com (smtpbg138.qq.com [106.55.201.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 591CB18C062
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 05:12:25 -0700 (PDT)
X-QQ-mid: bizesmtp74t1653653517tiv7vzps
Received: from localhost.localdomain ( [182.148.13.40])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 27 May 2022 20:11:40 +0800 (CST)
X-QQ-SSF: 01000000002000B0G000000A0000000
X-QQ-FEAT: RKCwGdK8Yfi2eFJ32OTXHJX7Mf5yNB5Ebft1FvL5LJRKtQWC4ZGmyFAmQ0teK
        3lfRqetO0rebxgVX0jLKj8ICp3PiK4KesjiP6RTztZRjzc65a+muY5yOsdZI3TY404toRI3
        n5bFIYdbXgaHn+BLAFDFXdmpSDnMgiHYwer4O2ectEhEH/N3awrvJ9jR3of30tzDLcqOxYy
        SZBFgOBLPM6N9rbK1842vr8JrMaC3NcshCiwTMki5IPVqdFQ8ccZGsUn+k7NktrLlloyvrT
        MX836PLxb6HnusVvvNIZHT5q31BojLMlwfyWBnjXqQxXoJUy5ROUfVf093VONsFxiebQXGm
        18PK4KI5DzNJgloBAo=
X-QQ-GoodBg: 0
From:   Xiang wangx <wangxiang@cdjrlc.com>
To:     perex@perex.cz
Cc:     tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Xiang wangx <wangxiang@cdjrlc.com>
Subject: [PATCH] ALSA: hda/via: Delete does not require return
Date:   Fri, 27 May 2022 20:10:59 +0800
Message-Id: <20220527121059.25221-1-wangxiang@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam10
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Void function return statements are not generally useful.

Signed-off-by: Xiang wangx <wangxiang@cdjrlc.com>
---
 sound/pci/hda/patch_via.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/pci/hda/patch_via.c b/sound/pci/hda/patch_via.c
index 773a136161f1..a05304f340df 100644
--- a/sound/pci/hda/patch_via.c
+++ b/sound/pci/hda/patch_via.c
@@ -449,8 +449,6 @@ static void vt1708_set_pinconfig_connect(struct hda_codec *codec, hda_nid_t nid)
 		def_conf = def_conf & (~(AC_JACK_PORT_BOTH << 30));
 		snd_hda_codec_set_pincfg(codec, nid, def_conf);
 	}
-
-	return;
 }
 
 static int vt1708_jack_detect_get(struct snd_kcontrol *kcontrol,
-- 
2.36.1

