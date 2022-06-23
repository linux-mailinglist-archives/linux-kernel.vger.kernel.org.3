Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5485557813
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 12:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbiFWKpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 06:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbiFWKpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 06:45:35 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E45034B1C9;
        Thu, 23 Jun 2022 03:45:33 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id e10so440706wra.11;
        Thu, 23 Jun 2022 03:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=yo+6S0bVZFj15xUOaX5n49aCMwaG4HuXlgCxrBpq27U=;
        b=ndcxBl5Qp9eJ5nzkxN5EDiysnSYxHsPzzxVtTBrzCAXf7gHChskFXfTA/lgd3652Ec
         J5tvhQv0JKa3eBxOhvHArneOqOo2Xl5azPCn7cMXMIjtyy9+KtOGbLJ3f++OcvZgDAio
         U7OYIVJ8iRlAdQ7jY9WXKCysFb+/Ds2rc1L0bSjiSHTJELOZWL2ZmhKH4rPvRKOB70pG
         AfdjDE/xYQpcbWSSp3R1F8LWoLi+PACi70QEat6livKlUbkTzEdaurjK1vptIxiPERrK
         OeFidGna+Y1fiRxq3h0wdOjrYI+UvijOW7QIGEkA34SoKvYc9GIZ54bVWWKIwXq2igWv
         TsSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=yo+6S0bVZFj15xUOaX5n49aCMwaG4HuXlgCxrBpq27U=;
        b=wwNeEZP2wBErSjaofm+QKgoLBiPZBncBi/0k2+NsAh3v6DPGGeO0xmSm0qciG/NDEw
         25tbkLRw5Ui4rwp+9UIeuun+a+8isMI/2Y2+eJH9mFpudsrJyAgvWgPb0luglm/4kByD
         A8zIZPV6FqE3DxxHc6rDtN8gomFkvqmCY3PNu9rrK7vwy6FF8G3tjGfLC2xoXKo5H8lq
         fAvRtnWW863NhozZBcByvMpPnItIA+Bv1KDy3mipYYWOLNgi7cPPiIeYvqqyReI5G6RG
         Qqa4r2k65RYHLWo+G+tb0gI3kXKtnnhRJTa/CAsBC7ZqpFrJCo4wgqn1hBAr/B0Unba7
         90ZQ==
X-Gm-Message-State: AJIora/c1hQW8y6Dg5tGgJgacCSG/LkkBCbTSxtXkjtWkv9AgkgmXZK0
        009D2lowGAPmb/3lA/5VIMM=
X-Google-Smtp-Source: AGRyM1vEQj2z1+nh+K5QWnNPP8grCm8e9ggnCkbXxCVsOjntLeecur3FWso/i01QzH0STWsbvgykCg==
X-Received: by 2002:adf:e104:0:b0:21b:9938:b07a with SMTP id t4-20020adfe104000000b0021b9938b07amr7798958wrz.682.1655981132441;
        Thu, 23 Jun 2022 03:45:32 -0700 (PDT)
Received: from felia.fritz.box (200116b826a89a00b5a52346a320d486.dip.versatel-1u1.de. [2001:16b8:26a8:9a00:b5a5:2346:a320:d486])
        by smtp.gmail.com with ESMTPSA id l35-20020a05600c1d2300b0039c95b31e66sm2760949wms.31.2022.06.23.03.45.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 03:45:31 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Conor Dooley <conor.dooley@microchip.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     Support Opensource <support.opensource@diasemi.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: repair pattern in DIALOG SEMICONDUCTOR DRIVERS
Date:   Thu, 23 Jun 2022 12:44:56 +0200
Message-Id: <20220623104456.27144-1-lukas.bulwahn@gmail.com>
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

Commit 441613662db7 ("dt-bindings: mfd: Convert da9063 to yaml") converts
da9063.txt to dlg,da9063.yaml and adds a new file pattern in MAINTAINERS.
Unfortunately, the file pattern matches da90*.yaml, but the yaml file is
prefixed with dlg,da90.

Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about a
broken file pattern.

Repair this file pattern in DIALOG SEMICONDUCTOR DRIVERS.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
Conor, please ack.
Lee, pleae pick this minor non-urgent clean-up patch.

 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index f84dba7ee301..4b08464abb1b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5876,7 +5876,7 @@ W:	http://www.dialog-semiconductor.com/products
 F:	Documentation/devicetree/bindings/input/da90??-onkey.txt
 F:	Documentation/devicetree/bindings/input/dlg,da72??.txt
 F:	Documentation/devicetree/bindings/mfd/da90*.txt
-F:	Documentation/devicetree/bindings/mfd/da90*.yaml
+F:	Documentation/devicetree/bindings/mfd/dlg,da90*.yaml
 F:	Documentation/devicetree/bindings/regulator/dlg,da9*.yaml
 F:	Documentation/devicetree/bindings/regulator/da92*.txt
 F:	Documentation/devicetree/bindings/regulator/slg51000.txt
-- 
2.17.1

