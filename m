Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8A254E5F3E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 08:21:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348484AbiCXHWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 03:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242373AbiCXHWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 03:22:44 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ADAD986F9;
        Thu, 24 Mar 2022 00:21:13 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id r13so7309255ejd.5;
        Thu, 24 Mar 2022 00:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L8t/rxY8yvEceEcSHYnXjymDX7m07BTfnPsMbsacLCE=;
        b=Td6lnLH/iruIZ4mx+aAqQafW+QnS0cKUyBO9/9JyZRZK0RKswmoPiW+EHpBnzYMBll
         jgqss9CUEHP+ky5KHFkHEkoh1/JBQD1+I6PxPbp1vGK90mriH7Y3dsR7wgo+y59C93hQ
         s9xi3SjjPw9Si53jEekr8kdc2jKrl5rkTg31PN65vsWSlNZZMElgVNWVJcDdh8r8Jyak
         vvlRWRKgTSQF7YSACyI2zgQxpqxiAqr9CXA9ek8kqCEahUBnqEhjj92Ddd2wF25Pqn2M
         tQ/N8jFGOqAaerJ4zgoQDg2D5iI4BxFmjfoAMp1QT0nHTBJ6YTKpPMYRF5zt/T2fAIa3
         rg8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L8t/rxY8yvEceEcSHYnXjymDX7m07BTfnPsMbsacLCE=;
        b=UDcLumBCgnc2lmc5bsOc/ZtXfE4aT0nW+d2qlKxVWIbo8orjc643xpdjJa72YWkKpX
         nIqNplXMYGdqJHFE99oHu9V3bic2WfkuTi6w9NUBzhnj2lwk/WlMbeafXvOA2JbirpPB
         6a5ZSaMlNPQzWcicIWvu0RpMyyMG9CQUrvRC7msHt3sXjixBfyhwuWS9teyKGy6K6o5v
         S9nhwN9wIGF6REbtIwh3LIUk18nOlnecUtZb45rZoCujI+2AlJdQpniBjxPu9ns2xB/U
         3A4eX9iJ/Yqn+A3OPtFKqX8lVN5j9aNdmHs9QRjMOcyAxg8mShQERMRZLY4SoBueCOeH
         gG0w==
X-Gm-Message-State: AOAM530owdbqazicQJiBm82OeNRWoz2CmALcQGDqb16Xzy73lm5ZiUim
        2l3fUGPmma3wR7yCOyifNxE=
X-Google-Smtp-Source: ABdhPJx6LGoPkFEFkoaZyd3WBwpMSKmhSaujWAgVjTGkfEJZBG+4bfYn+4vbts3FB+vBfIrYJ+UHfw==
X-Received: by 2002:a17:906:3ad1:b0:6ce:a880:7745 with SMTP id z17-20020a1709063ad100b006cea8807745mr4221888ejd.46.1648106472018;
        Thu, 24 Mar 2022 00:21:12 -0700 (PDT)
Received: from localhost.localdomain (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id m4-20020a17090672c400b006e0035654b0sm780758ejl.84.2022.03.24.00.21.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 00:21:11 -0700 (PDT)
From:   Jakob Koschel <jakobkoschel@gmail.com>
To:     Ilya Dryomov <idryomov@gmail.com>
Cc:     Dongsheng Yang <dongsheng.yang@easystack.cn>,
        Jens Axboe <axboe@kernel.dk>, ceph-devel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@kernel.org>,
        "Brian Johannesmeyer" <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>, Jakob Koschel <jakobkoschel@gmail.com>
Subject: [PATCH] rbd: replace usage of found with dedicated list iterator variable
Date:   Thu, 24 Mar 2022 08:20:50 +0100
Message-Id: <20220324072050.62242-1-jakobkoschel@gmail.com>
X-Mailer: git-send-email 2.25.1
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

To move the list iterator variable into the list_for_each_entry_*()
macro in the future it should be avoided to use the list iterator
variable after the loop body.

To *never* use the list iterator variable after the loop it was
concluded to use a separate iterator variable instead of a
found boolean [1].

This removes the need to use a found variable and simply checking if
the variable was set, can determine if the break/goto was hit.

Link: https://lore.kernel.org/all/CAHk-=wgRr_D8CB-D9Kg-c=EHreAsk5SqXPwr9Y7k9sA6cWXJ6w@mail.gmail.com/
Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
---
 drivers/block/rbd.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index b844432bad20..e5f891d058e8 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -756,24 +756,23 @@ static struct rbd_client *__rbd_get_client(struct rbd_client *rbdc)
  */
 static struct rbd_client *rbd_client_find(struct ceph_options *ceph_opts)
 {
-	struct rbd_client *client_node;
-	bool found = false;
+	struct rbd_client *client_node = NULL, *iter;
 
 	if (ceph_opts->flags & CEPH_OPT_NOSHARE)
 		return NULL;
 
 	spin_lock(&rbd_client_list_lock);
-	list_for_each_entry(client_node, &rbd_client_list, node) {
-		if (!ceph_compare_options(ceph_opts, client_node->client)) {
-			__rbd_get_client(client_node);
+	list_for_each_entry(iter, &rbd_client_list, node) {
+		if (!ceph_compare_options(ceph_opts, iter->client)) {
+			__rbd_get_client(iter);
 
-			found = true;
+			client_node = iter;
 			break;
 		}
 	}
 	spin_unlock(&rbd_client_list_lock);
 
-	return found ? client_node : NULL;
+	return client_node;
 }
 
 /*

base-commit: f443e374ae131c168a065ea1748feac6b2e76613
-- 
2.25.1

