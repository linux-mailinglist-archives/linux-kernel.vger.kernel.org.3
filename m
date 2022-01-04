Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08955483A99
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 03:35:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232281AbiADCet (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 21:34:49 -0500
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:48912 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232120AbiADCer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 21:34:47 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id 4JScCB55Dxz9vcQr
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 02:34:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id fd-sUltsS47i for <linux-kernel@vger.kernel.org>;
        Mon,  3 Jan 2022 20:34:46 -0600 (CST)
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id 4JScCB3MlTz9vcQh
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jan 2022 20:34:46 -0600 (CST)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p7.oit.umn.edu 4JScCB3MlTz9vcQh
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p7.oit.umn.edu 4JScCB3MlTz9vcQh
Received: by mail-pf1-f200.google.com with SMTP id t128-20020a628186000000b004bac607ec25so17711673pfd.11
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jan 2022 18:34:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CWsjvf5lJTjl1jfTfkc0TR1vLe+VA5l5rArUlTfHN8c=;
        b=M/kLfQdjuHaT1Zp2/lozGdWmAj+7S7WYQEmrJoNfPXWpGXJGOb98/9hL9qXAfvcVlL
         jNiyMYd2fzQATZKD8/lnt02G56ANzPhewVhOnAi+zYKbnlf563Jmw9lw1NftgwqFOjie
         NiKljfNR9BbzKbuQ7bPYXLdEm1HW1pJqDOicUhFhWIJXK2/eKGJSp30tfQStmzQ2LR3F
         sTgiuaFQXKhA403v2UnB0CP9ZPVGzAWkCoouBFHjebCcLHYdMiVCAncSWekvHZuFHARo
         CtRywwBoWTP2N5BjCIEqBRXA+odGw4UDJq+h9qE0qkZDzb5+Wwgc24YsfyaRXQv0UdC6
         K7rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CWsjvf5lJTjl1jfTfkc0TR1vLe+VA5l5rArUlTfHN8c=;
        b=2qA9RjFsZK4CDIgX1EI9r68S+p1qiJurgB1VlZbhOh1WQYD8znFA4C0KX3QbN+gFey
         1YzwAa1+VoeJWVNlUYy1wAiJBIezy/TR//q4ZjfltKjE4ICyRDNPvLaC/vK1hzaOOIQJ
         8lypJpNhcIAI0f58zw+Ldln31fdfGUNsU9xbmEAxoJRVcLkjZTAzr9t9KKnqbrywM8uW
         tiwhwlpR5pETcw71IkMscmy0r3pO9rMDNtnXATVcUTal94ZUaSyZIzaUz1kBJYh4QLDz
         ERx06I97EMj0i7UTQQZdUspXnLUGUpz10geh4iUdUCyTT9Z0bpSbkMgoK6CZChJxzPh6
         LCug==
X-Gm-Message-State: AOAM533Xm4NPUAE4Onsv/1qkwK/biS0TsgZSUpaHB5YY/Khd2VKFvtEh
        cxxw/uFlRdeGY4rllWk/G6k0a01449kZxYvAFEA+dgrDCJzRj1AxpiUjdgp4+cy+fBvzkocvQ1w
        RnM5FLtgPIU97Gyy9SkWDFJ3cGPob
X-Received: by 2002:a17:902:d2d0:b0:149:3d85:229d with SMTP id n16-20020a170902d2d000b001493d85229dmr47174419plc.151.1641263685689;
        Mon, 03 Jan 2022 18:34:45 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzFEYXJYqg/6jMWwdU70fHqk5p6GTqGCHfajWL6APjOhUqOyr5o8h4CqTaOePD6co3tRk35dg==
X-Received: by 2002:a17:902:d2d0:b0:149:3d85:229d with SMTP id n16-20020a170902d2d000b001493d85229dmr47174406plc.151.1641263685453;
        Mon, 03 Jan 2022 18:34:45 -0800 (PST)
Received: from zqy787-GE5S.lan ([36.4.62.162])
        by smtp.gmail.com with ESMTPSA id p22sm36356236pfo.57.2022.01.03.18.34.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jan 2022 18:34:45 -0800 (PST)
From:   Zhou Qingyang <zhou1615@umn.edu>
To:     zhou1615@umn.edu
Cc:     kjlu@umn.edu, Fei Li <fei1.li@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shuo Liu <shuo.a.liu@intel.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] virt: acrn: fix a memory leak bug in acrn_dev_ioctl()
Date:   Tue,  4 Jan 2022 10:34:39 +0800
Message-Id: <20220104023439.33754-1-zhou1615@umn.edu>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In acrn_dev_ioctl(), vm_param is not released or passed out on the 
error path of "if ((vm_param->reserved0 | vm_param->reserved1) != 0)", 
which could lead to a memory leak.

Fix this bug by adding a kfree of vm_param on the error path.

This bug was found by a static analyzer.

Builds with CONFIG_ACRN_GUEST=y, CONFIG_ACRN_HSM=y show no new warnings, 
and our static analyzer no longer warns about this code.

Fixes: 9c5137aedd11 (“9c5137aedd11 virt: acrn: Introduce VM management interfaces”)
Signed-off-by: Zhou Qingyang <zhou1615@umn.edu>
---
The analysis employs differential checking to identify inconsistent
security operations (e.g., checks or kfrees) between two code paths
and confirms that the inconsistent operations are not recovered in 
the current function or the callers, so they constitute bugs. 

Note that, as a bug found by static analysis, it can be a false
positive or hard to trigger. Multiple researchers have cross-reviewed
the bug.

 drivers/virt/acrn/hsm.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/virt/acrn/hsm.c b/drivers/virt/acrn/hsm.c
index 5419794fccf1..205f4c637556 100644
--- a/drivers/virt/acrn/hsm.c
+++ b/drivers/virt/acrn/hsm.c
@@ -136,9 +136,11 @@ static long acrn_dev_ioctl(struct file *filp, unsigned int cmd,
 		if (IS_ERR(vm_param))
 			return PTR_ERR(vm_param);
 
-		if ((vm_param->reserved0 | vm_param->reserved1) != 0)
-			return -EINVAL;
-
+		if ((vm_param->reserved0 | vm_param->reserved1) != 0) {
+			ret = -EINVAL;
+			kfree(vm_param);
+			break;
+		}
 		vm = acrn_vm_create(vm, vm_param);
 		if (!vm) {
 			ret = -EINVAL;
-- 
2.25.1

