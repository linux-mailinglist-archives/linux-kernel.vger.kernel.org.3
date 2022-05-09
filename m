Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D71C25200E5
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 17:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238081AbiEIPSP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 11:18:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238020AbiEIPSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 11:18:11 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5B1113F1E;
        Mon,  9 May 2022 08:14:17 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id w17-20020a17090a529100b001db302efed6so13042181pjh.4;
        Mon, 09 May 2022 08:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=Vq+9ElJ3KdJuFm4uEqJclXzDkj2eUubFFU8zQNcLEUw=;
        b=HR/aB2q76+hmLYIfepQv5fnej93zhH6qrET/ZI67IEwtW7zSVQMurWk4AOr3hed7UD
         wd94AEC4JQjfDCME0UmOoQw8JJhNRWYPvDJTORv8qCYZIXvfXl3NaI1uLXHEkSV/PbvA
         eJl3q7buApYzYrjEP9ldlSibd/1PcxyHEH1pucFC3FID5Tjpugr27NfclrVzEAXxA9YY
         0TaKGcTYiTOBo8qJM4Mjyxh5JEH6EBj+T8i/gkkMmnH11M/A+11pGed50rkPWnfmE9oz
         /nUbqzb8jdyetkwNOj0TDy0DwLNg3cjc3T2niFgcE36ZgbQ/ou8pSWm8ozHq61C025J6
         srlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Vq+9ElJ3KdJuFm4uEqJclXzDkj2eUubFFU8zQNcLEUw=;
        b=Mp+v5POZ2WoM0kvdqCLrPiXwobJ0b+Th8X30dP+Ng0mbWpVSTdmLgxPZF4UtqZ6ruT
         f93lzHH6sHBuaGgq/ImJcSXNrE09vZ/B5BR9Gpoc9FGoNdzrHbWsFxMxs8EAXNG3Yz3h
         Kts7b//iWhfWUVpP5Z2Fy7MsAbav8/FC7RarsJ+1nziNA/yPFgZG33/r8kBOCA0+0weH
         QdOwYMTOxu4i6EpI6sxioit7kEZPtKFYSwQxgCNIIkHe+M+WTFtLdyrAknkuwGaQks++
         wZ9enuhUQJmTESyC1ArAjwf6BE3enqRRl5Uw9SX3xnbwGIRN0T9pxPnWJxbCPJEnPBfB
         1umQ==
X-Gm-Message-State: AOAM532te9/DVlHyzfEyMfD0mAGqkdJcPDLweS7BoziXXsUdZ76HG50L
        j27fQbjlOvnOTbsgfQw7Uc4=
X-Google-Smtp-Source: ABdhPJwSH+UgtxEWDsp3aqevFgxSaHSc7MNhSe4mKeyXxs3V5bZK5eNTNZUwzSKALh+n7iZKHBlNMA==
X-Received: by 2002:a17:902:f607:b0:15e:f845:bf99 with SMTP id n7-20020a170902f60700b0015ef845bf99mr12020176plg.96.1652109257257;
        Mon, 09 May 2022 08:14:17 -0700 (PDT)
Received: from potin-quanta.dhcpserver.local (125-228-123-29.hinet-ip.hinet.net. [125.228.123.29])
        by smtp.gmail.com with ESMTPSA id k7-20020a056a00134700b0050dc76281b6sm9221596pfu.144.2022.05.09.08.14.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 08:14:16 -0700 (PDT)
From:   Potin Lai <potin.lai.pt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>
Cc:     Patrick Williams <patrick@stwcx.xyz>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Potin Lai <potin.lai.pt@gmail.com>
Subject: [PATCH 0/6] ARM: dts: aspeed: bletchley: update dts file base on DVT schematic
Date:   Mon,  9 May 2022 23:11:12 +0800
Message-Id: <20220509151118.4899-1-potin.lai.pt@gmail.com>
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

This patch series update Facebook Bletchley BMC devicetree base on DVT
schematic.

- EHCI: enable ehci0 for detecting and accessing usb device on sled
- MDIO Bus: enable mdio0 for accessing switch registers
- SPI2 Flash: switch spi driver back to aspeed-smc to improve performance
- EEPROM: add eeprom node on each sled
- GPIO:
  - add PCA9536 IOEPX node on each sled
  - update gpio line names

Potin Lai (6):
  ARM: dts: aspeed: bletchley: enable ehci0 device node
  ARM: dts: aspeed: bletchley: switch spi2 driver to aspeed-smc
  ARM: dts: aspeed: bletchley: Enable mdio0 bus
  ARM: dts: aspeed: bletchley: update gpio0 line names
  ARM: dts: aspeed: bletchley: add pca9536 node on each sled
  ARM: dts: aspeed: bletchley: add eeprom node on each sled

 .../dts/aspeed-bmc-facebook-bletchley.dts     | 180 ++++++++++++++----
 1 file changed, 145 insertions(+), 35 deletions(-)

-- 
2.17.1

