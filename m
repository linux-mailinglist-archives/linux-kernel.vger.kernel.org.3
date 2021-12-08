Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29D0846D8B1
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 17:40:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234815AbhLHQo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 11:44:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbhLHQo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 11:44:26 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D997DC0617A1
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 08:40:53 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id q72so3386541iod.12
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 08:40:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dLp7ooqjkm3LCs3m7YGKT3KDP/GRqGUVpJDeFht0HwI=;
        b=SmPl6s5+V+iNXXZYYxli3T0CqmmSXs5B0qKfZoVwArEbPtubQqdg76iMQiEimyw5ic
         lR/jI6AIq8vSh0WuAYh7LKaWfBSQitAzKlxEvoh4JtVDGRFEdDPKYVKK/f1ut67nqSBI
         A5NLMtcPWp6JLp18SuDO/7vKzzG7Z4P8XYEZM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dLp7ooqjkm3LCs3m7YGKT3KDP/GRqGUVpJDeFht0HwI=;
        b=FlQ0jhctODZ7SELjKQNB8zRIR9jsGfdZLb1nFPw++YZujZ0zQCGwDeEbTdRxdKwtT6
         8MpUowlGobGFwobOm1wlqVenlVPtXOM5fi/nKzFwBrG7BLt6BSbpar+GC6mGXPl8fTpP
         4HIs3zLo7xKUEQ+iELIcKxDycr0UO1UB1CFJgyLkRdXhxu4Zr6MAIIy+kMwbuCkCoPO/
         CID/bfL65GQoh+Rfk3Lr19tdGhBg3X9eBBZGTtGbkDjW22dx4Qm9v/2/00f2XlpCsfRC
         +bBF78D4Uyzu8JIUkgaPT9DCmGtxeIeDXvreVFQvinjruIbDBitICgxqPrNrXc3vWvgX
         eLdw==
X-Gm-Message-State: AOAM5318bYAEodUCpeP7rOoLyyPA4s2YOTZi3YHywf6kXHCr6N0+c9UW
        fdRcE8qiU0fRx0PqNVSWhrUaUA==
X-Google-Smtp-Source: ABdhPJzJfuomwPa7mM7YKDPxKKEjWO0HUnKMPZcF7SScBP7ZSfbt8vjbwxkB8kzBjpeyS45ecKl8uQ==
X-Received: by 2002:a02:a91a:: with SMTP id n26mr840089jam.46.1638981653256;
        Wed, 08 Dec 2021 08:40:53 -0800 (PST)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id n28sm2123182ioz.17.2021.12.08.08.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 08:40:52 -0800 (PST)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     corbet@lwn.net
Cc:     Shuah Khan <skhan@linuxfoundation.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] docs: update self-protection __ro_after_init status
Date:   Wed,  8 Dec 2021 09:40:51 -0700
Message-Id: <20211208164051.8783-1-skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__ro_after_init is no longer new and under development. Update the
document to reflect the correct status.

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 Documentation/security/self-protection.rst | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/security/self-protection.rst b/Documentation/security/self-protection.rst
index f584fb74b4ff..910668e665cb 100644
--- a/Documentation/security/self-protection.rst
+++ b/Documentation/security/self-protection.rst
@@ -81,8 +81,7 @@ of the kernel, gaining the protection of the kernel's strict memory
 permissions as described above.
 
 For variables that are initialized once at ``__init`` time, these can
-be marked with the (new and under development) ``__ro_after_init``
-attribute.
+be marked with the ``__ro_after_init`` attribute.
 
 What remains are variables that are updated rarely (e.g. GDT). These
 will need another infrastructure (similar to the temporary exceptions
-- 
2.32.0

