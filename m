Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F17F846E0A1
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 02:59:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbhLICC5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 21:02:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbhLICC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 21:02:56 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71C27C061746;
        Wed,  8 Dec 2021 17:59:24 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id s137so3696688pgs.5;
        Wed, 08 Dec 2021 17:59:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JzKJU9/fdgz4zCFQsZnYR8rQ00toTP+WIkyJkXRFWIM=;
        b=OZr3wZmNqqTFiJAx7f5og5BMSj4JcKYzH3VKHx1/PSUryXYdVZuwSsbF/J8hWB/M1K
         7Tbe794hKeqjqAgHkY94RnmaL1bxdv5Fw1GRG8ESKuP+d+VFZlTFyntcuVbQRJUdzeXJ
         j2wybrgdQQOL5VO4gTU5UCRD9dyTmuwslv7TgtgtrXyeaMasLubjFApOiMtEcQZp7c7x
         YsWONmLMkjAVV23slk9bpOatn17O8Te1ymv1yYCnsPHPAmIwZxEZYC4HCtqhF1aGH4pd
         KhpufkB0Zx1ZDhDEPodIA/OBp4S2ygGz1SFEGSKam6E3OYGpMCTK0bqPxaEPvxAPOqaT
         xpYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JzKJU9/fdgz4zCFQsZnYR8rQ00toTP+WIkyJkXRFWIM=;
        b=6M0d2s0Lz9EvsvtilC71j0o5jo0mb0Bjgp3QVT5mkDpQltxKTBlwNdDGWJ7MV+1v5x
         SZVeVG7Ipjiw5szcoZ7Fv3OMySUD/7WR2AOPXKMxtWgp+AsMB/1TKd3r/aQ4W7mVkYyh
         zbsxQnXv5+S7fHz37sq63Zo9p9R0qr7y1q9Dij2ggtErkfmHZ8KzTyQHHGcdqdWNSgRe
         xImrc8jGg/vSPyfsGiHGemhcYzdlVMbJCPS8KhtZFarjh2bbiNIDmh3n6g/oC3nOjZQX
         uPvyw9OYvazpITbTDgfdjOiPz36iMyKVz3bMyAHZuc6aCczg1EtwXEL7pYamLX5ywCoi
         o+ZQ==
X-Gm-Message-State: AOAM533aIXTMYoFQOcXTkKLRYQCZwOa9vNylGxH+nI/8XV2cqfPgaZvf
        SvmaCykSkb1a/Qr4viLxRuY=
X-Google-Smtp-Source: ABdhPJxKwSGtoAL4ai1J6zxR9GiJm5eg+1s+NhFdnI2yPRP9D4OGjb6PtzeaaD3Sg2A6dVoX3Pn+xA==
X-Received: by 2002:a62:7a92:0:b0:49f:9a0f:6bcd with SMTP id v140-20020a627a92000000b0049f9a0f6bcdmr9071956pfc.43.1639015164031;
        Wed, 08 Dec 2021 17:59:24 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id o16sm5316435pfu.72.2021.12.08.17.59.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 17:59:23 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     willy@infradead.org
Cc:     hare@suse.com, jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        chiminghao <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cm>
Subject: [PATCH] drivers:scsi:remove unneeded variable
Date:   Thu,  9 Dec 2021 01:59:17 +0000
Message-Id: <20211209015917.410029-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: chiminghao <chi.minghao@zte.com.cn>

return value form directly instead of
taking this in another redundant variable.

Reported-by: Zeal Robot <zealci@zte.com.cm>
Signed-off-by: chiminghao <chi.minghao@zte.com.cn>
---
 drivers/scsi/advansys.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/scsi/advansys.c b/drivers/scsi/advansys.c
index ace5eff828e9..610c0be1b47b 100644
--- a/drivers/scsi/advansys.c
+++ b/drivers/scsi/advansys.c
@@ -6237,14 +6237,12 @@ AscMsgOutSDTR(ASC_DVC_VAR *asc_dvc, uchar sdtr_period, uchar sdtr_offset)
 static uchar
 AscCalSDTRData(ASC_DVC_VAR *asc_dvc, uchar sdtr_period, uchar syn_offset)
 {
-	uchar byte;
 	uchar sdtr_period_ix;
 
 	sdtr_period_ix = AscGetSynPeriodIndex(asc_dvc, sdtr_period);
 	if (sdtr_period_ix > asc_dvc->max_sdtr_index)
 		return 0xFF;
-	byte = (sdtr_period_ix << 4) | (syn_offset & ASC_SYN_MAX_OFFSET);
-	return byte;
+	return (sdtr_period_ix << 4) | (syn_offset & ASC_SYN_MAX_OFFSET);
 }
 
 static bool AscSetChipSynRegAtID(PortAddr iop_base, uchar id, uchar sdtr_data)
-- 
2.25.1

