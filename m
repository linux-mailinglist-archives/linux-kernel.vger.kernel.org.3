Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FCD858FD8E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 15:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234309AbiHKNmJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 09:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbiHKNmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 09:42:07 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 530F015A22;
        Thu, 11 Aug 2022 06:42:06 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id 17so16926057plj.10;
        Thu, 11 Aug 2022 06:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc;
        bh=p1TxuLj+R0HduMtTWToeGigGtVfbsJW4F/EMut9GGiE=;
        b=QEm2doY3whZViiKl5O4Vw4CbKk4s64aQAFofySTGsdge5sZXoZQ74qjezABR7sfRir
         2u1dxxMYd78ms9zj7Z7Ru9dCcCcN4Ss6+L1GqJ8rQk+EZwKEeE88TiE/nclF8xgRX9po
         gc+qq54uDrMTdQhjgofBGyL/keejTSJh9vlVtQeut7CyjXfZHgf77jXgInIjpv8h5gCG
         uTqBDKdKVxvYFXicbTngStewjSCQ5wAMIAOj5DqPGXidx3rYeF4A9+3MKC9Lfd9touGW
         riCM0ptUKKbQS9ptbB6Qc2XPX3KC9CyLy9bEZFrv1n99ccAnwPY+nW4Q5LzHgc7csXL6
         cq8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=p1TxuLj+R0HduMtTWToeGigGtVfbsJW4F/EMut9GGiE=;
        b=7qNo2bOHNeI3EUKz+G/Ii/wH+xvLklztloFAZJHtYe0VOy4bDnP/Xj+PtCtrWYTp6X
         8xsZxiovOy1c1K9vWXXdWBYhKRjHRAD+rnIGpZyjuOIkRfHhKpEIpv5Y8E8JEjZWIuJE
         25c2LBIAVmtG+KL7AAeeUxt3F4mLCtTLR/IEI6zM23sjbxRhVt7YtogAWgP9I72Zhpc3
         J3zoXluRS25QzJ0DPbmb5lFSZ8br23F9QRTe9D3aXl1ekPEwiTBZKq4+4yKcC0go2OR6
         ppNOis2B3/8QhjOD7LxYmQ5x1d8NngikupQZBhYy/fKDWK9tkfjFUoR5i6hzj9LH+PZR
         9uag==
X-Gm-Message-State: ACgBeo0tKhj9GUVPD5bo9oQYHbcspRkELsp4TEgR54oWx96/Vz4ufmCG
        qXzABiaRa3RkG/2tWlnmeQo=
X-Google-Smtp-Source: AA6agR7AmQJEmAqJXah+6Iwv6S6YIzgVGXrvfYC0EK86MDFozFmLC/Do8uMgQY242hJI5cjmzj8JqA==
X-Received: by 2002:a17:90b:3e8c:b0:1f7:3792:d336 with SMTP id rj12-20020a17090b3e8c00b001f73792d336mr9053879pjb.0.1660225325598;
        Thu, 11 Aug 2022 06:42:05 -0700 (PDT)
Received: from localhost.localdomain (1-171-1-124.dynamic-ip.hinet.net. [1.171.1.124])
        by smtp.gmail.com with ESMTPSA id b11-20020a170903228b00b0016edff78844sm14887753plh.277.2022.08.11.06.42.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Aug 2022 06:42:05 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        sre@kernel.org
Cc:     alina_yu@richtek.com, cy_huang@richtek.com, alinayu829@gmail.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Add Richtek RT9471 3A battery charger support
Date:   Thu, 11 Aug 2022 21:41:56 +0800
Message-Id: <1660225318-4063-1-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

This patch set is to add Richtek RT9471 charger support.

The RT9471/D is a highly-integrated 3A switch mode battery charge management
and system power path management device for single cell Li-Ion and Li-polymer
battery. The low impedance power path optimizes switch-mode operation
efficiency, reduces battery charging time and extends battery life during
discharging phase.

ChiYuan Huang (2):
  dt-bindings: power: supply: Add Richtek RT9471 battery charger
  power: supply: rt9471: Add Richtek RT9471 charger driver

 .../bindings/power/supply/richtek,rt9471.yaml      |  78 ++
 drivers/power/supply/Kconfig                       |  16 +
 drivers/power/supply/Makefile                      |   1 +
 drivers/power/supply/rt9471.c                      | 952 +++++++++++++++++++++
 drivers/power/supply/rt9471.h                      |  76 ++
 5 files changed, 1123 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/richtek,rt9471.yaml
 create mode 100644 drivers/power/supply/rt9471.c
 create mode 100644 drivers/power/supply/rt9471.h

-- 
2.7.4

