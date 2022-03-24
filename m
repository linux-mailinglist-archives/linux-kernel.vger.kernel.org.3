Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0C834E5F5C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 08:27:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348557AbiCXH3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 03:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348545AbiCXH26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 03:28:58 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 535BD98F72;
        Thu, 24 Mar 2022 00:27:26 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id r13so7333474ejd.5;
        Thu, 24 Mar 2022 00:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DAtToKdRS0zfVnS9HsS764HRko9yvlBX55xZExohPhI=;
        b=C6lJsHb8Ua0B3vszq3ZlSFp9A0YBsRu9mnPk11EG7gZ5v2ngkVTwYI0taNDgJ6TmSa
         P0kDVWF8XQXNiCf0UyYcyjxP6TBoiIhyAd7oqVX9x1SljitbUDhQj5EtqhMYTZoELhXw
         xqVGut7ZTcGZsXS+i766X1z/fvbknrRYjEB3M+I0A2r8roRNYNM9Hxz3W8vnOtcKa0Ix
         rsHea1vzuwan96vBib/nt9fQnGGAX7nbxYinnmRMOFfXLNXJUktv5hImOdi5IDyDSEE0
         zFDHnsLtsG5xnJlcSA841GkOzmy7xKm/+xj4QEdIsKQWgKYIzh5aCRagdPc/60OLni1/
         c5Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DAtToKdRS0zfVnS9HsS764HRko9yvlBX55xZExohPhI=;
        b=Y6KWRLv3rY9MNW22ffM2NKwq5onszNOgp1uGuR+6dgGxlfys7f158+jFGgyovBMq1v
         GZtWx76SWQZuqw98fs6UI/lBdzwvDGik55K4iziGlpGzOHiHce7INCsRMkWYS2jxT+f6
         RfHvohZntLob0KwYWALSy67M117lgzLTQwZmkm9dY1psJA7NmslXgOh8gZQh/6DOuK3b
         VHoFuF6dG8hMHfdO/ae89YxeOCrBgyJFNcXVA8YZE3RxjYzEDCe2YXYFY85msODUR/06
         neUKOt7S5UyTHzArZ7A3H22d1TRbmKkGBknMh+1F5hbY1yDOJrcjTTnx+071nVV1pYrE
         dAvw==
X-Gm-Message-State: AOAM531LqIOGauFICWIE9ytkZ7fHcECLR8bu+r+mWFjpep4b8oqAN5TL
        C0vwyBQXFq29euVX56mZJK0=
X-Google-Smtp-Source: ABdhPJxuy5OwcuHiwxx2kTj53MTVWm9l1g6mMZIh4t6sVXn4V2Xfgcu+l/18CgkvNOWvM0cQGtuioQ==
X-Received: by 2002:a17:906:c091:b0:6db:62b6:f4cc with SMTP id f17-20020a170906c09100b006db62b6f4ccmr4249141ejz.607.1648106844690;
        Thu, 24 Mar 2022 00:27:24 -0700 (PDT)
Received: from localhost.localdomain (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id d7-20020a50cd47000000b004187eacb4d6sm1031270edj.37.2022.03.24.00.27.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 00:27:24 -0700 (PDT)
From:   Jakob Koschel <jakobkoschel@gmail.com>
To:     Andreas Noever <andreas.noever@gmail.com>
Cc:     Michael Jamet <michael.jamet@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@kernel.org>,
        "Brian Johannesmeyer" <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>, Jakob Koschel <jakobkoschel@gmail.com>
Subject: [PATCH] thunderbolt: replace usage of found with dedicated list iterator variable
Date:   Thu, 24 Mar 2022 08:27:00 +0100
Message-Id: <20220324072700.63787-1-jakobkoschel@gmail.com>
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
 drivers/thunderbolt/ctl.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/thunderbolt/ctl.c b/drivers/thunderbolt/ctl.c
index 4986edfbdf67..e92c658dba1c 100644
--- a/drivers/thunderbolt/ctl.c
+++ b/drivers/thunderbolt/ctl.c
@@ -158,21 +158,20 @@ static bool tb_cfg_request_is_active(struct tb_cfg_request *req)
 static struct tb_cfg_request *
 tb_cfg_request_find(struct tb_ctl *ctl, struct ctl_pkg *pkg)
 {
-	struct tb_cfg_request *req;
-	bool found = false;
+	struct tb_cfg_request *req = NULL, *iter;
 
 	mutex_lock(&pkg->ctl->request_queue_lock);
-	list_for_each_entry(req, &pkg->ctl->request_queue, list) {
-		tb_cfg_request_get(req);
-		if (req->match(req, pkg)) {
-			found = true;
+	list_for_each_entry(iter, &pkg->ctl->request_queue, list) {
+		tb_cfg_request_get(iter);
+		if (iter->match(iter, pkg)) {
+			req = iter;
 			break;
 		}
-		tb_cfg_request_put(req);
+		tb_cfg_request_put(iter);
 	}
 	mutex_unlock(&pkg->ctl->request_queue_lock);
 
-	return found ? req : NULL;
+	return req;
 }
 
 /* utility functions */

base-commit: f443e374ae131c168a065ea1748feac6b2e76613
-- 
2.25.1

