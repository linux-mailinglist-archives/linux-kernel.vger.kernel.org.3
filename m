Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7D7E47527D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 07:05:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231612AbhLOGFg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 01:05:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbhLOGFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 01:05:35 -0500
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9C7AC061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 22:05:34 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id bu11so19468834qvb.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 22:05:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kfB50yz+wtniH54BM6Vm2zw9w3vq/rJwIyH5Smo+/Jo=;
        b=J5aTdyn12laJzJtmwQtHRwJpYqox3Ppg6gM9O/iTPQGJKCJAw7TrOojuAKaCcjiltK
         CVZqgLXIvG9RmyevGn1jmP+PW8ttpavSiWK9PuxAdOvKqf0FUaMrd6j1HktU6MERFg4L
         wfClW46lzk/3xFlhI8DmqaZE+l4TuLrCDDNq39MjvFYH5H8HYHo9I5KdSeR6CJAhrg0P
         7EC16wyCVZWZi2uz9n+CU7b4PrlVdWSPipQ1xmwe1jNi4SJ+cum+hM0hbA10fwA9Sc8P
         Gt1DCNUUL79eITCVOmPkUSzB9QziYTWtpJmCzySWRLLwAsGiNIWEksgvGtJ2zzcuJq/Z
         +EsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kfB50yz+wtniH54BM6Vm2zw9w3vq/rJwIyH5Smo+/Jo=;
        b=4PGtjR03d1+R+yusWyc0t8zy4wn0SfX0jzQBqMKA0em0U1iVyoNd8VojA16Y47wdq2
         oGpmgo+CIpaTbUbCDtzFyhMWCG/YoQfjavDrdu0XkOlynA73E4EJF/HiEgadySDYmG4L
         3hQ78XlBcuoJLXt8rc5itDYwamABvo6Ymg0vYIPs8eaX6iMJxUBUAmT0Mqkzc6HoV+7D
         rloBdRz5WfjLARSZQsepx+aSFD/VMr8/erWJ/OTJflIHDmdlP8VQ96ltSD+oICwAxUw2
         KtKEDMk+FgZ2XyxSuHGy8j7Rxm3H9Pf3NrL8kNh0J/3OC0ujQxgcam4A4Dz2l8eOQL0E
         B4ag==
X-Gm-Message-State: AOAM533k5dV6AZNU0P7C+NzP/e6LVR3AHoQ3JgLJ0yUdcA96lPcnvr8P
        ZWDtq79NLNpf/FNjIK3hGmw=
X-Google-Smtp-Source: ABdhPJwhFH2MM84maffO9BMwznbkRqZ0gyp7GM8TVIIzFezFqVl2zZc02G1CuV/iFJlx+kbkFey5KQ==
X-Received: by 2002:a05:6214:2428:: with SMTP id gy8mr9883423qvb.18.1639548333964;
        Tue, 14 Dec 2021 22:05:33 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id l22sm747156qtj.68.2021.12.14.22.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 22:05:33 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     tglx@linutronix.de
Cc:     maz@kernel.org, matthias.bgg@gmail.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH irqchip-next] drivers/irqchip: remove redundant ret variable
Date:   Wed, 15 Dec 2021 06:05:28 +0000
Message-Id: <20211215060528.442001-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Minghao Chi <chi.minghao@zte.com.cn>

Return value directly instead of taking this
in another redundant variable.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
---
 drivers/irqchip/irq-mtk-cirq.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-mtk-cirq.c b/drivers/irqchip/irq-mtk-cirq.c
index 9bca0918078e..2f895473d9d3 100644
--- a/drivers/irqchip/irq-mtk-cirq.c
+++ b/drivers/irqchip/irq-mtk-cirq.c
@@ -60,8 +60,6 @@ static void mtk_cirq_unmask(struct irq_data *data)
 
 static int mtk_cirq_set_type(struct irq_data *data, unsigned int type)
 {
-	int ret;
-
 	switch (type & IRQ_TYPE_SENSE_MASK) {
 	case IRQ_TYPE_EDGE_FALLING:
 		mtk_cirq_write_mask(data, CIRQ_POL_CLR);
@@ -84,8 +82,7 @@ static int mtk_cirq_set_type(struct irq_data *data, unsigned int type)
 	}
 
 	data = data->parent_data;
-	ret = data->chip->irq_set_type(data, type);
-	return ret;
+	return data->chip->irq_set_type(data, type);
 }
 
 static struct irq_chip mtk_cirq_chip = {
-- 
2.25.1

