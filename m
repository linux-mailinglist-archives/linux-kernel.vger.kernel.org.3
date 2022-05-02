Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77D91517127
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 16:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385479AbiEBOFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 10:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236925AbiEBOFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 10:05:33 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C03B3898;
        Mon,  2 May 2022 07:02:02 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id y3so27898447ejo.12;
        Mon, 02 May 2022 07:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WkFaJgQfY8xafjGsalWc3iud3tYP7nWYcNFdHaIwP9Q=;
        b=MjdhurxCNSwDwDeoauPjdn+WJkbwFr3TJmtEgqnUWnBlfaQ39uoIHPGb2FYpc45V1r
         AT5c6NDRvLZVlR7YLpUAMgHgs2HiyTXurPuCvoe7sZPP+ymNxNqgaVek/S6FyXiIYbvM
         5NLWxN/ehx2C0/WvaN8JgBBkVvdEVuwOdac8z+jlrV4hZLZZLVAWvN6SOk4B9dZcMv3a
         iq+wqIQk8DGDhvy9cwC3KDRLFeZKwTXUIZXzWcycEW2O9Zz3gfuK/fwM4z6kcD0gvl/O
         Z5Pu10J7m+jlKvKH3Fa/LIEf+WxbcWN0me5AAFIcARMIug4P33sPAYcnsbjZppMSgiP2
         8pJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WkFaJgQfY8xafjGsalWc3iud3tYP7nWYcNFdHaIwP9Q=;
        b=fjGws7QNdlOx8Lr639bEJyYbYOqT+GElPFV+lWoY3Lr/fWfdo9imjC5wRC/4sCHckR
         Bo3ofsE3Z9IzkZRnquQ02umh0IEdJegVtbRhspckiapqukRp0pFTbgKp/eWQ70Jr2rb7
         xUaiH5jWA98i/4EjFuvM3Tg5GWCZ75hCoxADaqALR8nLOl2C58RaMlzgL+K0qvAwcbsd
         XWQ3Y01Wrxmud8NVn+c5dAcwIakPOQstmDj9yI/V0YQ3ehU6VbhzmjwsaWoVJ4g3lcNi
         EWRLvhJTKsY5d6wHH/Z6dKRs0LWsfjml8ZvLbkCHlXajHp2uxzKBn0eszOuCLI93RhB1
         CITw==
X-Gm-Message-State: AOAM533sAjyR9hYtBnM+C7YlChf/gNQqpvisjI0O0Ia80cJ26c8DoAf8
        Eqc3vzkDWJQECD2xtLdeHHLjfru8L38=
X-Google-Smtp-Source: ABdhPJwM4mPi+VJVSc99REy3rsk6vnxjwUSJLUlUCoiv8ZwuixH/ZOgfYZcjZK2un67w9jatoehGhA==
X-Received: by 2002:a17:907:7618:b0:6f3:9722:3dd1 with SMTP id jx24-20020a170907761800b006f397223dd1mr6159925ejc.424.1651500114261;
        Mon, 02 May 2022 07:01:54 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-001-135-067.77.1.pool.telefonica.de. [77.1.135.67])
        by smtp.gmail.com with ESMTPSA id r22-20020a056402035600b00425d6c76494sm6681193edw.1.2022.05.02.07.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 07:01:53 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Cc:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Al Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: [PATCH] selinux: update parameter documentation
Date:   Mon,  2 May 2022 16:01:50 +0200
Message-Id: <20220502140151.31767-1-cgzones@googlemail.com>
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

security/selinux/include/audit.h:54: warning: Function parameter or member 'krule' not described in 'selinux_audit_rule_known'
security/selinux/include/audit.h:54: warning: Excess function parameter 'rule' description in 'selinux_audit_rule_known'
security/selinux/include/avc.h:130: warning: Function parameter or member 'state' not described in 'avc_audit'

This also bring the parameter name of selinux_audit_rule_known() in sync
between declaration and definition.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/include/audit.h | 2 +-
 security/selinux/include/avc.h   | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/security/selinux/include/audit.h b/security/selinux/include/audit.h
index 073a3d34a0d2..549a382fe6e7 100644
--- a/security/selinux/include/audit.h
+++ b/security/selinux/include/audit.h
@@ -51,7 +51,7 @@ int selinux_audit_rule_match(u32 sid, u32 field, u32 op, void *rule);
  *	@rule: rule to be checked
  *	Returns 1 if there are selinux fields specified in the rule, 0 otherwise.
  */
-int selinux_audit_rule_known(struct audit_krule *krule);
+int selinux_audit_rule_known(struct audit_krule *rule);
 
 #endif /* _SELINUX_AUDIT_H */
 
diff --git a/security/selinux/include/avc.h b/security/selinux/include/avc.h
index 00f78be48283..2b372f98f2d7 100644
--- a/security/selinux/include/avc.h
+++ b/security/selinux/include/avc.h
@@ -104,6 +104,7 @@ int slow_avc_audit(struct selinux_state *state,
 
 /**
  * avc_audit - Audit the granting or denial of permissions.
+ * @state: SELinux state
  * @ssid: source security identifier
  * @tsid: target security identifier
  * @tclass: target security class
-- 
2.36.0

