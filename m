Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D42E52CFBD
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 11:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231956AbiESJvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 05:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236334AbiESJvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 05:51:24 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D92CE3B571
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 02:51:22 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id v5-20020a17090a7c0500b001df84fa82f8so4741268pjf.5
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 02:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=Kz0h8AVlhDxqu2fBv10G2DB8irasLWVcOGHbwSABuog=;
        b=j8zmNa4gMVNlK1u6bsG4t1uiZRogcunLjCd15/qrWM4n/t2ugaS7lRDlEPZ6jY+yIg
         mTkGGLdzW/XF1HzWzoin/UaQRAH1HC3QmvuecgIwR59XLaQAahzL2pgVCOsQvNZj7cdz
         VYmF4RqqxQQpgjr2ibTG/yK7t16feYxU3umPw8ojMW425llDHKVO+X5yB6azRO4u6S58
         UzattIxywCxCfAijShBykl2CXmkGvvOSVCsH94kEZkUjIFlVSSr3OA351Ri9HUtPyFhO
         1A35o6nL/k3nMH4PSxrKdHRFharWVdXlHgLosiZP6HKazU5lWFSTbsjROPCzR/ueoDD1
         zBxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Kz0h8AVlhDxqu2fBv10G2DB8irasLWVcOGHbwSABuog=;
        b=0QekHIhgUfnsASd1fcyDFEKTwYRgHvZZMT//5ROl+glf7b+QRJdtzVl1XW+BZXFXiM
         TdNpJpVWLFU5+SFebWmA/Aph2TRb3qP+y7QbkSyD2feznT9bl8JFrx0hJ5UKryHj5r/F
         vh+p5dy/xrmeLgg5QQxRLZ0lzfEnp1J3YEIMc80t07bQkXP83yryWqk9NmvJ+HLebGA3
         b4Gs4KfOdCTZnanCm9ys6Cz8JIfwhzqTPUJrUgy67OmEjPjpZ3F4Cq3dM4O1dh+iRIPA
         ETj7QzAydmgCe5XHesCNYHweqHrrZHwGg1hffbY48PjxdhI4iNoK26y0hiCuEuFMRwR2
         n6dg==
X-Gm-Message-State: AOAM5319O43CTMUE0xJoasdPmgvTYvNpW42mNAd5t5A0uMgg8oobu7H+
        rChgP5bQNwU6gSPSVFzFuC2M/s1hQDEFfA==
X-Google-Smtp-Source: ABdhPJw1fyrbaoYaCvEaPe+05dXjx+wf3KiemTb56WVrxGS0CtEIIiLvyqyF450u94ZVs2dzcF4H8w==
X-Received: by 2002:a17:90b:1d0b:b0:1df:b3dc:5140 with SMTP id on11-20020a17090b1d0b00b001dfb3dc5140mr4289320pjb.225.1652953882156;
        Thu, 19 May 2022 02:51:22 -0700 (PDT)
Received: from Negi ([207.151.52.3])
        by smtp.gmail.com with ESMTPSA id f186-20020a62dbc3000000b0050dc7628133sm3798073pfg.13.2022.05.19.02.51.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 02:51:21 -0700 (PDT)
From:   Soumya Negi <soumya.negi97@gmail.com>
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Soumya Negi <soumya.negi97@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: r8188eu: Remove multiple assignments
Date:   Thu, 19 May 2022 02:50:11 -0700
Message-Id: <20220519095012.5619-1-soumya.negi97@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Conform to Linux coding style.
Issue found by checkpatch:-
CHECK: multiple assignments should be avoided

Signed-off-by: Soumya Negi <soumya.negi97@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_br_ext.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/r8188eu/core/rtw_br_ext.c b/drivers/staging/r8188eu/core/rtw_br_ext.c
index e1b3e9d5250b..bca20fe5c983 100644
--- a/drivers/staging/r8188eu/core/rtw_br_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_br_ext.c
@@ -53,7 +53,8 @@ static unsigned char *__nat25_find_pppoe_tag(struct pppoe_hdr *ph, unsigned shor
 	unsigned char *cur_ptr, *start_ptr;
 	unsigned short tagLen, tagType;
 
-	start_ptr = cur_ptr = (unsigned char *)ph->tag;
+	start_ptr = (unsigned char *)ph->tag;
+	cur_ptr = (unsigned char *)ph->tag;
 	while ((cur_ptr - start_ptr) < ntohs(ph->length)) {
 		/*  prevent un-alignment access */
 		tagType = (unsigned short)((cur_ptr[0] << 8) + cur_ptr[1]);
-- 
2.17.1

