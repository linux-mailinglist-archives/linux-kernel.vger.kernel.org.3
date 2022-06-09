Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC455458BC
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 01:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345329AbiFIXlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 19:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238141AbiFIXld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 19:41:33 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 813EE24D6AF
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 16:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1654818086;
        bh=Rl9WrMgBIa/yI1Mcm82IC1znT+c2KjvFsK4cEWVrTp0=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=AzznsniZIMOvcSyeh3GFojvoMPEQeBJdv/qrsKya71LTllehjVOhT9RksM8fHTJJJ
         HYip+ebRgIHv8sj2KlAYnmqZjfWUkFw2sw1vLV+chxkybQ3Zvhi6wJ+tAncJ6z1tfI
         r3ZtjrwfqRbuiE1bHJC21/J9Tdz04608CqJvW6qI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.195.3]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mg6dy-1nXHlg2wmc-00he9L; Fri, 10
 Jun 2022 01:41:26 +0200
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-kernel@vger.kernel.org
Cc:     trivial@kernel.org,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [PATCH RESEND] workqueue: Switch to new kerneldoc syntax for named variable macro argument
Date:   Fri, 10 Jun 2022 01:41:10 +0200
Message-Id: <20220609234111.226879-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WDhYrFq0Di5EhwsWXsbXT1hGJtkbYXMcCCLlTiWJAU/aSCsxHiP
 EJA/alH/aNZBGHDlbnT8CQV/laiYaFdJw7UxY76T+N/oSIOneO+vRvWtS1xmeBDS2JFcKRc
 fKqujLUguJ8OxFRjb6ACXsGrsx1iqkfTu2nhqhZKzsAwSwH+30JPDNEePXgLAjcgQjq7AN4
 KvfTTljYaSQ8i/0CUZD4w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0TB8WP92lGo=:itar347bhBe/SQmBhRYxkv
 58W0/DVrxJ7xzLvNq37Qd0mgFxjVhulBu5Ezzr7RkL3ILvhhNN1+PE2Wopn51PBTb/xLsVoFK
 Sh7+NQl23M88pSvVF1kB3f6hyGsI3pq6EdJUj8uMG8vfQ/4JhILNXw5h2PR4p1FcUe9TClqM4
 I/MIceojcVlw6Plfx/Bh/Q5r+Np0NCr9M30GOV0cCECJzROLNd/0l0Xzr2kLhxGMdk4VmdtGV
 lQ3Ol2A2levpfoQePd8Y5RJVROMdqI4EagMRuIE3kv11qow+v7rqd8zAtAvkyxMOPl+MjxSsr
 9rjcXa+beBNS7LKTNwLk7+AhspuX0fFmY+hingeNezSoovYCa7nYW1VBNK52nEkMz9qmKz/RJ
 lt2Ea1YlEFBNpxSdJL2KLfpNaGIEI073eVOna6AVznaFsk/g3o4iVWdCk+YVYdLFBStMEnhPd
 8WDtOG2bUQa9872rSK3TtYiSdCJuONhpcJePbf/ty96FTmOV6lh3+FIoM5c4HnYTNQXnVRUE4
 WUvZk3nqIavkvke/L/IFJVqMring790lkmjbHOhfd48pSm8GNCC5m4+fjRva+Nk0fBVGsw9di
 wAgzYd9enOcLbu3gKbVB/TLjfT6JItzYKDvLmPNACRoRrylvp0L1FLXYtG2iY4rxGCMW2Ohsw
 aeR2i1Yc7nFcujk5qdAvMARUsnXFhdrFz0LoNlVJ5ATUWw0ccmQsfeTmNsJnfCzy58bnAaSJR
 JlZ46Jmj6w2xWHV4o/5olQ/C7NnKa9/+fvTZgJ6OQ1W8iZxJP2XZL0DkNh+I0eeSp/PVbKpzM
 H987cwsdkTeBt2bRjx+OOVTTbg30bP6JOXfdUr383zJ8xKmA497BjBcuGCEQ5OWpre/xK75Qe
 81chW7O6RSNbeg1w6s+zAFNTbzH9nnmpMwI5zDhx1348q+buYzW0l3XL4hwUBRkRNmY3joZ27
 jJnetPCYCYPG1jauQ+vY0Qk+3WI4wl2djuhhvDsAYn0NsV7iqULrgOJoceaAZXiXXy0kKGrmx
 Yx0Sv9Ts2FukYsL/HWLlG5xbRkdn0sNFxQEn6GM2v6PBy3c6m4ZnM3CSoTnKmMEmEs0QE4xR2
 Nc0nPA1KQyUd+nx221cTZ/pEisW0lt80fiU/iGVL0IICYF53m3V/KD4XA==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The syntax without dots is available since commit 43756e347f21
("scripts/kernel-doc: Add support for named variable macro arguments").

The same HTML output is produced with and without this patch.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
Acked-by: Tejun Heo <tj@kernel.org>
=2D--
Previous copy:
- https://lore.kernel.org/lkml/20210320182829.688032-1-j.neuschaefer@gmx.n=
et/
=2D--
 include/linux/workqueue.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index d15a7730ee18b..83a51c5100e68 100644
=2D-- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -412,7 +412,7 @@ struct workqueue_struct *alloc_workqueue(const char *f=
mt,
  * alloc_ordered_workqueue - allocate an ordered workqueue
  * @fmt: printf format for the name of the workqueue
  * @flags: WQ_* flags (only WQ_FREEZABLE and WQ_MEM_RECLAIM are meaningfu=
l)
- * @args...: args for @fmt
+ * @args: args for @fmt
  *
  * Allocate an ordered workqueue.  An ordered workqueue executes at
  * most one work item at any given time in the queued order.  They are
=2D-
2.30.1

