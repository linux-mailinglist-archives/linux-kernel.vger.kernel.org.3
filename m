Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CB3A4639A1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 16:15:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243645AbhK3PSH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 10:18:07 -0500
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:33530 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243682AbhK3PMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 10:12:39 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id 4J3Qbq3Rjlz9w5JZ
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 15:09:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id OTGET5qWjghg for <linux-kernel@vger.kernel.org>;
        Tue, 30 Nov 2021 09:09:11 -0600 (CST)
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id 4J3Qbq1GJtz9w5Jj
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 09:09:11 -0600 (CST)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p7.oit.umn.edu 4J3Qbq1GJtz9w5Jj
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p7.oit.umn.edu 4J3Qbq1GJtz9w5Jj
Received: by mail-pl1-f197.google.com with SMTP id p3-20020a170903248300b00143c00a5411so8371524plw.12
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 07:09:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3mYlzhw6r+9Mp6IKYQ9nMg120b8BOmoHgUdl8QpOk5c=;
        b=CbnfvDsHyZfUIAfPOq8fr3INvguV7sJ5kXmsvEBN8QtM47XBS3eqYwQ5/ktvmqfJSz
         sp0czczSOTjbMiWNQZKPHYLZnBd9lAOsCDsH1ElFod+AjX7jytGtTiP2HMa2QpR0LNUZ
         SMsWKCoJJnGgcT803Gr/f/5GZJwfgNol/h5EvHVH8v8nJziQvRPBGB0UIYzVOWCMojq6
         w/iY9Po+EgtWGRa3EEUru2uPadUq3XETSoUp0abF8qeEXOqzpZPHkRm+xLtueafnfM2z
         ZjKulfDeDs38KLfRCDzqpouL9cmFMmHPtYkHn0EGKUOtS/OpuwOvEwYPnrsYLEECbuSf
         Hb4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3mYlzhw6r+9Mp6IKYQ9nMg120b8BOmoHgUdl8QpOk5c=;
        b=ttxzaQAEYb3QJLdqpdxV+LBKkdiAqpJ6x4tFF+K4SMFEGpqSVLpOs0rUkg9+AVkNXe
         sQR9WdsCX7z0R1YVK1Z4ZpopgyUD3p2CZwPcLg9vh5nzl2XCs6TKneMxhL81mikeP0Ti
         dCQAyCrks2z/zdvHg591kw27PV5v0GqbKg3uA09mhtG9Khmmm1Lnkl7zp9gBT4ryihVI
         esKicu7HzTJzMQfybiIQzDnuQ3xoeozQm62AoOmjuMu1s6xH1z0tpZezzDy829Q+AAr4
         5xcQQCcKGUrpMrWW522orXH06BSNqRibK58xMDb7jyoVsm9ECKUgKSKI1Ccs+Gieb+32
         Q+ow==
X-Gm-Message-State: AOAM533tbaP0TTAIMn2hdsM1CU+nOHIIF5LBEjjWm9jkbkhidkzJWNpf
        AydZGCdgYMLla9HFf7j4aUidXCeAekWYc6LtieLfQhvpI551lTeSChJkc/u0lJUvlh059q6l16P
        gr8+iPbOfgR4rpbza5ZYq9eUM/wfI
X-Received: by 2002:a17:90b:3e81:: with SMTP id rj1mr6765921pjb.31.1638284950358;
        Tue, 30 Nov 2021 07:09:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxDwfJqD6b0hGXoHCsF6GWwAY3N91Gxt4Dzpgtkc5H3soA79pZ8MvegrwJxvRl6WyerOIg8fg==
X-Received: by 2002:a17:90b:3e81:: with SMTP id rj1mr6765882pjb.31.1638284950107;
        Tue, 30 Nov 2021 07:09:10 -0800 (PST)
Received: from zqy787-GE5S.lan ([36.7.42.137])
        by smtp.gmail.com with ESMTPSA id f1sm23143513pfj.184.2021.11.30.07.09.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 07:09:09 -0800 (PST)
From:   Zhou Qingyang <zhou1615@umn.edu>
To:     zhou1615@umn.edu
Cc:     kjlu@umn.edu, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Lee Jones <lee.jones@linaro.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/selftests/test-drm_dp_mst_helper: A memleak in sideband_msg_req_encode_decode()
Date:   Tue, 30 Nov 2021 23:08:56 +0800
Message-Id: <20211130150858.167686-1-zhou1615@umn.edu>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In test-drm_dp_mst_helper.c file, if the initialization of
txmsg fails in sideband_msg_req_encode_decode(),
this function will directly return false and forget to free
the variable out, which will lead to a possible memory leak.

Although this bug is not serious as it belongs to testing code, it is
better to be fixed to avoid unexpected behavior in testing.

I fix this bug by changing 'return false' to 'goto out'.

This bug was found by a static analyzer. The analysis employs
differential checking to identify inconsistent security operations
(e.g., checks or kfrees) between two code paths and confirms that the
inconsistent operations are not recovered in the current function or
the callers, so they constitute bugs.

Note that, as a bug found by static analysis, it can be a false
positive or hard to trigger. Multiple researchers have cross-reviewed
the bug.

we build kernel with CONFIG_DRM_DEBUG_SELFTEST=m and show no warnings.
Also our static analyzer no longer warns.

Fixes:  09234b88ef55 ( "drm/selftests/test-drm_dp_mst_helper: Move 'sideband_msg_req_encode_decode' onto the heap")
Signed-off-by: Zhou Qingyang <zhou1615@umn.edu>
---
 drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c b/drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c
index 6b4759ed6bfd..e74cea9dafc6 100644
--- a/drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c
+++ b/drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c
@@ -132,7 +132,7 @@ sideband_msg_req_encode_decode(struct drm_dp_sideband_msg_req_body *in)
 
 	txmsg = kzalloc(sizeof(*txmsg), GFP_KERNEL);
 	if (!txmsg)
-		return false;
+		goto out;
 
 	drm_dp_encode_sideband_req(in, txmsg);
 	ret = drm_dp_decode_sideband_req(txmsg, out);
-- 
2.25.1

