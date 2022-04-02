Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 115F24EFFC3
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 10:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353969AbiDBIxW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 04:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353945AbiDBIxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 04:53:10 -0400
Received: from mail-oa1-x41.google.com (mail-oa1-x41.google.com [IPv6:2001:4860:4864:20::41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E4081544BC
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 01:51:18 -0700 (PDT)
Received: by mail-oa1-x41.google.com with SMTP id 586e51a60fabf-de48295467so5195495fac.2
        for <linux-kernel@vger.kernel.org>; Sat, 02 Apr 2022 01:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vf9XrnRNNEu/g7WX3Cp+ZJwmHe6lW1eduApC7K6BbhE=;
        b=j4xXeAsTbXwdT377xyxJfFrgd59iWXp7ELSyJv/EanKnQ6DUqM7TKGIHzdUAJwBhho
         IfP92/Mu4xkb7coNtVbXepdb/BDiVtnO/ri84k0s5IenWecqphAeZiDhCpKLiikTU+Le
         iJxeo8FeZ5r55plXaqBWsRyfw9tioVsq2pyYtxMggElcaVnSqMJ4rjjgn1lnJ2bmnACv
         m6HfGppRv2L5jJYOFopWEj9iTHX1qjv1kHfy3BOqaZg1vPUL6Vwx7TQ48KeRQfZmrEc9
         8p8IPjIaOIflSh+Klx1YPKYCicJ4SqF7Ep6mWy6uzd/Tur6gHbU4eZjvbZwcukbbeZBb
         t+mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vf9XrnRNNEu/g7WX3Cp+ZJwmHe6lW1eduApC7K6BbhE=;
        b=2MgqSbUSEk8FOF29ZnkHsY0RzNK9RlJ18zpReLeg39s9JpgAVWqaAz2+nJ3JPiJULt
         tl9Mx3mJrtn8upsTrrm8jrFMCo3FNnzohAnHU8X2Z/K51VPmQNB1T/RSgej1f09MTjrr
         TYelcVPE0Upi7xBHLvqtUKyy+ZwJF/ChTIZEDOLOxy4M+Pk9z9haTHQa5goOSD8tHYLq
         I2BBJ3a6bMklCtCtTdBaF188yybvhAloFJnOzrj8Tj8oKC5aIJBgrwXxbQZ+mk2WxJ5W
         oTypWMPp7PmACoFd8/d6rj1sQpl/3ioz2OpJMK60STVSP7beb8hW27yUDGmT/OWaJRZB
         lXwQ==
X-Gm-Message-State: AOAM531ep+DVE0tad62DCnmke/ApjxJVzgmocDsmU7Td5sOx/tgDb9l4
        i8h2GAuU1v/pjiZ1zilKxqJ5QWzaY+F+EA==
X-Google-Smtp-Source: ABdhPJz0isEyVWmgEv8MhEfi7jtm1pbgdsRBYf6wjvSELYX1zdlwt+fTQ0mw2iorYuRZP969f1KQXw==
X-Received: by 2002:a05:6871:787:b0:df:f1a:2d9c with SMTP id o7-20020a056871078700b000df0f1a2d9cmr6599085oap.1.1648889477542;
        Sat, 02 Apr 2022 01:51:17 -0700 (PDT)
Received: from bertie (072-190-140-117.res.spectrum.com. [72.190.140.117])
        by smtp.gmail.com with ESMTPSA id bg39-20020a056820082700b00324c8eba341sm2074930oob.18.2022.04.02.01.51.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Apr 2022 01:51:17 -0700 (PDT)
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     outreachy@lists.linux.dev
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Rebecca Mckeever <remckee0@gmail.com>
Subject: [PATCH 3/6] staging: r8188eu: correct misspelling in comment "conider" -> "consider"
Date:   Sat,  2 Apr 2022 03:50:45 -0500
Message-Id: <5799315f84e50db2a7d05b74cd4ed9ec2f28a8e2.1648888461.git.remckee0@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1648888461.git.remckee0@gmail.com>
References: <cover.1648888461.git.remckee0@gmail.com>
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

Correct spelling typo. Reported by checkpatch:

CHECK: 'conider' may be misspelled - perhaps 'consider'?

Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_cmd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
index 09fde5b23ce2..2e135bbd836a 100644
--- a/drivers/staging/r8188eu/core/rtw_cmd.c
+++ b/drivers/staging/r8188eu/core/rtw_cmd.c
@@ -293,7 +293,7 @@ int rtw_cmd_thread(void *context)
 				rtw_free_cmd_obj(pcmd);
 			else
 				/* todo: !!! fill rsp_buf to pcmd->rsp if (pcmd->rsp!= NULL) */
-				pcmd_callback(pcmd->padapter, pcmd);/* need conider that free cmd_obj in rtw_cmd_callback */
+				pcmd_callback(pcmd->padapter, pcmd);/* need consider that free cmd_obj in rtw_cmd_callback */
 		} else {
 			rtw_free_cmd_obj(pcmd);
 		}
-- 
2.32.0

