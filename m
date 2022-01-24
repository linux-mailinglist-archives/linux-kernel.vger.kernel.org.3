Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A3B84985E4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 18:07:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244155AbiAXRHk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 12:07:40 -0500
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:60816 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244156AbiAXRHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 12:07:39 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id 4JjGd65wv5z9vkn3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 17:07:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id jxuuOSXcyKnP for <linux-kernel@vger.kernel.org>;
        Mon, 24 Jan 2022 11:07:38 -0600 (CST)
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id 4JjGd63sWHz9vknZ
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 11:07:38 -0600 (CST)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p6.oit.umn.edu 4JjGd63sWHz9vknZ
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p6.oit.umn.edu 4JjGd63sWHz9vknZ
Received: by mail-pl1-f199.google.com with SMTP id z11-20020a1709027e8b00b0014a642aacc6so3662075pla.10
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 09:07:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bwacIyhw4ndT7Q8gzdzBTG/k+JrJsO2KqpjmIUL+vWA=;
        b=kJI91Vo7bN27z4B9JgEUCwzA8BYCtXAdsrJ4FHRzwnK64pe3UPnwWC1F0cAGOtZ7WG
         Q+88wHxzRN6/WrCSylWwmTG4jmJJ6i2+e5duI47qvf0R66Rz6hoYxplW21WD9Hy7PLZy
         py9092c5AXMrwBn+lzMOcQYIsP3dkSAMJto4d32KMFkO3G3u8GVXF+wBgDYbFwtlD4Ga
         ubmyLflng7RPkmH10M+jwZoJ2demX0+SmJLokvvSZy1SUuK9Ascu7NDXRo5OL9jVx7Jh
         jj2UH9Wn57Ne7QcoP4GoP2ITElgufFyQ5TRan3ToN4maFclNLlM/WUfp4hiasmMMwH+p
         nJQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bwacIyhw4ndT7Q8gzdzBTG/k+JrJsO2KqpjmIUL+vWA=;
        b=Lk4+wsAUtE5LPflatx7y290k5y4ykCpPYKETdHToBU8VI//ZfESDBGqyOyK0XQb2YP
         KjrpeuIppaFQ+kov2FGb3+sBUgctsUKmUvz/FAqaq+kLOBG8SOSbPD8D+woRnT9mLQrB
         z2MjWLRLCd/YAAjCH1/WTQG+QNdvK/DWgOnvF0A9yRGQxvzXkzd++loeKVrc/Q0ooD09
         mTkgi3B2PycHBREIlq0RsMtungBtopEveFASEPodw+uzkoe+DMZ9ZkRksLsAXHvsHDwX
         KOClIwnGppgRh94NmU6gtyL/MZmMxki12YLToSAjE/OYZrwWoDn93UCiX+sK/nUrs1+R
         SrJQ==
X-Gm-Message-State: AOAM530JuzZFPj4UsCvnGjNTxoeozmPnq349QXo8OcFvKoDBpC0KiP6Y
        p1md4JeH8/l4yR5x5aT3mBmLlJfTNrEhft7US7gpdqH8VOTAktYr59RcjX0BQ4AOeRwaQxo0O/K
        7XKQeMMyuGmWsCQD4ICNnapBVJyvS
X-Received: by 2002:a17:902:8ec9:b0:149:8864:cfd4 with SMTP id x9-20020a1709028ec900b001498864cfd4mr15147414plo.16.1643044057821;
        Mon, 24 Jan 2022 09:07:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxphJVDZw2235x19mcgfApB+cYhwOKywYswD+mgI1+aI4SfPA9f1zN9tdRsco1iPLSlgQhNqg==
X-Received: by 2002:a17:902:8ec9:b0:149:8864:cfd4 with SMTP id x9-20020a1709028ec900b001498864cfd4mr15147388plo.16.1643044057532;
        Mon, 24 Jan 2022 09:07:37 -0800 (PST)
Received: from zqy787-GE5S.lan ([36.4.61.248])
        by smtp.gmail.com with ESMTPSA id ha21sm13030092pjb.48.2022.01.24.09.07.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 09:07:37 -0800 (PST)
From:   Zhou Qingyang <zhou1615@umn.edu>
To:     zhou1615@umn.edu
Cc:     kjlu@umn.edu, Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Alexandre Courbot <acourbot@chromium.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] media: mtk-vcodec: Fix a NULL pointer dereference in mtk_vcodec_fw_scp_init()
Date:   Tue, 25 Jan 2022 01:07:31 +0800
Message-Id: <20220124170731.59240-1-zhou1615@umn.edu>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In mtk_vcodec_fw_scp_init(), devm_kzalloc() is assigned to fw and there is
a dereference of it right after that, which could lead to NULL pointer
dereference on failure of devm_kzalloc().

Fix this bug by adding a NULL check of fw.

This bug was found by a static analyzer.

Builds with 'make allyesconfig' show no new warnings,
and our static analyzer no longer warns about this code.

Fixes: 46233e91fa24 ("media: mtk-vcodec: move firmware implementations into their own files")
Signed-off-by: Zhou Qingyang <zhou1615@umn.edu>
---
The analysis employs differential checking to identify inconsistent 
security operations (e.g., checks or kfrees) between two code paths 
and confirms that the inconsistent operations are not recovered in the
current function or the callers, so they constitute bugs. 

Note that, as a bug found by static analysis, it can be a false
positive or hard to trigger. Multiple researchers have cross-reviewed
the bug.

 drivers/media/platform/mtk-vcodec/mtk_vcodec_fw_scp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_fw_scp.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_fw_scp.c
index d8e66b645bd8..aa36bee51d01 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_fw_scp.c
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_fw_scp.c
@@ -65,6 +65,9 @@ struct mtk_vcodec_fw *mtk_vcodec_fw_scp_init(struct mtk_vcodec_dev *dev)
 	}
 
 	fw = devm_kzalloc(&dev->plat_dev->dev, sizeof(*fw), GFP_KERNEL);
+	if (!fw)
+		return ERR_PTR(-ENOMEM);
+
 	fw->type = SCP;
 	fw->ops = &mtk_vcodec_rproc_msg;
 	fw->scp = scp;
-- 
2.25.1

