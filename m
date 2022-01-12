Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D613A48C7D0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 17:05:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354909AbiALQFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 11:05:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240010AbiALQE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 11:04:58 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EE8FC06173F;
        Wed, 12 Jan 2022 08:04:58 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id m13so5823460pji.3;
        Wed, 12 Jan 2022 08:04:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p9vDS7ou1+K0jTUYDpO057Bsl73tb9hvAFDeAhdEnkg=;
        b=MXWP+LqLo5weL9eKi1XWJ8ZN2oPbD5LfoJB0Ew569LonPEQIaH2ebzF4unLsuTpb1X
         FhAD6mlmgYTkz6itTdqWP8YofB8WKWSOZh+TlqG4tukI3AifSrDIy3seUEaJJ7z2H7b/
         tqgrEFue4Y5oRJ2vuQYHcSw6x5BeWXuQmcAF4lVePFaa8gSHi/Er8AIA9vypcLQbDdnQ
         l1CXxvuOLnBNhie+rC5z7wnM8oYgWHt6918HnXFCI7cD3nBdwKtfX/LWHQ9DcRGOAccn
         3NLO0h4/odsPrjfhZIa2FKJsIplh+v8ZYgICI9DdQFX04G+AeajhoE/EZvRG7mFdPwaG
         hrPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p9vDS7ou1+K0jTUYDpO057Bsl73tb9hvAFDeAhdEnkg=;
        b=qlTdvySDOXYP9cZ7SsM7TL/0s6ZFMLK4WuLYNF1rACFYyg7yxql1egCpb3vJhHu9Tg
         1h3PNZ6Rp8NVhQ8y8UkQXiOx9cXkWMrDAAQ82KmnTkgg2a0+riqzudh7n8SPd66Pa109
         c+donF7QxY+VrlEAXA66T6q6fP+yYjz6kSSL3E6YF5Azg6yqalGmXSfyXq28h2vUaQc9
         rDZxWucujwb5I82GMmHRRen+wwIdcgbz7B4vugrBMV4p3Ou2Bu9xKCPAlD8a59uDZn1X
         Wi7X8MJ6MyusbNcUFzXfK3WEP+Lsx9w4KXqK/rFt3spwrn83NsfSXKLkgEto2nl1UQC/
         pQJw==
X-Gm-Message-State: AOAM530voLNVnbHf+ZxP/cTzJfRfHjuVcSxeUZs8x7V5xwwt4iujMkhn
        Ww01+VMCIrG9dLdxXTvV3qw=
X-Google-Smtp-Source: ABdhPJw/5EmtPQ4pqAF9nzNkFBcXsKnPk0aGXdobZEznOBMSaixKn2hhPXJIDcuFSe1NWrzRpGoApg==
X-Received: by 2002:a17:902:ecc6:b0:148:a65d:842d with SMTP id a6-20020a170902ecc600b00148a65d842dmr430395plh.56.1642003497591;
        Wed, 12 Jan 2022 08:04:57 -0800 (PST)
Received: from localhost.localdomain ([218.88.125.213])
        by smtp.gmail.com with ESMTPSA id e15sm104808pfv.23.2022.01.12.08.04.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jan 2022 08:04:57 -0800 (PST)
From:   yongw.pur@gmail.com
X-Google-Original-From: wang.yong12@zte.com.cn
To:     alexs@kernel.org, siyanteng@loongson.cn, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        wang.yong12@zte.com.cn, yang.yang29@zte.com.cn
Subject: [PATCH] docs/zh_CN: Update zh_CN/accounting/delay-accounting.rst
Date:   Wed, 12 Jan 2022 08:04:42 -0800
Message-Id: <1642003482-48935-1-git-send-email-wang.yong12@zte.com.cn>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: wangyong <wang.yong12@zte.com.cn>

Update zh_CN/accounting/delay-accounting.rst.
The document modification has been merged which refers to the following link:
https://lore.kernel.org/all/1639583021-92977-1-git-send-email-wang.yong12@zte.com.cn/

Signed-off-by: wangyong <wang.yong12@zte.com.cn>
Reviewed-by: Yang Yang <yang.yang29@zte.com.cn>
---
 .../zh_CN/accounting/delay-accounting.rst          | 62 +++++++++++-----------
 1 file changed, 30 insertions(+), 32 deletions(-)

diff --git a/Documentation/translations/zh_CN/accounting/delay-accounting.rst b/Documentation/translations/zh_CN/accounting/delay-accounting.rst
index 67d5606..f184941 100644
--- a/Documentation/translations/zh_CN/accounting/delay-accounting.rst
+++ b/Documentation/translations/zh_CN/accounting/delay-accounting.rst
@@ -17,6 +17,8 @@ a) 等待一个CPU（任务为可运行）
 b) 完成由该任务发起的块I/O同步请求
 c) 页面交换
 d) 内存回收
+e) 页缓存抖动
+f) 直接规整
 
 并将这些统计信息通过taskstats接口提供给用户空间。
 
@@ -37,10 +39,10 @@ d) 内存回收
 向用户态返回一个通用数据结构，对应每pid或每tgid的统计信息。延时计数功能填写
 该数据结构的特定字段。见
 
-     include/linux/taskstats.h
+     include/uapi/linux/taskstats.h
 
 其描述了延时计数相关字段。系统通常以计数器形式返回 CPU、同步块 I/O、交换、内存
-回收等的累积延时。
+回收、页缓存抖动、直接规整等的累积延时。
 
 取任务某计数器两个连续读数的差值，将得到任务在该时间间隔内等待对应资源的总延时。
 
@@ -72,40 +74,36 @@ kernel.task_delayacct进行开关。注意，只有在启用延时计数后启
 
 getdelays命令的一般格式::
 
-	getdelays [-t tgid] [-p pid] [-c cmd...]
+	getdelays [-dilv] [-t tgid] [-p pid]
 
 获取pid为10的任务从系统启动后的延时信息::
 
-	# ./getdelays -p 10
+	# ./getdelays -d -p 10
 	（输出信息和下例相似）
 
 获取所有tgid为5的任务从系统启动后的总延时信息::
 
-	# ./getdelays -t 5
-
-
-	CPU	count	real total	virtual total	delay total
-		7876	92005750	100000000	24001500
-	IO	count	delay total
-		0	0
-	SWAP	count	delay total
-		0	0
-	RECLAIM	count	delay total
-		0	0
-
-获取指定简单命令运行时的延时信息::
-
-  # ./getdelays -c ls /
-
-  bin   data1  data3  data5  dev  home  media  opt   root  srv        sys  usr
-  boot  data2  data4  data6  etc  lib   mnt    proc  sbin  subdomain  tmp  var
-
-
-  CPU	count	real total	virtual total	delay total
-	6	4000250		4000000		0
-  IO	count	delay total
-	0	0
-  SWAP	count	delay total
-	0	0
-  RECLAIM	count	delay total
-	0	0
+	# ./getdelays -d -t 5
+	print delayacct stats ON
+	TGID	5
+
+
+	CPU             count     real total  virtual total    delay total  delay average
+	                    8        7000000        6872122        3382277          0.423ms
+	IO              count    delay total  delay average
+	                    0              0              0ms
+	SWAP            count    delay total  delay average
+	                    0              0              0ms
+	RECLAIM         count    delay total  delay average
+	                    0              0              0ms
+	THRASHING       count    delay total  delay average
+	                    0              0              0ms
+	COMPACT         count    delay total  delay average
+	                    0              0              0ms
+
+获取pid为1的IO计数，它只和-p一起使用::
+	# ./getdelays -i -p 1
+	printing IO accounting
+	linuxrc: read=65536, write=0, cancelled_write=0
+
+上面的命令与-v一起使用，可以获取更多调试信息。
-- 
2.7.4

