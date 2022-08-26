Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85C835A20C3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 08:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244954AbiHZGTX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 02:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241159AbiHZGTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 02:19:20 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA182BCC38;
        Thu, 25 Aug 2022 23:19:19 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id a65so687412pfa.1;
        Thu, 25 Aug 2022 23:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=9wKFe2ysnOXjYOby5ofhokOV07YcBDN9+0+z9LRtL10=;
        b=F7fr3D1kVeTCiQ9KCREh3wXAhqkxWfinHJYUmokmtkq+XTm4cWq6yt9y6pmMBgse+D
         Rl4iW9SEJQfVgvPXHvk8SOvR7wPIls0a2dQFYsUHNw1vq0dqTsGe73IlaAzfw6drv9Qq
         Eo23gUHQ75WmniDPhVuE7Ew+ep69dqR9IrzFH3ooF5NPhwZYboHrYBIWEl/cLZv9hEUG
         rUrEDTV5DxNBVh5ivHo5JFUDPk5H8fgACvQfRcjzXPYYZzp3CesalhEoGzIFWhGe7hRr
         apHYFzC/wIVtdZOocIgPbV4+1ZBaoAAlTzKrj65GX5qcFtVx0L+I8uIR/cLZ/YGrNDON
         y8gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=9wKFe2ysnOXjYOby5ofhokOV07YcBDN9+0+z9LRtL10=;
        b=j5QuwE2mBugNEsN1LOl9lMhTuqZhbQSnQzBlnn4VzAhJRx+TQShalrgCVh8I5R1lQ9
         /6udPR9keS7pBBG3VqapIvDebvd9ft/3YiA5OPx456NCyYD9wNt8xGa5tJ0KEszyjnxD
         McmaXVwxzLqXVSGaKtZyPpTqWUUrCtu+afMNKer+1rizuoOV61yTPgCK8RoABCIvPPnU
         r1CWECgWSZBnsSgd3gYUHitQxPljsala6TZyL5/bgPsXMy8HPbUttssiIrAbpA6pKlFu
         KK6gRYU0iPnOVkbv2kjnLqvWskh+FcKBi8YJy6gju1jNW+EeL35vIGXda9XSILvNpECr
         UIVA==
X-Gm-Message-State: ACgBeo0PvMuI1QKvNXL05706GeEGzb7b+iRK7fjksrL9MUd5UD46I/Bz
        gw9kStTmZf13oeG/qU2u9wM=
X-Google-Smtp-Source: AA6agR5aaH/3VU47k5ejJLISacaKchrUtO0rxyvyNIFm8b9udPD6kqbvYr1NiuLAzSaDC059N7TQ5A==
X-Received: by 2002:a63:66c7:0:b0:429:b6fe:903d with SMTP id a190-20020a6366c7000000b00429b6fe903dmr2136772pgc.33.1661494759224;
        Thu, 25 Aug 2022 23:19:19 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.84])
        by smtp.gmail.com with ESMTPSA id b10-20020a170902d50a00b001730cf6f839sm672445plg.70.2022.08.25.23.19.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 23:19:18 -0700 (PDT)
From:   menglong8.dong@gmail.com
X-Google-Original-From: imagedong@tencent.com
To:     kuba@kernel.org, sfr@canb.auug.org.au
Cc:     corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Menglong Dong <imagedong@tencent.com>
Subject: [PATCH net-next] docs/conf.py: add function attribute '__fix_address' to conf.py
Date:   Fri, 26 Aug 2022 14:19:14 +0800
Message-Id: <20220826061914.816239-1-imagedong@tencent.com>
X-Mailer: git-send-email 2.37.2
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

From: Menglong Dong <imagedong@tencent.com>

Stephen Rothwell report that the function attribute '__fix_address'
causes a warning when create html docs with the command:

  make htmldocs

Therefor, add this attribute to c_id_attributes in Documentation/conf.py
to clean this warning.

BTW, I'm not able to reproduce this warning (both ubuntu and centos are
tested). I will appreciate it if anyone can have a test for this
commit.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Menglong Dong <imagedong@tencent.com>
---
 Documentation/conf.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/conf.py b/Documentation/conf.py
index 934727e23e0e..255384d094bf 100644
--- a/Documentation/conf.py
+++ b/Documentation/conf.py
@@ -86,6 +86,7 @@ if major >= 3:
             "__used",
             "__weak",
             "noinline",
+            "__fix_address",
 
             # include/linux/memblock.h:
             "__init_memblock",
-- 
2.37.2

