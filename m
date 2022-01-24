Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7AAD49853D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 17:51:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243929AbiAXQvI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 11:51:08 -0500
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:35564 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243924AbiAXQvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 11:51:06 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id 4JjGG20Mc1z9w2xf
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 16:51:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id FVyStysfDiR3 for <linux-kernel@vger.kernel.org>;
        Mon, 24 Jan 2022 10:51:05 -0600 (CST)
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id 4JjGG15PgRz9w2xh
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 10:51:05 -0600 (CST)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p7.oit.umn.edu 4JjGG15PgRz9w2xh
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p7.oit.umn.edu 4JjGG15PgRz9w2xh
Received: by mail-pj1-f69.google.com with SMTP id j9-20020a17090a7e8900b001b58e473d48so2476720pjl.5
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 08:51:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZI8YuwYv90KYmYShElkaKD7+O4xtWqLO7AtdD86iqPo=;
        b=JEXHUEG00k/tjVrRYZZDZrFrAnIKx2tg0PD8vTiBpWYYydZmjrK/VtY7uFj1SulSqC
         QqTK092VcTHAPUDv/EN1l7T+R/TdpQydJLOKAArS4tsLRz9euhhbW7Bpev2gGRlBnS9J
         WtlZ2iDbxbkJOXJ/r0qeySuFCnIZ2LZS8C3/ESlF5T/JajCy1YdUQFyRRr7oWyiO24kl
         wkLScmA9bsVXZpdjdrnvtQuYUlBErJmIcik2+FPHYjQmF1GpewD6XzkzsabgM5oJUi1Z
         hJl9782YyXcGqLiC+8Zp12n2uSGyzgWCSpm7zbqpUIfKZ5Ue+200WiJaZOqZpuT+W8ox
         iFlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZI8YuwYv90KYmYShElkaKD7+O4xtWqLO7AtdD86iqPo=;
        b=Rah1djrR3zpDOKyb2y+fUjstDXggZ0O0MPoU90JFeDPNSNqe6iV4QjEO9UyCKIaLId
         LwvrELCnIvc92PNRmWcNoCl0s/NPU+2FvDFeSUdbHDtHHpVqjM+inmzQYJhvZ+k73KmL
         8Gx363HAii9aLbwp7HCwh6TnIRbDtKPwQTErxhTtN5FoX2S1PGcogfeAyAD2ao4sIC9K
         8j5xYe/fbTi2LD0VAjEhTFHQRNI56KjX+DQlHA4/MtMSqlBawW4CApRiMVWL35xJygK2
         Z/nBIuelH+EUQRzRT5wEMDCkOX0I8y4RUXChKfM4RAvnrL8GoPM0WkXXvwbokOHJfGFa
         /1eQ==
X-Gm-Message-State: AOAM5311NKhMSG01EgJJ/CypccZlMQrMrFG9OBczPpRiY9wIENDntHbw
        Deytluik0gmejEM7FdZ2YrQG6n5IFXhDmm/dApVLgnggcPTqVgl88r310rMrzq8lIouDkxIbAOz
        edZrsKJbpfdUL3bhXSeUPNNx7Xucn
X-Received: by 2002:a17:902:7e82:b0:149:9714:699e with SMTP id z2-20020a1709027e8200b001499714699emr15301130pla.66.1643043064972;
        Mon, 24 Jan 2022 08:51:04 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw8RIuohziTVtdBDn6b6CW2twXFnMB+xvuiE2F10TMndWaOG1wxoxI1hSHir9NE/ss1eNeWAA==
X-Received: by 2002:a17:902:7e82:b0:149:9714:699e with SMTP id z2-20020a1709027e8200b001499714699emr15301107pla.66.1643043064769;
        Mon, 24 Jan 2022 08:51:04 -0800 (PST)
Received: from zqy787-GE5S.lan ([36.4.61.248])
        by smtp.gmail.com with ESMTPSA id b12sm17205153pfv.148.2022.01.24.08.51.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 08:51:04 -0800 (PST)
From:   Zhou Qingyang <zhou1615@umn.edu>
To:     zhou1615@umn.edu
Cc:     kjlu@umn.edu, Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-hsien Lin <chi-hsien.lin@infineon.com>,
        Wright Feng <wright.feng@infineon.com>,
        Chung-hsien Hsu <chung-hsien.hsu@infineon.com>,
        Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Len Baker <len.baker@gmx.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Hans deGoede <hdegoede@redhat.com>,
        Matthias Brugger <mbrugger@suse.com>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] brcmfmac: Fix a NULL pointer dereference in brcmf_of_probe()
Date:   Tue, 25 Jan 2022 00:50:46 +0800
Message-Id: <20220124165048.54677-1-zhou1615@umn.edu>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In brcmf_of_probe(), the return value of devm_kzalloc() is assigned to
board_type and there is a dereference of it in strcpy() right after
that. devm_kzalloc() could return NULL on failure of allocation, which
could lead to NULL pointer dereference.

Fix this bug by adding a NULL check of board_type.

This bug was found by a static analyzer.

Builds with 'make allyesconfig' show no new warnings,
and our static analyzer no longer warns about this code

Fixes: 29e354ebeeec ("brcmfmac: Transform compatible string for FW loading")
Signed-off-by: Zhou Qingyang <zhou1615@umn.edu>
---
The analysis employs differential checking to identify inconsistent 
security operations (e.g., checks or kfrees) between two code paths 
and confirms that the inconsistent operations are not recovered in the
current function or the callers, so they constitute bugs. 

Note that, as a bug found by static analysis, it can be a false
positive or hard to trigger. Multiple researchers have cross-reviewed
the bug.

 drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
index 513c7e6421b2..535e8ddeab8d 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
@@ -80,6 +80,8 @@ void brcmf_of_probe(struct device *dev, enum brcmf_bus_type bus_type,
 		/* get rid of '/' in the compatible string to be able to find the FW */
 		len = strlen(tmp) + 1;
 		board_type = devm_kzalloc(dev, len, GFP_KERNEL);
+		if (!board_type)
+			return;
 		strscpy(board_type, tmp, len);
 		for (i = 0; i < board_type[i]; i++) {
 			if (board_type[i] == '/')
-- 
2.25.1

