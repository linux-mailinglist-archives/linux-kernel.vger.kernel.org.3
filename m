Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB5EF58D972
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 15:37:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242583AbiHINhE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 09:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235573AbiHINhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 09:37:01 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 526E210AB;
        Tue,  9 Aug 2022 06:36:59 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id w15so13036493ljw.1;
        Tue, 09 Aug 2022 06:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc;
        bh=2cmYg+dq7t0/+vlcTjrhmxMyOhXFDdKVoPEbwy8Q0NE=;
        b=mhwPoFmZPKYXEMScxx8/vMlyt2z4qTQ8TgRHwrvOcBrbkT0SFbJBWVMcJ6zj2wAye1
         FbilLQEdufY22g0FdRTteHn60CUaNWtFGUoQL6DdgtoRUm93Umhn3kv9dofmUNJvACZ1
         4zvadaOox4+LlNYIGcgvOYLQ8qd3kuPbbTgvaJpWuJ5jjmtbJWBFfgaqBKgYSCbxLWNe
         w1UyZNy+YVV+eUKJOL0DgXtbeD1tBpu/J1Eb1gcYRvxQ9ORVmgK3mdZmESXHx278jKV3
         BDFbCX1+gbe78Ku5gAtaaFKB2Qh0G+OBiWkbqIxOMHw+ogroycb4zK9ysIZ1Ql63hfuz
         2BdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc;
        bh=2cmYg+dq7t0/+vlcTjrhmxMyOhXFDdKVoPEbwy8Q0NE=;
        b=OA/DCeInBN7ORS5Ba9KmftnNZiitugz2KkyAwQdqrep0QjOWOzZ2kSly/RHJw7NN6q
         2gjMQMozqFxpzjZ+fIfMtwddGceoXLRxw/ZB7HaBAEXkWR/hoaC/DrcgebUbeJ85yEaZ
         XHm0eHPvinDmSrKzvHMkq/HMy4m9AMX1z2WOvyl/mulRoDi+3oL8T/SeBJ5OYBSBG7tS
         yNdDEui8+PTnT/56pT3nyXGIQtVRSLufOROQaHzOeZOgfMiDrQ39DcMNmnM8LFrxZV+U
         hWPctb9iZZcSNPUv9CPtOuUYGBrj6J1VFz+fwcCzjvvKpo0j3hMXkfamfmo8Dzr5sXG+
         x1Hw==
X-Gm-Message-State: ACgBeo1ZIAW6X/n5emMPX47UPuGfk+Shmhi86XdZQHw+Snzw4dDpM91+
        Vlfc+t+jtG+hTk6FpRR2XL0=
X-Google-Smtp-Source: AA6agR7g1XBteOUR51MJjix2gbrN6cNqU38bYGyx9V0y/1aq+hz/vgt1ZnPO2My4RrblepoZeGfuzA==
X-Received: by 2002:a2e:aa26:0:b0:25e:8d08:8d2b with SMTP id bf38-20020a2eaa26000000b0025e8d088d2bmr5553409ljb.93.1660052217649;
        Tue, 09 Aug 2022 06:36:57 -0700 (PDT)
Received: from elende (elende.valinor.li. [2a01:4f9:6a:1c47::2])
        by smtp.gmail.com with ESMTPSA id w18-20020ac25d52000000b0048afa5daaf3sm1768511lfd.123.2022.08.09.06.36.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 06:36:56 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
From:   Salvatore Bonaccorso <carnil@debian.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Salvatore Bonaccorso <carnil@debian.org>
Subject: [PATCH v2] Documentation: stable: Document alternative for referring upstream commit hash
Date:   Tue,  9 Aug 2022 15:36:49 +0200
Message-Id: <20220809133649.2235524-1-carnil@debian.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Additionally to the "commit <sha1> upstream." variant, "[ Upstream
commit <sha1> ]" is used as well as alternative to refer to the upstream
commit hash.

Signed-off-by: Salvatore Bonaccorso <carnil@debian.org>
---
Changes in v2:
 - Drop extra RST markup which just only clutters things without any
   advantage.

 Documentation/process/stable-kernel-rules.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/process/stable-kernel-rules.rst b/Documentation/process/stable-kernel-rules.rst
index c61865e91f52..beef21280d88 100644
--- a/Documentation/process/stable-kernel-rules.rst
+++ b/Documentation/process/stable-kernel-rules.rst
@@ -97,6 +97,10 @@ text, like this:
 
     commit <sha1> upstream.
 
+or alternatively::
+
+    [ Upstream commit <sha1> ]
+
 Additionally, some patches submitted via :ref:`option_1` may have additional
 patch prerequisites which can be cherry-picked. This can be specified in the
 following format in the sign-off area:
-- 
2.36.1

