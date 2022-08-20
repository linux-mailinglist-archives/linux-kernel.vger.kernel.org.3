Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D31759AF81
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 20:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232474AbiHTSQy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 14:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231807AbiHTSQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 14:16:42 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A6A231DC2
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 11:16:41 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 2so1124590edx.2
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 11:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=2iiedlofv1fkN9T2ZU3EkgMCuLITjKpLLf2R2cOJIQM=;
        b=AEsz7o6e8ncSjAOisRGbrXWqd6Lb6D6i+Z46CZA80zY6RxUf1xaBjVShI90lhKPXKR
         zU+/SM2DNkL779x9nWZWNDKECu5BZNErW6zC1rey/U8ti8qN1Tdao/jwIsCpw+Iuc8KH
         GBEQW42nGsInnKpWDqbmLIkpo/wYn3kgy4Vlw8JAiv3IQJ8rq/vVflTPQ/XWXOuL97qH
         iiyp1D2ai5XI3rNjIkwnKQEqBaBVe1EKoAQNh7ibChZo0TGPGWBrdADpqgW9ChcFCVcz
         tTxe/Ltte0jSnuX8QvmCb70JMcFkb8TtpjZY7kMebKZ/vR5GdNdxd3vMKKAmAj7CW4uT
         sUTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=2iiedlofv1fkN9T2ZU3EkgMCuLITjKpLLf2R2cOJIQM=;
        b=NZiDWF/i+v8otmfDQ82ddOr/RzfIb+MtzoV09uSXG4TmFuIo4yfbMXBM9T/X3INBdi
         juvNZQFSkahs+gDL05HNJF5K0FZr6hfNYUeXCc5unQVOVvjLtDFQ6g0Mpz0GUfaKKxNK
         MyYN0uWjHUt4wYhTKfNrsEn2SRwWVmBCPFC3WWIUvOLzWzivNMAEpjpXSrjUWGmW6Tbd
         wkI70A3LOUbVnanTILjSneE7MxUNBfaOTSdQMytPPksOQZzLmsOcEjq0DBD1EE47iL2V
         AB/GlLSbubw7X1eXVlue2P1PHUBJl1+QWOScQrcvdkOIt3KJgqKYLUQF2Z+z0TpYF1cx
         uPUQ==
X-Gm-Message-State: ACgBeo1l+JEotnMwOWnU8sf3+ygP9AX5YFNqehulIyD7Ba7u8DtTSRlu
        uZ3lpGbf687FM2jnACO4I10=
X-Google-Smtp-Source: AA6agR74IV2U1FDGPjYlwqqWQ+oKl5C3hY8cBbfEiMjNzHak9YgN3Jd3OCf4FlS7WuUG6IED/0FoSQ==
X-Received: by 2002:a05:6402:5384:b0:431:6d84:b451 with SMTP id ew4-20020a056402538400b004316d84b451mr10086593edb.46.1661019399652;
        Sat, 20 Aug 2022 11:16:39 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb77.dynamic.kabel-deutschland.de. [95.90.187.119])
        by smtp.gmail.com with ESMTPSA id g2-20020a17090604c200b0072af890f52dsm3887833eja.88.2022.08.20.11.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Aug 2022 11:16:39 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 05/19] staging: r8188eu: rename rtw_os_xmit_resource_alloc()
Date:   Sat, 20 Aug 2022 20:16:09 +0200
Message-Id: <20220820181623.12497-6-straube.linux@gmail.com>
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

The function rtw_os_xmit_resource_alloc() was moved from the os_dep
directory. It looks like the driver was originaly written to support
different operating systems. Obviously we do not need an extra 'os'
in the function name that indicates that the function is operating
system specific. Rename it to rtw_xmit_resource_alloc().

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_xmit.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_xmit.c b/drivers/staging/r8188eu/core/rtw_xmit.c
index 6f3a70a1ab3c..a1d2c2f78044 100644
--- a/drivers/staging/r8188eu/core/rtw_xmit.c
+++ b/drivers/staging/r8188eu/core/rtw_xmit.c
@@ -33,8 +33,8 @@ void	_rtw_init_sta_xmit_priv(struct sta_xmit_priv *psta_xmitpriv)
 	INIT_LIST_HEAD(&psta_xmitpriv->apsd);
 }
 
-static int rtw_os_xmit_resource_alloc(struct adapter *padapter, struct xmit_buf *pxmitbuf,
-				      u32 alloc_sz)
+static int rtw_xmit_resource_alloc(struct adapter *padapter, struct xmit_buf *pxmitbuf,
+				   u32 alloc_sz)
 {
 	pxmitbuf->pallocated_buf = kzalloc(alloc_sz, GFP_KERNEL);
 	if (!pxmitbuf->pallocated_buf)
@@ -142,10 +142,10 @@ s32	_rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
 		pxmitbuf->ext_tag = false;
 
 		/* Tx buf allocation may fail sometimes, so sleep and retry. */
-		res = rtw_os_xmit_resource_alloc(padapter, pxmitbuf, (MAX_XMITBUF_SZ + XMITBUF_ALIGN_SZ));
+		res = rtw_xmit_resource_alloc(padapter, pxmitbuf, (MAX_XMITBUF_SZ + XMITBUF_ALIGN_SZ));
 		if (res == _FAIL) {
 			msleep(10);
-			res = rtw_os_xmit_resource_alloc(padapter, pxmitbuf, (MAX_XMITBUF_SZ + XMITBUF_ALIGN_SZ));
+			res = rtw_xmit_resource_alloc(padapter, pxmitbuf, (MAX_XMITBUF_SZ + XMITBUF_ALIGN_SZ));
 			if (res == _FAIL)
 				goto exit;
 		}
@@ -179,7 +179,7 @@ s32	_rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
 		pxmitbuf->padapter = padapter;
 		pxmitbuf->ext_tag = true;
 
-		res = rtw_os_xmit_resource_alloc(padapter, pxmitbuf, max_xmit_extbuf_size + XMITBUF_ALIGN_SZ);
+		res = rtw_xmit_resource_alloc(padapter, pxmitbuf, max_xmit_extbuf_size + XMITBUF_ALIGN_SZ);
 		if (res == _FAIL) {
 			res = _FAIL;
 			goto exit;
-- 
2.37.2

