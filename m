Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF85052C606
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 00:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbiERWMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 18:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbiERWMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 18:12:18 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7752914AA69
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 15:12:09 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id w14so5907174lfl.13
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 15:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Cn63gQ8fiAaCxUAU+GTYt00yC4JfY8txZfLENC/Ur9w=;
        b=GQzLTFCOrNanqTm53W3JgcJ/s6SmwuCgS3A2l9Sfjr4qOIA3OtMOW46EryhNNjDLsn
         SdIxVDoIi9qQue2hi8jtFVzVhjh1vQOhmXFHuN7H1ijXrYgOfxbpq4LfNqCpcUEYCStN
         RqWhqUMpDDKculdrAtCqaQxLgo5C0Kic0ken3PECPtrlKCMBIKSjeD6rokGdwC+bwUa/
         tEx1XcSx0T5s4eRe15812GAO4xpmkA/6cOco9pOmZvvuC3Aqh7cgz7Agb7cifOcydZA7
         lz6jOsZQgQLCVY9o/BfL0f8EU38KI+RoEbQecYOuycx8JjFLpAsj86cwc57jnhvkHCgU
         7jeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Cn63gQ8fiAaCxUAU+GTYt00yC4JfY8txZfLENC/Ur9w=;
        b=2vpBLNjPFzVmCFPbodnD/yGcrBujyaVudHAK8t88LFZVRDwD+6hqPA18bqTUN2im5J
         XRQ/xwnHYs+fsFJpDFv1iPhv1q06O+yFbB5I4varfL9SsPrIqlDdMj5R2YZVpcXC2lOu
         Ixg0J61Ak3HAeNGxs2KXlFHbowAZoYuBBAEGj5KERGmNr+iAcFH8nDkAus1hwR/MiU2Z
         FSABaHo8HCsqnJdyVxDzlNGJK4EuHtf9xx4yWxEGSfj1gWq8TNH3Cb5MdwA7rXT4bnim
         62fL1IW5CtGGHjp1j6iOwXrEN1WAbFDCa6qV3nWd1XtCptgbF7btsi1XUc/YzkKv3lVE
         Mocw==
X-Gm-Message-State: AOAM531KO3Wx1YjxB40o4RvWznMSsfKK6XYXh/haIZNrneL2iLbutuyK
        CMm7P33d1oEz2NcQT6f+rs0=
X-Google-Smtp-Source: ABdhPJxqQOd8gl6Gdx8ldU4/CWEFIHt5q7SkIzGwSMHTA+fcC45NmWvTJFdnaVHDZSN+e5fjJemAjw==
X-Received: by 2002:a05:6512:21ad:b0:477:a61a:bfe6 with SMTP id c13-20020a05651221ad00b00477a61abfe6mr1061417lft.173.1652911929001;
        Wed, 18 May 2022 15:12:09 -0700 (PDT)
Received: from localhost.localdomain ([46.235.67.4])
        by smtp.gmail.com with ESMTPSA id o23-20020ac24e97000000b0047255d211b0sm65411lfr.223.2022.05.18.15.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 15:12:08 -0700 (PDT)
From:   Pavel Skripkin <paskripkin@gmail.com>
To:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, straube.linux@gmail.com,
        dan.carpenter@oracle.com, fmdefrancesco@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        Pavel Skripkin <paskripkin@gmail.com>
Subject: [PATCH 4/4] MAINTAINERS: add myself as r8188eu reviewer
Date:   Thu, 19 May 2022 01:12:06 +0300
Message-Id: <42559eab6dd1a69c3fb11ee6ed1f33337041817d.1652911343.git.paskripkin@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1652911343.git.paskripkin@gmail.com>
References: <cover.1652911343.git.paskripkin@gmail.com>
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

Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
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

