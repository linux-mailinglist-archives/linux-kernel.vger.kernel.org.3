Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBA18550CCD
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 21:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236367AbiFSTnK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 15:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234474AbiFSTnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 15:43:00 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD1476267
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 12:42:58 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id p5so2648630pjt.2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 12:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p64PM6E0TGRLi7vOtiUccETzM6tLKB5mp4MOcHiJCCA=;
        b=otsj+QWi/QqeRrqbbivddkYBK20Ow+ZA4auexlE+f5RNCTdE/E4TEHi/VQFGmqpD+N
         ilyCyLzeA48sbbxX6wqYF0Y+Gn3kcTNLVuGjhClY+TRss1eJwShYgMb0o2ga6d0U1Up6
         3m7+Bu8X7P8k5/l0NndJoFXmQ26IaYFyZn9vt2j91Pe41JqeKF/OdnC1GiC7RUzqtHq6
         ks423bAssMsHYdHbysdQnP3VlXmpo9QteOvJl9IS9GefCqLo8rSZI18y31iSgqLAKzjf
         jDhWB6hQu9ZX60ExUevPFytfiIlP8R35yuwerqZH4v+Qas+OmxuV9Kao6UEbbATCpYQb
         urow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p64PM6E0TGRLi7vOtiUccETzM6tLKB5mp4MOcHiJCCA=;
        b=RkrunJKBDWKVgkrvozmqDGq2Kt9tHgnRpCM6eBNrsiXMehEWIJobWWDVUBkfZlRBiM
         g/F5EUyxPVXhGTYRBnZ1DQD3IAAJbbje6JIgTyhJS7dcKogPsMjxjV7fWniECzzCRyOj
         YErTHDgiuurQ6pu2Cd1OnJHgBzB5/H2wUptWaf2VfHjRznDatv6+/5JsHADLpQ3orchb
         uEbnW766Ht3mD5CpFOvykHPS93GBRBmvNMmPen8NKhwx0pVv/6Pd/3WnSmNQQkAmUemP
         llpassh2gF3icV53J22qAaz07HBk8MV6VoDrFh+aCkgZoD5r+7GIOOIF9o9jqKPvjIFG
         izhw==
X-Gm-Message-State: AJIora+ViGv1arg0TRZXOCEdsNyjUs0JlfE/PWSwfUXiYSRlttARHQ4u
        MIhCyKjzEd/m8jOzIy7hcEnqouA5LN4iRk7b
X-Google-Smtp-Source: AGRyM1tTEVPq8AxeR+Q/BVmPnVdkXz2lZ/RQFuYV0erbmazTI/xk0cGSEi1l1XGP5xwHiWwxFuuUrQ==
X-Received: by 2002:a17:90b:17c7:b0:1e8:5136:c32a with SMTP id me7-20020a17090b17c700b001e85136c32amr22873247pjb.43.1655667778131;
        Sun, 19 Jun 2022 12:42:58 -0700 (PDT)
Received: from localhost (c-67-180-87-133.hsd1.ca.comcast.net. [67.180.87.133])
        by smtp.gmail.com with ESMTPSA id z4-20020a62d104000000b005180c127200sm7370805pfg.24.2022.06.19.12.42.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jun 2022 12:42:57 -0700 (PDT)
From:   Chang Yu <marcus.yu.56@gmail.com>
To:     Larry.Finger@lwfinger.net, paskripkin@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Chang Yu <marcus.yu.56@gmail.com>
Subject: [PATCH v2 4/5] Staging: r8188eu: core: rtw_xmit: Fixed a brace coding style issue
Date:   Sun, 19 Jun 2022 12:42:30 -0700
Message-Id: <ff6f2ecb22c3d295ceae0dab593bedfc6eac9e32.1655666628.git.marcus.yu.56@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1655666628.git.marcus.yu.56@gmail.com>
References: <cover.1655666628.git.marcus.yu.56@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removed superfluous brackets around a if clause as per checkpatch.pl

Signed-off-by: Chang Yu <marcus.yu.56@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_xmit.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_xmit.c b/drivers/staging/r8188eu/core/rtw_xmit.c
index 73eb2f01c176..6797335f7855 100644
--- a/drivers/staging/r8188eu/core/rtw_xmit.c
+++ b/drivers/staging/r8188eu/core/rtw_xmit.c
@@ -952,9 +952,8 @@ s32 rtw_xmitframe_coalesce(struct adapter *padapter, struct sk_buff *pkt, struct
 			mpdu_len -= llc_sz;
 		}
 
-		if ((pattrib->icv_len > 0) && (pattrib->bswenc)) {
+		if ((pattrib->icv_len > 0) && (pattrib->bswenc))
 			mpdu_len -= pattrib->icv_len;
-		}
 
 		if (bmcst) {
 			/*  don't do fragment to broadcast/multicast packets */
-- 
2.36.1

