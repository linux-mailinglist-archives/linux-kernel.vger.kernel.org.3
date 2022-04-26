Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBEBC50FF9F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 15:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351201AbiDZN4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 09:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351194AbiDZN4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 09:56:34 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F248815C387
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 06:53:26 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id a14-20020a7bc1ce000000b00393fb52a386so924021wmj.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 06:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EnYpaxkZav5f4TJAXC67BWjjIGhseiAu51rAnrYK/5U=;
        b=lI7BSk8KWqBYCpdh38+sEuQTXEGVto0akFD9ogV65L+lfxpWNY7YCAxoHhi3rzbMIW
         ILIDW18W5OozzGvqzIAj1v9qW97xKuPduSfceDbSlqsZRRdWX5fWyJJpwE86dYJqanuQ
         2kluTJmxGisJIgE4Q6bSwOxsvOWImJhvoMKbKdyMTrCSXoPcXDlWPZffdgbf2HISfxPE
         RLnjfkD1OnvoorEv4m6Dy+6oxrG87bDJnyQo9flX4+dxOZh2bSYkpldS3vZMEH1KXHRw
         bLTON0Q1ofUBLNum6tgAxItyw7XCA7dQrDXcm8juB1pC3bGOWv0yXpnNdi+Qo48l05eP
         eyFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EnYpaxkZav5f4TJAXC67BWjjIGhseiAu51rAnrYK/5U=;
        b=tl+FiKRUkW9LsacGqmL+j7/uK/fOC8wXPh8anAPuw1tH33W1ZWn8rpkZZ40brmQJvD
         SZhXwTr8Icf82GIbyG7paDgeM/HPHqNzMF3KZ8twT4Ab5OMUb1Xd9NObpHT3tNqz4ji/
         wlZjVj6dZamDo6sly1GQq8LH+Sy0trlzQ0jH0sD5TThlFthSgGMvFXvGeRR4S9MDpQ3e
         HG3l9ajkp1BqxRB8f1spF6lQVz/qS4eL6pMYtqV6WR6Zh/EGi0c1pOK4tsMgdPTrkPjB
         rVO0N8zTbJ1rRRJpzNUUwZn98Cjue38kpw+UkUnNqt759QgmIiOIhOIAA4NQ0C1fqy7/
         op+Q==
X-Gm-Message-State: AOAM5310OEgK36m+XfUque32dXRfgPXQGTSzo7/jKqhkQ44Jzu8I9fBH
        5G3j+J0RESybcoii4lzG3nLGcXF7aqY=
X-Google-Smtp-Source: ABdhPJy7jim0MQqG6FtfP8lrRE796ANDund2SRO/1IO4nMn3uKtHCXimtboj+/N76RJ90r5YSwfnSA==
X-Received: by 2002:a1c:6a01:0:b0:37f:1b18:6b17 with SMTP id f1-20020a1c6a01000000b0037f1b186b17mr30518474wmc.146.1650981205489;
        Tue, 26 Apr 2022 06:53:25 -0700 (PDT)
Received: from ubuntu.fritz.box ([2a02:908:4b20:9740:f9ba:b974:8a6:43e6])
        by smtp.googlemail.com with ESMTPSA id z6-20020a1c4c06000000b00392b49c7ad4sm11224925wmf.3.2022.04.26.06.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 06:53:24 -0700 (PDT)
From:   Noah Tschirner <noahtschirner@gmail.com>
To:     jerome.pouiller@silabs.com
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Noah Tschirner <noahtschirner@gmail.com>
Subject: [PATCH] Staging: wfx: Fixed a space coding style issue.
Date:   Tue, 26 Apr 2022 15:51:48 +0200
Message-Id: <20220426135148.29785-1-noahtschirner@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed a space coding style issue.

Signed-off-by: Noah Tschirner <noahtschirner@gmail.com>
---
 drivers/staging/wfx/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/wfx/main.c b/drivers/staging/wfx/main.c
index b93b16b900c8..e575a81ca2ca 100644
--- a/drivers/staging/wfx/main.c
+++ b/drivers/staging/wfx/main.c
@@ -170,7 +170,7 @@ bool wfx_api_older_than(struct wfx_dev *wdev, int major, int minor)
  *
  * The PDS file is an array of Time-Length-Value structs.
  */
- int wfx_send_pds(struct wfx_dev *wdev, u8 *buf, size_t len)
+int wfx_send_pds(struct wfx_dev *wdev, u8 *buf, size_t len)
 {
 	int ret, chunk_type, chunk_len, chunk_num = 0;
 
-- 
2.32.0

