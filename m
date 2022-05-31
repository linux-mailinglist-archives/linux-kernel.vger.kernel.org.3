Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21ECF53954D
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 19:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346460AbiEaRN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 13:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346482AbiEaRNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 13:13:24 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB1D68DDF5
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 10:13:22 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id 187so2214072pfu.9
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 10:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8RLG13nKpWjsjuIbbUgrnquP8Z1EdA3+DmofowDTXK8=;
        b=h2LApYajNKyFrQl2xlZsGJ1ICjgtRdW1rpOvkUmIAYocin3G/UCeqoDMZnF2EzSksr
         Ulkb9pT6QMPDzYUEyda1M3SlLQ68hDa0PvUbqN6md1sBKdCiel3g4A2rS5rUix0NUxIR
         5Y9CZg1cOY7tc7ncdZtrQz0DD8RO9DAiMuFNxaJiAoIBxKckpz4xArZRPq7cZX12PdBT
         2KCulVe55RRwxPoMkJ46WXm8Eeafgmfca9PX5MxHvhSNV1lPzpfD9PmxvKik/LhU9hja
         c3Qden3XuKr9qiNCRmTeDh0WQgMVzoASWqunPmwQjcLRDn2t5BXGvq+KD0x/D64sX8Eb
         QQ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8RLG13nKpWjsjuIbbUgrnquP8Z1EdA3+DmofowDTXK8=;
        b=4hlWMLreFP/jw42yb4cNpF0mujgzgw3OzZ6eo6khm0zyMxJgsT4e3HgsNR3HrkaBL9
         S5rZLMZetRc/jBYTs6iv/1JwWiGdqKrVXwUTfMSbKgEUMLFZ+rC2uM2qWJ9a3UWCk4dw
         ULbw193OT9qljpzf4OD2Vm23IWajxkGgFBUH/fwx+IwF6fBWK5YeikgJQ2dsjTZ9LgsM
         KwfRh+7OCkZq2Aji6/naOa7r09G1vabmoX3t4gyVqeoz2CLEfI8anCk2Q9B+xbyQ/6eq
         72Cu686H4e+BpG2pWf/DBkpLXGo9WuhW69ESH8X2vb6zbsDKUbvdku8aI1zOY/+Axync
         QVUQ==
X-Gm-Message-State: AOAM530zIZI5FHnbO2vP7JJ1luoM1jcdK8w+a9dkKJAwKozXjqI2Q5Qp
        TPrQKjbagqlH23XnRlgMBunwl0PZPF4xIA==
X-Google-Smtp-Source: ABdhPJySrbG4tcwXaGTWngYEqrZ8L8o+mA+izcojiZpZJanb547iiZCZqdgcjweE1fSJPkk+zDgXrg==
X-Received: by 2002:a62:ab02:0:b0:518:f6ca:3905 with SMTP id p2-20020a62ab02000000b00518f6ca3905mr32203114pff.1.1654017202391;
        Tue, 31 May 2022 10:13:22 -0700 (PDT)
Received: from optiplex.localdomain (174-21-45-174.tukw.qwest.net. [174.21.45.174])
        by smtp.gmail.com with ESMTPSA id u6-20020a170902e5c600b0015e8d4eb2cdsm6728766plf.279.2022.05.31.10.13.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 10:13:22 -0700 (PDT)
From:   "=?UTF-8?q?Eivind=20N=C3=A6ss?=" <eivnaes@gmail.com>
X-Google-Original-From: =?UTF-8?q?Eivind=20N=C3=A6ss?= <eivnaes@yahoo.com>
Cc:     eivnaes@yahoo.com, linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] Adding in defines for PPP_ECP and PPP_EAP into linux/ppp_defs.h
Date:   Tue, 31 May 2022 10:13:05 -0700
Message-Id: <20220531171308.651960-1-eivnaes@yahoo.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MSGID_YAHOO,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch includes additional defiles for PPP ECP and EAP protocols.

Signed-off-by: Eivind Næss <eivnaes@yahoo.com>
---
 include/uapi/linux/ppp_defs.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/uapi/linux/ppp_defs.h b/include/uapi/linux/ppp_defs.h
index 20286bd90ab5..5c4c94205e33 100644
--- a/include/uapi/linux/ppp_defs.h
+++ b/include/uapi/linux/ppp_defs.h
@@ -50,6 +50,7 @@
 #define PPP_IPCP	0x8021	/* IP Control Protocol */
 #define PPP_ATCP	0x8029	/* AppleTalk Control Protocol */
 #define PPP_IPXCP	0x802b	/* IPX Control Protocol */
+#define PPP_ECP		0x8053	/* Encryption Control Protocol */
 #define PPP_IPV6CP	0x8057	/* IPv6 Control Protocol */
 #define PPP_CCPFRAG	0x80fb	/* CCP at link level (below MP bundle) */
 #define PPP_CCP		0x80fd	/* Compression Control Protocol */
@@ -58,6 +59,7 @@
 #define PPP_PAP		0xc023	/* Password Authentication Protocol */
 #define PPP_LQR		0xc025	/* Link Quality Report protocol */
 #define PPP_CHAP	0xc223	/* Cryptographic Handshake Auth. Protocol */
+#define PPP_EAP		0xc227	/* Extensible Authentication Protocol */
 #define PPP_CBCP	0xc029	/* Callback Control Protocol */
 
 /*
-- 
2.32.0

