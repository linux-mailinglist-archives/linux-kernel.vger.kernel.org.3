Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBFC84F933F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 12:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbiDHKsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 06:48:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiDHKr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 06:47:58 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7347335E73;
        Fri,  8 Apr 2022 03:45:54 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id t6so1179837plg.7;
        Fri, 08 Apr 2022 03:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tU5KIeEDkNDfQSVimmmxQWaHeUiPsGedJnTrUmm/PRE=;
        b=V1DEQHgslrv4uVGkwW1fZ5yUSHZHDAdupuxRqL7BCPj3t38l2Sp6M8PlgUQrU8Guzg
         6PvuNVWP327KhSFGLnFXiXIxvYGLyEc9EOS2je5u6WfsUQfwbzoIz53VmaS98Xv/aWau
         O5EDmeCrp6Qjb/5LDMr0LzCiOTwDd/bT5m87+XALCo3IWkc3BFSDG7zrYJGSTCiu45yF
         30S/s+cvPNVvPCOvNM9lMde7fYOwTiz9KjerW9w1z/0VwDm859oKsZk5GsMXfKxTcSOa
         CueljkgzYLMps2bftSafKkj/ebJFecBCtDdN3sCo6aT1ZS4I9IZoiuXHlD1W5ZmYmnQF
         sT/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tU5KIeEDkNDfQSVimmmxQWaHeUiPsGedJnTrUmm/PRE=;
        b=motuu1nuOWMxLXa9ekkG17PthKxZSbtvLgeGXAU3GyIe0tbINwShHJE9MT3LwnEo1o
         /1B+4T8qjDru/cvXbflSPW2NsKFCgUeXKNrQi3TlgRLe13BYbIUvhdBm7fcoZtwUTEPJ
         qRNpkmQTIBpTdy9bQIgD40QVwFP3PJwRaD9mxXT2nvlG2jKcX/XWv5n7fq0pVvFSMKmD
         R54PiE4vBwGMqm2kOiL9spcHNKlCuK+Up2G+PE70QeCpQi1xGIVTFL52QtXLENPApkOp
         adlPb1+b53EtgfgtYJT6wh5h5hNbQ5iklR5OlPZJ7QX8PJ8FJeJNl1Xpvl/K01lKgtdq
         vp9w==
X-Gm-Message-State: AOAM531I54lldI3KQG4kL0ummDUmVxyvaC0jANQG5L35nrgGaU9/Jv3N
        HF0/xZRuc/2iwErnvrSTqMl6l6NSoqHjWEDK
X-Google-Smtp-Source: ABdhPJxT5uX+CwqpsHurpBR0lP2jgn20qI9jeQMEaLzFf3+jqr3Z5UnxCs/6zjuoiVooXRhUFDEN1w==
X-Received: by 2002:a17:902:bf06:b0:14d:8c72:96c6 with SMTP id bi6-20020a170902bf0600b0014d8c7296c6mr18313012plb.156.1649414754435;
        Fri, 08 Apr 2022 03:45:54 -0700 (PDT)
Received: from tj10039pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id m17-20020a17090a859100b001bc20ddcc67sm11184902pjn.34.2022.04.08.03.45.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 03:45:54 -0700 (PDT)
From:   Cixi Geng <gengcixi@gmail.com>
To:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        orsonzhai@gmail.com, baolin.wang7@gmail.com, zhang.lyra@gmail.com
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] Add ums512 clocks and relative bindings file
Date:   Fri,  8 Apr 2022 18:45:17 +0800
Message-Id: <20220408104520.1896568-1-gengcixi@gmail.com>
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

From: Cixi Geng <cixi.geng1@unisoc.com>

This patchset is add the UMS512 clocks support

Cixi Geng (3):
  dt-bindings: clk: sprd: add bindings for ums512 clock controller
  clk: sprd: Add dt-bindings include file for UMS512
  clk: sprd: add clocks support for UMS512

 .../bindings/clock/sprd,ums512-clk.yaml       |  100 +
 drivers/clk/sprd/Kconfig                      |    6 +
 drivers/clk/sprd/Makefile                     |    1 +
 drivers/clk/sprd/ums512-clk.c                 | 2199 +++++++++++++++++
 include/dt-bindings/clock/sprd,ums512-clk.h   |  397 +++
 5 files changed, 2703 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/sprd,ums512-clk.yaml
 create mode 100644 drivers/clk/sprd/ums512-clk.c
 create mode 100644 include/dt-bindings/clock/sprd,ums512-clk.h

-- 
2.25.1

