Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE055ABC39
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 04:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbiICCEB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 22:04:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiICCD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 22:03:58 -0400
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A2DC8754;
        Fri,  2 Sep 2022 19:03:57 -0700 (PDT)
Received: by mail-qv1-f54.google.com with SMTP id d1so2781169qvs.0;
        Fri, 02 Sep 2022 19:03:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=wuSBjMiBTaAL8YRizai7RiR6f5CVFgeNpvVuZnceTRg=;
        b=VZuhTACe0U3EXGt8EU0qfjCtXlQc2l5Ukl2XQwX+e8zN7/S/94ov1ahq/aw82swBoi
         Tdq8DoMVuF1BRV3+AZSi8vfdu3lYAL+dTeMsIrynhuEY7lcQoIAJuDyGlA9ClR5TZeXK
         DdHDNnXnlnvdUkZPPyBOZR3OL6ER9doo75Y2Tzwq4YWF2bVLpcG87ut0MWzRLm5SrDtC
         Af0CZ6XEjcnivlm3INNqRi8uPLruUs5T8HPnEGaj7wFu1UFUsRLTcEQYhH0HErbTVs+n
         oCuFjXo+sYeO8qCF6dMWouzDqhQPjjHa/rskFYirXvcCgE+Zt3Sa1JTNi0vyV7jHFBvJ
         /Vxw==
X-Gm-Message-State: ACgBeo0QqGcf7s3D6UVPE7izQrPW/zG/GoICibLZa73Vo3z1l55jjt5l
        vjcNr7bNaPq/Exk1KTgfFQB2Aco03I4=
X-Google-Smtp-Source: AA6agR59MlkhSq+vlXnlcC8JiBBEJ/6n6KMBfgpZvlo8YtzVRP/QsfUTKR6pxdCYzu/dP04gHZ9hEA==
X-Received: by 2002:a17:902:cf11:b0:172:6437:412e with SMTP id i17-20020a170902cf1100b001726437412emr37762911plg.77.1662170029186;
        Fri, 02 Sep 2022 18:53:49 -0700 (PDT)
Received: from localhost.localdomain ([211.49.23.9])
        by smtp.gmail.com with ESMTPSA id q13-20020a170902dacd00b001743be790b4sm2338512plx.215.2022.09.02.18.53.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 18:53:48 -0700 (PDT)
From:   Namjae Jeon <linkinjeon@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-cifs@vger.kernel.org
Cc:     smfrench@gmail.com, hyc.lee@gmail.com, senozhatsky@chromium.org,
        tom@talpey.com, Namjae Jeon <linkinjeon@kernel.org>,
        Steve French <stfrench@microsoft.com>
Subject: [PATCH] MAINTAINERS: Add Tom Talpey as ksmbd reviewer
Date:   Sat,  3 Sep 2022 10:53:40 +0900
Message-Id: <20220903015340.7336-1-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tom have been actively reviewing ksmbd patches as well as
smb-direct patches. He agreed to help us as a reviewer,
So adding him to reviewer list in ksmbd entry.

Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f512b430c7cb..f7ccb9abfe86 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11070,6 +11070,7 @@ M:	Namjae Jeon <linkinjeon@kernel.org>
 M:	Steve French <sfrench@samba.org>
 M:	Hyunchul Lee <hyc.lee@gmail.com>
 R:	Sergey Senozhatsky <senozhatsky@chromium.org>
+R:	Tom Talpey <tom@talpey.com>
 L:	linux-cifs@vger.kernel.org
 S:	Maintained
 T:	git git://git.samba.org/ksmbd.git
-- 
2.25.1

