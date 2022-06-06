Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F44753EEB8
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 21:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232549AbiFFThg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 15:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232529AbiFFThY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 15:37:24 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E798E01C
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 12:37:17 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id e4so918481ljl.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 12:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LU+ehwQCgMw+RYAoa7UysR6sc9DbOFvZWP1+pr1tYwY=;
        b=lCbnKYifr76Ts+W+Qg90YlR4M6WXtHUcrsKy/4n+7CGfZnvzr3QaV5y+IRd710y+vq
         ZObhXIihBHKg6ecLk2vuSJpkIq7rPDnp2dVpDcA1+fx/lrQlp7vJhooYKtpbpZmbnoI0
         XAyt2V0GrN8EDAzLt9/K68mHqiAuQVDlqWJ5Rn5KpQ/2HGMg7/OOOMj8QA1xEgGwHQLZ
         9xXvgMWtAU7xLJhOnrBo5QGveUyjYRzFuxPYk17o7iGdLC7YGpZ1kJnUoSgR8h77FQlE
         FJymYiIzy0Q6ekLg3Z9OQuAdD+Pi5puRL1D8+SLH0m/vtBjQQ9QdW23o9qEMvR80mnVm
         KBcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LU+ehwQCgMw+RYAoa7UysR6sc9DbOFvZWP1+pr1tYwY=;
        b=0d9L8Dr6JqsheTcYL3admN+wXu8e5Jk4/p2t8P0Cy82KrDQ2PwGJWbS8XWI08gv35q
         0GwVe5NrnUhMgDNUWClOGwZaTriqv7SbGl9p8LAdItItxrObiX7a0V9PUNUUHRK8MEXn
         jEHAtjRv4J4qRnx1JhUnSrsYe/ncROk+xFxgn+8MLEfP8UO9P1tx7iD/pAbFTChCZTDH
         YMMSxAuCCLlmop7Uv3JV2JeFcxTpcfdfPD6hMMhlrdA2EgeOgfuf0Ttd3Ntz4kZYt1dV
         200+tx452o8xW94usCzSfps3AchRyxxOYFj4f4DBRJBhSNakPh89qRRNyzOBnB/ksGhv
         iwew==
X-Gm-Message-State: AOAM5313JZa/rbjM/np6D0Oq57RQXKasiGBmUo3kvOfuFXuKCCOQ+xfO
        lasZfMKgfXMic6ByGdRTmdI=
X-Google-Smtp-Source: ABdhPJxsCGSY9/dA+Q1B/ePGKjzzQzv5s5GxY2jagXqL8gholPFkBXGB+z4UXa3QQH6gJzNQ15qabg==
X-Received: by 2002:a2e:954f:0:b0:24f:4457:950d with SMTP id t15-20020a2e954f000000b0024f4457950dmr52789784ljh.35.1654544235470;
        Mon, 06 Jun 2022 12:37:15 -0700 (PDT)
Received: from localhost.localdomain ([94.103.229.27])
        by smtp.gmail.com with ESMTPSA id j22-20020a056512345600b00478ed85bc92sm2968233lfr.249.2022.06.06.12.37.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 12:37:15 -0700 (PDT)
From:   Pavel Skripkin <paskripkin@gmail.com>
To:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, straube.linux@gmail.com,
        dan.carpenter@oracle.com
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        Pavel Skripkin <paskripkin@gmail.com>
Subject: [PATCH v3 4/4] MAINTAINERS: add myself as r8188eu reviewer
Date:   Mon,  6 Jun 2022 22:37:12 +0300
Message-Id: <a5e93a54a2481f7a0c1921b7c9914972a5a93e45.1654543286.git.paskripkin@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1654543286.git.paskripkin@gmail.com>
References: <cover.1654543286.git.paskripkin@gmail.com>
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

I was reviewing r8188eu patches for a while, but I am missing some of
them, since I am not in CC list. I want to be CC'ed to help reviewing
and testing more patches.

Acked-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
Acked-by: Phillip Potter <phil@philpotter.co.uk>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0a635f2ae5b9..bd38a2e465cc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18716,6 +18716,7 @@ F:	drivers/staging/olpc_dcon/
 STAGING - REALTEK RTL8188EU DRIVERS
 M:	Larry Finger <Larry.Finger@lwfinger.net>
 M:	Phillip Potter <phil@philpotter.co.uk>
+R:	Pavel Skripkin <paskripkin@gmail.com>
 S:	Supported
 F:	drivers/staging/r8188eu/
 
-- 
2.36.1

