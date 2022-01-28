Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3F5149F883
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 12:42:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348183AbiA1Lm5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 06:42:57 -0500
Received: from mail.loongson.cn ([114.242.206.163]:40642 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237846AbiA1Lml (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 06:42:41 -0500
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dxb+Kh1vNhREgFAA--.17556S4;
        Fri, 28 Jan 2022 19:42:27 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Baoquan He <bhe@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Marco Elver <elver@google.com>
Cc:     kexec@lists.infradead.org, linux-doc@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] docs: kdump: add scp sample to write out the dump file
Date:   Fri, 28 Jan 2022 19:42:22 +0800
Message-Id: <1643370145-26831-3-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1643370145-26831-1-git-send-email-yangtiezhu@loongson.cn>
References: <1643370145-26831-1-git-send-email-yangtiezhu@loongson.cn>
X-CM-TRANSID: AQAAf9Dxb+Kh1vNhREgFAA--.17556S4
X-Coremail-Antispam: 1UD129KBjvdXoWrKFyktrW7AFW5ur4kuF18AFb_yoW3tFg_Ka
        97WF4kXF17J340qr17tFWDZF1fZw45uayF9rs7Jr4UA3y3Xan8JFyvvFyDAFyUWFnY9ryf
        Wa95XryxArnFgjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbqxYjsxI4VWxJwAYFVCjjxCrM7AC8VAFwI0_Wr0E3s1l1xkIjI8I
        6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7
        IE14v26r15M28IrcIa0xkI8VCY1x0267AKxVW8JVW5JwA2ocxC64kIII0Yj41l84x0c7CE
        w4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6x
        kF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF
        7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F4
        0Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC
        6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc2xSY4
        AK67AK6r4kMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
        rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8Zw
        CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x02
        67AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
        0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0du
        ctUUUUU==
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Except cp and makedumpfile, add scp sample to write out the dump file.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 Documentation/admin-guide/kdump/kdump.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/admin-guide/kdump/kdump.rst b/Documentation/admin-guide/kdump/kdump.rst
index d187df2..a748e7e 100644
--- a/Documentation/admin-guide/kdump/kdump.rst
+++ b/Documentation/admin-guide/kdump/kdump.rst
@@ -533,6 +533,10 @@ the following command::
 
    cp /proc/vmcore <dump-file>
 
+or use scp to write out the dump file between hosts on a network, e.g::
+
+   scp /proc/vmcore remote_username@remote_ip:<dump-file>
+
 You can also use makedumpfile utility to write out the dump file
 with specified options to filter out unwanted contents, e.g::
 
-- 
2.1.0

