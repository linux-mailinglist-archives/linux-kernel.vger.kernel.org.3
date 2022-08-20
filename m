Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3201859AF7D
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 20:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232490AbiHTSRF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 14:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231817AbiHTSQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 14:16:42 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 421FD31DCB
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 11:16:41 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id t5so9131291edc.11
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 11:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=qVzfHbu5pGUMMhouEyZrkVnSBIn9SzY5DZdTT7h9U4g=;
        b=AfXZ56h85+QxZ5KoQ2/jNFPLYZV3Lt2RitLHjiRAfa5VhgVuCnSnvhf+mh4Dxu8yBL
         BVdZ8T11N4oSNt6rVgPKep8D2/CW2iyiOr9CkJZc1vZGjgXBAgd4KvJeECccHEFlqO7E
         3jl9JzxDYIKrq5Rp2pMPn9VZg/xdV245vPgZX0JMw9SKmW47KXpPvHG55kNL/lbUbW+y
         2+t/GSkKsOfxzDj2X8oBg+dZcCy1E6CjBTykdiVdZfH7VRUZYPpSvQXqxhvSnR3XxEQi
         GXS4CxX3PJ1izIjxsXiAmvt/ICBSj27S5QFwQixwTjIcT/p8Vcg0RdJLLoiPbV4WvpeN
         8cYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=qVzfHbu5pGUMMhouEyZrkVnSBIn9SzY5DZdTT7h9U4g=;
        b=ALPyU7ueREnHZD5gO6G+Hk49Mx24jSuTpNlK/nSGjH2ogfNiwlJ/n/BSh+cQz5yP3a
         jdnmeDWSAO+7Qw2TDoDBwxGA9iQiYpjOtH+X2Bp1OVepwUaVW09kpy9tzz34YU2gmYea
         ozcQuZk89knJcKnE9PcUqcM/Hc7+4Iu69mzMVpxlp4enFVDWfisxM97ERUV3V2g8n89Y
         ZMQNLJi9Qyake5SxXHO36NC95Wi7LNOwPDo7LtmBIyCy/Plz1IxVd6SJHBV9L8kyrY3u
         Bb4QW5YXGWeoJUEPRH7e/83JAUcXdorzXzC5vRkKEyl9kTC66tuFEJdpAtZ6nXhHa6Jp
         t+KA==
X-Gm-Message-State: ACgBeo3AJNVmcXCoAI928AYrvO4j7omuIUVsO54o5nBi+oj2v24xKpOY
        92VA6g7Bkzu/NNGH1ouwB7A36CJ1MUE=
X-Google-Smtp-Source: AA6agR7O9ui7ABd1AbtCzkkjldF3wv5rwC1rytIM3lPLNFCSZ1xyv8CTpQAaY1mVA/a75M7t8Huijg==
X-Received: by 2002:a05:6402:4312:b0:43d:b9c0:65ee with SMTP id m18-20020a056402431200b0043db9c065eemr10423578edc.205.1661019400934;
        Sat, 20 Aug 2022 11:16:40 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb77.dynamic.kabel-deutschland.de. [95.90.187.119])
        by smtp.gmail.com with ESMTPSA id g2-20020a17090604c200b0072af890f52dsm3887833eja.88.2022.08.20.11.16.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Aug 2022 11:16:40 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 07/19] staging: r8188eu: rename rtw_os_xmit_resource_free()
Date:   Sat, 20 Aug 2022 20:16:11 +0200
Message-Id: <20220820181623.12497-8-straube.linux@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220820181623.12497-1-straube.linux@gmail.com>
References: <20220820181623.12497-1-straube.linux@gmail.com>
MIME-Version: 1.0
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

The function rtw_os_xmit_resource_free() was moved from the os_dep
directory. It looks like the driver was originaly written to support
different operating systems. Obviously we do not need an extra 'os'
in the function name that indicates that the function is operating
system specific. Rename it to rtw_xmit_resource_free().

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_xmit.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_xmit.c b/drivers/staging/r8188eu/core/rtw_xmit.c
index 426bf87a1404..eef1a27e84eb 100644
--- a/drivers/staging/r8188eu/core/rtw_xmit.c
+++ b/drivers/staging/r8188eu/core/rtw_xmit.c
@@ -50,8 +50,8 @@ static int rtw_xmit_resource_alloc(struct adapter *padapter, struct xmit_buf *px
 	return _SUCCESS;
 }
 
-static void rtw_os_xmit_resource_free(struct adapter *padapter, struct xmit_buf *pxmitbuf,
-				      u32 free_sz)
+static void rtw_xmit_resource_free(struct adapter *padapter, struct xmit_buf *pxmitbuf,
+				   u32 free_sz)
 {
 	usb_free_urb(pxmitbuf->pxmit_urb);
 	kfree(pxmitbuf->pallocated_buf);
@@ -248,7 +248,7 @@ void _rtw_free_xmit_priv(struct xmit_priv *pxmitpriv)
 	}
 
 	for (i = 0; i < NR_XMITBUFF; i++) {
-		rtw_os_xmit_resource_free(padapter, pxmitbuf, (MAX_XMITBUF_SZ + XMITBUF_ALIGN_SZ));
+		rtw_xmit_resource_free(padapter, pxmitbuf, (MAX_XMITBUF_SZ + XMITBUF_ALIGN_SZ));
 		pxmitbuf++;
 	}
 
@@ -258,7 +258,7 @@ void _rtw_free_xmit_priv(struct xmit_priv *pxmitpriv)
 
 	pxmitbuf = (struct xmit_buf *)pxmitpriv->pxmit_extbuf;
 	for (i = 0; i < num_xmit_extbuf; i++) {
-		rtw_os_xmit_resource_free(padapter, pxmitbuf, (max_xmit_extbuf_size + XMITBUF_ALIGN_SZ));
+		rtw_xmit_resource_free(padapter, pxmitbuf, (max_xmit_extbuf_size + XMITBUF_ALIGN_SZ));
 		pxmitbuf++;
 	}
 
-- 
2.37.2

