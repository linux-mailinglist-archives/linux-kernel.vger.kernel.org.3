Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 357BF500D60
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 14:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243361AbiDNMaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 08:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242775AbiDNMaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 08:30:12 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5634E90CC6;
        Thu, 14 Apr 2022 05:27:20 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id c12so4508799plr.6;
        Thu, 14 Apr 2022 05:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hgmXgR00QIvN0EExWeBXD0io2j2TnCvQ61c8fzNW+rY=;
        b=lBhx+rdb4hdC3YMcxjpgviIlzjH0B9ZCqf6Ct2MgxT6NghOvYjqU/940zldXEfAO19
         znO6rFvRm5qAn4o3HeiO/V4nGgKVwz7szCyvQLz7t3izCfFxpwXGk8JcQ6MGD32qpPib
         9dX0ACO7neSZP56wSm2/RKkt2YLUCWLoqY2zo3UPOcv0lZ0eWknBFoqwBLH/yiL6DmdG
         bsYFyJP8IcPQKQGhhEFgLOwkD1H4eiYctXBaMR+VqANA5qQJUke0MQTS6A4sAlFyXKaT
         GmgRKADylZasl7QhsHQ6e7ykXicekGuaUyQwpQaYbxz5VtYFQAnhx7h9EC1L1H0GYQXg
         qSMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hgmXgR00QIvN0EExWeBXD0io2j2TnCvQ61c8fzNW+rY=;
        b=SOtLp/61/dhu1HYa7LMDJJjfO/S+2IdwvRqHgMOqdHWJdVSr9vn+xVPxkdlspdpZpD
         x65jimiydVbtP9PtchDjGBlgDBwg76n+N+emRY1PFg1mu0vtjpWbx9MTEt19c5SmJ1BL
         0Fm72z6QfaQitMZN1yMia22DrX8sYxZCi9tHWMTmPOQHWN3WnvuiZzPicsGh2wHoM61T
         +kXbUadqEvNaIsEFChX1rD45NN0r+bmzUWMMuoI/9RX6ymJsJ4o6W1khR6Rge2dFtqum
         oi8g9TLGBvX11Sd9G13O/elRJuCWu+5oFlRi7l3dz0IISExYAD9q+UZ8EApjNCAoi5R4
         XsbQ==
X-Gm-Message-State: AOAM530k6dRqKHK4C/aVSA3QtwJVictcoWQ+kELwVlUk9jmCSzAD3ygW
        RP7XZwWAy2g6QUqQbIgqRnHaOGhaVQA=
X-Google-Smtp-Source: ABdhPJwaCAGXUNk5NBVP//O6IYwtnSgFoauuQgLqwkJQkCTYfcsq+wKr4HFi6STjucSyAflguiB0/w==
X-Received: by 2002:a17:90b:1d11:b0:1cd:9d72:3f40 with SMTP id on17-20020a17090b1d1100b001cd9d723f40mr3442196pjb.99.1649939239780;
        Thu, 14 Apr 2022 05:27:19 -0700 (PDT)
Received: from tj10039pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id pi2-20020a17090b1e4200b001c7b15928e0sm6265826pjb.23.2022.04.14.05.27.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 05:27:19 -0700 (PDT)
From:   Cixi Geng <gengcixi@gmail.com>
To:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        orsonzhai@gmail.com, baolin.wang7@gmail.com, zhang.lyra@gmail.com
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 0/3] Add ums512 clocks and relative bindings file
Date:   Thu, 14 Apr 2022 20:26:54 +0800
Message-Id: <20220414122657.526406-1-gengcixi@gmail.com>
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

v2 changes:
  adjust description and add the "sprd,ums512-glbregs,syscon,simple-mfd"
  compatibles to fix match failed logs in the dt_binding_check.
  add the property license and copyright notice.

Cixi Geng (3):
  dt-bindings: clk: sprd: Add bindings for ums512 clock controller
  clk: sprd: Add dt-bindings include file for UMS512
  clk: sprd: Add clocks support for UMS512

 .../bindings/clock/sprd,ums512-clk.yaml       |  108 +
 drivers/clk/sprd/Kconfig                      |    6 +
 drivers/clk/sprd/Makefile                     |    1 +
 drivers/clk/sprd/ums512-clk.c                 | 2199 +++++++++++++++++
 include/dt-bindings/clock/sprd,ums512-clk.h   |  397 +++
 5 files changed, 2711 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/sprd,ums512-clk.yaml
 create mode 100644 drivers/clk/sprd/ums512-clk.c
 create mode 100644 include/dt-bindings/clock/sprd,ums512-clk.h

-- 
2.25.1

