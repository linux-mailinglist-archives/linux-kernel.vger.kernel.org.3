Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E412474F03
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 01:19:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235360AbhLOATe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 19:19:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232930AbhLOATd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 19:19:33 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E475C06173E
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 16:19:33 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id c3so27285571iob.6
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 16:19:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tMAMO0djljzKE3TENnIaAeCLl2cv92t1lTW3pqGBMI0=;
        b=VolncuD+ecLvUJYaYCLJYLHnoSda1ds53ng7/XHsT6rIWQNgZKX7N5dginAgH92FO2
         BoLitBFswKWP4wzRENpMLpf1rMRH7MXB/Kgqlnm2EcGeO2YedQhzsKt3OXP39DX0W2HO
         Lp9HXliGQtlsVv27n8YZl7bI85kk5vXWRwz68=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tMAMO0djljzKE3TENnIaAeCLl2cv92t1lTW3pqGBMI0=;
        b=LTkiK8y6mvTdE+xwepKnAOqoedsLAPbbRJ3Npdh8jHxPYsKY34R/YXv6mSM0BRyvLX
         fy4izMMcD/oM9UM0jIe8kGTbpALbNKTbJ09LqdU6aUcLMHgz8FWJTF71nBP647Xb9Q4f
         eJ6N6xn9wStoyEJflM0V9JL04V0VNJ8cINC5bmFvV3biiSiJuTzKjYlJp/unnEIFOXvS
         kZvbOHUKj7rd+q30yOA08EQp0oOga5IHFi2Y6vgogAzi0G2npsFOeQ+zX2F6zcqmMR+7
         6jBfg1WOCgxTm38ln1+yBaJRIZTU0vsqEeHql/JgqsbN49uqfs3jXoUw3vCUEEHHrtUa
         xJdQ==
X-Gm-Message-State: AOAM531nvNeiysCThSA2f3SvAOjfHRLR4fxuXs+LZsQMM8KT2EEXUdZW
        IdpEggJvtEKvR0GeYG8QQmCi/o2he55LFw==
X-Google-Smtp-Source: ABdhPJwhscLR8urvPYNYICV9n50i02n9ItYu6S9knOO/0EpDjHr2GIwgeFzqaHpnegAQXSBVR0bqeg==
X-Received: by 2002:a05:6602:24ce:: with SMTP id h14mr5443876ioe.87.1639527572066;
        Tue, 14 Dec 2021 16:19:32 -0800 (PST)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id b8sm258975iow.2.2021.12.14.16.19.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 16:19:31 -0800 (PST)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     corbet@lwn.net, akpm@linux-foundation.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] docs/vm: fix Unexpected indentation warns in page_owner
Date:   Tue, 14 Dec 2021 17:19:29 -0700
Message-Id: <20211215001929.47866-1-skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix Unexpected indentation warns in page_owner:

Documentation/vm/page_owner.rst:92: WARNING: Unexpected indentation.
Documentation/vm/page_owner.rst:96: WARNING: Unexpected indentation.
Documentation/vm/page_owner.rst:107: WARNING: Unexpected indentation.

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 Documentation/vm/page_owner.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/vm/page_owner.rst b/Documentation/vm/page_owner.rst
index 9837fc8147dd..9a3af6aafa09 100644
--- a/Documentation/vm/page_owner.rst
+++ b/Documentation/vm/page_owner.rst
@@ -89,11 +89,11 @@ Usage
 
 	Page allocated via order XXX, ...
 	PFN XXX ...
-	 // Detailed stack
+	// Detailed stack
 
 	Page allocated via order XXX, ...
 	PFN XXX ...
-	 // Detailed stack
+	// Detailed stack
 
    The ``page_owner_sort`` tool ignores ``PFN`` rows, puts the remaining rows
    in buf, uses regexp to extract the page order value, counts the times
@@ -104,7 +104,7 @@ Usage
 
 	XXX times, XXX pages:
 	Page allocated via order XXX, ...
-	 // Detailed stack
+	// Detailed stack
 
    By default, ``page_owner_sort`` is sorted according to the times of buf.
    If you want to sort by the pages nums of buf, use the ``-m`` parameter.
-- 
2.32.0

