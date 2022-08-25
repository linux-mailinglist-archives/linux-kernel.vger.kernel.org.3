Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3C885A157D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 17:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240558AbiHYPU6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 11:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiHYPUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 11:20:55 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 917E65E573;
        Thu, 25 Aug 2022 08:20:54 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id y3so13839153ejc.1;
        Thu, 25 Aug 2022 08:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc;
        bh=WZ8MQtJvC/KpySjQ3aROp2zGmulLJPZErMxtsAeIFY8=;
        b=leK+enpXEtB2wG033uP8ZGyjWLkAvT6bOnLKtKm8FQqsLCEGaMyEdAmDY+RbiC4b2Y
         7LiDN4/bZSuLYDOWkVIRRlGcgIjeVDx52aCik96/+w2Wb7o9BiD8sOSbcoe1ahmxGrR/
         oKQZuVDMci+Qm/zXV+8/KjxSe9QRX7gka2oF+Puo2SfvFiJXmmVQe+JH8IXB48BJMnSV
         0Zehu0CRsEoAYLSBRMNxGZR0fVrUv/Xq5dnDDL7HTd7KeJYBsrDHxjaaxBEbOIVpbUeI
         e8wUJSjGRWFZaJ1/2Ahr7jePwlaobNoN1dMpLLAHc5XDryTBRKlkgWDSQt/SUPi7msm0
         Nu/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=WZ8MQtJvC/KpySjQ3aROp2zGmulLJPZErMxtsAeIFY8=;
        b=cCfWKZjkQvZWXRVbNPvTjiOjjsodH8l4UtVHDPnxvo2SkcRbfWItRLbfj0Ptt9jgOK
         ATYepuEu1Dh6Sq4D/haUix/yskAI8SZgoUY3GUF0LmaeHvHWbsJ7DnmfPKIAyDfHMNDQ
         n0INaozOln7C40SLxP0uh2C80RYt0yJpD2nhrnxKgdIBfde65qb+N8wdqiuhFi6JS0yo
         Px6xdPaBUnLt6NcBR7v9wUSeOwnxUPXFIrm097w+SFLtrDDyBv1i31UtHfnYtO5Z+hm5
         8uUmkKlLY/h+Pu07Q3hZYvCsM5egAdOwhiJt8VtM5Ww6lO2aUsHHXJEiErYzq0sK+huw
         uYUA==
X-Gm-Message-State: ACgBeo0rYddu3WtRCjxmQAfbd/8FpLRHpRBYuVtvaUKIb5CmdTOCuGNy
        ftbQl0oW/G1Sz0NJw9eoFKRKAa+C45M=
X-Google-Smtp-Source: AA6agR6i4DjhSEw5Gp1aeR1LlFSo+e1tW7M06AcHbsbz4bR53X/cpd8jeUi0ALEfMH444LQ7sCPKYw==
X-Received: by 2002:a17:907:6eaa:b0:73d:81db:64d0 with SMTP id sh42-20020a1709076eaa00b0073d81db64d0mr2745039ejc.334.1661440853040;
        Thu, 25 Aug 2022 08:20:53 -0700 (PDT)
Received: from felia.fritz.box (200116b8261c3400c04988a24c54b107.dip.versatel-1u1.de. [2001:16b8:261c:3400:c049:88a2:4c54:b107])
        by smtp.gmail.com with ESMTPSA id a24-20020a170906369800b00730979f568fsm2566580ejc.150.2022.08.25.08.20.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 08:20:52 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-spdx@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: add spdxexclude to LICENSES and SPDX stuff
Date:   Thu, 25 Aug 2022 17:20:29 +0200
Message-Id: <20220825152029.12660-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 0509b270a358 ("scripts/spdxcheck: Put excluded files and directories
into a separate file") moved excluded files to the new file
scripts/spdxexclude, but did not adjust the MAINTAINERS section. The file
scripts/spdxexclude clearly belongs to LICENSES and SPDX stuff.

Add a corresponding file entry.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8022a4dd2ef3..b1b6e6ee2a0c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11622,6 +11622,7 @@ F:	Documentation/process/license-rules.rst
 F:	LICENSES/
 F:	scripts/spdxcheck-test.sh
 F:	scripts/spdxcheck.py
+F:	scripts/spdxexclude
 
 LINEAR RANGES HELPERS
 M:	Mark Brown <broonie@kernel.org>
-- 
2.17.1

