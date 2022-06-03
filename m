Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D038653C76C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 11:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243005AbiFCJYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 05:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242971AbiFCJYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 05:24:19 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7C1328722
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 02:24:18 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id g12so7841320lja.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jun 2022 02:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QFSYNioYj53ugT+XnFcagEPMgVZUKHIrYtdlR+BaPMw=;
        b=Uj5pQCbaqw+S8llFY3KzjlJ4sNmRc936NPpaoIg49TAD67QdE5f14mzfxc/+GtlNAX
         9Hz2gn637jjeiCaMI7G58XCcPMDK8MdK0Jx7KuZrwAYlPgbeBzB8uoYhhf1UZWwnwKT1
         icXpr3ERi0uvVRy2s9oWnrbuGPmi3zwDHxiwN05MEGkFn5PuVPsR6PwhujwfEgRldiIj
         Mx96zvTcyYuKiQSzCot2D+7dxYObFFWjGim3yPOSE2m9Z1170yOM298InzLyPViSwQEQ
         CwcAKSalHq9OT1hY74Xc4and6+K5/BTi/t4YKJlEArKV/zM6B9/+BP3f4ISoAa2LQEih
         rDWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QFSYNioYj53ugT+XnFcagEPMgVZUKHIrYtdlR+BaPMw=;
        b=WrmwkhxRftK4H7hJNeaTJf33zInOIql6BvK2q2F3Yn1lhipOFch2qCF2VEcTnzcwDK
         Rbe2zzPGiuiFXqe7waer0oXxdLNlwqqA/g8wSMlveBmFJMf3oGjSXXxNjfnSWi3ah3VO
         UX3OWuh6+DMNWRt3oadD62rZ6JpYdtVy1Fj8uRTzji07Xb2WMt4T6ZamdyOg3TDsXhYT
         p/mJukDe6TCjnJq0r56KZRok9ksgAJ4I3k4nL20BV+Tw1pz+/c0pK0ikgvd3/ugWYcZB
         sEATuBzWKkan/VFWa4KNCjL/MDGnZktD5RFDJCJiISobxvFylbvaqBpdNmkowZflpmLI
         35kg==
X-Gm-Message-State: AOAM53167XybJkeah4xuax98EGC7yUdrDEFnkHqJ7efxpBHqWAkRZ2SO
        LTVI2JZg8siDFheYJ+8C68wWTw==
X-Google-Smtp-Source: ABdhPJy2jZOSD0jnQeBMhKjievMP76bhDOnt99sJsKAlHh2RRwsvcuKxjpOnKX8gSCkJDKZWHNeZhA==
X-Received: by 2002:a2e:81cc:0:b0:255:5d1c:196a with SMTP id s12-20020a2e81cc000000b002555d1c196amr9951136ljg.1.1654248257077;
        Fri, 03 Jun 2022 02:24:17 -0700 (PDT)
Received: from panikiel.roam.corp.google.com (staticline-31-182-204-250.toya.net.pl. [31.182.204.250])
        by smtp.gmail.com with ESMTPSA id e10-20020a2e9e0a000000b002555dd9c20fsm1224434ljk.20.2022.06.03.02.24.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 02:24:16 -0700 (PDT)
From:   =?UTF-8?q?Pawe=C5=82=20Anikiel?= <pan@semihalf.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        dinguyen@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, amstan@chromium.org,
        upstream@semihalf.com,
        =?UTF-8?q?Pawe=C5=82=20Anikiel?= <pan@semihalf.com>
Subject: [PATCH v4 0/5] Add Chameleon v3 devicetree
Date:   Fri,  3 Jun 2022 11:23:49 +0200
Message-Id: <20220603092354.141927-1-pan@semihalf.com>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The Google Chameleon v3 is a board made for testing both video and audio
interfaces of external devices. It acts as a base board for the
Mercury+ AA1 module.

socfpga_arria10_mercury_aa1.dtsi and socfpga_arria10_chameleonv3.dts
have also been sent to u-boot:
https://lists.denx.de/pipermail/u-boot/2022-May/485107.html
https://lists.denx.de/pipermail/u-boot/2022-May/485111.html

v4 changes:
 - remove enclustra,mercury-aa1 from Arria 10 boards in dt-bindings

v3 changes:
 - make seperate group for Chameleon v3 in dt-bindings
 - add blank line after copyright header

v2 changes:
 - split first patch into three
 - move sdmmc-ecc node to socfpga_arria10.dtsi (instead of removing it entirely)
 - use generic names for dts node names
 - keep the enclustra,mercury-aa1 compatible

Paweł Anikiel (5):
  ARM: dts: socfpga: Change Mercury+ AA1 dts to dtsi
  ARM: dts: socfpga: Move sdmmc-ecc node to Arria 10 dts
  ARM: dts: socfpga: Add atsha204a node to Mercury+ AA1 dts
  ARM: dts: socfpga: Add Google Chameleon v3 devicetree
  dt-bindings: altera: Add Chameleon v3 board

 .../devicetree/bindings/arm/altera.yaml       |  9 +-
 arch/arm/boot/dts/Makefile                    |  2 +-
 arch/arm/boot/dts/socfpga_arria10.dtsi        | 10 +++
 .../boot/dts/socfpga_arria10_chameleonv3.dts  | 90 +++++++++++++++++++
 ...1.dts => socfpga_arria10_mercury_aa1.dtsi} | 48 ++--------
 5 files changed, 117 insertions(+), 42 deletions(-)
 create mode 100644 arch/arm/boot/dts/socfpga_arria10_chameleonv3.dts
 rename arch/arm/boot/dts/{socfpga_arria10_mercury_aa1.dts => socfpga_arria10_mercury_aa1.dtsi} (70%)

-- 
2.36.1.255.ge46751e96f-goog

