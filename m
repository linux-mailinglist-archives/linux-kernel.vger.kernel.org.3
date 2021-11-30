Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBF0F463663
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 15:17:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242151AbhK3OUV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 09:20:21 -0500
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:54664 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242133AbhK3OUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 09:20:20 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id 4J3PRc5kGZz9vJrY
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 14:17:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id VvEai6NfXIgZ for <linux-kernel@vger.kernel.org>;
        Tue, 30 Nov 2021 08:17:00 -0600 (CST)
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id 4J3PRc3fdlz9vJrX
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 08:17:00 -0600 (CST)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p7.oit.umn.edu 4J3PRc3fdlz9vJrX
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p7.oit.umn.edu 4J3PRc3fdlz9vJrX
Received: by mail-pj1-f71.google.com with SMTP id b8-20020a17090a10c800b001a61dff6c9dso6851852pje.5
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 06:17:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Br9hM7P/V/R39racOZSbovY60IQqXaZlTn4ZHVtwfgE=;
        b=F/plmO+lDIBEUmhbzZT9f4kxQ1Xrqyir+jK2tT0U4wr8TJJ6EKuuTfxvk4jjv3vkJv
         BW3tZWfIWNTuRVA3ewqNODzHaWhICIFxNCqJDHWLTJrsExH1A1IYMkkREyn5kaFnallc
         KxPHQg6n+trmZGL5qLwkWqYF7ipwIdpXnXwE1g+XJw5cYoJ1fjTTOthppmJkR6e4Tm4F
         cmRiBb0rWHQR3yF/UIqg/+M99wJ1MpgaSfhRyq6QUvOYXYfNPgEVCZtb6sCTyA7wRFsO
         k4tcLiOLVewR714qjx69DdNvXujpyGDA8SBzDORGW/ojUgV9wJhkPtn//H4ChM8lHVHv
         S4Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Br9hM7P/V/R39racOZSbovY60IQqXaZlTn4ZHVtwfgE=;
        b=2QR8mQT1LoxKZXgtOH75pZFtyMoW5+KHrMGcsZNhNSXLfccXulBtkxnxE9k3yL0/0p
         9rJvJBCnoPvR/Is1TX+ZD5b6Ys/qZAX3X8JFEwVPZx2EmiJLMMvKLJxM/aNImYzaimUT
         b7fzmBLEkGNS8gxAc5gWFGaUqF3ToIQpY7JRrw967lzxSOAN0zJwewetSZW0vuxccI1z
         yRHgzd33uOm6v4U/2SMCWjz7DxvbUsqxT+MkrTayPuD16HN9KTop/w/TtL3QZiwSeTNQ
         ZhEyOobaAyCa8pHCX9gGITLjtp58ucT3SCgru4Q8FRtHdgOpx8HA13JBdNBLskPSwfsy
         5C1A==
X-Gm-Message-State: AOAM533wgCZ26d6LPxH506vzB/1N2qSyDaRxVFv1X0e/vOkVyVGZRJNQ
        QQ2o6htoouyX2zfarsWE1MZ9UTuvzKUuC8hQzBrr4BN3chhLlK8hZ5CmlydaTqjqhyzt4znw0Cd
        twaq1Yz1ADdvvWvBcilr2JYPo2Qtx
X-Received: by 2002:a65:4d03:: with SMTP id i3mr10181757pgt.623.1638281819744;
        Tue, 30 Nov 2021 06:16:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwYhKO0APLVwerxxpbVWgXBtWNaBFn9ENpSead2gdy6fg/I7r3VA59NSxP8PMR0M6Q2gB5YBg==
X-Received: by 2002:a65:4d03:: with SMTP id i3mr10181744pgt.623.1638281819551;
        Tue, 30 Nov 2021 06:16:59 -0800 (PST)
Received: from zqy787-GE5S.lan ([36.7.42.137])
        by smtp.gmail.com with ESMTPSA id q13sm21904082pfk.22.2021.11.30.06.16.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 06:16:59 -0800 (PST)
From:   Zhou Qingyang <zhou1615@umn.edu>
To:     zhou1615@umn.edu
Cc:     kjlu@umn.edu, Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Mika Kuoppala <mika.kuoppala@linux.intel.com>,
        John Harrison <John.C.Harrison@Intel.com>,
        Zhihao Cheng <chengzhihao1@huawei.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Matthew Brost <matthew.brost@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Matthew Auld <matthew.auld@intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/i915/gem: Fix a NULL pointer dereference in igt_request_rewind()
Date:   Tue, 30 Nov 2021 22:15:44 +0800
Message-Id: <20211130141545.153899-1-zhou1615@umn.edu>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In igt_request_rewind(), mock_context(i915, "A") is assigned to ctx[0]
and used in i915_gem_context_get_engine(). There is a dereference
of ctx[0] in i915_gem_context_get_engine(), which could lead to a NULL
pointer dereference on failure of mock_context(i915, "A") .

So as mock_context(i915, "B").

Although this bug is not serious for it belongs to testing code, it is
better to be fixed to avoid unexpected failure in testing.

Fix this bugs by adding checks about ctx[0] and ctx[1].

This bug was found by a static analyzer. The analysis employs
differential checking to identify inconsistent security operations
(e.g., checks or kfrees) between two code paths and confirms that the
inconsistent operations are not recovered in the current function or
the callers, so they constitute bugs.

Note that, as a bug found by static analysis, it can be a false
positive or hard to trigger. Multiple researchers have cross-reviewed
the bug.

Builds with CONFIG_DRM_I915_SELFTEST=y show no new warnings,
and our static analyzer no longer warns about this code.

Fixes: ca883c304f54 ("drm/i915/selftests: Pass intel_context to mock_request")
Signed-off-by: Zhou Qingyang <zhou1615@umn.edu>
---
 drivers/gpu/drm/i915/selftests/i915_request.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/i915/selftests/i915_request.c b/drivers/gpu/drm/i915/selftests/i915_request.c
index d67710d10615..d6fc7b892793 100644
--- a/drivers/gpu/drm/i915/selftests/i915_request.c
+++ b/drivers/gpu/drm/i915/selftests/i915_request.c
@@ -209,6 +209,10 @@ static int igt_request_rewind(void *arg)
 	int err = -EINVAL;
 
 	ctx[0] = mock_context(i915, "A");
+	if (!ctx[0]) {
+		err = -ENOMEM;
+		goto err_ctx_0;
+	}
 
 	ce = i915_gem_context_get_engine(ctx[0], RCS0);
 	GEM_BUG_ON(IS_ERR(ce));
@@ -223,6 +227,10 @@ static int igt_request_rewind(void *arg)
 	i915_request_add(request);
 
 	ctx[1] = mock_context(i915, "B");
+	if (!ctx[1]) {
+		err = -ENOMEM;
+		goto err_ctx_1;
+	}
 
 	ce = i915_gem_context_get_engine(ctx[1], RCS0);
 	GEM_BUG_ON(IS_ERR(ce));
@@ -261,9 +269,11 @@ static int igt_request_rewind(void *arg)
 	i915_request_put(vip);
 err_context_1:
 	mock_context_close(ctx[1]);
+err_ctx_1:
 	i915_request_put(request);
 err_context_0:
 	mock_context_close(ctx[0]);
+err_ctx_0:
 	mock_device_flush(i915);
 	return err;
 }
-- 
2.25.1

