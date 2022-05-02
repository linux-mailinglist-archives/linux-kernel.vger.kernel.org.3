Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F5F35170E4
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 15:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385435AbiEBNwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 09:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236253AbiEBNwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 09:52:32 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98C8A12743;
        Mon,  2 May 2022 06:49:03 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id y21so16698901edo.2;
        Mon, 02 May 2022 06:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H/4xzLqwIKeVu+ASklRt4sq1liyEda8jvxXULguh/dk=;
        b=i3bi4gEuL9OUDxzPR9IK8VOscpCIL2KCndLusI2KNDb5JCyfMVRMvKwZ+9k2HBZrIs
         YLeBcY/R7S4rWKZIbkbBP6eL1GzwPa7tiFzstGTxWzx9q9Rh/XSim1VVMo79h6a6CMAj
         e0hQtew11gSzQDJRYGRz/NK7BfXAa0bSfVP3DZFwsCxXvBn6l+sp8zkuyV1uoPFGJ/X2
         gF8WAetV6KZe9cAA1FRV/jxTnZFVsBtcTWH1Bx46H1mJEhMaV/qOfR4sGvJ7NPNCKrOs
         jY1E8UwW+9+WJDi6mIt3+fPHEoCNSS4KRZ1rgLGOIDf5O4u1acE6Z0DR2t7ej9yQxP6k
         zyIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H/4xzLqwIKeVu+ASklRt4sq1liyEda8jvxXULguh/dk=;
        b=Sv5uNGAPT1ISrIHGG9AsTbR7WnA9R9py5CKeCnFeIL3B3DMOl1/fqfPbFlmwcuYpan
         xU8QWBtwYeP4v2Vfuh8maBTPMD5VaP0Yx7SOQgq6ud/OLJGlioeL/8vdsGZJLupxWexX
         SVQXM4dNA66h9Fsvef6ruGI8w14VmXtLtQPJOn0kkJWe9Lx2CI5amHV5gBSARy19Lw81
         c5/2zF0F2xoXIgdv8MZz1GE+EMEAczeHiQoMiO3PrpgvWmkUgFV8hCfH8wZY7Ow/4iZq
         p24Py19vX70aQkj6WiJ2kPBVNvJjFxkx/9MKeJ7TT1Ni1XLy+wO1agQqFwy2DrRRqcIj
         sBsQ==
X-Gm-Message-State: AOAM533gGCE60bICs2UVYYq7gOeHRklWCxHnDvvXiwVEEvjMghamXhGn
        OZFt/Ci++30cBUKvrcn/LZirl9n7hv8=
X-Google-Smtp-Source: ABdhPJxiNKXh5nPY15pU839tLBO6aAYIIVVNTlYlbnwB1x18cYzeh3ZoIfK/fJqKr/p65ndsEcQDbw==
X-Received: by 2002:a05:6402:ea8:b0:41d:78ca:b929 with SMTP id h40-20020a0564020ea800b0041d78cab929mr13345949eda.289.1651499342008;
        Mon, 02 May 2022 06:49:02 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-001-135-067.77.1.pool.telefonica.de. [77.1.135.67])
        by smtp.gmail.com with ESMTPSA id em22-20020a170907289600b006f3ef214e5fsm3595732ejc.197.2022.05.02.06.49.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 06:49:01 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Cc:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Xiu Jianfeng <xiujianfeng@huawei.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] selinux: resolve checkpatch errors
Date:   Mon,  2 May 2022 15:48:48 +0200
Message-Id: <20220502134850.28372-1-cgzones@googlemail.com>
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

Reported by checkpatch:

    security/selinux/nlmsgtab.c
    ---------------------------
    ERROR: that open brace { should be on the previous line
    #29: FILE: security/selinux/nlmsgtab.c:29:
    +static const struct nlmsg_perm nlmsg_route_perms[] =
    +{

    ERROR: that open brace { should be on the previous line
    #97: FILE: security/selinux/nlmsgtab.c:97:
    +static const struct nlmsg_perm nlmsg_tcpdiag_perms[] =
    +{

    ERROR: that open brace { should be on the previous line
    #105: FILE: security/selinux/nlmsgtab.c:105:
    +static const struct nlmsg_perm nlmsg_xfrm_perms[] =
    +{

    ERROR: that open brace { should be on the previous line
    #134: FILE: security/selinux/nlmsgtab.c:134:
    +static const struct nlmsg_perm nlmsg_audit_perms[] =
    +{

    security/selinux/ss/policydb.c
    ------------------------------
    ERROR: that open brace { should be on the previous line
    #318: FILE: security/selinux/ss/policydb.c:318:
    +static int (*destroy_f[SYM_NUM]) (void *key, void *datum, void *datap) =
    +{

    ERROR: that open brace { should be on the previous line
    #674: FILE: security/selinux/ss/policydb.c:674:
    +static int (*index_f[SYM_NUM]) (void *key, void *datum, void *datap) =
    +{

    ERROR: that open brace { should be on the previous line
    #1643: FILE: security/selinux/ss/policydb.c:1643:
    +static int (*read_f[SYM_NUM]) (struct policydb *p, struct symtab *s, void *fp) =
    +{

    ERROR: that open brace { should be on the previous line
    #3246: FILE: security/selinux/ss/policydb.c:3246:
    +                               void *datap) =
    +{

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/include/initial_sid_to_string.h |  3 +--
 security/selinux/nlmsgtab.c                      | 12 ++++--------
 security/selinux/ss/policydb.c                   | 12 ++++--------
 3 files changed, 9 insertions(+), 18 deletions(-)

diff --git a/security/selinux/include/initial_sid_to_string.h b/security/selinux/include/initial_sid_to_string.h
index 5d332aeb8b6c..9683f0ddecbc 100644
--- a/security/selinux/include/initial_sid_to_string.h
+++ b/security/selinux/include/initial_sid_to_string.h
@@ -1,6 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-static const char *initial_sid_to_string[] =
-{
+static const char *initial_sid_to_string[] = {
 	NULL,
 	"kernel",
 	"security",
diff --git a/security/selinux/nlmsgtab.c b/security/selinux/nlmsgtab.c
index d8ceee9e0d6f..2ee7b4ed43ef 100644
--- a/security/selinux/nlmsgtab.c
+++ b/security/selinux/nlmsgtab.c
@@ -25,8 +25,7 @@ struct nlmsg_perm {
 	u32	perm;
 };
 
-static const struct nlmsg_perm nlmsg_route_perms[] =
-{
+static const struct nlmsg_perm nlmsg_route_perms[] = {
 	{ RTM_NEWLINK,		NETLINK_ROUTE_SOCKET__NLMSG_WRITE },
 	{ RTM_DELLINK,		NETLINK_ROUTE_SOCKET__NLMSG_WRITE },
 	{ RTM_GETLINK,		NETLINK_ROUTE_SOCKET__NLMSG_READ  },
@@ -97,16 +96,14 @@ static const struct nlmsg_perm nlmsg_route_perms[] =
 	{ RTM_GETTUNNEL,	NETLINK_ROUTE_SOCKET__NLMSG_READ  },
 };
 
-static const struct nlmsg_perm nlmsg_tcpdiag_perms[] =
-{
+static const struct nlmsg_perm nlmsg_tcpdiag_perms[] = {
 	{ TCPDIAG_GETSOCK,	NETLINK_TCPDIAG_SOCKET__NLMSG_READ },
 	{ DCCPDIAG_GETSOCK,	NETLINK_TCPDIAG_SOCKET__NLMSG_READ },
 	{ SOCK_DIAG_BY_FAMILY,	NETLINK_TCPDIAG_SOCKET__NLMSG_READ },
 	{ SOCK_DESTROY,		NETLINK_TCPDIAG_SOCKET__NLMSG_WRITE },
 };
 
-static const struct nlmsg_perm nlmsg_xfrm_perms[] =
-{
+static const struct nlmsg_perm nlmsg_xfrm_perms[] = {
 	{ XFRM_MSG_NEWSA,	NETLINK_XFRM_SOCKET__NLMSG_WRITE },
 	{ XFRM_MSG_DELSA,	NETLINK_XFRM_SOCKET__NLMSG_WRITE },
 	{ XFRM_MSG_GETSA,	NETLINK_XFRM_SOCKET__NLMSG_READ  },
@@ -134,8 +131,7 @@ static const struct nlmsg_perm nlmsg_xfrm_perms[] =
 	{ XFRM_MSG_GETDEFAULT,	NETLINK_XFRM_SOCKET__NLMSG_READ  },
 };
 
-static const struct nlmsg_perm nlmsg_audit_perms[] =
-{
+static const struct nlmsg_perm nlmsg_audit_perms[] = {
 	{ AUDIT_GET,		NETLINK_AUDIT_SOCKET__NLMSG_READ     },
 	{ AUDIT_SET,		NETLINK_AUDIT_SOCKET__NLMSG_WRITE    },
 	{ AUDIT_LIST,		NETLINK_AUDIT_SOCKET__NLMSG_READPRIV },
diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index d036e1238e77..3d50dfb0211b 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -314,8 +314,7 @@ static int cat_destroy(void *key, void *datum, void *p)
 	return 0;
 }
 
-static int (*destroy_f[SYM_NUM]) (void *key, void *datum, void *datap) =
-{
+static int (*destroy_f[SYM_NUM]) (void *key, void *datum, void *datap) = {
 	common_destroy,
 	cls_destroy,
 	role_destroy,
@@ -670,8 +669,7 @@ static int cat_index(void *key, void *datum, void *datap)
 	return 0;
 }
 
-static int (*index_f[SYM_NUM]) (void *key, void *datum, void *datap) =
-{
+static int (*index_f[SYM_NUM]) (void *key, void *datum, void *datap) = {
 	common_index,
 	class_index,
 	role_index,
@@ -1639,8 +1637,7 @@ static int cat_read(struct policydb *p, struct symtab *s, void *fp)
 	return rc;
 }
 
-static int (*read_f[SYM_NUM]) (struct policydb *p, struct symtab *s, void *fp) =
-{
+static int (*read_f[SYM_NUM]) (struct policydb *p, struct symtab *s, void *fp) = {
 	common_read,
 	class_read,
 	role_read,
@@ -3242,8 +3239,7 @@ static int user_write(void *vkey, void *datum, void *ptr)
 }
 
 static int (*write_f[SYM_NUM]) (void *key, void *datum,
-				void *datap) =
-{
+				void *datap) = {
 	common_write,
 	class_write,
 	role_write,
-- 
2.36.0

