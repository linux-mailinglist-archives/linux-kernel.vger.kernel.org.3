Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 625FF497F11
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 13:16:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242713AbiAXMPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 07:15:45 -0500
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:39592 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239342AbiAXMOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 07:14:17 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id 4Jj86b4RXcz9vC8s
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 12:14:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id omnldx4fKL66 for <linux-kernel@vger.kernel.org>;
        Mon, 24 Jan 2022 06:14:15 -0600 (CST)
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id 4Jj86b2HTFz9vC8v
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 06:14:15 -0600 (CST)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p8.oit.umn.edu 4Jj86b2HTFz9vC8v
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p8.oit.umn.edu 4Jj86b2HTFz9vC8v
Received: by mail-pg1-f199.google.com with SMTP id c19-20020a637253000000b0035e0ba5a1bfso2760025pgn.13
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 04:14:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bcoDGYv5WbGoY7EVxjd/aG/krLpaD/QwL/X8pTR3VUk=;
        b=I9K1ey0NhGpNev5axEpQwfCr7zcPte2LN+htxeiycK6t56WT4om0xTQeVf5ij4PBd8
         mcTOSD2Mkui15OuZYRuN2iDXVWOJ/2bsWFyJQs3u96aGJpBQqUIx9AXy67FKGAF9g9c8
         tN6fzvCZuHeInuZKtq6p0rki6LhTW3I2o/prlUQQIlouqS4WRfBUhAC1MauNatB1WyhX
         6eMHmcyiJqjHGZLa7+Rx0u+wUUQLjlZCx3gkxxMY7w29+LS+UfFwxdtOLMJ+3CfM42Ez
         K2AdD3u/IjP9llrpNtJalHxwk0TL4DN0f5MmwdHJf0SwUDlxneyUPsoOF60EGQSoBpHq
         ig4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bcoDGYv5WbGoY7EVxjd/aG/krLpaD/QwL/X8pTR3VUk=;
        b=uIbK6/j3YCXLDk+z/McbRcS7gHOLYgTPD17zMgxUrWf3t1rD08BMQnlBsfCLH/3F4p
         1imvAvdaiDqROdnNQkFFe4SEkKJ7tcqN1iwa9eqIJNIYWeRzV39n9SE2sKk6ITatqcQx
         4AGXuypEurClTNQWchgKZx4PZY9HHugsK6lmz7s/gkgyXXD9Y3Dz1yNiuqzfi+f0cK8B
         HuBwsvcxwaa5XObaYij1tzLeFnzYKLsPT53QFxMVmJThrUZ7MQcEsPs636xvouHTcRIn
         elBZCFaUOvS4X9GK0rM7he96T0P2DfHWgSbrmmbTDvNWjVAUbXHV/NRmvpv/XfxO7OlA
         dWhg==
X-Gm-Message-State: AOAM531jNa133k7L3BiaURhiQubIkdwhrsjyxxCm+uo+5xBroZSqBnbB
        gpYeF8VcE1xNB4lCLBmFOpWMlk10odfMMgGIi6goB3jrQbq05Ebj3F5Z3RUfAcb59NULPysGgyv
        IFQrWSLZ5hOkAQFXFQyHhebXSNfFM
X-Received: by 2002:a05:6a00:cc5:b0:4c3:832a:1180 with SMTP id b5-20020a056a000cc500b004c3832a1180mr14103252pfv.10.1643026454442;
        Mon, 24 Jan 2022 04:14:14 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzkPpY5o+pwP/MpYJFNoBFr9G8QoFt755MIYhSaRAtEQ74j4Dp4tq5YxTU7Ff5MZDdXIDiHSg==
X-Received: by 2002:a05:6a00:cc5:b0:4c3:832a:1180 with SMTP id b5-20020a056a000cc500b004c3832a1180mr14103233pfv.10.1643026454188;
        Mon, 24 Jan 2022 04:14:14 -0800 (PST)
Received: from zqy787-GE5S.lan ([36.4.61.248])
        by smtp.gmail.com with ESMTPSA id b21sm11546359pgi.51.2022.01.24.04.14.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 04:14:13 -0800 (PST)
From:   Zhou Qingyang <zhou1615@umn.edu>
To:     zhou1615@umn.edu
Cc:     kjlu@umn.edu, Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>,
        Nadezda Lutovinova <lutovinova@ispras.ru>,
        Yu Xu <yuxu@marvell.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] usb: gadget: mv_u3d: Fix a NULL pointer dereference in mv_u3d_req_to_trb()
Date:   Mon, 24 Jan 2022 20:12:33 +0800
Message-Id: <20220124121236.19761-1-zhou1615@umn.edu>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <Yan3RHLH7UUjwSvE@hovoldconsulting.com>
References: <Yan3RHLH7UUjwSvE@hovoldconsulting.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In mv_u3d_req_to_trb(), mv_u3d_build_trb_one() is assigned to trb and
there is a dereference of it in mv_u3d_req_to_trb(), which could lead
to a NULL pointer dereference on failure of mv_u3d_build_trb_one().

Fix this bug by adding a check of trb.

This bug was found by a static analyzer.

Builds with CONFIG_USB_MV_U3D=m show no new warnings,
and our static analyzer no longer warns about this code.

Fixes: 3d4eb9dfa3e8 ("usb: gadget: mv: Add USB 3.0 device driver for Marvell PXA2128 chip.")
Signed-off-by: Zhou Qingyang <zhou1615@umn.edu>
---
The analysis employs differential checking to identify inconsistent
security operations (e.g., checks or kfrees) between two code paths 
and confirms that the inconsistent operations are not recovered in 
the current function or the callers, so they constitute bugs.

Note that, as a bug found by static analysis, it can be a false
positive or hard to trigger. Multiple researchers have cross-reviewed
the bug.

Changes in v2:
  -  Remove unnecessary error message

 drivers/usb/gadget/udc/mv_u3d_core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/gadget/udc/mv_u3d_core.c b/drivers/usb/gadget/udc/mv_u3d_core.c
index a1057ddfbda3..4573233f2835 100644
--- a/drivers/usb/gadget/udc/mv_u3d_core.c
+++ b/drivers/usb/gadget/udc/mv_u3d_core.c
@@ -417,6 +417,9 @@ static int mv_u3d_req_to_trb(struct mv_u3d_req *req)
 	 */
 	if (length <= (unsigned)MV_U3D_EP_MAX_LENGTH_TRANSFER) {
 		trb = mv_u3d_build_trb_one(req, &count, &dma);
+		if (!trb)
+			return -ENOMEM;
+
 		list_add_tail(&trb->trb_list, &req->trb_list);
 		req->trb_head = trb;
 		req->trb_count = 1;
-- 
2.25.1

