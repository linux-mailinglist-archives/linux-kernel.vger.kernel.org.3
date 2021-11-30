Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66A14463CD9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 18:30:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244821AbhK3RdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 12:33:20 -0500
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:43508 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238828AbhK3RdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 12:33:19 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id 4J3TkG6z47z9vf8D
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 17:29:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id dhXl3Vm3auKu for <linux-kernel@vger.kernel.org>;
        Tue, 30 Nov 2021 11:29:58 -0600 (CST)
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id 4J3TkG4yqgz9vf8F
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 11:29:58 -0600 (CST)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p6.oit.umn.edu 4J3TkG4yqgz9vf8F
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p6.oit.umn.edu 4J3TkG4yqgz9vf8F
Received: by mail-pj1-f71.google.com with SMTP id o4-20020a17090a3d4400b001a66f10df6cso7154382pjf.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 09:29:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9pznBESKnWofLpakL5pmxJ7peOOaf1Zo5EKUeNDZGEM=;
        b=kzhzFTyE+GWmogVbkYEGEkbnwsaA7ObafZWTOIIl6lQKwkKhy5i9SRZF0d04IE+f4U
         qVYUKPGvMWLhppSw9Zl47sNmMEJM238Pcq980a+zBd/3vcDX1MG2gHb5+vsX71rK9pXA
         77ibpTsGvu9lJKbqTDKE3d5FnUvuximjXq2nlABC773N8GaVOto2yKbm9ukStLk3hb7w
         mBoJuFb/mTIb1cMx3YD2wq3CASBlaIWVIQ4kwkj1XTaL8O3NxKrs2a3+SOmsumyg2DUw
         plBZgJvrQ1lQWFUuT3g3TOjb1WaeWIJWH6ccS6FOo9le5WfLjXVriSwd24Uk2sCKi1yl
         y85g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9pznBESKnWofLpakL5pmxJ7peOOaf1Zo5EKUeNDZGEM=;
        b=hlnJl0D5HDYcgUqwxZS7Jo439VfkG5hCLxz/bggH39nlotDeqlPW1V3FVIQIX4KNry
         iwX5TD16OtLAuUJMH/hr5H721iDoaaM1nIdC/NzEYwyISBAFR/uuVW1pK2S5m46Ldt0A
         2P2SKS1uq78b4+WilOnlo22fvZTh044TNxktYmuLhSUHWBR/s04S8R1Wu0DCNgalocb6
         UEVlR6eRu8epcF9l7T896jKisOE8a8HkUjt+9e3IN9ShLW6f0QQ3Hq22cRXyrvedqakX
         nsdP5gPdV1mrZRlpn4huQa0Wv5f6bUn1OQdTE5sTW2uC+BwrB2zl25H6iNytTyBnW4x0
         2FeA==
X-Gm-Message-State: AOAM531w4sUBT5XsL3ULDwHVi71tyvoYKEBoyyJAVZ4viyJqk8J6wN+L
        N3q6BwNchlbtNsUIIlYED6/lMnChkcnMB/a0slpdmLr+koyhJu/l8AP/ll0MuVdES83ydX7bzI3
        kSNLXGXaZ58yOp/yRUuSh+adjuJ4y
X-Received: by 2002:a17:90a:ce02:: with SMTP id f2mr337868pju.77.1638293397949;
        Tue, 30 Nov 2021 09:29:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxf2pmqIXch/OBlEuEuZunx2vNxCa+wfgpKWnjANdlDUNXev1TH7xbVfl6DPtnhF5K7lGPDXQ==
X-Received: by 2002:a17:90a:ce02:: with SMTP id f2mr337840pju.77.1638293397688;
        Tue, 30 Nov 2021 09:29:57 -0800 (PST)
Received: from zqy787-GE5S.lan ([36.7.42.137])
        by smtp.gmail.com with ESMTPSA id e6sm15453845pgr.24.2021.11.30.09.29.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 09:29:57 -0800 (PST)
From:   Zhou Qingyang <zhou1615@umn.edu>
To:     zhou1615@umn.edu
Cc:     kjlu@umn.edu, Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>,
        Nadezda Lutovinova <lutovinova@ispras.ru>,
        Yu Xu <yuxu@marvell.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] usb: gadget: mv_u3d: Fix a NULL pointer dereference in mv_u3d_req_to_trb()
Date:   Wed,  1 Dec 2021 01:29:17 +0800
Message-Id: <20211130172919.207823-1-zhou1615@umn.edu>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In mv_u3d_req_to_trb(), mv_u3d_build_trb_one() is assigned to trb and
there is a dereference of it in mv_u3d_req_to_trb(), which could lead
to a NULL pointer dereference on failure of mv_u3d_build_trb_one().

Fix this bug by adding a check of trb.

This bug was found by a static analyzer. The analysis employs
differential checking to identify inconsistent security operations
(e.g., checks or kfrees) between two code paths and confirms that the
inconsistent operations are not recovered in the current function or
the callers, so they constitute bugs.

Note that, as a bug found by static analysis, it can be a false
positive or hard to trigger. Multiple researchers have cross-reviewed
the bug.

Builds with CONFIG_USB_MV_U3D=m show no new warnings,
and our static analyzer no longer warns about this code.

Fixes: 3d4eb9dfa3e8 ("usb: gadget: mv: Add USB 3.0 device driver for Marvell PXA2128 chip.")
Signed-off-by: Zhou Qingyang <zhou1615@umn.edu>
---
 drivers/usb/gadget/udc/mv_u3d_core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/usb/gadget/udc/mv_u3d_core.c b/drivers/usb/gadget/udc/mv_u3d_core.c
index a1057ddfbda3..e90ef4046a9d 100644
--- a/drivers/usb/gadget/udc/mv_u3d_core.c
+++ b/drivers/usb/gadget/udc/mv_u3d_core.c
@@ -417,6 +417,12 @@ static int mv_u3d_req_to_trb(struct mv_u3d_req *req)
 	 */
 	if (length <= (unsigned)MV_U3D_EP_MAX_LENGTH_TRANSFER) {
 		trb = mv_u3d_build_trb_one(req, &count, &dma);
+		if (!trb) {
+			dev_err(u3d->dev, "%s, mv_u3d_build_trb_one fail\n",
+				__func__);
+			return -ENOMEM;
+		}
+
 		list_add_tail(&trb->trb_list, &req->trb_list);
 		req->trb_head = trb;
 		req->trb_count = 1;
-- 
2.25.1

