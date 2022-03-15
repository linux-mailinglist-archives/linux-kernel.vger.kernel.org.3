Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 403BE4DA3D0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 21:16:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351632AbiCOURk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 16:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234688AbiCOURi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 16:17:38 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 751CB5AA7C;
        Tue, 15 Mar 2022 13:16:26 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id r10so180466wrp.3;
        Tue, 15 Mar 2022 13:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IbbjVN0Q8IlfsZ85oniZzYVvKEoAu/4r4JrF1woWNgk=;
        b=WA364z6v6yFOrho2KuxyZFk72Bcx89l5vi22pwWXWvkxr2NQGEHOzFSIMnE89MyMz2
         PuG1jahMn97C6QDBCjmxOgUWfR4LR2XH75IU3YS05N8ae+GMYaMAi7DEYmo/V8eV02/d
         ztHgGSQEjur7eAk5HNusQt+dygxJrKSq4Jsfya28gV37tAUIsd+07HQni3eSFf1xSMu/
         qqHfGaTabYM4LQ8TCdSyudSAG9z15SvU+ghEYHR9UcYdRXDCdkP05TZRgPv7Zk4MEAVQ
         +wtefAkkrFstYy7FqpY95JH681HmltLkUDuOShnZLqyU57EDZ+OP1HUsw6BJSjR/U+sf
         AJgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IbbjVN0Q8IlfsZ85oniZzYVvKEoAu/4r4JrF1woWNgk=;
        b=AVAC40IuM9C9VTnxv2a2lKu5xuLl58LGUQ2RMSOwFGsI9kHDOjXb4k8MaqwbJlKCiT
         Sh2Wuo/jtD8WAkH06AZtB74Nr8uEqmemIOArpvFDERYMGeC6ad2I4cJj8DK1u2e50dCt
         sip4i95nKstpf9NWQ9+UI7HkltmoT//q/9RgsVYVP7/aNBZ26OI6h62Zdyg/XKgspSn/
         dLExgFwiLEujKZ6RJLN4xYwT0hn6RY2lPxVOTSu7eJN+loGPCBAUNCsH6rme91l6cZML
         yMs8N2sVRRZtLOG8a3Wk7MzAoMPtVcbyFkmA5Fr3/s5xZXtYHbpwZ/kkAy2NO3naP3ZX
         qb9w==
X-Gm-Message-State: AOAM5315WsDPSWakd7/0pwsau5FPpX8VGQO4zPlp81daAK4A5JumPaVu
        8dhKW5DIORO2WcrWah98p5o=
X-Google-Smtp-Source: ABdhPJz6x+l/GjODhBBJl0FbUTTh0W8inuyeGHQI1mYX3UpiPbl9wbJZKGDo2fANf0JNfxvVFJlOlg==
X-Received: by 2002:a5d:525b:0:b0:203:8f00:1a56 with SMTP id k27-20020a5d525b000000b002038f001a56mr19697216wrc.202.1647375384932;
        Tue, 15 Mar 2022 13:16:24 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id i11-20020a05600c354b00b00389f440512esm3359836wmq.32.2022.03.15.13.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 13:16:24 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     "David S . Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] sparc: Fix spelling mistake "wont" -> "won't"
Date:   Tue, 15 Mar 2022 20:16:23 +0000
Message-Id: <20220315201623.2951748-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a missing contraction hyphen a prom_printf message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 arch/sparc/kernel/leon_smp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/kernel/leon_smp.c b/arch/sparc/kernel/leon_smp.c
index 1eed26d423fb..cf3bddda8bb0 100644
--- a/arch/sparc/kernel/leon_smp.c
+++ b/arch/sparc/kernel/leon_smp.c
@@ -135,7 +135,7 @@ static void leon_smp_setbroadcast(unsigned int mask)
 	    ((LEON3_BYPASS_LOAD_PA(&(leon3_irqctrl_regs->mpstatus)) >>
 	      LEON3_IRQMPSTATUS_BROADCAST) & 1);
 	if (!broadcast) {
-		prom_printf("######## !!!! The irqmp-ctrl must have broadcast enabled, smp wont work !!!!! ####### nr cpus: %d\n",
+		prom_printf("######## !!!! The irqmp-ctrl must have broadcast enabled, smp won't work !!!!! ####### nr cpus: %d\n",
 		     leon_smp_nrcpus());
 		if (leon_smp_nrcpus() > 1) {
 			BUG();
-- 
2.35.1

