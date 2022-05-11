Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 673885231E1
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 13:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240401AbiEKLfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 07:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239248AbiEKLfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 07:35:21 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94319237B8B;
        Wed, 11 May 2022 04:35:20 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id bs17so2070911qkb.0;
        Wed, 11 May 2022 04:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fIWpbH8Qkfx6CtZf98GRcpag46QLNFxJDLii79V6Ww4=;
        b=iwUFlCXpNjAisVEfnwmlAdOatVcSnAwwbuVcsltGQ/5e2qlxjuvMvHFH0zjH653Mbe
         P10WcoYwALsqMADv3kofz5Iv36VCkh+MBGhmZIVf+tfXY4c6t/nPYMTWollwMNTd8SA1
         axrtWIBOwW4r+pvlA76424OgOCu0uMq70lLVLEb+qqhnND16vEEjQS5J1IpkudyWrFy4
         5TlJT9hljT5a5CrhxTLXnu0mHPi/Gd9oa/44/w52HsA6upKYCtvyhYOLlUSUSNn9AO6J
         FrVO5m0S9T8BVuuyUXNKoMtg808X7troFbx1f36TKqFRqd8P4T0doH2AqrtBrlJleTDW
         O5Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fIWpbH8Qkfx6CtZf98GRcpag46QLNFxJDLii79V6Ww4=;
        b=Ekv6pEGrRM9z70wvcLuRA3Cvnk1EQmeuCj49tW3am/hNaxf57DsWzPseZaYTx/4nUw
         cj8gWUzNgfxXfwEE6uH8ZT/b+2iDKOKZ/IgySRmEK7pzAFAZrnQqkfPkpLyQK9WrznMP
         /qIlbb9G2OBoBNWaaZgOdgKnjwgD+jzA/hyFseDKX0Dcxs01XVQBcblVxaQYoFI41PgO
         l1FcVgJxch5DID34r9L3Vt+I52n1POeC9WCeF+JDN2H2Ut64AZaC6ARapHlKB9pPoDC+
         uixd3Bi/eEVxy2u5v+lUkwWQ8kkuRVz4V3D8kDFt9y4BOJ/F0ErhdKCECQG0J727pvnx
         6hRA==
X-Gm-Message-State: AOAM532G3RBVHtOfosO2uW3o4IPVtQ4uXTAICtzhQMvkNcYweyHNzqJt
        4jZ95FwsvJxlyWJkGqHdP+bcL167cHZ9nA==
X-Google-Smtp-Source: ABdhPJzmxu38yPKnQkUR29DXmgeEH2Q7/lQoPhE5QKvfpHBeWFD/QSRUEnuuqI6W5KyHPA4iWJ4xBw==
X-Received: by 2002:a05:620a:254e:b0:680:a307:8a33 with SMTP id s14-20020a05620a254e00b00680a3078a33mr18549892qko.304.1652268919643;
        Wed, 11 May 2022 04:35:19 -0700 (PDT)
Received: from master-x64.sparksnet ([2601:153:980:85b1::10])
        by smtp.gmail.com with ESMTPSA id bw26-20020a05622a099a00b002f39b99f6basm953377qtb.84.2022.05.11.04.35.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 04:35:19 -0700 (PDT)
From:   Peter Geis <pgwipeout@gmail.com>
To:     linux-rockchip@lists.infradead.org
Cc:     Heiko Stuebner <heiko@sntech.de>, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Peter Geis <pgwipeout@gmail.com>
Subject: [PATCH v2 0/3] add Pine64 touch panel support to rockpro64
Date:   Wed, 11 May 2022 07:35:13 -0400
Message-Id: <20220511113517.4172962-1-pgwipeout@gmail.com>
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

Apologies Heiko on taking so long for this v2.

This patch series adds support for the Pine64 touch panel to the
rockpro64 single board computer.
This panel attaches to the dsi port and includes an i2c touch screen.

The first two patches involve making the reset pin to the Feiyang
fy07024di26a30d panel optional. On the rockpro64 and quartz64-a this pin
is tied to dvdd and automatically comes high when power is applied.
The third patch adds the device tree nodes to rockpro64 to permit the
panel to be used.

Changelog:
v2:
- Drop patch 4 so we don't "enable" the nodes
- Drop the unnecessary null checks
- Rebase to 5.18-rc1

Peter Geis (3):
  dt-bindings: display: panel: feiyang, fy07024di26a30d: make reset gpio
    optional
  drm/panel: feiyang-fy07024di26a30d: make reset gpio optional
  arm64: dts: rockchip: add pine64 touch panel display to rockpro64

 .../panel/feiyang,fy07024di26a30d.yaml        |  1 -
 .../boot/dts/rockchip/rk3399-rockpro64.dtsi   | 80 ++++++++++++++++++-
 .../drm/panel/panel-feiyang-fy07024di26a30d.c |  2 +-
 3 files changed, 77 insertions(+), 6 deletions(-)

-- 
2.25.1

