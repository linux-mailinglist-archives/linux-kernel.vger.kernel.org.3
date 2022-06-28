Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8DE755D0C1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344460AbiF1JrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 05:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344310AbiF1Jqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 05:46:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 786E925C5C;
        Tue, 28 Jun 2022 02:46:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0C787B81D91;
        Tue, 28 Jun 2022 09:46:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B33FC341CF;
        Tue, 28 Jun 2022 09:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656409590;
        bh=ahdzpqYwi4rLbemhWXEKhNIrYuQYS6uMQzIKxHuMXDI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QZezjzuKXXhgx44O2x6Iw9Zlvv+iyQpkIIikfCvEF04mzxQzxUmZ2pQ2lB1c40Yjm
         CSx2AhNwnfnTAq/7DFWRNer1u9QpCcZOnbQ5AMTmndeDI92/NvdP5nRinbDBed3L40
         GhhJtO4SZUHv7Sjr23/dUinep0hVB1mXT+yX8Q3sjLOqyZznWW1e+x3zjAEjY1NfTF
         MYtbwNf1xh/wLXQ6+Xi3yWfFBKrBb6E8YTZyGQ1+isbvaa4tYLFTsrjmTWjSn96bio
         Z7GrwsrEp5X+wsOJy1cRGubqbSXH2jTZ5MVqJtJhB5jSLaNna7iojFuEeL+GiiJIIi
         apcptWz+9DvPA==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1o67nf-005HF7-PD;
        Tue, 28 Jun 2022 10:46:27 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH 08/22] devfreq: shut up kernel-doc warnings
Date:   Tue, 28 Jun 2022 10:46:12 +0100
Message-Id: <6a15081e17d78e914526c315d5bb53ea575edf90.1656409369.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1656409369.git.mchehab@kernel.org>
References: <cover.1656409369.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are 4 warnings there:
	drivers/devfreq/devfreq.c:707: warning: Function parameter or member 'val' not described in 'qos_min_notifier_call'
	drivers/devfreq/devfreq.c:707: warning: Function parameter or member 'ptr' not described in 'qos_min_notifier_call'
	drivers/devfreq/devfreq.c:717: warning: Function parameter or member 'val' not described in 'qos_max_notifier_call'
	drivers/devfreq/devfreq.c:717: warning: Function parameter or member 'ptr' not described in 'qos_max_notifier_call'

It turns that neither val nor ptr are actually used on those
function, so document as such.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH 00/22] at: https://lore.kernel.org/all/cover.1656409369.git.mchehab@kernel.org/

 drivers/devfreq/devfreq.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 01474daf4548..3020855d8400 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -700,6 +700,8 @@ static int qos_notifier_call(struct devfreq *devfreq)
 /**
  * qos_min_notifier_call() - Callback for QoS min_freq changes.
  * @nb:		Should be devfreq->nb_min
+ * @val:	not used
+ * @ptr:	not used
  */
 static int qos_min_notifier_call(struct notifier_block *nb,
 					 unsigned long val, void *ptr)
@@ -710,6 +712,8 @@ static int qos_min_notifier_call(struct notifier_block *nb,
 /**
  * qos_max_notifier_call() - Callback for QoS max_freq changes.
  * @nb:		Should be devfreq->nb_max
+ * @val:	not used
+ * @ptr:	not used
  */
 static int qos_max_notifier_call(struct notifier_block *nb,
 					 unsigned long val, void *ptr)
-- 
2.36.1

