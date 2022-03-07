Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7488D4D0239
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 16:00:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243499AbiCGPA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 10:00:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243285AbiCGPAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 10:00:53 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B184C3CA65;
        Mon,  7 Mar 2022 06:59:58 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id w4so17779258edc.7;
        Mon, 07 Mar 2022 06:59:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=VVnlaWLoAj4ztYijY1PVJxwx/BOoH/almjRyiU6VmRk=;
        b=U/2luno5Chz3HyhMJsWNx9qQ1evwDAUbNkzGgKymgJHrNHS4ZLz3I6xud1s1X+s6Fi
         rdyW+PV0npzc1qR0Z58dXus71PCDmTFIG/OG8OcDBZb3oYjqRTigMYgCH/DGf6A+3EMu
         It5Evf9qGVfZZ7TUMNPInYS4J7pXjPqLl78tkpt0A4BCOloWgGApEaUBWR8Yb36tfv/s
         OQ+lq3TvX5cjO1tygs0wkg9hQ+VqlgcH7D5sF4GZhXRO/w6gQNWaC216KkiYUMjszZ75
         bCHFzgqfuNE500qkjS4re6PcidMvohmAU6xeNyJ1YCC1DZESS68G5/Ji3mgHcRygrwuj
         X2xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=VVnlaWLoAj4ztYijY1PVJxwx/BOoH/almjRyiU6VmRk=;
        b=OTtFdq/U8FjpsCDLxVWYCZ4DlpSFM9td2TZdmRW7vbJ0O5Te97Gf2VCQJ4Y4NTZ4wg
         I6kRf4inFBFyhx2H5QZBjn3vjPUlrzOdNoAl3gwV5JWjZcj/4S9GqCbuyh0PNnoEbM9l
         773SUtjAj/I12tOlIMNkMLTZATnjFUmqXf6ZS0feFlEzUfsmcVLEIOrLCG2oWFMDAb+o
         mKpdrffqcV8qXd52mmfrK0FiSyNKEp8G9g7SeuBE7S2gbpvakXG+zXchE5iQEto2pVdW
         NVRh9bHyMMDqvfbEGs+CHpRwfT6jCP0OXTD/2nUF66d8ID3rna3UAWo0EJrwam7BvHbt
         H9LQ==
X-Gm-Message-State: AOAM5326BvMT7jkP4S8wTOxLE8eSO7/aXoaompgjWCyTsFPgkMfLRJfR
        l4SiqVVxm9sY7swNbPpssBM=
X-Google-Smtp-Source: ABdhPJz+iG+iwPoRYF1WfXSNBaaS2QmqI3mVJ9w/cDNyUryjnV1HzUyeATY108wz4okfIFkZMbHYWA==
X-Received: by 2002:aa7:c5d7:0:b0:415:ee77:d6f2 with SMTP id h23-20020aa7c5d7000000b00415ee77d6f2mr11542074eds.208.1646665197090;
        Mon, 07 Mar 2022 06:59:57 -0800 (PST)
Received: from felia.fritz.box (200116b826f87d0045da35f0fd1c76e8.dip.versatel-1u1.de. [2001:16b8:26f8:7d00:45da:35f0:fd1c:76e8])
        by smtp.gmail.com with ESMTPSA id h30-20020a056402095e00b00412b81dd96esm6218261edz.29.2022.03.07.06.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 06:59:56 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-media@vger.kernel.org, linux-tegra@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-staging@lists.linux.dev, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: rectify entry for  MEDIA DRIVERS FOR NVIDIA TEGRA - VDE
Date:   Mon,  7 Mar 2022 15:59:35 +0100
Message-Id: <20220307145935.13178-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit ccc3016261ed ("media: dt: bindings: tegra-vde: Convert to schema")
converts nvidia,tegra-vde.txt to nvidia,tegra-vde.yaml, but missed to
adjust its reference in MAINTAINERS.

Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about a
broken reference.

Repair this file reference in  MEDIA DRIVERS FOR NVIDIA TEGRA - VDE.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
Dmitry, please ack.

Thierry, please pick this minor non-urgent clean-up patch.

 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 05fd080b82f3..2b96a22cf5ea 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11964,7 +11964,7 @@ L:	linux-media@vger.kernel.org
 L:	linux-tegra@vger.kernel.org
 S:	Maintained
 T:	git git://linuxtv.org/media_tree.git
-F:	Documentation/devicetree/bindings/media/nvidia,tegra-vde.txt
+F:	Documentation/devicetree/bindings/media/nvidia,tegra-vde.yaml
 F:	drivers/staging/media/tegra-vde/
 
 MEDIA DRIVERS FOR RENESAS - CEU
-- 
2.17.1

