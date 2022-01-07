Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7DC948701F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 03:02:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345236AbiAGCCS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 21:02:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344474AbiAGCCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 21:02:17 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34CB6C061245;
        Thu,  6 Jan 2022 18:02:17 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id e25so4536964qkl.12;
        Thu, 06 Jan 2022 18:02:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Li/jQ4nlT3gPpvd1NyTQnIxzc9JA+p42BI5110gVryI=;
        b=D48pMHDKbceVDw3lQnRewim5ayodaSN8T49QKqKck52RgM8Mk1qDNvXzqQZTnFoxUT
         cwf++gs/8Oewu2oZnv8+2UTTs7QjqQsCOUDMLb0NapFC1w3DOCVRufqCim/OZ4C9dUnd
         +oFMPFlkmFwfvmJkbdujiDwc5O++ZtZBcOkcjZZr3S53UF7oR3YhsJXqyoY14X2DverP
         Xcr+jZjlMins+iJLvn1DvIBZOpTRisZoI2kgWnfl8q0elZmlT2h63bzyNpNF+n5BWqPE
         OU4hOI1VfzBTi4rMdyRztgoAn4DZL0e1MMRPnNtUXCBRL4xOzpTOasUJgChGwtosRfzR
         uiVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Li/jQ4nlT3gPpvd1NyTQnIxzc9JA+p42BI5110gVryI=;
        b=ns5w6Rg4SXR7ETsPsheyYkVw3HyX7+END0OoJHQ97qft8rnkguOgtjva+ZNcOoxKAL
         gr3vQVU+3WtwtdN25uEehzmDPSmYOjxUiUn+o9CUtiziMOqcoacYxnkEialYkLvLM0mC
         XTUVHxcpgDA9agYf2g9q9Rwoup7qW4k9T3t/9HA0rGocx25kiOo6GiJWXHrBF5TDPNeH
         RHlXumewPPsrPh0+oT26yrMG0SlWREyowjd/4kR1gLemZepMoL5T4ZU5I37o18wlS4CP
         9XYUXcFeCMm/B+b3xYJUbHRWVySntznIDnsLbkdSOT4ub2e8KZ6yPbDNBf0dAlU4hCc3
         sC+g==
X-Gm-Message-State: AOAM531HOcs6YzyenOw5Lf2NsszmXCzn5l7ctGRk1hnRXeEnYsQiDrp6
        X9etw1TPj15+8RfnKIfJf21UzY3Ofkk=
X-Google-Smtp-Source: ABdhPJyFLUnXGpl/Ej//ERbkZnC0lZ7GVhRcnFLH5j/9dsaix5WLKtzn9XSDUBszz5HWPfy/+38YFw==
X-Received: by 2002:a37:34c:: with SMTP id 73mr44285797qkd.726.1641520936215;
        Thu, 06 Jan 2022 18:02:16 -0800 (PST)
Received: from master-x64.sparksnet (c-98-233-193-225.hsd1.dc.comcast.net. [98.233.193.225])
        by smtp.gmail.com with ESMTPSA id m20sm2960331qtx.39.2022.01.06.18.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 18:02:15 -0800 (PST)
From:   Peter Geis <pgwipeout@gmail.com>
Cc:     Peter Geis <pgwipeout@gmail.com>, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH 0/4] add pine64 touch panel support to rockpro64
Date:   Thu,  6 Jan 2022 20:22:06 -0500
Message-Id: <20220107012207.3779449-1-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds support for the Pine64 touch panel to the
rockpro64 single board computer.
This panel attaches to the dsi port and includes an i2c touch screen.

The first two patches involve making the reset pin to the Feiyang
fy07024di26a30d panel optional. On the rockpro64 and quartz64-a this pin
is tied to dvdd and automatically comes high when power is applied.
The third patch adds the device tree nodes to rockpro64 to permit the
panel to be used.
The fourth patch is an example patch to enable this support, tagged do
not merge as this is something for the end user to enable only when they
have the panel attached.

Peter Geis (4):
  dt-bindings: display: panel: feiyang,fy07024di26a30d: make reset gpio
    optional
  drm/panel: feiyang-fy07024di26a30d: make reset gpio optional
  arm64: dts: rockchip: add pine64 touch panel display to rockpro64
  arm64: dts: rockchip: enable the pine64 touch screen on rockpro64

 .../panel/feiyang,fy07024di26a30d.yaml        |  1 -
 .../boot/dts/rockchip/rk3399-rockpro64.dtsi   | 80 ++++++++++++++++++-
 .../drm/panel/panel-feiyang-fy07024di26a30d.c | 11 ++-
 3 files changed, 83 insertions(+), 9 deletions(-)

-- 
2.32.0

