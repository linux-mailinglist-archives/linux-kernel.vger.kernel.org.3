Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31C7457E67A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 20:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235992AbiGVS0e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 14:26:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231304AbiGVS0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 14:26:33 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70F4A6E88E;
        Fri, 22 Jul 2022 11:26:32 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id c139so5145254pfc.2;
        Fri, 22 Jul 2022 11:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U1Vpm+Ol39J44Ip/w/HGMbvmcj0WPHsL80jPsnskDEw=;
        b=CIGDJTjDuxvqk+hCAVZdusqUVAB4D0wVz5qJlyJOS1t/EvRJV94W6dZYKkmoSp5htk
         85ooyVSgoL9yjlHJdM4YDgysnOay2oPLsQxV/rIxWIm8Zgh+7SxljgH9WF8y+m+LNBqO
         haHm4fnrh9Tyc+Go6wHoM8L9WTGyeY2QCM33mmTnCjlkL8OGlXahSv/+899vGQVbsbbK
         iBDcJrO/pFAUcDftanvX7cAnnwfbJ4Gn22olrqlzxChGUcdif1Iqlu+N1ygzF5LaDlPH
         Pgo77iJjki4ipA6pJSQPXRjRdvEfypfvoRlseeKoijA7jP5J/b9xRJwKDpgXXOlncLrv
         Lojg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U1Vpm+Ol39J44Ip/w/HGMbvmcj0WPHsL80jPsnskDEw=;
        b=JPsEVwZMdJw0pBgLhJ1gjdA1JTZRGEn73GYbhVD4+gaqf80zUtS/UUk7c/n7+CW8tm
         4YR1C18ITVdJMl2xkrAIv2bvTjwK5I2/X3Pbl28vHEIV1Af0Zj1YJbyHAVFOI9Zn9Ht8
         DoHYmXuUQOur12kX+pSvtrLhkkatVL5zFPL3ou0cJv6zCQqDjLFnEY0M6gBrBqfo1XJ7
         L1G6NC+k5tfNUdQ6wA0b93jBS1/8w40w6Awmy1dv1v9P35QWvHv7XZLbgnovt7fcXirI
         J8mx3pogOlGNkYIuJ3jBkIfFEXMnN78GFTaQ5kl/0pi/jGOgBSfuXL72EY7a8WYCTpGM
         lPNQ==
X-Gm-Message-State: AJIora8THTi7lcJd0BP5wFzjrcnM+69wYxVLVkuSor2nilY5ZIEkZPKA
        QWDiYMCHQSqUikCxKqD5zN0=
X-Google-Smtp-Source: AGRyM1s3AfvMh+6Az1vFDMlygz2ppZ+CXyD+YBPfhW1Rh2oGSjnY+p3TwbFP2r7HMBo+hBDNTVCFFA==
X-Received: by 2002:a63:ff4c:0:b0:412:b100:786b with SMTP id s12-20020a63ff4c000000b00412b100786bmr874215pgk.537.1658514391994;
        Fri, 22 Jul 2022 11:26:31 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:d01c:7038:fdc9:680c:9dce:420d])
        by smtp.googlemail.com with ESMTPSA id n8-20020a170902e54800b0016d21c1b265sm2173044plf.275.2022.07.22.11.26.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 11:26:31 -0700 (PDT)
From:   Abhijeet Srivastava <abhijeet.srivastava2308@gmail.com>
Cc:     abhijeet.srivastava2308@gmail.com,
        Corentin Labbe <clabbe@baylibre.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        mjpeg-users@lists.sourceforge.net, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] media: staging: media: zoran: Deleted dead code
Date:   Fri, 22 Jul 2022 23:56:17 +0530
Message-Id: <20220722182622.23719-1-abhijeet.srivastava2308@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Deleted part of code in block comment

Signed-off-by: Abhijeet Srivastava <abhijeet.srivastava2308@gmail.com>
---
 drivers/staging/media/zoran/zoran_driver.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/staging/media/zoran/zoran_driver.c b/drivers/staging/media/zoran/zoran_driver.c
index b408c1d4e0a7..836edf623571 100644
--- a/drivers/staging/media/zoran/zoran_driver.c
+++ b/drivers/staging/media/zoran/zoran_driver.c
@@ -746,11 +746,6 @@ static const struct v4l2_ioctl_ops zoran_ioctl_ops = {
 	.vidioc_enum_input		    = zoran_enum_input,
 	.vidioc_g_input			    = zoran_g_input,
 	.vidioc_s_input			    = zoran_s_input,
-
-/*	.vidioc_enum_output		    = zoran_enum_output,
- *	.vidioc_g_output		    = zoran_g_output,
- *	.vidioc_s_output		    = zoran_s_output,
- */
 	.vidioc_g_std			    = zoran_g_std,
 	.vidioc_s_std			    = zoran_s_std,
 	.vidioc_create_bufs		    = vb2_ioctl_create_bufs,
@@ -762,13 +757,9 @@ static const struct v4l2_ioctl_ops zoran_ioctl_ops = {
 	.vidioc_streamon		    = vb2_ioctl_streamon,
 	.vidioc_streamoff		    = vb2_ioctl_streamoff,
 	.vidioc_enum_fmt_vid_cap	    = zoran_enum_fmt_vid_cap,
-/*	.vidioc_enum_fmt_vid_out	    = zoran_enum_fmt_vid_out,*/
 	.vidioc_g_fmt_vid_cap		    = zoran_g_fmt_vid_cap,
-/*	.vidioc_g_fmt_vid_out               = zoran_g_fmt_vid_out,*/
 	.vidioc_s_fmt_vid_cap		    = zoran_s_fmt_vid_cap,
-/*	.vidioc_s_fmt_vid_out               = zoran_s_fmt_vid_out,*/
 	.vidioc_try_fmt_vid_cap		    = zoran_try_fmt_vid_cap,
-/*	.vidioc_try_fmt_vid_out		    = zoran_try_fmt_vid_out,*/
 	.vidioc_subscribe_event             = v4l2_ctrl_subscribe_event,
 	.vidioc_unsubscribe_event           = v4l2_event_unsubscribe,
 };
-- 
2.34.1

