Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27F1052EEA7
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 17:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350592AbiETPFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 11:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230362AbiETPFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 11:05:48 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C9BBE9D;
        Fri, 20 May 2022 08:05:45 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id w4so11845711wrg.12;
        Fri, 20 May 2022 08:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=G8YVkVvldVjKj8/0oo3UbRp23lrDTxV5/xNVgylcsT4=;
        b=V2HCnqC15P9wvepLpKvmLIZ/9Rx5Uod4d7VSzHTrJgGdrKY39XOPNQSwzaxUEo69tV
         W3h/22hEcVCRRC4bJKTV74Xmlv2ln/DwQi3oicGlPFFRjwkme8JeaNQyREewcwNzIECz
         v7nGNoRa5NHRdH6AsxtAcvAPWb7xGw4UeJkcEZ9++32JBISHfGk6zcmUQtbLAizjHq3/
         xsQu7LULxhj8YIBIRukbUkC9aHKaoM1BaErP2vggvAaOlQvKXUICpbeGOVrbZXjGt7of
         6Nq8SGmTolxQ/0Mn7ghKngdT472i6O49x+R+NFPK+ItYdp2TKw4FZexIt20ArGWhgPUu
         Ldkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=G8YVkVvldVjKj8/0oo3UbRp23lrDTxV5/xNVgylcsT4=;
        b=Ysw5ce0lTnopKz0ws8nUdghfYP1kPKbA1v/W3Ko395PIXRU4vAqkQgaF3YxWddeAUZ
         wFNZ6FHqpRn1IyVM0fwtJDOMXWbFKq6xoj1anfFuLN6A42s/RTJm7fn1/lD/dv43E8OL
         v0cBi/YwKYyCdf3+Hr/ZaHdNkXR/EDz809x2K/k8gBU+i/BTVgtpxFDqdfDN7aY07fUO
         FGKbVeICQx/i4y2iDAaAD3y1FNJIWdN9Lhjuqpb+rk3Ylmlmy85jNoWNCeUjx1o8K9k7
         Dpe18d3MyQy1nLy4oyiov1IGs6kjlQMY+SvGwdNj0q9gEXrbf7/JQdwaF5n5sts32cjD
         wYSg==
X-Gm-Message-State: AOAM531KzJkMWNpbXDg5j9SPrBfcK9w00Lx3fEQIO0LbgAR+yw4UXycV
        Ed8vKV6pNIJwm9ZH6djSpC8=
X-Google-Smtp-Source: ABdhPJw1cnAe3OhOvzaMoMndqpMi5klAmXfWOiG+PBEGujPKaW3SyGKUkneNo1N039XYptZR44TNwA==
X-Received: by 2002:adf:fb12:0:b0:20c:79b2:a200 with SMTP id c18-20020adffb12000000b0020c79b2a200mr8978121wrr.617.1653059143904;
        Fri, 20 May 2022 08:05:43 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id y10-20020a7bcd8a000000b003942a244f54sm2768800wmj.45.2022.05.20.08.05.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 08:05:43 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] vdpa: Fix spelling mistake "excceeds" -> "exceeds"
Date:   Fri, 20 May 2022 16:05:42 +0100
Message-Id: <20220520150542.170526-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.35.3
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

There is a spelling mistake in an error message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/vdpa/vdpa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
index ebf2f363fbe7..b1bdacc867f0 100644
--- a/drivers/vdpa/vdpa.c
+++ b/drivers/vdpa/vdpa.c
@@ -979,7 +979,7 @@ static int vdpa_dev_vendor_stats_fill(struct vdpa_device *vdev,
 	switch (device_id) {
 	case VIRTIO_ID_NET:
 		if (index > VIRTIO_NET_CTRL_MQ_VQ_PAIRS_MAX) {
-			NL_SET_ERR_MSG_MOD(info->extack, "queue index excceeds max value");
+			NL_SET_ERR_MSG_MOD(info->extack, "queue index exceeds max value");
 			err = -ERANGE;
 			break;
 		}
-- 
2.35.3

