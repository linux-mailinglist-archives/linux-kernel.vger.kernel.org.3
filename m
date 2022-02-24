Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A8B44C23A7
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 06:39:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbiBXFkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 00:40:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbiBXFkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 00:40:16 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AA3A25291F
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 21:39:47 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id m11so784097pls.5
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 21:39:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e6g7HRr0zIYQVPNXmzVLc42NaJplGVZDGpMCXVnQwkY=;
        b=kQguTOJO79zZ4TeGl8ygulyeSSwdjpqt9d2DbpR98u/5voWF2vVcUewhxvoROD4gsS
         uZrwk5rvwB7Co7uAs9s1JjHsP7YkJ64yF75ePStV2f1kYz89S9mt/653j1vslw3z4QB/
         bjCw/20qq+IRFwwfQMNTkH23tqNWmgfeZGHTk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e6g7HRr0zIYQVPNXmzVLc42NaJplGVZDGpMCXVnQwkY=;
        b=Bybwmyc1JAdzP4TyX28jJBkf6hOdfSRJHD43vvN3RZAcI1PYFbi2Y+itmVOcsSharQ
         Y3jWczfwvtGAqAOxXurkWIam+fvWjFFQUrnNoP2FdgiebRoeXQrSAb2yLGIV/BO32mzU
         Ab4G1+P+Hx59xrpnATs434xJHCCrdwuX1QiJqLzyDy0lXHB6zn2n5Ihr5nBwT5a6Qg6M
         p2mdu8JsN9qHhlJyugiVPZt2+YOB1ncC/byxsN3PrJIgP44J7n8WZHXGsT/qQntbZb9r
         4KBg/41NsZMHxXVBbl98tht57oIqKdzZKHhjT5GwfPZnhOt7HSwT2KvPWNEWpGxMoKkX
         jXIQ==
X-Gm-Message-State: AOAM533sgVLTJxtpHGHg1a70NVWE29JCYJPmq7CzLtXkCqypKxy9jNKw
        pHZP+ModlX7fshuwWdZLaQ5+8Q==
X-Google-Smtp-Source: ABdhPJxamHd9J69LDxApBkkgGOYtMrUJj4jHtb4mswOsHzhA2LHPjTBWBDLvlXh3wGYZLdR8Pxap/Q==
X-Received: by 2002:a17:902:9348:b0:14d:8ee9:329f with SMTP id g8-20020a170902934800b0014d8ee9329fmr1309310plp.80.1645681187027;
        Wed, 23 Feb 2022 21:39:47 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s48sm1436917pfw.111.2022.02.23.21.39.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 21:39:46 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Eric Biederman <ebiederm@xmission.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-hardening@vger.kernel.org
Subject: [PATCH] MAINTAINERS: Update execve entry with more details
Date:   Wed, 23 Feb 2022 21:39:45 -0800
Message-Id: <20220224053945.1852048-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1098; h=from:subject; bh=gYwy98bhL+KP9Gi2xFKK93KwgEGtemx/KrxoV+zoPYo=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBiFxogXLPUMpaKGsP1Vih6r5khjZfd+nup6pyAwYKN /FXB3bmJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYhcaIAAKCRCJcvTf3G3AJsPCEA ClSkAioh0+Pvcf1Eu11wtLQqXh+P5prw5MDJaii8067aGgL2rRL9vVo1GhyWXJ47YSAPzZoN5ySqu8 6OxUTVM7BOzSj6+lnTxAE9/ktBSag7rE+HLVc2PTOr+RI7VQZimb5CjzrxCTJ3cGcEJz9EaJkaXeTX Zr2p6Lw2C4RN96cRPAoviVXLMcIshmJByek6KA/4RqyT0YCH7bPVHb+pHigX9O1TM2pU3if/tFnafI UQi8GkYO877+/7AFsVYMXK8/gZwr4kEJniBRTUexQ3GThdhV529cmFMoVL3egN4DM0M5qKlxUFyGl0 qE5lUqQGNUXYoTl4o/5O2I3aWYsIsxL4hclkllZZmzHvelCkVMlObtQi4kS9pvn9nFA5vEGRGp4F0+ /w6JDZhUgHMD42TYdypgXRjg6jd5JCUI63pXDq2N+Tstny26C9c+wsZJYlb4XRxs8r6deywJnC9fS5 BBvSHKacNHuqFhIW3JVvncWL5lzwA6k2IWZY4R2fpHpOK58iNITgilLkZ3vd2RbknmwzgpF1ToEp33 zSfO3E1qbQ5Zv5EEY8kcT2VDXWXVxOfigkJSB64beoMIfYS129rIhbIBrKs/DkuirlnmE6YRLvEpcG 7i8Ne4f+WKXP9TzAsG9iGK42gCqYsEXK2KZjJniE2ltk/bvm05tnvq8pRrbg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The UAPI elf.h header was missed in the original MAINTAINER entry. Add
it. Include linux-mm mailing list since that's where execve has
traditionally been discussed. Note that this area is Supported, and aim
at the git tree.

Cc: Eric Biederman <ebiederm@xmission.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 MAINTAINERS | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 69a2935daf6c..2a4de0619c49 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7225,6 +7225,9 @@ F:	net/core/of_net.c
 EXEC & BINFMT API
 R:	Eric Biederman <ebiederm@xmission.com>
 R:	Kees Cook <keescook@chromium.org>
+L:	linux-mm@kvack.org
+S:	Supported
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/execve
 F:	arch/alpha/kernel/binfmt_loader.c
 F:	arch/x86/ia32/ia32_aout.c
 F:	fs/*binfmt_*.c
@@ -7232,6 +7235,7 @@ F:	fs/exec.c
 F:	include/linux/binfmts.h
 F:	include/linux/elf.h
 F:	include/uapi/linux/binfmts.h
+F:	include/uapi/linux/elf.h
 F:	tools/testing/selftests/exec/
 N:	asm/elf.h
 N:	binfmt
-- 
2.30.2

