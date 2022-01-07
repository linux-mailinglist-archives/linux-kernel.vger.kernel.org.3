Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD8948704D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 03:23:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345364AbiAGCXO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 21:23:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344468AbiAGCXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 21:23:14 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF42C061245
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 18:23:13 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id q4so4186677qvh.9
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jan 2022 18:23:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dFifp4IhOFibmidbxdWOtwDyLOsL6LxbTa27pTNK8Nk=;
        b=pPyr/dIuKq4QiCp1BtRqwAxXMqf7zUjwgKGFiN7eXE/emsKEpDtIPdUXicWnetHw1n
         bo700UQrZGPRbWMxhGJw2HezQiy2om+ZkPe5TEM2tsY9bIIzvxiMaUqKCkv1Td2YdZfw
         hEVOl+XLVnGybqZjvpWk3mdDx/JxLfl/Xnx9ytXO87F1sJ3ZCPKDThROcBX9qvGiqv+x
         6P1H4jckjJXIuwO+UiQtvMjDyTnmwwWphMvgAk8+lsiXRXwDDmrT7ZJ5xoRz2s9oQCJi
         2XwUrlMfsdp/ge6pD50UdBK22Edh3MLBZBo0rBGACVl4Mq4j634+5erffDYO+moW/ijT
         s6uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dFifp4IhOFibmidbxdWOtwDyLOsL6LxbTa27pTNK8Nk=;
        b=O9y1ZoqFC5TFNB9tv6wHtiF9qNol+mROMLJBbruQNz67Iroz1m/WpQR7Ldmqex7pZ2
         JK4Z+xOnsZQ3CUi2rxYuGp2K3GBOIZQikjjRZT15VtzgXxRzwlDmbP0xdG6AmUFSIK7B
         70LxszECJFeqdhSNzrKOwDspphtMGrxYIZuhkoLfdJGmjtvGSdlDw9i3s2DwN4UdxtRs
         0jbS86QgkOfH1ciQNE0Uw3tinzD59s+ST4R76vGW5i6eMWcdRO/Le27EIzncUWLKOtU+
         s8fUPV8LujyczbcK4nLrSEUj76t9yaVkEY8j/WBTfVnflUT8ywZ0RSxZ1Q0BWXQqeoJC
         //CA==
X-Gm-Message-State: AOAM533Jjp/DCrsnFNSfr6gueKB7mUcSNgO0iu9sIRuD64KcY5ByOCrZ
        rRC9nncyhkfEsO+5bPPe9Ss=
X-Google-Smtp-Source: ABdhPJx05b+2PR+Ea1MqSU7lA8zHdT3RQG2PnuCl2Ds80cRnsOvNuPrbeYoAwMY0rtlBMg7w7n4BUw==
X-Received: by 2002:a05:6214:21ce:: with SMTP id d14mr56783406qvh.73.1641522193157;
        Thu, 06 Jan 2022 18:23:13 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id h3sm2619617qko.78.2022.01.06.18.23.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 18:23:12 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: deng.changcheng@zte.com.cn
To:     kbusch@kernel.org
Cc:     axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] nvme-fabrics: remove unneeded variable
Date:   Fri,  7 Jan 2022 02:23:06 +0000
Message-Id: <20220107022306.622222-1-deng.changcheng@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Changcheng Deng <deng.changcheng@zte.com.cn>

Remove unneeded variable used to store return value.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Changcheng Deng <deng.changcheng@zte.com.cn>
---
 drivers/nvme/host/fabrics.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 7ae041e2b3fb..f79a66d4e22c 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -1092,7 +1092,6 @@ static void __nvmf_concat_opt_tokens(struct seq_file *seq_file)
 static int nvmf_dev_show(struct seq_file *seq_file, void *private)
 {
 	struct nvme_ctrl *ctrl;
-	int ret = 0;
 
 	mutex_lock(&nvmf_dev_mutex);
 	ctrl = seq_file->private;
@@ -1106,7 +1105,7 @@ static int nvmf_dev_show(struct seq_file *seq_file, void *private)
 
 out_unlock:
 	mutex_unlock(&nvmf_dev_mutex);
-	return ret;
+	return 0;
 }
 
 static int nvmf_dev_open(struct inode *inode, struct file *file)
-- 
2.25.1

