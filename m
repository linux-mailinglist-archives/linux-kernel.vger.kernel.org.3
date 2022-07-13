Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 915C8573696
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 14:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234530AbiGMMuK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 08:50:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbiGMMuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 08:50:07 -0400
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8DFB2F386;
        Wed, 13 Jul 2022 05:50:06 -0700 (PDT)
Received: by mail-pj1-f48.google.com with SMTP id z12-20020a17090a7b8c00b001ef84000b8bso3507544pjc.1;
        Wed, 13 Jul 2022 05:50:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YqtkMT3tnVRyNCa8MEyOXmJg3Zr2qGjezMRiYj7Y9QI=;
        b=dDM4HsDx9mnqDE+h2z60x9SFy/DSNyg2QjQV8K0VT/cZ8Xu00oM63IQrOUUNfg8oeC
         WBTB8PKxTPML4eZq+bg3FmL0AMhXj4pVuUTZWkG1DWPONhZ9ouKBibgshKQFrxl5Qtgx
         CDKKu/1MKDNOP1gagGYjTGKnamrGQnWQiWVuXzJcSQ3szV+JCPGcAwH7bKL9r7vQhfjI
         I//lnbwHstOtij/jJgnULfZd2NTNphDgEYJOBp/zhyz+k8oLaFL+CZaWEvb1MKlqXOwD
         y7aAJhI3biAS3/DEzLXZckKINqYqhag3pwDgk9hKTN9svxttsyR0XkeTM9tThPzlSbPy
         3Edw==
X-Gm-Message-State: AJIora+CxSW6xU7AxWSFf1BLgHQ3U0vgQ4er81zzxoEFeI996cyO2ncs
        4bxKdRvO7z2oQ9LhwyMN586NwgFurmwujw==
X-Google-Smtp-Source: AGRyM1s7zReI3CqF80QFnw1pL7SRC7OTF0TLvrTzuQOJVWaf09jZ7Xqab3WrqTgqRl49JsEzapXhUA==
X-Received: by 2002:a17:90b:33d2:b0:1f0:3a40:982d with SMTP id lk18-20020a17090b33d200b001f03a40982dmr3728981pjb.60.1657716606028;
        Wed, 13 Jul 2022 05:50:06 -0700 (PDT)
Received: from localhost.localdomain ([211.49.23.9])
        by smtp.gmail.com with ESMTPSA id gf17-20020a17090ac7d100b001ef87123615sm1521303pjb.37.2022.07.13.05.50.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 05:50:05 -0700 (PDT)
From:   Namjae Jeon <linkinjeon@kernel.org>
To:     linux-cifs@vger.kernel.org
Cc:     smfrench@gmail.com, linux-kernel@vger.kernel.org,
        Namjae Jeon <linkinjeon@kernel.org>
Subject: [PATCH] MAINTAINERS: ksmbd: add entry for documentation
Date:   Wed, 13 Jul 2022 21:49:40 +0900
Message-Id: <20220713124940.6591-1-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Include Documentation/filesystems/cifs/ksmbd.rst in the ksmbd maintainers
file entry.

Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index fe5daf141501..ae1aa7380265 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10813,6 +10813,7 @@ R:	Sergey Senozhatsky <senozhatsky@chromium.org>
 L:	linux-cifs@vger.kernel.org
 S:	Maintained
 T:	git git://git.samba.org/ksmbd.git
+F:	Documentation/filesystems/cifs/ksmbd.rst
 F:	fs/ksmbd/
 F:	fs/smbfs_common/
 
-- 
2.25.1

