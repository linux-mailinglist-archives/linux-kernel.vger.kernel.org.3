Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08E42504703
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Apr 2022 09:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233601AbiDQHyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 03:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233570AbiDQHyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 03:54:05 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FC24140D1;
        Sun, 17 Apr 2022 00:51:31 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id u5-20020a17090a6a8500b001d0b95031ebso4685360pjj.3;
        Sun, 17 Apr 2022 00:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MoKiGu5hYYcfsxqQHX2Q84Bhs0fRLBU9UCfGUfeAlqU=;
        b=HF8LwImncW0D1JtKhI+cq2dt3nB//pzEAk7tRBQrnEySTSmm/MDQHQzvYorITSuz2R
         ouw1Rc5wdNnwbFRCPngNRvpHKiu9zaTrOd6uEyTlEOFYu8K4KPYz/qKG42oH0Bhei64r
         cK3DbzifnAzF9qLWZjOqlIpLIQHD00Gdm5sSqa/l5S4wayRpk1WbOodvI+dZ1UCWLMf6
         h66uACfhaB7miPIAk93SiGO9Cu6mIPpqIri0cO6b6dWEHn+gHAusvvkXDgCMe64ETQly
         hXaAntqSLcogJFrGDB20RVST/rRd0/5svij5jXynnfvwKSOkAGaLpcTwVXYzYIWNu15A
         W6iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MoKiGu5hYYcfsxqQHX2Q84Bhs0fRLBU9UCfGUfeAlqU=;
        b=nC4OoyspbMMdKBHAlWcCu00aSZfZyN2xohwc1dfQ99ItLzegpchuUL18TUKpKW0SsM
         Qt0gOWrw7oMuBuMHP2h2Etk+PAoQ1E8ynOlXQffQ0SeHElQfIA4Dh5oELYB2UyONyaIX
         222dMFBs3sOK0fosew64Il8WlT4EA2kg7G4punCT9DNluwdTg7VojEv3PJolWia4dLYi
         mkLukur0AgoOxTV9Ey484TOISrzkrRrVvX6mHgbBu40HfVk/PM94v1/Ga/2YpPrwIh3y
         srPH4lroBjHGsiZam1fCOltn2nwhRGJGlsn7kax6KEOJvQmP4n13ysk1C1WsjVVwmWnK
         z2wg==
X-Gm-Message-State: AOAM532/WhW0tSkm4w0v45/S6UAuqCGid09t+Rzvu8mNv+Ah+Mzzb8bM
        cQt387secxq+Ur70LPhXjBNYgu4tzjrkww==
X-Google-Smtp-Source: ABdhPJwEM8DJm74QIZFhmFv4M6dyT8c3GvHa7PUfPI7/TCab213391jBRaPDx72DZH0VxJVBYSaRVg==
X-Received: by 2002:a17:902:cf05:b0:156:9d:ca01 with SMTP id i5-20020a170902cf0500b00156009dca01mr6264769plg.111.1650181890860;
        Sun, 17 Apr 2022 00:51:30 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-74.three.co.id. [180.214.232.74])
        by smtp.gmail.com with ESMTPSA id m21-20020a17090a7f9500b001c97c6bcaf4sm13558356pjl.39.2022.04.17.00.51.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Apr 2022 00:51:30 -0700 (PDT)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     linux-doc@vger.kernel.org
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Eric Biggers <ebiggers@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH RESEND 2/2] Documentation: siphash: enclose HalfSipHash usage example in the literal block
Date:   Sun, 17 Apr 2022 14:50:58 +0700
Message-Id: <20220417075057.127865-3-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220417075057.127865-1-bagasdotme@gmail.com>
References: <20220417075057.127865-1-bagasdotme@gmail.com>
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

