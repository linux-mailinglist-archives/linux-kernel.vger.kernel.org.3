Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEC844830CC
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 13:00:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231842AbiACMAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 07:00:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbiACMAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 07:00:17 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24373C061761
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jan 2022 04:00:17 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id o6so135044242edc.4
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jan 2022 04:00:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JOsgRWzbW7i9cHPER6RC1xxIi1+F1LeKK9MgTtvOIbc=;
        b=QtSn3B2MDIOEpYvgNQiyW8retvUbyxi/RO1QbX3BgmBxH8HN3TlJ951662JqAk7qI+
         sVE1qdCN6CLH1rijdX1cVN3IseGdZxWnhPsYjA2SxR2QNuG3ZFw4E3PF6VyuMnbs4+5J
         oUHdaaBPWEFy2M+BnZ3DciyqZnT+AFcySKHIatc2fmelOX9Xbnc+GuMYdPMS/i5Fjhd6
         vHKzQtCsIzijEAHWTb8hhbDdntjm0yItEJW2/hDPfiGdVt3Gn1yXNOcWpch72BzgI2l2
         W9q0QonjruMrUG6S6Jtc9KUY0KoPAXuxywuLZQdZWvWLkm7yfLKUCERw07JDPer6MlAF
         iIFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JOsgRWzbW7i9cHPER6RC1xxIi1+F1LeKK9MgTtvOIbc=;
        b=CNsa20JaWv6Zcb6Hos1TFhnCmrfc/jqdjSp6yhoFcX08do3lyn3gRXxmqY7k2fAF9O
         qvMfyJ9+34qXeeer48FsqDLzmNm7JFd8fSJ9qnLJasrsVuDOYUPNgEzwjF5TArcbywEt
         KoctrIy4vPbjiV5198IUyyqoCyOTwss8edtFH4SNRN/iOhG1Ki/RRWX3JvTkHW5/cHCv
         x61i1EuwW9fF6+cptpEtWOMVF8n239rW44daXSl8G1WWyekpzCWXqnIfWi/gDyY85afK
         Q4/M5z/YzQbD3JkBiJYE73/GA6RNbt6uB6k0i5opTAPshRAESdRC5OybHLtl7QEYwT+1
         6jIQ==
X-Gm-Message-State: AOAM533lw7YEt6dqkI1/GiMYYyhsAreVWE+SSOhNTJXfT2MvEF3nYTSa
        fgWjBo/KCIdOEXR3M3yiOOM=
X-Google-Smtp-Source: ABdhPJzm2PeqpbDCSS5NKSPL01iO1HxjyW7TgF2/0B4HSTHr3d6qL2jen1XIAI5mXEukP0Hd3DJwvQ==
X-Received: by 2002:a17:907:961c:: with SMTP id gb28mr35344729ejc.385.1641211215689;
        Mon, 03 Jan 2022 04:00:15 -0800 (PST)
Received: from t470p.fritz.box (host-87-18-201-21.retail.telecomitalia.it. [87.18.201.21])
        by smtp.gmail.com with ESMTPSA id lg17sm10525191ejb.194.2022.01.03.04.00.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jan 2022 04:00:15 -0800 (PST)
From:   Alberto Merciai <alb3rt0.m3rciai@gmail.com>
Cc:     alb3rt0.m3rciai@gmail.com, linuxfancy@googlegroups.com,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Zameer Manji <zmanji@gmail.com>, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: r8188eu: add spaces around P2P_AP_P2P_CH_SWITCH_PROCESS_WK
Date:   Mon,  3 Jan 2022 12:56:25 +0100
Message-Id: <20220103115633.221853-1-alb3rt0.m3rciai@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove checkpatch.pl error by adding spaces
around P2P_AP_P2P_CH_SWITCH_PROCESS_WK.

Signed-off-by: Alberto Merciai <alb3rt0.m3rciai@gmail.com>
---
 drivers/staging/r8188eu/include/wifi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/r8188eu/include/wifi.h b/drivers/staging/r8188eu/include/wifi.h
index 7cbc7015e90f..0b0bd39a257f 100644
--- a/drivers/staging/r8188eu/include/wifi.h
+++ b/drivers/staging/r8188eu/include/wifi.h
@@ -893,7 +893,7 @@ enum P2P_PROTO_WK_ID {
 	P2P_PRE_TX_PROVDISC_PROCESS_WK = 2,
 	P2P_PRE_TX_NEGOREQ_PROCESS_WK = 3,
 	P2P_PRE_TX_INVITEREQ_PROCESS_WK = 4,
-	P2P_AP_P2P_CH_SWITCH_PROCESS_WK =5,
+	P2P_AP_P2P_CH_SWITCH_PROCESS_WK = 5,
 	P2P_RO_CH_WK = 6,
 };
 
-- 
2.25.1

