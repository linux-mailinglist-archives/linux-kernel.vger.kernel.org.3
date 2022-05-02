Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA4E0516F45
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 14:06:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233214AbiEBMJm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 08:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384900AbiEBMIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 08:08:44 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7676210C1
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 05:05:14 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id p8so12127724pfh.8
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 05:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:from
         :subject:to:cc:content-transfer-encoding;
        bh=3fDxi1QIxwzVqsF1Ck/dGgA8KZypvCqmnIlsr5hMVOM=;
        b=J1TKFyfNnQHA/OzGXEHbLNJDF4ryUJjank6aoqTyvDWYosE5CLPzOqiu+lror3lbVo
         Rrvnv9l+tn6k6YCQNFxEGTxXWp/nA7VAmcBeUsc0+TVc8Z4TzLqOKYXfBv4ZOA8fNPo0
         5FJ4kJe0j2/yloPDDBsSkwCiRaREn+XG+SpZv3TQLFDC8su64SaEfBhty7omEYVcZWQs
         bnJAVD20FYdItXu4DY1rXyPPA7HONKqDaVRlE9X6aCfCqFhv26I5jKdffAyhTm8BBqM6
         GtKztjPYjC+Ci4fVs9EkCC0nFLfOzdtc0Is8vuJjTpGl6jOsxIDinlGiZ6l8kav2MlCQ
         tj5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:from:subject:to:cc:content-transfer-encoding;
        bh=3fDxi1QIxwzVqsF1Ck/dGgA8KZypvCqmnIlsr5hMVOM=;
        b=xev1B2+kXLHEJ6lx3KjS4ms5woprRpA/KFo70ZlBRyz6QAI6LTnT+inQ74QccZghQR
         1Ofew/p7sPZfP1DvRQhSFScA7DevA+fl0klMS9aQtMNOYz8fBeoPpV68NcKIh+r6zqOK
         8+VS95ncvh44ueaCfQGiTDQRyYAfrkw6GAHMBxh8nXJ6pPrqGFS8GTEj7O5r/rnGWCSm
         sldqHbycDiwgiWZcz2e4pRcobuopQKVNSMsUhjIaZJDK1ifJ58Aw+mL/P7NIjLSz2Vek
         ++BW25KZPN2p5C8c1epSFLQG3KLiGMTEP0X6YPc7ntnVUN/oxKWvOxZa9Ym6IoaT5fXJ
         DIDA==
X-Gm-Message-State: AOAM533P0nANnDTrVTVe76BuHMOFkvyG9l8UrAMbeTKYCbor9YpISqKs
        E35JalO6FaBobT1MJ2BoPInQ8QA1YDg=
X-Google-Smtp-Source: ABdhPJyatU1p+ulgw2xZaDllxjMctIJQbgi5Q5qtturaj9DePHeizwUcGME9wwOGS1ZOdS1fqwRkvQ==
X-Received: by 2002:a05:6a00:124e:b0:50d:bf78:936f with SMTP id u14-20020a056a00124e00b0050dbf78936fmr10754168pfi.85.1651493113942;
        Mon, 02 May 2022 05:05:13 -0700 (PDT)
Received: from [192.168.11.5] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id u23-20020a170902a61700b0015e8d4eb2b9sm4518897plq.259.2022.05.02.05.05.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 May 2022 05:05:13 -0700 (PDT)
Message-ID: <2b237126-88d1-17f2-ce94-2cb679f0b285@gmail.com>
Date:   Mon, 2 May 2022 21:05:09 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Content-Language: en-US
From:   Akira Yokosawa <akiyks@gmail.com>
Subject: [PATCH -lkmm] tools/memory-model/README: Update klitmus7 compat table
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Luc Maranget <luc.maranget@inria.fr>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Akira Yokosawa <akiyks@gmail.com>, linux-kernel@vger.kernel.org
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

EXPORT_SYMBOL of do_exec() was removed in v5.17.  Unfortunately,
kernel modules from klitmus7 7.56 have do_exec() at the end of
each kthread.

herdtools7 7.56.1 has addressed the issue.

Update the compatibility table accordingly.

Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
Cc: Luc Maranget <luc.maranget@inria.fr>
Cc: Jade Alglave <j.alglave@ucl.ac.uk>
Cc: stable@vger.kernel.org # v5.17+
---
Hi Paul,

herdtools7 release 7.56.1 is available at
https://github.com/herd/herdtools7/releases/tag/7.56.1,
and "opam update/upgrade" should catch it soon.

I think this is worth for v5.18, albeit it is a minor update
in documentation.

Thoughts?

        Thanks, Akira
--
 tools/memory-model/README | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/memory-model/README b/tools/memory-model/README
index 9edd402704c4..dab38904206a 100644
--- a/tools/memory-model/README
+++ b/tools/memory-model/README
@@ -54,7 +54,8 @@ klitmus7 Compatibility Table
 	     -- 4.14  7.48 --
 	4.15 -- 4.19  7.49 --
 	4.20 -- 5.5   7.54 --
-	5.6  --       7.56 --
+	5.6  -- 5.16  7.56 --
+	5.17 --       7.56.1 --
 	============  ==========
 
 
-- 
2.25.1

