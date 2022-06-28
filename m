Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3BBC55D817
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:19:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344533AbiF1Jrl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 05:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344324AbiF1Jqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 05:46:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8040425C76;
        Tue, 28 Jun 2022 02:46:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CB98DB81D98;
        Tue, 28 Jun 2022 09:46:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71C7DC341E9;
        Tue, 28 Jun 2022 09:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656409590;
        bh=lh6o/QFPtVGrO1ZYX3PjI7UAR4mnHtfCksAmlyGH4Z0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g0TTrjSTKMtxLlo0c0qbNEDt5h7tfXmjrOPlCioBph0Q3Clxqg5W3k0D74JiDGVl6
         A6QC2NeDyEg8wLQzcPvnwzmQtkS8PaC5yODnbPogbGVA33BARCCW2vXa7WeBabj1DH
         b4S+oMCu2pQ2XwDZlt29QztuJ0rvPzzqRm5/SFjL5lvTfxYYGGkJ0bL5arOrBQ3NvY
         QqOqFmsX+zviJUWFpvdmrpwh9XscBs8BIbSsOQ4d9zdcMZhBY1AGYGJTUwmMCbtcZS
         FsMtMP3H4EerCmVVnZpbVS0My5r57HN8R4fv3zXxMJagGqEqFkZX8GZLGlCvhe3T9m
         ujZqMN04z1z1g==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1o67ng-005HFq-0w;
        Tue, 28 Jun 2022 10:46:28 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [PATCH 20/22] usb: typec_altmode: add a missing "@" at a kernel-doc parameter
Date:   Tue, 28 Jun 2022 10:46:24 +0100
Message-Id: <70dc4c5d744cf1fe9a0efe6b85deaa0489628282.1656409369.git.mchehab@kernel.org>
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

Without that, the parameter is not properly parsed:
	include/linux/usb/typec_altmode.h:132: warning: Function parameter or member 'altmode' not described in 'typec_altmode_get_orientation'

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH 00/22] at: https://lore.kernel.org/all/cover.1656409369.git.mchehab@kernel.org/

 include/linux/usb/typec_altmode.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/usb/typec_altmode.h b/include/linux/usb/typec_altmode.h
index 65933cbe9129..350d49012659 100644
--- a/include/linux/usb/typec_altmode.h
+++ b/include/linux/usb/typec_altmode.h
@@ -124,7 +124,7 @@ struct typec_altmode *typec_match_altmode(struct typec_altmode **altmodes,
 
 /**
  * typec_altmode_get_orientation - Get cable plug orientation
- * altmode: Handle to the alternate mode
+ * @altmode: Handle to the alternate mode
  */
 static inline enum typec_orientation
 typec_altmode_get_orientation(struct typec_altmode *altmode)
-- 
2.36.1

