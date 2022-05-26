Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70431534B0E
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 09:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346517AbiEZH7r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 03:59:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232951AbiEZH7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 03:59:43 -0400
Received: from gofer.mess.org (gofer.mess.org [IPv6:2a02:8011:d000:212::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F3883153F;
        Thu, 26 May 2022 00:59:42 -0700 (PDT)
Received: by gofer.mess.org (Postfix, from userid 1000)
        id 8C044101CFB; Thu, 26 May 2022 08:59:40 +0100 (BST)
Date:   Thu, 26 May 2022 08:59:40 +0100
From:   Sean Young <sean@mess.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        linux-media@vger.kernel.org
Subject: [PATCH] media: lirc: add missing exceptions for lirc uapi header file
Message-ID: <Yo8zbIJuceliqWfi@gofer.mess.org>
References: <20220526172154.23853e1c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220526172154.23853e1c@canb.auug.org.au>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit e5499dd7253c ("media: lirc: revert removal of unused feature flags")
reintroduced unused feature flags in the lirc uapi header, but failed to
reintroduce the necessary exceptions for the docs.

Fixes: e5499dd7253c ("media: lirc: revert removal of unused feature flags")
Signed-off-by: Sean Young <sean@mess.org>
---
 Documentation/userspace-api/media/lirc.h.rst.exceptions | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/userspace-api/media/lirc.h.rst.exceptions b/Documentation/userspace-api/media/lirc.h.rst.exceptions
index 913d17b49831..1aeb7d7afe13 100644
--- a/Documentation/userspace-api/media/lirc.h.rst.exceptions
+++ b/Documentation/userspace-api/media/lirc.h.rst.exceptions
@@ -30,6 +30,8 @@ ignore define LIRC_CAN_REC
 
 ignore define LIRC_CAN_SEND_MASK
 ignore define LIRC_CAN_REC_MASK
+ignore define LIRC_CAN_SET_REC_FILTER
+ignore define LIRC_CAN_NOTIFY_DECODE
 
 # Obsolete ioctls
 
-- 
2.36.1

