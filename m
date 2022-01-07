Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D19648704E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 03:23:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345371AbiAGCXl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 21:23:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344468AbiAGCXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 21:23:39 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B549C061245
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 18:23:39 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id 205so4052390pfu.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jan 2022 18:23:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4WQ/8JHSUHdcC60H26iiWsvlZ6gMDmzCg30bgw7CA0o=;
        b=FL4sc2NxYvM7CVA0ejjbQITIST/Lwlef9buy0Gi1qxucnL+bBNxx9HtfQ5A7zUyeIS
         4SdEFiy9roL/i3Nu+kpbXkViLRtnlkVsk0TfkNNlMW1Wxiqan/VWs4LdKg5KknAbC/5P
         cglaoA3R+Vkl/XM3HR0O6vwHTyDJXCSZDhtBtwX+R5OQjJeQfq1oHgZdCpXX3tmclTIv
         Q/dK6fuWF6NWY34EAo3GJ1AacIXX7IfIi7xie7kTycTkDYA1BCppojRR+wobKtxAfjOh
         OEEIXaNjCGP4QsyfEgoXTdrYc2UjbO3PXgowPe7zHwk4PqLZWB9NMEOeVQ7pSXCAHCEg
         oZSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4WQ/8JHSUHdcC60H26iiWsvlZ6gMDmzCg30bgw7CA0o=;
        b=dY5j82Ed+zOqLZ0MnMBoLAmb8qSEC8bqYxrPfHxwXsdxcgZIou4j4RcSPQvqm7EVyt
         de0o4mgbVL2wRe2AYXNaXM72uiaZ5nshHaywKMu90Wwj0a+sIvE1IbHrmyh31OQGRYwI
         OiMrEsoJNa+ec46bmfBRCUlFYpLaOpyRdeS5EgA8VkDkbxxe4WQr6YvRlrOB98otrxAY
         eBKr2PshyRsXHYmqo2PqXBIFuqtkaM8y6oGLOivHP08uAlaeEOFWAn+/MApEXgfKYMh6
         OacYyC1v29zPpYEAvkBYSJQVj/7lHIa2fZNVuxPJ8SVY+nRZaHXLXfAm1XilqmY26sVV
         KlAQ==
X-Gm-Message-State: AOAM530dm1A+aDsehExsLgsLJPIIaHEv+tjdQdobrHMc/c4OvHlyiRPy
        E5CtVVB9HF99x4F0hvkQP0o=
X-Google-Smtp-Source: ABdhPJw6bDSKRP5ew33JRHzIyIA8jawuyjfDgVbtuw55FeuP83NGxhrNbRGDiATaOoID+LN51S0NDQ==
X-Received: by 2002:a63:8c1c:: with SMTP id m28mr50519636pgd.594.1641522218829;
        Thu, 06 Jan 2022 18:23:38 -0800 (PST)
Received: from localhost.localdomain ([94.177.118.38])
        by smtp.googlemail.com with ESMTPSA id h4sm6439769pjk.2.2022.01.06.18.23.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 18:23:38 -0800 (PST)
From:   Qinghua Jin <qhjin.dev@gmail.com>
Cc:     qhjin_dev@163.com, Qinghua Jin <qhjin.dev@gmail.com>,
        James Smart <james.smart@broadcom.com>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] nvme-fc: fix typo
Date:   Fri,  7 Jan 2022 10:22:58 +0800
Message-Id: <20220107022258.396058-1-qhjin.dev@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

subsytem -> subsystem

Signed-off-by: Qinghua Jin <qhjin.dev@gmail.com>
---
 include/linux/nvme-fc-driver.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/nvme-fc-driver.h b/include/linux/nvme-fc-driver.h
index cb909edb76c4..5358a5facdee 100644
--- a/include/linux/nvme-fc-driver.h
+++ b/include/linux/nvme-fc-driver.h
@@ -721,7 +721,7 @@ enum {
  *
  * Fields with static values for the port. Initialized by the
  * port_info struct supplied to the registration call.
- * @port_num:  NVME-FC transport subsytem port number
+ * @port_num:  NVME-FC transport subsystem port number
  * @node_name: FC WWNN for the port
  * @port_name: FC WWPN for the port
  * @private:   pointer to memory allocated alongside the local port
-- 
2.30.2

