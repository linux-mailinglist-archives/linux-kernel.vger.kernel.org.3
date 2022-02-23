Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA2DC4C0C69
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 07:07:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238196AbiBWGID (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 01:08:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235016AbiBWGIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 01:08:01 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4D7D5AEDB;
        Tue, 22 Feb 2022 22:07:34 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id qe15so1733554pjb.3;
        Tue, 22 Feb 2022 22:07:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc:from
         :subject:content-transfer-encoding;
        bh=5ZxXawg5jpHvxptI63it2ru8ZC820c4H+yI5lDwnbmg=;
        b=DLeshPWhqt9qlx/LiXsHolmTGxOS62BKgISxnZTyZMC8tcQjueS0hhhLW9BWT0JeHh
         oIalc7sJWfg7xqhX/2LMTOFFMyIL3UOweO7qKTpqdB2YOd55jCaO5gyKfRJSwG/apc1D
         ynYc985LlhZsH6kqdqXjqh1Og+aIa9kLtmmQgHPJP1+GNm3THxLCFFnEhcpr50Pujgvj
         BplF6m9gQZtWx7BMn+2oaYaixWpQOu1Xv1BUgj6g1+my3JVhwoEtb4vAIESqeO8Oob8f
         BfDR4bp4iBaaJIZoHiNHLZK853jIHaj4h85DViA0bVUczCvEage6Aqkifmf4xoMKv7tc
         dqVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:from:subject:content-transfer-encoding;
        bh=5ZxXawg5jpHvxptI63it2ru8ZC820c4H+yI5lDwnbmg=;
        b=KdZPDeRoGGx8Jospp2nD60/NM2Lk85NYu83a7eqv/rSaS+0zpnV7AAV5EV3LKH8Nz4
         /DrST6z2sZ5pPMiFlFJlgD6eXgXYOY+GjAwYRvYJ2XMmqxvGa5HKHLhoEMHXRBha6stk
         W0UBfxvc0hWFJBLqofBhv6brV2JYbAAxN194Z2m7ZJZXJdNSpJ3Yjt8j1GqAijyDPt9j
         kjvrOGWp25EYutxxoWWXZ00B2WYbPdNy1KvzcvFOpM1XW7SNTWp6R32OHtWTo+2G/36p
         fNNvxRDVW9IflB934Er1ZoMrZ0bYWjHZofwwr4/Ycr/5fslxbYMm62A36q2eFZhjVBrq
         g5Tw==
X-Gm-Message-State: AOAM530F+HoqQjn2Xs9ee7+sTorOwuBAQyu57JVGtPuP1GQM1a0SvPDQ
        z+PO43ezd4xMXd4sEv6CT7k=
X-Google-Smtp-Source: ABdhPJxmR8RD75S+gFKKvVcd9k8XK6x8Cg2hwP1YEAw0ydRjMvS6ZNtRnUtVeXx847uO6NHl1UdJFg==
X-Received: by 2002:a17:902:7786:b0:14d:51c6:21a8 with SMTP id o6-20020a170902778600b0014d51c621a8mr26661131pll.75.1645596454387;
        Tue, 22 Feb 2022 22:07:34 -0800 (PST)
Received: from [192.168.11.5] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id n13sm1485315pjq.13.2022.02.22.22.07.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Feb 2022 22:07:33 -0800 (PST)
Message-ID: <1c71e5d2-f87e-6c8e-6176-e5ce42e4d41b@gmail.com>
Date:   Wed, 23 Feb 2022 15:07:30 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>
From:   Akira Yokosawa <akiyks@gmail.com>
Subject: [PATCH] scripts: kernel-doc: Check existence of FILE arg
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: [PATCH] scripts: kernel-doc: Check existence of FILE arg

Currently, when no FILE argument is given following switches such
as -man, -rst, and -none, kernel-doc ends up in the error of (long
msg from perl folded):

    Use of uninitialized value $ARGV[0] in pattern match (m//)
    at ./scripts/kernel-doc line 438.

Fix this by adding an existence check at the bottom of the while
loop parsing command switches and call usage() if there remains
no argument.

While at it, fix inconsistent indent by spaces in the previous
block.

Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
Hi Jon,

I noticed this minor issue while reviewing Tomasz's patch series.
This patch is relative to docs-next as of 2022.02.22.

        Thanks, Akira
--
 scripts/kernel-doc | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index 3106b7536b89..faefe2977f0e 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -494,7 +494,11 @@ while ($ARGV[0] =~ m/^--?(.*)/) {
 	}
     } else {
 	# Unknown argument
-        usage();
+	usage();
+    }
+    if ($#ARGV < 0){
+	print "No FILE!\n";
+	usage();
     }
 }
 

base-commit: b62ef3a1cca0553613adce16515f3640400725b4
-- 
2.17.1


