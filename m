Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBBE74EA69A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 06:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232071AbiC2Eb4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 00:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232029AbiC2Ebt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 00:31:49 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D878831DF9;
        Mon, 28 Mar 2022 21:30:07 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id m22so16273673pja.0;
        Mon, 28 Mar 2022 21:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MoKiGu5hYYcfsxqQHX2Q84Bhs0fRLBU9UCfGUfeAlqU=;
        b=Au2SrM8R77nRJEsjHHjDlmyULoPonsfJ0BHPyx/Is3t/4LJJtGByzA5KdUbwSKuPOj
         j4y2syTcOwAUCs8C/znaY02NnsYisYySvX5hc0ibHmRB7sv7fypxk734RgZGLU3EWoPv
         xUw0GMExIbn7X/6asOAI85Urn8aNkC2Y7alS9gCsiUutHXqXPPk8ghBfG2lKKR0NlHKk
         iEKdEbhiiZ3Lfz96fAFLIXD3yZhHiAeuOqoJiRmx3cjrRWhmnbEA3fbu+I6itlVl7C/R
         2nzle3WGfbB9UHkkrliasqMdrAhcIXNK+J2mvTj4R3fXf3yKUJs3UnRGY6068y53PFC4
         37ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MoKiGu5hYYcfsxqQHX2Q84Bhs0fRLBU9UCfGUfeAlqU=;
        b=nC2IfjRdakfzjIEhzlA2L8a4icx2nV4NS3QNtXLQ0xBbd8PzSNyqBkc7wT/GDGWoOE
         0YjvFdIMMdAzGJrFWhbFG/90ld7/mEbXEqWS/2iG/v+riZryfoRnMNgAF9EonBZCyBHU
         GtoysGQGNBpZgEzysSe+8MV93DW3BiBCzwpchZOes8wSf739nUvaZwa2yYUM4Aa9JVyC
         kLjtR9YSx/nxJBMKZ96jKJnRRY5EREWowuRkpkPk5RXlRmai3aIoD3AFDu9wtePLKsuh
         57IbMaZ9LwCdIXSRQaGRJ2qgBJg43A9/D7wBwimv+2t7TVhHfk8POoj1/kL1cmpCDA5B
         DFqA==
X-Gm-Message-State: AOAM531Q5pDuoScb+Dg5uiCzTGUhsVRVgQDLb7DbPkV702iNhdvVAVCR
        8GS8u0TbT7kdeVif8HlNUM/3QKgztvULFPLV
X-Google-Smtp-Source: ABdhPJzopJffa3nKRux0NAzenVywEvJVTG3QPXObTupAnI8b/jhHatCtubi4mhXVMBty9iZZ+MqGFA==
X-Received: by 2002:a17:90b:164f:b0:1c7:8d27:91fc with SMTP id il15-20020a17090b164f00b001c78d2791fcmr2583548pjb.228.1648528207087;
        Mon, 28 Mar 2022 21:30:07 -0700 (PDT)
Received: from ubuntu.mate (subs32-116-206-28-55.three.co.id. [116.206.28.55])
        by smtp.gmail.com with ESMTPSA id z13-20020a17090a468d00b001c7db8e6ac7sm1055075pjf.40.2022.03.28.21.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 21:30:06 -0700 (PDT)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     linux-doc@vger.kernel.org
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Eric Biggers <ebiggers@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] Documentation: siphash: enclose HalfSipHash usage example in the literal block
Date:   Tue, 29 Mar 2022 11:29:52 +0700
Message-Id: <20220329042952.10100-3-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220329042952.10100-1-bagasdotme@gmail.com>
References: <20220329042952.10100-1-bagasdotme@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Render usage example of HalfSipHash function as code block by using
literal block syntax.

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Eric Biggers <ebiggers@google.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/security/siphash.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/security/siphash.rst b/Documentation/security/siphash.rst
index 42794a7e052f1e..06d793e680869c 100644
--- a/Documentation/security/siphash.rst
+++ b/Documentation/security/siphash.rst
@@ -132,10 +132,10 @@ Generating a HalfSipHash key
 ============================
 
 Keys should always be generated from a cryptographically secure source of
-random numbers, either using get_random_bytes or get_random_once:
+random numbers, either using get_random_bytes or get_random_once::
 
-hsiphash_key_t key;
-get_random_bytes(&key, sizeof(key));
+        hsiphash_key_t key;
+        get_random_bytes(&key, sizeof(key));
 
 If you're not deriving your key from here, you're doing it wrong.
 
-- 
An old man doll... just what I always wanted! - Clara

