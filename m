Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F350463C62
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 17:59:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244421AbhK3RCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 12:02:53 -0500
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:38392 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbhK3RCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 12:02:51 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id 4J3T371LqJz9xKjt
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 16:59:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 7JvVv-Jn-sxj for <linux-kernel@vger.kernel.org>;
        Tue, 30 Nov 2021 10:59:31 -0600 (CST)
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id 4J3T3619q5z9wVGL
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 10:59:30 -0600 (CST)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p8.oit.umn.edu 4J3T3619q5z9wVGL
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p8.oit.umn.edu 4J3T3619q5z9wVGL
Received: by mail-pg1-f199.google.com with SMTP id m5-20020a654c85000000b00325a50f232bso1459775pgt.8
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 08:59:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NgMbozFHXJqLHoRG49MYJugk9HJ3133hBjaLcyfLQ+8=;
        b=MNM/1HKe8CKwgts1qfL15f+7uqdvEcynNAkGPeyykBoJguCaKt3BjugMz9N2i6saZU
         bkYkidSDJ3nmPAZN4HY0T9Z1kKtpJNFRNSeoyKn90EARq2uT95VzdgJqfFQNywLUyL+J
         /oM0LOfm1qY3fuEURCkwYYL6e2wx41+GwUIfyNZ8tE6kNQ4QaC1qLyVlJaVkDsb1Pcz1
         lmFl7N/yHQWHYvFsfL7XYEXG047e82Hm6dNrzHTkq8szPuh9GbOSbj2xXqWheIpnWzjG
         imP5dVjySZH73y05CDDGjPpIoctMDaSnz78746GkxieG5CcEaUtbe+PAhnPuHJfBX1UF
         91Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NgMbozFHXJqLHoRG49MYJugk9HJ3133hBjaLcyfLQ+8=;
        b=F5+E26nH36KxL+Grt7Y3PZ4a07HRKQm6OukXoVsu20CX65VZe1Bo0tE6gYI+kHlqBT
         f9tftcn6UxIKIJFoBH0X1FEaDFyYOh8+djdSgolDGCGqIJY1jipEQrgr6AQcPicsRHIt
         aY7DUAdm+pwU/64JKxvFv0JZlxR4ARTOUWRIkmma8ktCHB/IBE2jRftgDUkiMunqh8md
         L7mzCQc6ItwOQu/TzGkYYJ8946AiO6Y9YD6r6Yo5qj+lfqugLosQUrSLpjcWfrVylvi1
         r6S7dFi7EZygev8csumbY6/jJDr5tsparK0osPRbE2E8HbF3FFYZrH5ms7liHiEeKA2T
         8YJQ==
X-Gm-Message-State: AOAM5330sa6tmSQSE9tuAeWNaQ5A480omzTdIRs48vEfonh1UVGVR1BB
        SKm4oAg3FXn/6E+OomkX6N2APomznmb7taXTyFVhcH1bj3+6vdzVvi6Ua/1dRK8HIgBiPP8xUJv
        DmEQ5u3OxHuy9JZ+329HRgOg6s5HB
X-Received: by 2002:a17:902:e550:b0:142:2673:d873 with SMTP id n16-20020a170902e55000b001422673d873mr246836plf.5.1638291569403;
        Tue, 30 Nov 2021 08:59:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzPR57h6rxGNToMOEsbKJcM2/dj1KPIokR41bDiNbNwCKkv/vJvDsHl2vgJg1eLs8EoqF6N1Q==
X-Received: by 2002:a17:902:e550:b0:142:2673:d873 with SMTP id n16-20020a170902e55000b001422673d873mr246789plf.5.1638291569095;
        Tue, 30 Nov 2021 08:59:29 -0800 (PST)
Received: from zqy787-GE5S.lan ([36.7.42.137])
        by smtp.gmail.com with ESMTPSA id lj15sm2997217pjb.12.2021.11.30.08.59.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 08:59:28 -0800 (PST)
From:   Zhou Qingyang <zhou1615@umn.edu>
To:     zhou1615@umn.edu
Cc:     kjlu@umn.edu, Dominik Brodowski <linux@dominikbrodowski.net>,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] pcmcia: rsrc_nonstatic: Fix a NULL pointer dereference in __nonstatic_find_io_region()
Date:   Wed,  1 Dec 2021 00:59:23 +0800
Message-Id: <20211130165925.194423-1-zhou1615@umn.edu>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In __nonstatic_find_io_region(), pcmcia_make_resource() is assigned to
res and used in pci_bus_alloc_resource(). There is a dereference of res
in pci_bus_alloc_resource(), which could lead to a NULL pointer
dereference on failure of pcmcia_make_resource().

Fix this bug by adding a check of res.

This bug was found by a static analyzer. The analysis employs
differential checking to identify inconsistent security operations
(e.g., checks or kfrees) between two code paths and confirms that the
inconsistent operations are not recovered in the current function or
the callers, so they constitute bugs.

Note that, as a bug found by static analysis, it can be a false
positive or hard to trigger. Multiple researchers have cross-reviewed
the bug.

Builds with ONFIG_PCCARD_NONSTATIC=y show no new warnings,
and our static analyzer no longer warns about this code.

Fixes: 49b1153adfe1 ("pcmcia: move all pcmcia_resource_ops providers into one module")
Signed-off-by: Zhou Qingyang <zhou1615@umn.edu>
---
 drivers/pcmcia/rsrc_nonstatic.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pcmcia/rsrc_nonstatic.c b/drivers/pcmcia/rsrc_nonstatic.c
index bb15a8bdbaab..4f5e1a46ebe4 100644
--- a/drivers/pcmcia/rsrc_nonstatic.c
+++ b/drivers/pcmcia/rsrc_nonstatic.c
@@ -689,6 +689,9 @@ static struct resource *__nonstatic_find_io_region(struct pcmcia_socket *s,
 	struct pcmcia_align_data data;
 	unsigned long min = base;
 	int ret;
+
+	if (!res)
+		return NULL;

 	data.mask = align - 1;
 	data.offset = base & data.mask;
-- 
2.25.1

