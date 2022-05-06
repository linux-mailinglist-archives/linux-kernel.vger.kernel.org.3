Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8D9451CF3D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 05:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243432AbiEFDKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 23:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232443AbiEFDKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 23:10:36 -0400
X-Greylist: delayed 550 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 05 May 2022 20:06:52 PDT
Received: from mail-m17657.qiye.163.com (mail-m17657.qiye.163.com [59.111.176.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FC5F63514
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 20:06:52 -0700 (PDT)
Received: from book-Convertible.. (unknown [171.83.5.166])
        by mail-m17657.qiye.163.com (Hmail) with ESMTPA id E3BE4280687;
        Fri,  6 May 2022 10:57:39 +0800 (CST)
From:   bo liu <bo.liu@senarytech.com>
To:     tiwai@suse.com, perex@perex.cz
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        bo liu <bo.liu@senarytech.com>
Subject: [PATCH] add a new hda codec SN6140
Date:   Fri,  6 May 2022 10:57:35 +0800
Message-Id: <20220506025735.17731-1-bo.liu@senarytech.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZCBgUCR5ZQVlLVUtZV1
        kWDxoPAgseWUFZKDYvK1lXWShZQUhPN1dZLVlBSVdZDwkaFQgSH1lBWUMfH09WSxhOSB8aHkkYSk
        oeVRMBExYaEhckFA4PWVdZFhoPEhUdFFlBWU9LSFVKSktISkNVS1kG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Nyo6Kxw5DT05MggoGDQMLAod
        MUMaCThVSlVKTU5KQ0tOQ01LT0JKVTMWGhIXVRkUVRcSDjsIHhUaCQIPHhgTVRgUFkVZV1kSC1lB
        WUpMSlVDSFVOVUpNTVlXWQgBWUFKTUpPNwY+
X-HM-Tid: 0a80974d30f3da03kuwse3be4280687
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current kernel does not support the SN6140 codec chip.
Add the SN6140 codec configuration item to kernel.

Signed-off-by: bo liu <bo.liu@senarytech.com>
---
 sound/pci/hda/patch_conexant.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index 0515137a75b0..aa360a0af284 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -1105,6 +1105,7 @@ static int patch_conexant_auto(struct hda_codec *codec)
 
 static const struct hda_device_id snd_hda_id_conexant[] = {
 	HDA_CODEC_ENTRY(0x14f11f86, "CX8070", patch_conexant_auto),
+	HDA_CODEC_ENTRY(0x14f11f87, "SN6140", patch_conexant_auto),
 	HDA_CODEC_ENTRY(0x14f12008, "CX8200", patch_conexant_auto),
 	HDA_CODEC_ENTRY(0x14f120d0, "CX11970", patch_conexant_auto),
 	HDA_CODEC_ENTRY(0x14f15045, "CX20549 (Venice)", patch_conexant_auto),
-- 
2.34.1

