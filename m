Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D66A7552C13
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 09:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347267AbiFUHa4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 03:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347526AbiFUHaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 03:30:21 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62B85248F5;
        Tue, 21 Jun 2022 00:29:28 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d17so3342344pfq.9;
        Tue, 21 Jun 2022 00:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SeQa+wrODZcFHBRh9tXKTMZZ67C9LDi6PMYsp4W5ugc=;
        b=fCsDF89i8RkubqktqLjrS+Ri0NGGpj23A2NPIMrwWV4MIQ837xA67Gain7vRUKJFOR
         N2PFM7GUsAR/Qd5otlUubXDWw0QPr6oz/4enHe3CuBTB35GrdIN55qnfL/jyR0HMpL0J
         VsqDgxR3QZf+ZSUcWO5RL7w1Z31KlXipPPKBDtJCjcfxo9OPeA2/rskOOSqAGcEZeFkF
         0e7oC/o/BQll3UQ+0q2lJ9FnKYdwi+jO7dgpU8IjhYfsvA4BVB3KuRkHErA9oDnQsDVh
         4ih+tBOhRMxzWJRbGIQElXsDEdEIeWE92OXJuBa1AnaZvrdXoqUsztwPVCTSnW5GZ4E7
         xL7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SeQa+wrODZcFHBRh9tXKTMZZ67C9LDi6PMYsp4W5ugc=;
        b=Zd0XWhNdV3rrvAyFC4dTZCJmDFldTbn3juRJhPtRzR2DNXYUs74KpTRsdZziOid8oy
         GPGtBkQpD6qq7mqJpZAFgqWzUmOfjvoOab5IOQ9P6Ox0gJjIXGe3C8SAirJfw6jaDcYP
         SrrxJAQw8/Km14AabwYn6GNJN/FYblKsx+hCKGdYlv/Y3B0zAopdtxqJmKcwiQdVi+AI
         9+vVKaqEI5/cqmqmvIgceEHQybIDhdSZKKceRR4iY+xwRnuXHEmzFIlS7QWbLaLB/vfv
         4x/VIvK1L0hmIPmlGhHASz2tGr1McqqsGxI9eVil8sdH3f9X60JD+U4M85SVb6Ev+99U
         /ROw==
X-Gm-Message-State: AJIora8PNJOOmXBQG5flXDD9+MvhT0uh9tUmFfa6XS4k9UHl8gZIKofH
        CZcNFnFL53+nkvo0LmQ98xpwzppo4vtdr/P5
X-Google-Smtp-Source: AGRyM1sEY6WBSCZcdQDwWHc3mBmtTfGIzhtvU5E6wnZzHFt9Zj1HWnleAcoc0zPnh30ZQtl54jmKCw==
X-Received: by 2002:a63:d851:0:b0:408:a74a:29 with SMTP id k17-20020a63d851000000b00408a74a0029mr25225868pgj.603.1655796567377;
        Tue, 21 Jun 2022 00:29:27 -0700 (PDT)
Received: from longfanaikebuke.Dlink (36-236-237-46.dynamic-ip.hinet.net. [36.236.237.46])
        by smtp.gmail.com with ESMTPSA id n18-20020a056a00213200b005251f4596f0sm4203152pfj.107.2022.06.21.00.29.25
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 21 Jun 2022 00:29:27 -0700 (PDT)
From:   Steven Lung <1030steven@gmail.com>
To:     corbet@lwn.net
Cc:     johannes@sipsolutions.net, linux-um@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Steven Lung <1030steven@gmail.com>
Subject: [PATCH] docs: UML: fix typo
Date:   Tue, 21 Jun 2022 15:29:10 +0800
Message-Id: <20220621072910.4704-1-1030steven@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_STARTS_WITH_NUMS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace 'absense' with 'absence'.

Signed-off-by: Steven Lung <1030steven@gmail.com>
---
 Documentation/virt/uml/user_mode_linux_howto_v2.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/virt/uml/user_mode_linux_howto_v2.rst b/Documentation/virt/uml/user_mode_linux_howto_v2.rst
index 863f67b72..af2a97429 100644
--- a/Documentation/virt/uml/user_mode_linux_howto_v2.rst
+++ b/Documentation/virt/uml/user_mode_linux_howto_v2.rst
@@ -322,7 +322,7 @@ Shared Options
 * ``v6=[0,1]`` to specify if a v6 connection is desired for all
   transports which operate over IP. Additionally, for transports that
   have some differences in the way they operate over v4 and v6 (for example
-  EoL2TPv3), sets the correct mode of operation. In the absense of this
+  EoL2TPv3), sets the correct mode of operation. In the absence of this
   option, the socket type is determined based on what do the src and dst
   arguments resolve/parse to.
 
-- 
2.35.1

