Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A474955773B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 11:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231407AbiFWJ4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 05:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231365AbiFWJ4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 05:56:06 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F78C4615F;
        Thu, 23 Jun 2022 02:56:05 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id s1so27142426wra.9;
        Thu, 23 Jun 2022 02:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=6Cgf9hVSkM/EuU/G5NtEggFm/5gYU2/ohft6Hi2iUoM=;
        b=DLmoXC2LYtmMgIH+URO1IHtjbJCkAlV59T4EGENzDuHw84VK8aoJRf91/NSWhHmkLq
         la7BekdDXIMQn5158NIifoyNSxZ8rOGLI4tmMtNQuFu09+Je2Cxuo7h8SQQMIVXThZMs
         8VT/86TI0kDnTa4ob3cL1JI/mU9v/1Gz51zfzHYQ8A/8LW2xVMxzdv4Ob9qaA8GOv6xS
         Yi4R3/5NY9nOtFNzri5fKyCDwKG0PRRndmIRvK8O17szrd38RoIwjZMS2x+ZesVzcP2F
         5+3Gn513loHRpcMpd3PgraUPt+wVBI+8OrOXqaF5u2M7VX29rSW+A5iNjl/6PBL0wYKs
         dCIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6Cgf9hVSkM/EuU/G5NtEggFm/5gYU2/ohft6Hi2iUoM=;
        b=b+qEexuLvQEmLtIUFiBRosWADih45Zu3iIzuFMVrd5QltGgsOgjb5/So4aKXFbxXRB
         Kz006KsYPjWWsy2LO3HYCt4bY9a2E89EpaNPUvM76ypHaST1vHOuY9SqjJXceD6tCX4+
         gnlFWWzbGi3xTZFYSkRule/nW6VdX2EShd0zQd0tfXSDGr+NooszkvEqRUiZeZNOhnV8
         fOT2kJnGasLpVpYToDUz4FKpGohIlEkaI1Nq3INbA3Ra9N4NhVmETFdpphHD2cWYygDL
         68pizVV7pNWzcIeTGHBWw6RTE6tZO/8qgB6eTtoAng4zjRY4XAegtfywAoS7/QBcHsqx
         MRnw==
X-Gm-Message-State: AJIora/kK6BMb9aCxttFJ1inNR4V1ArynBGPKnRQBtkh+wmJr/R8cBx0
        n1AGCaOUZG2znNdWsCvHB/sy7L/M4zI=
X-Google-Smtp-Source: AGRyM1vZrhIfv6R1QkV1NYPXd8xWwai/oZGPfNY5LyQaTGsyWgUNU53R1OmMZyCCfCJniSdsnvSlzA==
X-Received: by 2002:a05:6000:1a89:b0:21b:83a9:aa6f with SMTP id f9-20020a0560001a8900b0021b83a9aa6fmr7545833wry.33.1655978163774;
        Thu, 23 Jun 2022 02:56:03 -0700 (PDT)
Received: from felia.fritz.box (200116b826a89a00b5a52346a320d486.dip.versatel-1u1.de. [2001:16b8:26a8:9a00:b5a5:2346:a320:d486])
        by smtp.gmail.com with ESMTPSA id bp17-20020a5d5a91000000b0021b9870049dsm7938326wrb.82.2022.06.23.02.56.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 02:56:03 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: rectify entry for NVIDIA TEGRA DRM and VIDEO DRIVER
Date:   Thu, 23 Jun 2022 11:54:52 +0200
Message-Id: <20220623095452.30745-1-lukas.bulwahn@gmail.com>
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

Commit fd27de58b0ad ("dt-bindings: display: tegra: Convert to json-schema")
converts nvidia,tegra20-host1x.txt to yaml, but missed to adjust its
references in MAINTAINERS.

Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about a
broken reference.

Repair these file references in NVIDIA TEGRA DRM and VIDEO DRIVER.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
Thierry, please pick this minor non-urgent clean-up on top of the commit above.

 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1e99a4249dba..f84dba7ee301 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6767,7 +6767,7 @@ L:	dri-devel@lists.freedesktop.org
 L:	linux-tegra@vger.kernel.org
 S:	Supported
 T:	git git://anongit.freedesktop.org/tegra/linux.git
-F:	Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.txt
+F:	Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.yaml
 F:	Documentation/devicetree/bindings/gpu/host1x/
 F:	drivers/gpu/drm/tegra/
 F:	drivers/gpu/host1x/
@@ -19757,7 +19757,7 @@ M:	Sowjanya Komatineni <skomatineni@nvidia.com>
 L:	linux-media@vger.kernel.org
 L:	linux-tegra@vger.kernel.org
 S:	Maintained
-F:	Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.txt
+F:	Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.yaml
 F:	drivers/staging/media/tegra-video/
 
 TEGRA XUSB PADCTL DRIVER
-- 
2.17.1

