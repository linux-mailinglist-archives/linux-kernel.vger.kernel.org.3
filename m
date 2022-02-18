Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60E964BB6E7
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 11:29:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233556AbiBRK3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 05:29:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231464AbiBRK3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 05:29:01 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6183B39BA3;
        Fri, 18 Feb 2022 02:28:45 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id v4so8188255pjh.2;
        Fri, 18 Feb 2022 02:28:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hZxv3pHz6Udq1OzuuR9MJTgehSeTgSTYX6aQTnuEBto=;
        b=DelbllCB/RnzeNnQQUFk7K6N1cJt9lxouz4gqHucg3Uoadz8eU7vuIxQO54qf3Gid4
         2sNHQLHRI8ReIxh1KgWSg2K40KyZXT2/BfvwhzRgRO/prp2gzJnc/QLjoUMSFoQnrarp
         o+omlMWVM0lLTUWf1fgsOEENwOHGp+1WGm5aJNZLzVPwtr0kEqVtBhZ6UijYyRMz3FcK
         qQ2gW/WaTpyLD9ewHu/QUYzWYur+IXe7JZ3b0BjvZT5CZjMXsoSfUnBwggdcXit0/yx+
         95bvqo8tks7yD9HOQPoYm6Rbzcm2YpbVYYbynYex7LZmZMyva8lFyUUlno+jaT3xisY3
         4v6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hZxv3pHz6Udq1OzuuR9MJTgehSeTgSTYX6aQTnuEBto=;
        b=AzSzYugGdbv1a2BtVpR4kMfxKa+P1BLvdBseOkcyVCjaqGbMDK21VymZ8nmNCZSvH5
         jP5H0JHMYW1qnG3KyXKh61Urr/wuFVClUstS7QnPtyjCGIp+L0oTIMcFBegaW98dLj8k
         in50ZrXtGk8fSPfF4qr+L3FCgYiBpeAqt+fihLnPzt/cqhHo8viDzlnJF82hwvKTKFn/
         S6h8MZahGEYYsPsfP9TGCRHXYnkU7ikA7jQTv8Mew2ek9u7KpiJcG4UchGKp/MNy9cYe
         Y4EdLu8WtHvnYl1qHYPW47fj+qblS7Bj7MFQYr9rSVEQIn+toKqPTK2qwcehMa2jhohJ
         8KVw==
X-Gm-Message-State: AOAM531apC151vddiOoQYUvdDW84aMxmpnVnlidkobLR+Nryr3wq7som
        FslCNwTDGbzyupyMpZeZPLk=
X-Google-Smtp-Source: ABdhPJwxbtXRkf7mBwYXDUF8FymlXpTcaK8hVmcTvlAMUfv4/X0OyE197uN+tCZ27Bkb605Rvg773g==
X-Received: by 2002:a17:90b:1283:b0:1b9:cfb1:9cad with SMTP id fw3-20020a17090b128300b001b9cfb19cadmr11919710pjb.82.1645180124984;
        Fri, 18 Feb 2022 02:28:44 -0800 (PST)
Received: from localhost.localdomain ([101.78.151.222])
        by smtp.gmail.com with ESMTPSA id 16sm2676856pfl.99.2022.02.18.02.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 02:28:44 -0800 (PST)
From:   Rex Nie <rexnie3@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, hsinyi@chromium.org,
        Rex Nie <rexnie3@gmail.com>
Subject: [PATCH 2/2] dt-bindings: display: simple: Add InnoLux n140hca-eac panel
Date:   Fri, 18 Feb 2022 18:28:15 +0800
Message-Id: <20220218102815.1634561-1-rexnie3@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for InnoLux n140hca-eac display panel. It is a 14" eDP panel
with 1920x1080 display resolution.

Signed-off-by: Rex Nie <rexnie3@gmail.com>
---
 .../devicetree/bindings/display/panel/panel-simple.yaml         | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
index 1eb9dd4f8f58..f8383a8dc3dc 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
@@ -180,6 +180,8 @@ properties:
       - innolux,n116bge
         # InnoLux 13.3" FHD (1920x1080) eDP TFT LCD panel
       - innolux,n125hce-gn1
+        # InnoLux 14" FHD (1920x1080) eDP TFT LCD panel
+      - innolux,n140hca-eac
         # InnoLux 15.6" WXGA TFT LCD panel
       - innolux,n156bge-l21
         # Innolux Corporation 7.0" WSVGA (1024x600) TFT LCD panel
-- 
2.25.1

