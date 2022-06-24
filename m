Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA87559532
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 10:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbiFXISo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 04:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbiFXISd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 04:18:33 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 522836363F
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 01:18:32 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id cw10so3184911ejb.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 01:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ku+g6mH8ZtuEKNgu6VjhrNGoqiS6ry/wCTbIBt3/GQE=;
        b=SrzkAYFywwE4KrBRkZEgbZe97t9oQ6QOcINHeDh+qKi+h/tULRuRL9up5ahQJi0BHx
         1ERpQV3i5md1keFw6ib4iuscoIXbRMc4OoSTfkf/0JuyBuMx2yE5d+VuCZKlb+e2ydAv
         5qFTFHiUB3q+1qqLpxnDIPd/vqeriUMxtl3SOGo73K2fG9EtHuYeePfSheEb8/8ANM+k
         eG4cghoyIplOCn2+G4c+P8N3X+vglkd9sN1Hc29bRaUxH/EotEksy1u7fQBq3yGl79XY
         IsC5muYGdmRxX1LUj98aoURRTymJvls2yUuxwEUs1nF9bOpnmtzupShon/p7TptCzyHp
         /dTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ku+g6mH8ZtuEKNgu6VjhrNGoqiS6ry/wCTbIBt3/GQE=;
        b=WVSadrtSnwh/nNl4gA54iaJu+Fu8XoGr9fSx4kjVt6jGRVCBDZBnhwWuq1HqVhetp/
         hy/bJjXBkQf3HRQSX0WlCj1ehVN9rGCqKtr018/c3j2g9BvyhAAtRaihXNOUvbiUr3UZ
         O/vtZh6Iyq0NecwSIMgM44HQOECfVpkxxObJE0w+q58viWXuPle1JutiE4pmvrVni7H4
         3PDYbjgsAjZSsQHHnEolT4NBduVmkjx/BsXfU1s/Ascg5eURq1inS+MGPslG2TmsEswE
         FWN2UMjDna42Ft+2zCZOq58C8+gSIX1K/zjUR7G8Y7NTUhGrAL4esP/nwyz6ftuW2Ufc
         XmsQ==
X-Gm-Message-State: AJIora+eiUsUHZHD4jAmaC51LhrKOSN7Ci4519PMQe5Jl13bIKwRLPY/
        4JWy3CesZzlnyzDhQXc/fd09PQ==
X-Google-Smtp-Source: AGRyM1vDJ1ilNFbcJCloY+qyC5NXLH/wPECYN7/lSbVjCsXgDAbxJtcZoGXGprbeIgu7cqm5JYVB2A==
X-Received: by 2002:a17:906:147:b0:712:1288:348f with SMTP id 7-20020a170906014700b007121288348fmr11899014ejh.324.1656058710733;
        Fri, 24 Jun 2022 01:18:30 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id a18-20020aa7cf12000000b0043503d2fa35sm1383360edy.87.2022.06.24.01.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 01:18:30 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org, soc@kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
Subject: [GIT PULL] memory: drivers for v5.19
Date:   Fri, 24 Jun 2022 10:18:28 +0200
Message-Id: <20220624081828.33649-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit f2906aa863381afb0015a9eb7fefad885d4e5a56:

  Linux 5.19-rc1 (2022-06-05 17:18:54 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-mem-ctrl.git tags/memory-controller-drv-5.20

for you to fetch changes up to 0d97f2176dec9c1e070215c4e28ba87e036458c9:

  memory: mtk-smi: Add support for MT6795 Helio X10 (2022-06-06 11:11:50 +0200)

----------------------------------------------------------------
Memory controller drivers for v5.20

Add MediaTek MT6795 Helio X10 SMI support.

----------------------------------------------------------------
AngeloGioacchino Del Regno (2):
      dt-bindings: memory: mtk-smi: Add MT6795 Helio X10 bindings
      memory: mtk-smi: Add support for MT6795 Helio X10

 .../memory-controllers/mediatek,smi-common.yaml         |  1 +
 .../bindings/memory-controllers/mediatek,smi-larb.yaml  |  1 +
 drivers/memory/mtk-smi.c                                | 17 +++++++++++++++++
 3 files changed, 19 insertions(+)
