Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDFB0478985
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 12:10:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235259AbhLQLKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 06:10:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233227AbhLQLK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 06:10:29 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 912CBC061574;
        Fri, 17 Dec 2021 03:10:29 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id o17so2199932qtk.1;
        Fri, 17 Dec 2021 03:10:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pDyfTSH1efSZfDvPOs/4NwMG0xFq4708hQD2eV23YQs=;
        b=DyP9IqJhRDnwNLEysfHixKNa+aHFxymYUFZziDSjYPwLynB372764OHJnoiU+Yq9Wo
         PGC9Ug28y/dOzGmbH0XgsMIpcJVuQydnNPQH9QLAj2Q16zcC5bN4Op6oW+3tMIaN+e1P
         shC0eNlIBKOjkG8iRyu1VpWV4EU4Ka43eW2oS9y20tO3wjTDUlSKSTr1WUK4ivr01cXf
         oxczJ3YtKzuujq0rioR8jwEBX34rxOt/jAbPeN9z9XIULAiRTlMjtCfM4Xgcu+bEckie
         vAzPYl5b3/QEokXorhiUdTgAzWm36Jez3eWaXUqRpNZKZyCKda8q/It9OZyEHbMJ1H7I
         +GIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pDyfTSH1efSZfDvPOs/4NwMG0xFq4708hQD2eV23YQs=;
        b=JvZYjPkshE9LSglebd32MbxULNBWYQM/M/pF+Y6e4qLblmpfNzKdyiLmCvhLXMYwof
         OJF11gHnwCO806G4H65X1PpHSrwFj8FjPe3ZlO3BjP/OV2spiy+b8YGvQztpK7JokWmZ
         P9pUXXpeh5y3ng85NsnzOFsa9q0y9SAQ59z9WFh1GxGoY4zgP0z6vhRqcjkw140ir4+v
         CvZ5IbLu5/yMsSGtbslFvwNd4YyDumFiplRIXVcSfi2QLJYg8l1v4ur+q4F3dplCySV3
         2e7gD8Y2dz3GzIIXMVrvlPKWoCc80EqID/3VzUQyaqtyUhmZSlJ6j/1Sm6qE0xTSTaPn
         4FwQ==
X-Gm-Message-State: AOAM532cwOaisHyaw09r5T6LjUtc2gSR1vVyLviVKP0zb6v+T7by17Fd
        1FIHOTa/I86X15QoQfkpBBA=
X-Google-Smtp-Source: ABdhPJy9es42kS1v95G8dheZ0wFtI1qMAQyX5PdTiEmErsKdSm1InTdqmubgW/WsiCIKcMMuixlLZQ==
X-Received: by 2002:a05:622a:1898:: with SMTP id v24mr1811547qtc.508.1639739428670;
        Fri, 17 Dec 2021 03:10:28 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id x15sm4478381qko.82.2021.12.17.03.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Dec 2021 03:10:28 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: yang.yang29@zte.com.cn
To:     alexs@kernel.org, corbet@lwn.net, siyanteng@loongson.cn,
        seakeel@gmail.com
Cc:     yang.yang29@zte.com.cn, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4] docs/zh_CN: Add zh_CN/accounting/delay-accounting.rst
Date:   Fri, 17 Dec 2021 11:09:50 +0000
Message-Id: <20211217110949.453361-1-yang.yang29@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yang Yang <yang.yang29@zte.com.cn>

Add translation zh_CN/accounting/delay-accounting.rst and links it
to zh_CN/accounting/index.rst while clean its todo entry.

Signed-off-by: Yang Yang <yang.yang29@zte.com.cn>
Reviewed-by: Alex Shi <alexs@kernel.org>
Reviewed-by: Yanteng Si <siyanteng@loongson.cn>
---
v4:
- removed excess RST label.
v3:
- add missing period.
v2:
- delete useless blackline.
---
 .../zh_CN/accounting/delay-accounting.rst     | 111 ++++++++++++++++++
 .../translations/zh_CN/accounting/index.rst   |   2 +-
 2 files changed, 112 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/translations/zh_CN/accounting/delay-accounting.rst

diff --git a/Documentation/translations/zh_CN/accounting/delay-accounting.rst b/Documentation/translations/zh_CN/accounting/delay-accounting.rst
new file mode 100644
index 000000000000..67d5606e5401
--- /dev/null
+++ b/Documentation/translations/zh_CN/accounting/delay-accounting.rst
@@ -0,0 +1,111 @@
+.. include:: ../disclaimer-zh_CN.rst
+
+:Original: Documentation/accounting/delay-accounting.rst
+
+:Translator: Yang Yang <yang.yang29@zte.com.cn>
+
+========
+延时计数
+========
+
+任务在等待某些内核资源可用时，会造成延时。例如一个可运行的任务可能会等待
+一个空闲CPU来运行。
+
+基于每任务的延时计数功能度量由以下情况造成的任务延时：
+
+a) 等待一个CPU（任务为可运行）
+b) 完成由该任务发起的块I/O同步请求
+c) 页面交换
+d) 内存回收
+
+并将这些统计信息通过taskstats接口提供给用户空间。
+
+这些延时信息为适当的调整任务CPU优先级、io优先级、rss限制提供反馈。重要任务
+长期延时，表示可能需要提高其相关优先级。
+
+通过使用taskstats接口，本功能还可提供一个线程组（对应传统Unix进程）所有任务
+（或线程）的总延时统计信息。此类汇总往往是需要的，由内核来完成更加高效。
+
+用户空间的实体，特别是资源管理程序，可将延时统计信息汇总到任意组中。为实现
+这一点，任务的延时统计信息在其生命周期内和退出时皆可获取，从而确保可进行
+连续、完整的监控。
+
+接口
+----
+
+延时计数使用taskstats接口，该接口由本目录另一个单独的文档详细描述。Taskstats
+向用户态返回一个通用数据结构，对应每pid或每tgid的统计信息。延时计数功能填写
+该数据结构的特定字段。见
+
+     include/linux/taskstats.h
+
+其描述了延时计数相关字段。系统通常以计数器形式返回 CPU、同步块 I/O、交换、内存
+回收等的累积延时。
+
+取任务某计数器两个连续读数的差值，将得到任务在该时间间隔内等待对应资源的总延时。
+
+当任务退出时，内核会将包含每任务的统计信息发送给用户空间，而无需额外的命令。
+若其为线程组最后一个退出的任务，内核还会发送每tgid的统计信息。更多详细信息见
+taskstats接口的描述。
+
+tools/accounting目录中的用户空间程序getdelays.c提供了一些简单的命令，用以显示
+延时统计信息。其也是使用taskstats接口的示例。
+
+用法
+----
+
+使用以下配置编译内核::
+
+	CONFIG_TASK_DELAY_ACCT=y
+	CONFIG_TASKSTATS=y
+
+延时计数在启动时默认关闭。
+若需开启，在启动参数中增加::
+
+   delayacct
+
+本文后续的说明基于延时计数已开启。也可在系统运行时，使用sysctl的
+kernel.task_delayacct进行开关。注意，只有在启用延时计数后启动的
+任务才会有相关信息。
+
+系统启动后，使用类似getdelays.c的工具获取任务或线程组（tgid）的延时信息。
+
+getdelays命令的一般格式::
+
+	getdelays [-t tgid] [-p pid] [-c cmd...]
+
+获取pid为10的任务从系统启动后的延时信息::
+
+	# ./getdelays -p 10
+	（输出信息和下例相似）
+
+获取所有tgid为5的任务从系统启动后的总延时信息::
+
+	# ./getdelays -t 5
+
+
+	CPU	count	real total	virtual total	delay total
+		7876	92005750	100000000	24001500
+	IO	count	delay total
+		0	0
+	SWAP	count	delay total
+		0	0
+	RECLAIM	count	delay total
+		0	0
+
+获取指定简单命令运行时的延时信息::
+
+  # ./getdelays -c ls /
+
+  bin   data1  data3  data5  dev  home  media  opt   root  srv        sys  usr
+  boot  data2  data4  data6  etc  lib   mnt    proc  sbin  subdomain  tmp  var
+
+
+  CPU	count	real total	virtual total	delay total
+	6	4000250		4000000		0
+  IO	count	delay total
+	0	0
+  SWAP	count	delay total
+	0	0
+  RECLAIM	count	delay total
+	0	0
diff --git a/Documentation/translations/zh_CN/accounting/index.rst b/Documentation/translations/zh_CN/accounting/index.rst
index 124b590fb01b..a34952e12a27 100644
--- a/Documentation/translations/zh_CN/accounting/index.rst
+++ b/Documentation/translations/zh_CN/accounting/index.rst
@@ -15,11 +15,11 @@
 .. toctree::
    :maxdepth: 1
 
+   delay-accounting
    psi
    taskstats
 
 Todolist:
 
    cgroupstats
-   delay-accounting
    taskstats-struct
-- 
2.25.1
