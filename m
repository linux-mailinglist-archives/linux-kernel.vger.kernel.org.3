Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF53157E8C8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 23:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235668AbiGVVTM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 17:19:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235780AbiGVVTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 17:19:07 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C1BA81496
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 14:19:02 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id y9so5426069pff.12
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 14:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Oc5PTr+hvWvMjG9OJoUlCT4BEowktVJZckyg6eEiGZE=;
        b=eTAMEfddQglL1AT8gkFvkoYqCUn7WpbKEQMvs6GG4oI5Bc0veeCsdPwD63uxibZ2kF
         enfgN6MXjdQe8mmwCDXItiguLo9OOzOwjVRO1b/vA+PsLVpRxtfc/UzLrWEfk+pd2nV2
         z4qdGKxONyOS0rxjLij+6dlvhHjE12VJjINNJ69wIbHN2CvOFkdCfS7uCgvnp8Pkl0Ad
         IPJk9L4EA/ovS8wud+uzxq+GO1zrUUWhEWl3tvdl7g+NVng1d0kV0VJhQHLoHb63LSwg
         /etGTXNdbO6LCtcVfecjnR9SMlzIB3Hnltg/sGsC7Lu1NhEwjMWlT+E8roYHuoE99Zjf
         Rn/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Oc5PTr+hvWvMjG9OJoUlCT4BEowktVJZckyg6eEiGZE=;
        b=1DLINQTz8b4ffzcAK7Z7gXwslLE03CRuT99r0NB0umckNpzSrdF2ccNkw1fSf5m0FU
         C+lGHCJDhotXajJzB+afu5Rm0FXp514li1rvSsngspWKbHhP7yCEfJiR93h7q0pelpet
         jC1d9xib0cMdk47QG+H0gawMDMkmr1oafQA5dP4Iop3uPM11fT0uw7hpdTcndoUwMbvF
         evyc+nXNAnECp5yxu8dfwOU0GjklcqKACHfW9lp35ZQozDHNZEE+LJJGc1YRfUo8BME/
         96pvmCJh0NbHC6p0ndwYnBZf3iugQ4btmTiox3PMUh1QfISKWHFW7Wh16BkMQXPv37gG
         p2Og==
X-Gm-Message-State: AJIora8eMly3vyxesd4s+wJW+GH7W4XvzOLkPfDR1kNr8IF5Y0FXebA2
        +7x3DE7PbCclmYr+kbsg7IxqMOLVWiaF7g==
X-Google-Smtp-Source: AGRyM1tYXDMc3XqQvOOGhNhgbL5TID9KFoJ8Sa1bAObqRjclUX4VF72rxdFgWadSGCjuy2s/9WWAFw==
X-Received: by 2002:a63:6c87:0:b0:419:b667:6622 with SMTP id h129-20020a636c87000000b00419b6676622mr1364682pgc.495.1658524740956;
        Fri, 22 Jul 2022 14:19:00 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
        by smtp.gmail.com with ESMTPSA id d8-20020a170902cec800b0016c59b38254sm4259744plg.127.2022.07.22.14.19.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 14:19:00 -0700 (PDT)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Stafford Horne <shorne@gmail.com>,
        Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH] MAINTAINERS: Update Richard Henderson's address
Date:   Sat, 23 Jul 2022 06:18:54 +0900
Message-Id: <20220722211854.802252-1-shorne@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Richards address at twiddle.net no longer works and we are getting
bounces.

This patch updates to his Linaro address.

Cc: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index f679152bdbad..e64ca0ac6db7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -797,7 +797,7 @@ S:	Maintained
 F:	drivers/staging/media/sunxi/cedrus/
 
 ALPHA PORT
-M:	Richard Henderson <rth@twiddle.net>
+M:	Richard Henderson <richard.henderson@linaro.org>
 M:	Ivan Kokshaysky <ink@jurassic.park.msu.ru>
 M:	Matt Turner <mattst88@gmail.com>
 L:	linux-alpha@vger.kernel.org
-- 
2.36.1

