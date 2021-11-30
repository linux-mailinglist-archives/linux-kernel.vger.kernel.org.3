Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1999F463A3F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 16:38:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238424AbhK3PmF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 10:42:05 -0500
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:47608 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232311AbhK3PmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 10:42:04 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id 4J3RFw5X85z9vY6w
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 15:38:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id BHe0xdW24BQi for <linux-kernel@vger.kernel.org>;
        Tue, 30 Nov 2021 09:38:44 -0600 (CST)
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id 4J3RFw3j2Bz9vY6m
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 09:38:44 -0600 (CST)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p8.oit.umn.edu 4J3RFw3j2Bz9vY6m
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p8.oit.umn.edu 4J3RFw3j2Bz9vY6m
Received: by mail-pg1-f198.google.com with SMTP id x30-20020a637c1e000000b00324ab629735so10430874pgc.17
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 07:38:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wiBMlf8w+Lvhex8SpMtIm4owez3P1WFv8J1K31m9Xfk=;
        b=eBnJj+J1oCY/53Ah+ONQeTSeJY/Ln7eJcdvt5yMdD2hNKgvaYSx3bMTWKzC84DHT2w
         E/u5qULkJqxdc7XfWlon0PKAp2iBsd7SKyDyWo5YfJqQ4qHIWhzyRjFxZLVc3J4usN5p
         h0ekndsLhUSMEGRyFiY0TtGDyw2AoBEuli9ARA+aZnDiv8TIsIwB28WLRySjnX47bQVW
         Lzt9JkW6wjUEZGfGz7Rg7WXmOMklaF2GPGGUCaIcG+Kahfe/PzU1ApfxH6V8XIrteDLY
         ZxHIkppWtGsrey7AZoWbuq32f8sZIUeMGhi8j44+2A5+DDkovcUQp/WK9m2phX/VhefA
         4+lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wiBMlf8w+Lvhex8SpMtIm4owez3P1WFv8J1K31m9Xfk=;
        b=MlUWXzqPCSk8HJlRpDFKny/saab2WfWGVRgfDRNslfRCpl4XuO2rXTI1ItIumXVXRD
         +FrZn4VvcF2PGz36KgxI6yDrhIosM2R05fvVcij0INptTV5hQj6Xb9/w0/3SovwBPsRm
         tKFZ/GYazLxcLhxj9zO4bDTEdB0MSlt5Nlcb3zCQNPEDw3HlJy9AsYmcviXdP8ve206B
         oIjF/Q6ULt0AGMsGA9gh+yqF+nFoET/tSWT544OmE76bNAdJsU19fk/ZYRf0BeytcoR5
         6ljdrXu2Pa8HA4y19eoEU9KsOzSpn/0iRJ6hYzKMbtb/Eu5rw/dGPcx1KJvJMg+ualPd
         Uf4w==
X-Gm-Message-State: AOAM532+hj3L5oCSTrmoiVTADmmyX/UYpu1zpfF3WsGMI70C5iwG+/93
        Abf97N47MsOByK1tWP5E9y76ydoVICQLTk7VgKjhRkqC8XtZpmNSsK9ZJS3uYbOR2VQRuY0JXWp
        xsoaKpxyiuJeB/y65xRyEan8AQnMx
X-Received: by 2002:a17:902:c745:b0:143:d220:9196 with SMTP id q5-20020a170902c74500b00143d2209196mr130271plq.74.1638286723701;
        Tue, 30 Nov 2021 07:38:43 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxL9G+X20LYX5a66BCeYXRKS/K99ZgpXXqKaXiwAAlEOjlIhunhmegyKfocs1S086lQzw4Jrw==
X-Received: by 2002:a17:902:c745:b0:143:d220:9196 with SMTP id q5-20020a170902c74500b00143d2209196mr130252plq.74.1638286723495;
        Tue, 30 Nov 2021 07:38:43 -0800 (PST)
Received: from zqy787-GE5S.lan ([36.7.42.137])
        by smtp.gmail.com with ESMTPSA id d10sm21346300pfl.139.2021.11.30.07.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 07:38:43 -0800 (PST)
From:   Zhou Qingyang <zhou1615@umn.edu>
To:     zhou1615@umn.edu
Cc:     kjlu@umn.edu, Mauro Carvalho Chehab <mchehab@kernel.org>,
        Patrick Boettcher <pboettcher@dibcom.fr>,
        Olivier Grenie <Olivier.Grenie@dibcom.fr>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] media: dib8000: Fix a memleak in dib8000_init()
Date:   Tue, 30 Nov 2021 23:38:05 +0800
Message-Id: <20211130153807.174852-1-zhou1615@umn.edu>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In dib8000_init(), the variable fe is not freed or passed out on the
failure of dib8000_identify(&state->i2c), which could lead to a memleak.

Fix this bug by adding a kfree of fe in the error path.

This bug was found by a static analyzer. The analysis employs
differential checking to identify inconsistent security operations
(e.g., checks or kfrees) between two code paths and confirms that the
inconsistent operations are not recovered in the current function or
the callers, so they constitute bugs.

Note that, as a bug found by static analysis, it can be a false
positive or hard to trigger. Multiple researchers have cross-reviewed
the bug.

Builds with CONFIG_DVB_DIB8000=m show no new warnings,
and our static analyzer no longer warns about this code.

Fixes: 77e2c0f5d471 ("V4L/DVB (12900): DiB8000: added support for DiBcom ISDB-T/ISDB-Tsb demodulator DiB8000")
Signed-off-by: Zhou Qingyang <zhou1615@umn.edu>
---
 drivers/media/dvb-frontends/dib8000.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/media/dvb-frontends/dib8000.c b/drivers/media/dvb-frontends/dib8000.c
index bb02354a48b8..d67f2dd997d0 100644
--- a/drivers/media/dvb-frontends/dib8000.c
+++ b/drivers/media/dvb-frontends/dib8000.c
@@ -4473,8 +4473,10 @@ static struct dvb_frontend *dib8000_init(struct i2c_adapter *i2c_adap, u8 i2c_ad
 
 	state->timf_default = cfg->pll->timf;
 
-	if (dib8000_identify(&state->i2c) == 0)
+	if (dib8000_identify(&state->i2c) == 0) {
+		kfree(fe);
 		goto error;
+	}
 
 	dibx000_init_i2c_master(&state->i2c_master, DIB8000, state->i2c.adap, state->i2c.addr);
 
-- 
2.25.1

