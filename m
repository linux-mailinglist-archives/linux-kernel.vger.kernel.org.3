Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0904B5ACB1D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 08:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237022AbiIEGge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 02:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236435AbiIEGgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 02:36:08 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 085EF274;
        Sun,  4 Sep 2022 23:35:40 -0700 (PDT)
Received: from linux.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxT+C3mBVjZYsRAA--.7569S2;
        Mon, 05 Sep 2022 14:35:36 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     ceph-devel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ceph, docs: Remove Sage's git tree
Date:   Mon,  5 Sep 2022 14:35:35 +0800
Message-Id: <1662359735-18320-1-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf8CxT+C3mBVjZYsRAA--.7569S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtFWxXFWkKF4fZw48KryfJFb_yoWfAFbEvr
        Z7JF4kJFW5AryxGa4kCF45WF47Zw48CF18A3Z5Jry8C343t3yDJFyqqr9FyF45XrWI9r9x
        AFZxXr9IqF12kjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb7kYjsxI4VWDJwAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I
        6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
        8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0
        cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I
        8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
        64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVW8JVWxJw
        Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc2xSY4AK67AK6r47MxAIw28I
        cxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2
        IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI
        42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42
        IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280
        aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU4PrcDUUUU
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sage's git tree has not been pushed to in years, and it was removed in
commit 3a5ccecd9af7 ("MAINTAINERS: remove myself as ceph co-maintainer"),
so it is better to remove it in the documentation too.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 Documentation/filesystems/ceph.rst | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/filesystems/ceph.rst b/Documentation/filesystems/ceph.rst
index 4942e01..76ce938 100644
--- a/Documentation/filesystems/ceph.rst
+++ b/Documentation/filesystems/ceph.rst
@@ -203,7 +203,6 @@ For more information on Ceph, see the home page at
 
 The Linux kernel client source tree is available at
 	- https://github.com/ceph/ceph-client.git
-	- git://git.kernel.org/pub/scm/linux/kernel/git/sage/ceph-client.git
 
 and the source for the full system is at
 	https://github.com/ceph/ceph.git
-- 
2.1.0

