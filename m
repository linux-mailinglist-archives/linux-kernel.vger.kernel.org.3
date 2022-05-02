Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A7BC517164
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 16:15:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238052AbiEBOTR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 10:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385627AbiEBOS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 10:18:57 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95167DED5;
        Mon,  2 May 2022 07:15:27 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id a1so16782820edt.3;
        Mon, 02 May 2022 07:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PR2akzjSHzRoLtewUgMac6+Y64PGqXA5YmcADTBjoU4=;
        b=X7wEduK/sxNWcNtLYd0sc7+yrcRgmJh25G5yNy5TWFjEQdBZCMPhgaVDdOumB9XAMC
         7xQxydrHn/tGdmLO9sK536W9YcTX8qRpG5zcaQEmHJuP0ohRIRIeXDicO0mNCYM65Teu
         fBZbPs4HFzP7x1d7WBHr6flZpeyDaRwskBFU1FoPlE6CnEXHndnzPZe118SZSUMB/MDi
         F3ZoZAiEowignsRgGSCUkAADIyAehrvUI8ekDGRi7PlavmoIan/OVGS7hXNHQve8OVOq
         hRLepkxyn1ECWbKGdcANNmIIlxsWgEBgM7c8bbnucktUTSyR0pUncsIOMNyYWtfaGD0+
         tbIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PR2akzjSHzRoLtewUgMac6+Y64PGqXA5YmcADTBjoU4=;
        b=erqnaEvt/3J5F5JMmtkSP1q7k7XvtmvVpO2tkAJ/FJbOkoqPDw15/OT4LpbFCCfiy0
         a7hozlRvgsDNULKiR5MBn4wbTCQFYFqmwk0ez1VBQbMmJzYjQKhpTBw+ig6Ck4lWnnvJ
         S/pMCpik0RYcmtMlazA8a/NEwIBLK5OrFZVymKxVTtIWLak5G7MLreAGYXtf3mXXDUy4
         IU1qW9ZjNctyuh3Q7Xl9otSblBM14HF5YSyXcXZiY515004NwXCZojwvYx9ox2nYhL/W
         XEE+MeqcV7w9EqzgCd5XIz95vm530oUKpAtKlKOLXOZ8loIKX7or18hvP5mUsGqKaJTZ
         rdxQ==
X-Gm-Message-State: AOAM533JkfwhaWrn+jxVJvsSRguhS6iDdNzuEPx9a6Cuu3/t5oLk5sDc
        an0PL5m9tTUHXycUhbfhKzEThoITvNE=
X-Google-Smtp-Source: ABdhPJw+jDtp4IfHKIp26ybwHOkEk7fjBevcj7sFZ4t1Gq4UbzD+N99TSN8TYTqNZ3C95MsC3MT1yA==
X-Received: by 2002:aa7:df15:0:b0:41d:675f:ea9a with SMTP id c21-20020aa7df15000000b0041d675fea9amr13886093edy.148.1651500926165;
        Mon, 02 May 2022 07:15:26 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-001-135-067.77.1.pool.telefonica.de. [77.1.135.67])
        by smtp.gmail.com with ESMTPSA id ig11-20020a1709072e0b00b006f3ef214e2dsm3771770ejc.147.2022.05.02.07.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 07:15:25 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Cc:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Zhongjun Tan <tanzhongjun@yulong.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] selinux: include necessary headers in headers
Date:   Mon,  2 May 2022 16:15:20 +0200
Message-Id: <20220502141524.35268-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Include header files required for struct or typedef declarations in
header files.  This is for example helpful when working with an IDE, which
needs to resolve those symbols.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/include/audit.h   | 3 +++
 security/selinux/include/avc_ss.h  | 2 +-
 security/selinux/include/ibpkey.h  | 2 ++
 security/selinux/include/netnode.h | 2 ++
 security/selinux/include/netport.h | 2 ++
 security/selinux/include/xfrm.h    | 2 ++
 6 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/security/selinux/include/audit.h b/security/selinux/include/audit.h
index 073a3d34a0d2..be42d7dc2c0c 100644
--- a/security/selinux/include/audit.h
+++ b/security/selinux/include/audit.h
@@ -12,6 +12,9 @@
 #ifndef _SELINUX_AUDIT_H
 #define _SELINUX_AUDIT_H
 
+#include <linux/audit.h>
+#include <linux/types.h>
+
 /**
  *	selinux_audit_rule_init - alloc/init an selinux audit rule structure.
  *	@field: the field this rule refers to
diff --git a/security/selinux/include/avc_ss.h b/security/selinux/include/avc_ss.h
index 88c384c5c09e..66a87559b788 100644
--- a/security/selinux/include/avc_ss.h
+++ b/security/selinux/include/avc_ss.h
@@ -7,7 +7,7 @@
 #ifndef _SELINUX_AVC_SS_H_
 #define _SELINUX_AVC_SS_H_
 
-#include "flask.h"
+#include <linux/types.h>
 
 struct selinux_avc;
 int avc_ss_reset(struct selinux_avc *avc, u32 seqno);
diff --git a/security/selinux/include/ibpkey.h b/security/selinux/include/ibpkey.h
index e6ac1d23320b..c992f83b0aae 100644
--- a/security/selinux/include/ibpkey.h
+++ b/security/selinux/include/ibpkey.h
@@ -14,6 +14,8 @@
 #ifndef _SELINUX_IB_PKEY_H
 #define _SELINUX_IB_PKEY_H
 
+#include <linux/types.h>
+
 #ifdef CONFIG_SECURITY_INFINIBAND
 void sel_ib_pkey_flush(void);
 int sel_ib_pkey_sid(u64 subnet_prefix, u16 pkey, u32 *sid);
diff --git a/security/selinux/include/netnode.h b/security/selinux/include/netnode.h
index e3f784a85840..9b8b655a8cd3 100644
--- a/security/selinux/include/netnode.h
+++ b/security/selinux/include/netnode.h
@@ -17,6 +17,8 @@
 #ifndef _SELINUX_NETNODE_H
 #define _SELINUX_NETNODE_H
 
+#include <linux/types.h>
+
 void sel_netnode_flush(void);
 
 int sel_netnode_sid(void *addr, u16 family, u32 *sid);
diff --git a/security/selinux/include/netport.h b/security/selinux/include/netport.h
index 31bc16e29cd1..9096a8289948 100644
--- a/security/selinux/include/netport.h
+++ b/security/selinux/include/netport.h
@@ -16,6 +16,8 @@
 #ifndef _SELINUX_NETPORT_H
 #define _SELINUX_NETPORT_H
 
+#include <linux/types.h>
+
 void sel_netport_flush(void);
 
 int sel_netport_sid(u8 protocol, u16 pnum, u32 *sid);
diff --git a/security/selinux/include/xfrm.h b/security/selinux/include/xfrm.h
index 74159400eeee..c75839860200 100644
--- a/security/selinux/include/xfrm.h
+++ b/security/selinux/include/xfrm.h
@@ -8,7 +8,9 @@
 #ifndef _SELINUX_XFRM_H_
 #define _SELINUX_XFRM_H_
 
+#include <linux/lsm_audit.h>
 #include <net/flow.h>
+#include <net/xfrm.h>
 
 int selinux_xfrm_policy_alloc(struct xfrm_sec_ctx **ctxp,
 			      struct xfrm_user_sec_ctx *uctx,
-- 
2.36.0

