Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69F94498533
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 17:49:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243912AbiAXQs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 11:48:58 -0500
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:59260 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243914AbiAXQs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 11:48:57 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id 4JjGCX3wFCz9vrQ6
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 16:48:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id TEGv0s0fPRDf for <linux-kernel@vger.kernel.org>;
        Mon, 24 Jan 2022 10:48:56 -0600 (CST)
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id 4JjGCX1kfCz9vrQM
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 10:48:56 -0600 (CST)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p8.oit.umn.edu 4JjGCX1kfCz9vrQM
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p8.oit.umn.edu 4JjGCX1kfCz9vrQM
Received: by mail-pg1-f199.google.com with SMTP id 127-20020a630585000000b0035de5e88314so3197175pgf.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 08:48:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M1EN+FFfNlSfEsgNncNXUF0963zI+nXvNLe38e5GCuc=;
        b=EUlsAfVHOklvtJlvPGglcopNF7hGSrGhyl+5EOTYu1cimvRfBoJmB+7+os6JyrK9eR
         RVzoMRWj0SJeh8cBEW6GQ2B5BXVin9rot1GVkmQRYbb9GCJgu0RFdtROol9bBk1OERPi
         qoRRQsL542Cb1KYk2e+cugN7kvRrkUQeG0zMotp1DbzPMGzZf79FFNqzqx6QPqXyoFdN
         Rg/TzQFjr7APM90mhrqHw+ebUhHKpWKy7jRSbaqIAbcyLP8NExOreFCdF+mfTKr/NqDm
         45zaAg/5tg7EQ3c0lxdn8VCqqXeNumN9R6YGkTtP8fyMGuHZQUJFqXM2X80kfSqbnleD
         Kbow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M1EN+FFfNlSfEsgNncNXUF0963zI+nXvNLe38e5GCuc=;
        b=v70P/D3jnChffrZY7HK06+YtHebTh9cpTcBAEE0CQAKcLp9C9lHGUxEAnKgShqai5h
         zfuOLqNPiM2/ewW8YvSOav0y8T9JlyBNt6W1NAvYbGNMudJTitt9ra6XjAx8N8qe/mXU
         BYUNGpxkdyRd8+llSI7GJ/r7FcC3gdwNX9vzuYPHy1IupZKy2C04IOzwq/fQqWLIjYQU
         D0/s31xixcJL/Ugi5zxSPtQpFEEhy0ZqEJSmgnKUo3n53ID3ZxFdcLhYCwxifRlGuE2r
         +wAIaUo+sronQAVDnM6MuMurIm21IrtrnXH4yrsIrf5tprHz2D9dvLdmo+43MWONpv3o
         0bcw==
X-Gm-Message-State: AOAM532+Hwwab7ngpIfQ16pllQVTifsTfDzotettFqlLix/VfmOWc3Ya
        DTyU0RWDsTOEH+bOR3Y6otQuCi4EZxxy5PLsHQrnv3ZjlpQhJYWgcaUzJga+r4YsJRr3ZcEMC9v
        GXm3htH8TCA4C3feygetaxF3k68xb
X-Received: by 2002:a05:6a00:ace:b0:4c5:35c:db8 with SMTP id c14-20020a056a000ace00b004c5035c0db8mr14818308pfl.51.1643042935261;
        Mon, 24 Jan 2022 08:48:55 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwDmDFHUTEi0HFNEt70JZNrZypUVX+E57kTTIb1ig2mN4js04He3RiIqLXXvmVcq8wcVRlWEw==
X-Received: by 2002:a05:6a00:ace:b0:4c5:35c:db8 with SMTP id c14-20020a056a000ace00b004c5035c0db8mr14818298pfl.51.1643042935042;
        Mon, 24 Jan 2022 08:48:55 -0800 (PST)
Received: from zqy787-GE5S.lan ([36.4.61.248])
        by smtp.gmail.com with ESMTPSA id qe12sm3929319pjb.14.2022.01.24.08.48.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 08:48:54 -0800 (PST)
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
        Pieter-Paul Giesberts <pieter-paul.giesberts@broadcom.com>,
        Angus Ainslie <angus@akkea.ca>,
        "Daniel (Deognyoun) Kim" <dekim@broadcom.com>,
        "John W. Linville" <linville@tuxdriver.com>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] brcmfmac: Fix a wild pointer dereference bug in brcmf_chip_recognition()
Date:   Tue, 25 Jan 2022 00:48:45 +0800
Message-Id: <20220124164847.54002-1-zhou1615@umn.edu>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In brcmf_chip_recognition(), the return value of brcmf_chip_add_core()
is assigned to core and is passed to brcmf_chip_sb_corerev(). In
brcmf_chip_sb_corerev(), there exists dereference of core without check.
the return value of brcmf_chip_add_core() could be ERR_PTR on failure of
allocation, which could lead to a NULL pointer dereference bug.

Fix this bug by adding IS_ERR check for every variable core.

This bug was found by a static analyzer.

Builds with 'make allyesconfig' show no new warnings,
and our static analyzer no longer warns about this code

Fixes: cb7cf7be9eba ("brcmfmac: make chip related functions host interface independent")
Signed-off-by: Zhou Qingyang <zhou1615@umn.edu>
---
The analysis employs differential checking to identify inconsistent 
security operations (e.g., checks or kfrees) between two code paths 
and confirms that the inconsistent operations are not recovered in the
current function or the callers, so they constitute bugs. 

Note that, as a bug found by static analysis, it can be a false
positive or hard to trigger. Multiple researchers have cross-reviewed
the bug.

 .../net/wireless/broadcom/brcm80211/brcmfmac/chip.c    | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c
index 1ee49f9e325d..4d91cb107cd7 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c
@@ -986,18 +986,28 @@ static int brcmf_chip_recognition(struct brcmf_chip_priv *ci)
 
 		core = brcmf_chip_add_core(ci, BCMA_CORE_CHIPCOMMON,
 					   SI_ENUM_BASE_DEFAULT, 0);
+		if (IS_ERR(core))
+			return PTR_ERR(core);
 		brcmf_chip_sb_corerev(ci, core);
 		core = brcmf_chip_add_core(ci, BCMA_CORE_SDIO_DEV,
 					   BCM4329_CORE_BUS_BASE, 0);
+		if (IS_ERR(core))
+			return PTR_ERR(core);
 		brcmf_chip_sb_corerev(ci, core);
 		core = brcmf_chip_add_core(ci, BCMA_CORE_INTERNAL_MEM,
 					   BCM4329_CORE_SOCRAM_BASE, 0);
+		if (IS_ERR(core))
+			return PTR_ERR(core);
 		brcmf_chip_sb_corerev(ci, core);
 		core = brcmf_chip_add_core(ci, BCMA_CORE_ARM_CM3,
 					   BCM4329_CORE_ARM_BASE, 0);
+		if (IS_ERR(core))
+			return PTR_ERR(core);
 		brcmf_chip_sb_corerev(ci, core);
 
 		core = brcmf_chip_add_core(ci, BCMA_CORE_80211, 0x18001000, 0);
+		if (IS_ERR(core))
+			return PTR_ERR(core);
 		brcmf_chip_sb_corerev(ci, core);
 	} else if (socitype == SOCI_AI) {
 		ci->iscoreup = brcmf_chip_ai_iscoreup;
-- 
2.25.1

