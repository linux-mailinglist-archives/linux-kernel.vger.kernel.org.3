Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0A9A523695
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 17:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245409AbiEKPB4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 11:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245506AbiEKPBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 11:01:23 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED73032061;
        Wed, 11 May 2022 08:01:21 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id c8so2255491qvh.10;
        Wed, 11 May 2022 08:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BpLpbA3cEdZdB5NVHaxdX/JjV/xBP+7WcQWXCx8dzmk=;
        b=dfkMKQIkw1w9JLBk+Cr9V+7ivJKDpHfFtDTkU6lDsIntJczt3c5Xz5BafK1gXJTWpz
         TyTzxFQjmXdpFvjA/VHnhH44E/xZD70Iy19Iv2NzZMhOpjefhYxyk544Wk+KSjkee1Hw
         LAz/R00EkZVzbntXyEvPycJCSuc8vx0vGwgep51yVYHlNdLzmbhePKhUmTC9wTIZ7PdY
         VZzaInuDI66tSv1I4g6gub1uYBQjYorE9s2AE6z5c8qVDGhe7zz8P4SpWcOBKZuFyVbd
         Myopgc8sGJj00qUA/IZtilWM6AHrTbOMNGAQqls5aMn0ZYMaiiLrfYOkNveLEhRljUNh
         AeLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BpLpbA3cEdZdB5NVHaxdX/JjV/xBP+7WcQWXCx8dzmk=;
        b=PQiZ6/QU431N+AqSIkasYbMlSHppL1Loty7Hl8vfKQ3A11xztrjaefMscT0s0CJgbZ
         +ZUDC/NnNbK3WzkfeR1lGvKQ+Ea6ph+aONnXRoLHYWHtXo31qA0m7NHKj3EXr8FWLIBF
         u43ryUQA+RoSTBMCmo0Kbgp/YyhNrPomg7cPgp7C+QrHY/Ilrs4dGaP1ow/3te/xwna6
         szE4aW7x9tqQlFy9hY0wzBB4zBkUp+6gz1Kxa99pcU/kNL5X9Pu7DxetFllfnOnmGqrW
         Zh/QvgLsLsAFUAbr0CLw4DEEPTVDaxc/JPdFyvl2RDwYMRtdwyEL9jNta/cmzqcPg0uj
         G1ZQ==
X-Gm-Message-State: AOAM533jCoBEl50Qn04AZvl00tkA5ddW6kohcai13DNHXH+SZ2w2NxJX
        gy8Xk8QdSfxAQ2a0c/hp4CqZTpAh9nfvxA==
X-Google-Smtp-Source: ABdhPJx/cQGDrjrK51ktGYIyT1LOfezAIwxXLFpQqnqz5Dd76YXXs+eGPAvYc8cCr3FI5YI5X+yk6A==
X-Received: by 2002:a05:6214:1bcb:b0:45a:afd7:6f72 with SMTP id m11-20020a0562141bcb00b0045aafd76f72mr22702167qvc.20.1652281279783;
        Wed, 11 May 2022 08:01:19 -0700 (PDT)
Received: from master-x64.sparksnet ([2601:153:980:85b1::10])
        by smtp.gmail.com with ESMTPSA id h1-20020a05620a244100b0069fc6484c06sm1487134qkn.23.2022.05.11.08.01.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 08:01:19 -0700 (PDT)
From:   Peter Geis <pgwipeout@gmail.com>
To:     linux-rockchip@lists.infradead.org
Cc:     Heiko Stuebner <heiko@sntech.de>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peter Geis <pgwipeout@gmail.com>
Subject: [PATCH v1 0/6] Cleanups and enablement for Quartz64-A
Date:   Wed, 11 May 2022 11:01:11 -0400
Message-Id: <20220511150117.113070-1-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good Morning,

The following patches clean up some dtbs_check warnings, fixup the
Quartz64-A dts, and enable some additional functionality on the
Quartz64-A.

With this series the only remaining dtbs_check warnings are due to
unconverted bindings.

Patch 6 is dependent on:
13e0ee34f39c arm64: dts: rockchip: add rk356x sfc support
currently in linux-next.


Patches 1 and 2 add some missing bindings to the rk3568 cru.
Patch 3 renames the bluetooth gpios on Quartz64-A.
Patch 4 adds the fan gpio pinctrl on Quartz64-A.
Patch 5 enables sdr-104 on Quartz64-A.
Patch 6 adds the disabled by default sfc controller to Quartz64-A.

Peter Geis (6):
  dt-binding: clock: Add missing rk3568 cru bindings
  arm64: dts: rockchip: add clocks to rk356x cru
  arm64: dts: rockchip: rename Quartz64-A bluetooth gpios
  arm64: dts: rockchip: add Quartz64-A fan pinctrl
  arm64: dts: rockchip: enable sdr-104 on sdmmc
  arm64: dts: rockchip: enable sfc controller on Quartz64 Model A

 .../bindings/clock/rockchip,rk3568-cru.yaml   | 13 +++++++++
 .../boot/dts/rockchip/rk3566-quartz64-a.dts   | 29 +++++++++++++++++--
 arch/arm64/boot/dts/rockchip/rk356x.dtsi      |  2 ++
 3 files changed, 42 insertions(+), 2 deletions(-)

-- 
2.25.1

