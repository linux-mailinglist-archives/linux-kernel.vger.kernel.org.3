Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2B24E7FE9
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 09:07:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231982AbiCZIJN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 04:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbiCZIJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 04:09:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C32015A11;
        Sat, 26 Mar 2022 01:07:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1422C60CA0;
        Sat, 26 Mar 2022 08:07:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BFBBC340ED;
        Sat, 26 Mar 2022 08:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648282055;
        bh=uWGwd/TjDTtlET6TIDYKpJUWHawper8Pz2sEe19Tmgs=;
        h=From:To:Cc:Subject:Date:From;
        b=pMgOR81y2anBnhQydUKl5DlHqFosPv6ALnXZqsYZVd0cx/AXsuZ3wMJR+UEBUW9YG
         uW9ibeLIhjFTDNA58IJBH/xumKiiZH37n+Z8xLkgkTLOF75hY7kH/C3e4k79KJ/BAz
         XeLKkMEsxQbC8BGERMRpGtXZjoZOzpGt6RV/l/ziCNH5PmGZ3VCC2uYBitAbY2aSob
         O1FifVFClrMx03G/LuJR/8wb2MO7IsSbV562zXS487b8GE4yAdmHjRuOZeUPwjBBuF
         JyMzjVCMVxcWbr1HCI0CbqPjdxmNcqlRcJ2Kw/UjT6YG3G7TSTZyiBBAeSuQkJSF4y
         mQbeh0IBlHpqQ==
From:   Roger Quadros <rogerq@kernel.org>
To:     miquel.raynal@bootlin.com, robh+dt@kernel.org
Cc:     krzk@kernel.org, richard@nod.at, vigneshr@ti.com, kishon@ti.com,
        nm@ti.com, linux-mtd@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Roger Quadros <rogerq@kernel.org>
Subject: [PATCH v3 0/3] mtd: rawnand: omap_elm: convert DT binding to yaml
Date:   Sat, 26 Mar 2022 10:07:23 +0200
Message-Id: <20220326080726.30372-1-rogerq@kernel.org>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series converts omap_elm DT bindings to yaml and adds
support for ELM on AM64 SoC.

Changelog:
v3
- use 'enum' for compatible specifier. Get rid of 'items'.

v2
- explain hwmod usage deprecated in commit log
- fix example node name to 'ecc'
- remove 'items' for single compatible specifier

cheers,
-roger

Roger Quadros (3):
  dt-bindings: mtd: ti,elm: Convert to yaml
  dt-bindings: mtd: ti,elm: Add support for AM64 ELM
  mtd: rawnand: omap_elm: Add compatible for AM64 ELM

 Documentation/devicetree/bindings/mtd/elm.txt | 16 -----
 .../devicetree/bindings/mtd/ti,elm.yaml       | 72 +++++++++++++++++++
 drivers/mtd/nand/raw/omap_elm.c               |  1 +
 3 files changed, 73 insertions(+), 16 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mtd/elm.txt
 create mode 100644 Documentation/devicetree/bindings/mtd/ti,elm.yaml

-- 
2.17.1

