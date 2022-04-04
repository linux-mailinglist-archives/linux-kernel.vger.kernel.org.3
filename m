Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 823734F1772
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 16:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378204AbiDDOqp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 10:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379111AbiDDOoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 10:44:22 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CBD51FCED
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 07:39:27 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id z1so2522783wrg.4
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 07:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ezm7s/bPPlsKI3j5Vodd/A01CmYTO8Su6wSyqI3TlXY=;
        b=YwX2YHH9SfzSWfpOg5TmK7w79nGo2g57qnkikIFBOAJNPurOj2AeWp2y2GJDQMNRQo
         VPEa85uc0l8dCprSmr5BOnsWoPk8vPYjjtOlwJZaOb4XoNPz6+qmlApMVIAcNY7anQAa
         Cr5kcgA081NzJXrGn3cjAKh3m0nR5fV74Pnz1u3tcsM+KmEMxJ/wBXxmJx5d6nkMgyOi
         /iXbOaAy+LvPi7Nmbl+gneboS6mo1JgXvqPZX3BUP8Cq1uRk5+nrUwN7o47SeaJBpdZP
         oNnQfUV2ztUXqwtxrmSC5j1LH31tYrOxnxNIpx2OGX7OQrXdePRPPBIg3qn3Dtb7yZ49
         WcNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ezm7s/bPPlsKI3j5Vodd/A01CmYTO8Su6wSyqI3TlXY=;
        b=N0NSbYJTjRFjRtKLVc/e5XHs4nyoRGALHcYhKhw8U+NWtr+vyzbBCMgZrU2i99i6FS
         GDuST0ezM6JbvneDJEcxrBodtjew03CJfXF+8hhsqlPCjV4xR/rJ/LuPrOQs2tjyAOpc
         Ly5YzLCXVNBETWUACtP4hb/JJ2Y1SkpQdRIqtqTyR27v34ndPdDQy1vH1ahfOwmg7vcl
         HZNlgMpY9KQAdL7gcnEOxnZLAVH51TIdJptWbzO3hJWDAfs9amfU+63AWSG8mhWBtImw
         9Vo8fZA1z+jj3sKx3Fj2f30sKOD+VIO8gr+z8vkqksqCHExxm5i5G6EaDKc3hUmurR1W
         dcFg==
X-Gm-Message-State: AOAM531ZTUR8saypbJkcPA2XfsfjC8iQOmw0stR8kz/p6su39RDvK2nn
        W6fd8sJ3tu2v5wPZoQ7/jYs=
X-Google-Smtp-Source: ABdhPJym4Ae6g+MhdncKokbHAsqQnkyzEtw7DFFFy5O0cd45KZebnaDdSU2lJZ575HmSr7bcg+2p7A==
X-Received: by 2002:a5d:5512:0:b0:1ef:5f08:29fb with SMTP id b18-20020a5d5512000000b001ef5f0829fbmr17064670wrv.653.1649083165929;
        Mon, 04 Apr 2022 07:39:25 -0700 (PDT)
Received: from alaa-emad ([41.42.174.117])
        by smtp.gmail.com with ESMTPSA id y2-20020adffa42000000b002060d53dbe0sm6142385wrr.9.2022.04.04.07.39.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 07:39:25 -0700 (PDT)
From:   Alaa Mohamed <eng.alaamohamedsoliman.am@gmail.com>
To:     outreachy@lists.linux.dev
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, eng.alaamohamedsoliman.am@gmail.com
Subject: [PATCH 2/2] staging: r8188eu: Add line after declarations
Date:   Mon,  4 Apr 2022 16:39:17 +0200
Message-Id: <19d8f316e43d16c9341f7fe94e68534cf60cc05c.1649082939.git.eng.alaamohamedsoliman.am@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <860d8e222e2b695ce5cb4f48aa46a7f66e05d8e4.1649082939.git.eng.alaamohamedsoliman.am@gmail.com>
References: <860d8e222e2b695ce5cb4f48aa46a7f66e05d8e4.1649082939.git.eng.alaamohamedsoliman.am@gmail.com>
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

Reported by checkpatch:

WARNING: Missing a blank line after declarations

Signed-off-by: Alaa Mohamed <eng.alaamohamedsoliman.am@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_br_ext.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_br_ext.c b/drivers/staging/r8188eu/core/rtw_br_ext.c
index 7c664f80fa99..f7811b46db1c 100644
--- a/drivers/staging/r8188eu/core/rtw_br_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_br_ext.c
@@ -313,6 +313,7 @@ void nat25_db_cleanup(struct adapter *priv)
 
 	for (i = 0; i < NAT25_HASH_SIZE; i++) {
 		struct nat25_network_db_entry *f;
+
 		f = priv->nethash[i];
 		while (f) {
 			struct nat25_network_db_entry *g;
@@ -339,12 +340,12 @@ void nat25_db_expire(struct adapter *priv)
 
 	for (i = 0; i < NAT25_HASH_SIZE; i++) {
 		struct nat25_network_db_entry *f;
-		f = priv->nethash[i];
 
+		f = priv->nethash[i];
 		while (f) {
 			struct nat25_network_db_entry *g;
-			g = f->next_hash;
 
+			g = f->next_hash;
 			if (__nat25_has_expired(f)) {
 				if (atomic_dec_and_test(&f->use_count)) {
 					if (priv->scdb_entry == f) {
-- 
2.35.1

