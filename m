Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99F11504705
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Apr 2022 09:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233584AbiDQHyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 03:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233580AbiDQHyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 03:54:02 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1996140C8;
        Sun, 17 Apr 2022 00:51:28 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id u5-20020a17090a6a8500b001d0b95031ebso4685327pjj.3;
        Sun, 17 Apr 2022 00:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iDv+72tnbPCd3DSLzaLYf0PTI9YrKoCtiTHll5hbSxo=;
        b=l9TSM5rIIdgg6hhq4yRiWKbiyGwRrsh08FYQp1e0a4Gh9uCI43lmrJtJNfvv5bSiAM
         hS8h9Y0bYG7zWRdic5jopsntpN/o7c4uvFFeODluZ7jJrX1A0dZUA2a3is/61/ZLnpA8
         UWeAA27JffjZs6C7qaKKdQgkPrz5Sdm3syumZQlh4c3iCydb7F4Ue5fkSpO3HlkLvLhM
         x6sDDrtJPpCB0lBvpSr3gHgWibfJf3trE4IldeyQn4MJNE9Zv86VcyTOxODnxGg6dRBW
         qf6OTyub9zZrvBy7qxlytI6kpvfWjF3YbvqSoGF0P0aiS8n2+vmC12saitMk1TSTJ8I+
         QPdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iDv+72tnbPCd3DSLzaLYf0PTI9YrKoCtiTHll5hbSxo=;
        b=EvejQgnVIvPrZ7KswRuesvDzjxJhGtPzIBGb3kSS0I58xV4s7ps7synh7nYaKKUJSj
         u+m7grQAICT9uGaA+z46GD1M1B3SzGwUqPOuFnoV8NyGQi5karzQjyw5g4OwVNL3XOYQ
         f0vHbz8ycVlyzyAWm6jUy7023CPymYHD5/u/0IuR/1oaZ+fCTG9vPCSJex5uVRT7s/bh
         o0Y5u1fY0IuLTOnS82LPpu3zgQkASb43zdBT5cElmGODnl2+ZjZODxFHE6UsHW7docS4
         gn+qV6yLMxF1aMqtazqGJ1pmQ18eSXjqAabrh468aoSDvA7s4eJ0BVzPuRnor+jaLxoM
         Mp5g==
X-Gm-Message-State: AOAM530hUnhcKXftHDpiHNYGV67v0Lp/I+w4dZdZZd72ViUlFwSoWptK
        yKIO2vKhXYzBYXIevQ0yjC0qFAwGivhJRQ==
X-Google-Smtp-Source: ABdhPJydfLIkyr+VnJKc+uA5K5+9ktJSXyZJl04Kn8voy8PCMICi3r3VxQ1H1lvFzvFbfZ1KPwJBsg==
X-Received: by 2002:a17:903:2d1:b0:156:7ceb:b56f with SMTP id s17-20020a17090302d100b001567cebb56fmr6265640plk.11.1650181887904;
        Sun, 17 Apr 2022 00:51:27 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-74.three.co.id. [180.214.232.74])
        by smtp.gmail.com with ESMTPSA id m21-20020a17090a7f9500b001c97c6bcaf4sm13558356pjl.39.2022.04.17.00.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Apr 2022 00:51:27 -0700 (PDT)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     linux-doc@vger.kernel.org
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Eric Biggers <ebiggers@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH RESEND 1/2] Documentation: siphash: convert danger note to warning for HalfSipHash
Date:   Sun, 17 Apr 2022 14:50:57 +0700
Message-Id: <20220417075057.127865-2-bagasdotme@gmail.com>
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

Render danger paragraph into warning block for emphasization.

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Eric Biggers <ebiggers@google.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/security/siphash.rst | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/security/siphash.rst b/Documentation/security/siphash.rst
index bd9363025fcbc1..42794a7e052f1e 100644
--- a/Documentation/security/siphash.rst
+++ b/Documentation/security/siphash.rst
@@ -121,12 +121,12 @@ even scarier, uses an easily brute-forcable 64-bit key (with a 32-bit output)
 instead of SipHash's 128-bit key. However, this may appeal to some
 high-performance `jhash` users.
 
-Danger!
-
-Do not ever use HalfSipHash except for as a hashtable key function, and only
-then when you can be absolutely certain that the outputs will never be
-transmitted out of the kernel. This is only remotely useful over `jhash` as a
-means of mitigating hashtable flooding denial of service attacks.
+.. warning::
+   Do not ever use HalfSipHash except for as a hashtable key function, and
+   only then when you can be absolutely certain that the outputs will never
+   be transmitted out of the kernel. This is only remotely useful over
+   `jhash` as a means of mitigating hashtable flooding denial of service
+   attacks.
 
 Generating a HalfSipHash key
 ============================
-- 
An old man doll... just what I always wanted! - Clara

