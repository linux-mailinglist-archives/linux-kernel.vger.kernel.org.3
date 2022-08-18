Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC01F59909B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 00:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344851AbiHRWgg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 18:36:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231636AbiHRWge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 18:36:34 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F6EED743A;
        Thu, 18 Aug 2022 15:36:33 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id q19so2781653pfg.8;
        Thu, 18 Aug 2022 15:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=ZlZOnC/qYxA1pMjp6WtByZBS31wEhSXXjVgZuTf1udc=;
        b=M4+z6xgFbpWAO7nkNC5INGi4D2Oky49sDoMjdZ1xKGEjafCJY2RR3LQNjqAYijmZsv
         iHZ94TIECUpuUg26iV7nHvqe4JMYPbNEnLqQfpQKQwV4KCDDrPs6tnO/ghLOBPhPVexc
         pYu02a1t+52zhnEGRjqqu62+RrP8hqgOyOXm0C/M2FlJbuk5ek9R4NrZrTV6vActW/6S
         P0cWdvJl/N8AMpaFGs0WYNISVLyt9DIpadoSUInHTZNCNVhW9+jOow6Vmd841bGX9ogm
         +/Sn/Hq33S7MjGJuYsn0zKvAnAQ7jxPfvlp7yVwDeX1fZr/DcX89fjINDNxMFU11r2Zx
         kIFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=ZlZOnC/qYxA1pMjp6WtByZBS31wEhSXXjVgZuTf1udc=;
        b=Rp+q74QXBD9rBwbXd0n1Teh8yWgjM6jok7+Y3XJPF5lUVSr72zccvp7bWHhwGLlhOl
         WFN2cRaBdDbYf8TZErAcmTuTejn38eAGisxUIgAxj/yQIQ1FeWx038MwLIwf8rPSrZjk
         D288xvZErvXV9ijATBwBmVt1OPb0mCLbTqI606PO1YcW3VQIDxvzIwBmHWZWfHms7ESV
         SNRlgAT0OHX9ikvT3CBfzcJ7IyXNISz/aBAVWMcul+OE+RFqKzqzJ5cIRsT8DisIzcsu
         4XMCVhsO60Ze4bDa+Oc2Vgrla11QSlEOp2cV1YFDrrYjhFM0rDYncMRxAy1UNzKXhZcR
         pq0w==
X-Gm-Message-State: ACgBeo2uggYm3Ro3U7fPVwBZ7P7li+bcvyYh4WfviawCOHS8Liasi4tc
        H0OJ78axhiaISjVdYP8P8mo=
X-Google-Smtp-Source: AA6agR72l8PkNgjUQYyXf5WJq3MwwTkbLkb7lQt3y+OHz5cG+wy/poYDbmK8CovdxDcnaWYZq8NzQQ==
X-Received: by 2002:a63:e157:0:b0:429:c287:2b9 with SMTP id h23-20020a63e157000000b00429c28702b9mr4064652pgk.258.1660862192817;
        Thu, 18 Aug 2022 15:36:32 -0700 (PDT)
Received: from localhost.localdomain (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id d14-20020a170902aa8e00b00170a6722c79sm1829842plr.247.2022.08.18.15.36.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 15:36:31 -0700 (PDT)
From:   Akira Yokosawa <akiyks@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Akira Yokosawa <akiyks@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tsugikazu Shibata <shibata@linuxfoundation.org>
Subject: [PATCH RESEND] docs/ja_JP/SubmittingPatches: Remove reference to submitting-drivers.rst
Date:   Fri, 19 Aug 2022 07:34:40 +0900
Message-Id: <20220818223440.13530-1-akiyks@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <acaf13cd-52f0-c7c2-add0-0644cb1e77e4@gmail.com>
References: <acaf13cd-52f0-c7c2-add0-0644cb1e77e4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reflect changes made in commit 9db370de2780 ("docs: process: remove
outdated submitting-drivers.rst")

Reported-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
Fixes: 9db370de2780 ("docs: process: remove outdated submitting-drivers.rst")
Cc: Tsugikazu Shibata <shibata@linuxfoundation.org>
---
Hi,

This is a band-aide patch removing a sentence with reference to
submitting-drivers.rst (removed during the v6.0 merge window).

As the translation around here is outdated, the end result does
not match the corresponding text in the English doc.

Remaining discrepancies will be taken care of while catching
up the other changes of the original doc.

        Thanks, Akira
--
Documentation/translations/ja_JP/SubmittingPatches | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/translations/ja_JP/SubmittingPatches b/Documentation/translations/ja_JP/SubmittingPatches
index 66ce0d8b0526..04deb77b20c6 100644
--- a/Documentation/translations/ja_JP/SubmittingPatches
+++ b/Documentation/translations/ja_JP/SubmittingPatches
@@ -35,8 +35,7 @@ Linux カーネルに変更を加えたいと思っている個人又は会社
 てもらえやすくする提案を集めたものです。
 
 コードを投稿する前に、Documentation/process/submit-checklist.rst の項目リストに目
-を通してチェックしてください。もしあなたがドライバーを投稿しようとし
-ているなら、Documentation/process/submitting-drivers.rst にも目を通してください。
+を通してチェックしてください。
 
 --------------------------------------------
 セクション1 パッチの作り方と送り方

base-commit: d22903e33a284d2de574ff0d89b9871bf0443b66
-- 
2.25.1

