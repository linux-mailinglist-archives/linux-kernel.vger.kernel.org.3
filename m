Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B23364D2BA0
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 10:17:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231948AbiCIJSo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 04:18:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231797AbiCIJSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 04:18:42 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E87E1DA48
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 01:17:42 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id y22so2013170eds.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 01:17:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hWpPImVtoUiNVUu2h4LS7JTyYOKWJY6gpNjKd62Yxkg=;
        b=Hfa6lz7UYyCBsELtDHnUy0yBm1/cp3x13+fCjk7qbFsMzRq8d/UIjDLEU2CX5/xGhZ
         I+VBZrNB/qdSGktqHGEJgNbno4ztVnrcKDcZp+4P/w2oW7mt6qAH4XBgYppKounGnAzF
         SWuX/sEnx1XopufveGJpWuIUmhwyLbZ7Qxlm5oeIrDS6QBCRk0Wj7MaZfixEGziOZ/cA
         W1y/xN/+mB5KE0/ixARAAz9L7y7dNY8HiYLhD8fOFuOIQOe8b5oSFtuYqd4BojisymsH
         TSYMdKYLV3FROj3PXIoPeVyszL4zEa4QuKHyvzkfOdm2onc+Tb9g0vAwMdfe/T5rmkj5
         Ukcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hWpPImVtoUiNVUu2h4LS7JTyYOKWJY6gpNjKd62Yxkg=;
        b=SkFL68h7RPmhUlZaXnMgoEfix5XytTd5Zb/sQ0rzIO1+xDbSuf7tYdgqe3hEOgNGg7
         oVYfyutfnNKkDhHyn7jy1maAyBGLyiOOGqNXtXcrpnGxWXDDEx7VK6/Ir4COIqcAqBEm
         XF6/54mTXATqqzeckXV3V2LHXsw4FlNOSmHKXtKczWB3RygWUTyWmhEBCOdSLRAi4LRT
         e58C+M4m8uS/OzfIroxZ52gZY6AKFdKiUgzITF6WyGqa4MJPK6Yahbn/1FxYWDqtdBFV
         LTLPDVXbfmwhMHaHCP5wQ5hQvVaR7yUzEIw2XU15Q7zbYcz7lZX9zGxpB/ghTmAWVkyx
         vUXg==
X-Gm-Message-State: AOAM5310DiiXqjQrp7g+w+vucIq7EwHowHyqCiArGbHLHApjUsro0wej
        AZ4kyD5m/PN8Ys9gAJqQMQeV2lROSd1FaEh/
X-Google-Smtp-Source: ABdhPJycfuDctbdlBEIiSy8A5vAWJsYhsu2Kcuuk3TjIadZkqsmcAEQXLZH1GAzCcdtI1IDWu/XDGA==
X-Received: by 2002:a05:6402:2786:b0:416:6afe:2573 with SMTP id b6-20020a056402278600b004166afe2573mr7338062ede.54.1646817460386;
        Wed, 09 Mar 2022 01:17:40 -0800 (PST)
Received: from localhost.localdomain ([102.126.147.138])
        by smtp.gmail.com with ESMTPSA id y19-20020a1709064b1300b006dabe44a6edsm482948eju.141.2022.03.09.01.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 01:17:40 -0800 (PST)
From:   Hatim Muhammed <hatimmohammed369@gmail.com>
X-Google-Original-From: Hatim Muhammed
To:     linux-kernel@vger.kernel.org
Cc:     greg@kroah.com, abbotti@mev.co.uk, hsweeten@visionengravers.com,
        Hatim Muhammed <hatimmohammed369@gmail.com>
Subject: [PATCH 9/9] Removing unnecessary #if's
Date:   Wed,  9 Mar 2022 11:17:35 +0200
Message-Id: <20220309091735.13652-1-hatimmohammed369@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hatim Muhammed <hatimmohammed369@gmail.com>

Removing two #if 0 and one #if 1

Signed-off-by: Hatim Muhammed <hatimmohammed369@gmail.com>
---
 drivers/comedi/drivers/dt2801.c | 29 -----------------------------
 1 file changed, 29 deletions(-)

diff --git a/drivers/comedi/drivers/dt2801.c b/drivers/comedi/drivers/dt2801.c
index 230d25010f58..71193426d6e0 100644
--- a/drivers/comedi/drivers/dt2801.c
+++ b/drivers/comedi/drivers/dt2801.c
@@ -87,17 +87,6 @@
 #define DT2801_STATUS		1
 #define DT2801_CMD		1
 
-#if 0
-/* ignore 'defined but not used' warning */
-static const struct comedi_lrange range_dt2801_ai_pgh_bipolar = {
-	4, {
-		BIP_RANGE(10),
-		BIP_RANGE(5),
-		BIP_RANGE(2.5),
-		BIP_RANGE(1.25)
-	}
-};
-#endif
 static const struct comedi_lrange range_dt2801_ai_pgl_bipolar = {
 	4, {
 		BIP_RANGE(10),
@@ -107,17 +96,6 @@ static const struct comedi_lrange range_dt2801_ai_pgl_bipolar = {
 	}
 };
 
-#if 0
-/* ignore 'defined but not used' warning */
-static const struct comedi_lrange range_dt2801_ai_pgh_unipolar = {
-	4, {
-		UNI_RANGE(10),
-		UNI_RANGE(5),
-		UNI_RANGE(2.5),
-		UNI_RANGE(1.25)
-	}
-};
-#endif
 static const struct comedi_lrange range_dt2801_ai_pgl_unipolar = {
 	4, {
 		UNI_RANGE(10),
@@ -580,14 +558,7 @@ static int dt2801_attach(struct comedi_device *dev, struct comedi_devconfig *it)
 	/* ai subdevice */
 	s->type = COMEDI_SUBD_AI;
 	s->subdev_flags = SDF_READABLE | SDF_GROUND;
-#if 1
 	s->n_chan = n_ai_chans;
-#else
-	if (it->options[2])
-		s->n_chan = board->ad_chan;
-	else
-		s->n_chan = board->ad_chan / 2;
-#endif
 	s->maxdata = (1 << board->adbits) - 1;
 	s->range_table = ai_range_lkup(board->adrangetype, it->options[3]);
 	s->insn_read = dt2801_ai_insn_read;
-- 
2.35.1

