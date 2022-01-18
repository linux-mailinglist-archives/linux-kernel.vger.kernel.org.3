Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04000492E2E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 20:09:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348624AbiARTJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 14:09:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234118AbiARTJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 14:09:35 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CF5DC06161C
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 11:09:35 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id u185-20020a2560c2000000b0060fd98540f7so28561ybb.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 11:09:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=QxtNo/KbZx5IgHz5z04uslp6z4FHBvH/n/H++ERzScA=;
        b=TIcbT3J28mGsN75/ffXhPadp0ACFt3wfUEtZOT0VtsvJW7T3V0pbOaiWNGqB5Q75wN
         GjRWvvIXG1VAyESLdtaYvE/pKWUScvfmC3ZkyFPWZ3KRxI0ZewupHRaBmmLqwprRPESi
         fSlFW1MF75Dqc2L9i7ijMwM0a5CxwdbEJj+H30HlBr2NeWN0p8mklEouLVvqctEpVTXr
         oTX8Xp7a8fH5Y0hEcWkiXzHLhQb3Qw2gFhCwOyyRsqETapkJeMLnGuLWdfFsJkyhBOYM
         GGvqlo+laECpJnd0Ftm2wYRhmRtnawyP5ALf3fqE3bwkPMMzLJaTNQn+DsWTRsXjs4eP
         rbRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=QxtNo/KbZx5IgHz5z04uslp6z4FHBvH/n/H++ERzScA=;
        b=4ybt7rIiOaHv5r9uYVpYUAb5BQOGVWyqyjjdOmL40bgvdMEJ9bonJr/x1TP/0KA94/
         tIKIJB6u5YPeVv54bkIg4K9wujIn3qTBYsyWFk+XYJGd+w1cd+OVI9IuxT81KIuwMjWZ
         VDHLFe2ZTiOlloAjKCfscrGZgccyhA6mESGWlkawzwB7lpwValR26aqKMet/UoT0pmu6
         vCkFMOprolbOCUpydBUAtZQMdJXPQ6/Lx4vBcm7wgNYqmHvIHG6eMq9h8HoIE3JCXx37
         y0QYYBwXPfK41w/+kKSo3Evuf8ZPWSrnSYG0agOOAXoz5AhHmpO7FDMIgsv1u7Uk7xGq
         94LA==
X-Gm-Message-State: AOAM533ORj76ZrytWuXzOmIdlb7EJDb5C08u/Pj8M+72ufDLCrpKxE0F
        cpH2JH/Oey+kMaXC8JCgYVfbotblZroqWA==
X-Google-Smtp-Source: ABdhPJxleYIHreqkjvrzoaXG2AuFv3qsi4KjCyFK4enyPmfwWEIVgu0nzQpIOWBZyg/CwWvmplE/WwIWE9ef1w==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:7fc9:5977:ab73:1d36])
 (user=dlatypov job=sendgmr) by 2002:a05:6902:1365:: with SMTP id
 bt5mr26930889ybb.145.1642532974676; Tue, 18 Jan 2022 11:09:34 -0800 (PST)
Date:   Tue, 18 Jan 2022 11:09:20 -0800
In-Reply-To: <20220118190922.1557074-1-dlatypov@google.com>
Message-Id: <20220118190922.1557074-3-dlatypov@google.com>
Mime-Version: 1.0
References: <20220118190922.1557074-1-dlatypov@google.com>
X-Mailer: git-send-email 2.34.1.703.g22d0c6ccf7-goog
Subject: [PATCH 3/5] kunit: tool: drop unused KernelDirectoryPath var
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit be886ba90cce ("kunit: run kunit_tool from any directory")
introduced this variable, but it was unused even in that commit.

Since it's still unused now and callers can instead use
get_kernel_root_path(), delete this var.

Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
 tools/testing/kunit/kunit.py | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index bd2f7f088c72..4cb91d191f1d 100755
--- a/tools/testing/kunit/kunit.py
+++ b/tools/testing/kunit/kunit.py
@@ -63,8 +63,6 @@ class KunitRequest(KunitExecRequest, KunitBuildRequest):
 	pass
 
 
-KernelDirectoryPath = sys.argv[0].split('tools/testing/kunit/')[0]
-
 def get_kernel_root_path() -> str:
 	path = sys.argv[0] if not __file__ else __file__
 	parts = os.path.realpath(path).split('tools/testing/kunit')
-- 
2.34.1.703.g22d0c6ccf7-goog

