Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF23346DB9C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 19:55:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239457AbhLHS6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 13:58:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232216AbhLHS6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 13:58:36 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0A14C061746;
        Wed,  8 Dec 2021 10:55:03 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id y12so11302659eda.12;
        Wed, 08 Dec 2021 10:55:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r2KFZ69t1/696UTdyUen1WkYuVyfWbC1SxhC6bkU9vU=;
        b=Y7NxYnZ7I8yFTdefJinSE3jW81dH3xBPem5Djjox1JKJNOV2TN5G04JI7ZxgVEy7Fz
         iwDmTOX5sgG7khvVXLqV1pqFMsfgXBo9Qo4GTK5R99snfdtpP0iTHAaIRb5GUvMZpoOH
         QQkxgEATj8Uqr0vJXX0uHxbS3tCDQbyLhx3+or5BQm5JRDZhkFNUDv0/lPTYTNgTgs9M
         4Mw9mmfhXt7jfz+i1wojCbAhURhxLUMy4ROeNZyfMe41ClOaOEeCH8zTioGq57slnt4k
         W2RAwPYub23hR7f4NdPXs7zvoxqvjeXWmcaxgM/RLAd4dESnmLjBTkijLXTyLjgsE/RA
         mnwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r2KFZ69t1/696UTdyUen1WkYuVyfWbC1SxhC6bkU9vU=;
        b=IvMOWol9GkIy8x9beTzZHJ6G7apcluw1uStgzkGwlyncop3PRKHw3KgCbXipd4XwNm
         PNP+DGMSXZf/s4tENAnov/co6Xz401j5qcLNX5RTB4YKf86ZNeatYMPz1hinkXZ95hWD
         9xLfDdm8G1PbFPUHnUEmvnJt0NRc1A4f/95KkY1HfJ27PMEeAez5MgE3Z4FyIjhUGjH+
         6p+3uWEAfDjFWkPEr9tIKHN7fXiRJoLtChThVvzeFPhGrVaI9HPjEUSdje9ZUekYn86P
         No5H4pGvzXmsPViyGSOi7Jqm0RQ+onlrCZKWXLrQH8Xh4ak9vtXZCZqoQGyXa12ThYZ8
         /Sgw==
X-Gm-Message-State: AOAM5330LUaVGvkTthsF15kpNNeRsnXP11FrfhJb77YcpV914kZV/5oz
        24jcVtDadBwMH1QJWX848Jo=
X-Google-Smtp-Source: ABdhPJw0v6t6h30G+ShdLLU1olSh9d5rWV5SFj1vm8f7Y0l++eItxwnVQa9tQMXNuAirVao5rQqQ4g==
X-Received: by 2002:a17:906:2dcd:: with SMTP id h13mr9419142eji.135.1638989701773;
        Wed, 08 Dec 2021 10:55:01 -0800 (PST)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id g18sm1862273ejt.36.2021.12.08.10.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 10:55:01 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, kishon@ti.com, vkoul@kernel.org,
        p.zabel@pengutronix.de, yifeng.zhao@rock-chips.com,
        kever.yang@rock-chips.com, cl@rock-chips.com,
        linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH v4 1/4] dt-bindings: mfd: syscon: add naneng combo phy register compatible
Date:   Wed,  8 Dec 2021 19:54:46 +0100
Message-Id: <20211208185449.16763-2-jbx6244@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211208185449.16763-1-jbx6244@gmail.com>
References: <20211208185449.16763-1-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add naneng combo phy register compatible.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 Documentation/devicetree/bindings/mfd/syscon.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
index 5de16388a..9f0c8aa81 100644
--- a/Documentation/devicetree/bindings/mfd/syscon.yaml
+++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
@@ -52,6 +52,8 @@ properties:
               - rockchip,rk3288-qos
               - rockchip,rk3368-qos
               - rockchip,rk3399-qos
+              - rockchip,rk3568-pipe-grf
+              - rockchip,rk3568-pipe-phy-grf
               - rockchip,rk3568-qos
               - samsung,exynos3-sysreg
               - samsung,exynos4-sysreg
-- 
2.20.1

