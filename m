Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEED04C2C73
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 14:02:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234716AbiBXNDV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 08:03:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234644AbiBXNDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 08:03:19 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C576F1B0BE4;
        Thu, 24 Feb 2022 05:02:49 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id m22so1969274pja.0;
        Thu, 24 Feb 2022 05:02:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc:from
         :subject:content-transfer-encoding;
        bh=KmRf75qCveSuYPiB5ylSj3DCA7hKJMZwh2SvGTJxYZc=;
        b=HgvWDWVjZwTyTyjNJk7JGG0cjpWy0j5P8hy66zuV1DedXyfHIsIbs2uYNPIIMGo+mF
         SotPVMxz9dU1ADWzt9a902+g1bgF7IjoG12/jloc2Ih1T9uZ7sSnJsQZww2Fz3sw2iLc
         Bx6iOqG0qFPXiTP19vYsQjWSoc+zJDIW0BYeuQYnjKBQblhf4pkLSpvfQr+3OF1J9qSN
         53JJrhcrm6uk5pT+KfiQEdPMHHers59l7/cP5LHG9VcGR7m0G2l8t9t1XsrqvGTP3ONz
         0bEeuWwoSuMvmrRsf8QeookE9+ME8X1Az0upSXv7z82lDh2Rfd2Su+27NQayENtF+rgV
         t5LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:from:subject:content-transfer-encoding;
        bh=KmRf75qCveSuYPiB5ylSj3DCA7hKJMZwh2SvGTJxYZc=;
        b=nhuKJSuF+fKl3CoveAFqVw15BdpK8dKF5G6wlA2hSo0iguRLMwJ9iD3PD9uJSqu9QO
         C1awktcOUW4TwYKfXjVc+dOLvHLbjnQHoSqADRR5Uywtplc5SobeXNKfLo9QB2RVHVhq
         3eUz0CHpaSTqKR3A78iNF+HZGSfWH2pdkAEjxx3x/PPgg6zH/vUa9/GljZhrBPjv4luv
         l9Gn3VxzLsNnMO4qeym5RCe6dE0hBiwriSRFf21smoTqDNZ6GL0iyKuC9LUcFQun/JpN
         luAXsv3UG/LccX3CjkJIgL178zas9x9C784pg+JgOfXiEwvQK5sQISIRuuuKJ+BGgJ0r
         hlrw==
X-Gm-Message-State: AOAM530U7Ar5WC/t1vsB3wBfPOz0d7vhSG7YUIA/Djty/Q3W5PFat32Z
        j4mCgE1dmvRHhjiLauWoMWc=
X-Google-Smtp-Source: ABdhPJwxRaWj+QYLoEbry0cL/J97Ox7OrI8FluGuWmLRB9H16HKsqGHi1JxYqLrqi4HQ+xsosQwWWw==
X-Received: by 2002:a17:90b:1d91:b0:1b9:d5fd:3c8a with SMTP id pf17-20020a17090b1d9100b001b9d5fd3c8amr14467088pjb.213.1645707769252;
        Thu, 24 Feb 2022 05:02:49 -0800 (PST)
Received: from [192.168.11.5] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id s5sm2589044pgo.37.2022.02.24.05.02.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Feb 2022 05:02:48 -0800 (PST)
Message-ID: <7b136049-a3ba-0eb5-8717-364d773ff914@gmail.com>
Date:   Thu, 24 Feb 2022 22:02:46 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Jonathan Corbet <corbet@lwn.net>,
        =?UTF-8?B?VG9tYXN6IFdhcm5pZcWCxYJv?= <tomasz.warniello@gmail.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Akira Yokosawa <akiyks@gmail.com>
Subject: [PATCH v2] docs: scripts/kernel-doc: Detect absence of FILE arg
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, when there is no FILE argument following a switch such
as -man, -rst, or -none, kernel-doc exits with a warning from perl
(long msg folded):

    Use of uninitialized value $ARGV[0] in pattern match (m//)
    at ./scripts/kernel-doc line 438.

, which is unhelpful.

Improve the behavior by adding a check at the bottom of parsing
loop.
If the argument is absent, display help text and exit with
the code of 1 (via usage()).

Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Tomasz Warnie=C5=82=C5=82o <tomasz.warniello@gmail.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
Changes since v1 [1]:
  - No code change
  - Amend subject and reword the whole changelog.
  - The message from perl is not an error but a warning.
     (I thank Tomasz for pointing it out.)

I thought the change of exit code might affect sphinx-build processing,
and tested with several runs of "make htmldocs" and "make pdfdocs".
So far, I've not seen any regression.

[1] v1: https://lore.kernel.org/r/1c71e5d2-f87e-6c8e-6176-e5ce42e4d41b@gm=
ail.com

        Thanks, Akira
--
 scripts/kernel-doc | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index 3106b7536b89..faefe2977f0e 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -494,7 +494,11 @@ while ($ARGV[0] =3D~ m/^--?(.*)/) {
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
=20

base-commit: b62ef3a1cca0553613adce16515f3640400725b4
--=20
2.17.1

