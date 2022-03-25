Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE95E4E739B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 13:37:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359028AbiCYMiu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 08:38:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232552AbiCYMis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 08:38:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD42C21804;
        Fri, 25 Mar 2022 05:37:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6453461A05;
        Fri, 25 Mar 2022 12:37:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BECDC340E9;
        Fri, 25 Mar 2022 12:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648211833;
        bh=GZihoK7xdXZWYogtHpi8BIMEjFnQFzjhtRhwaFsx2Nk=;
        h=From:To:Cc:Subject:Date:From;
        b=EkH5CyRfQaGrQJSUzyXGHL3S667AwxxX+mmrWajpqcosqPHiHXCeY5HKZT8NdOyMP
         pIeNsj0QNJow3TpRdgc4Uu5JwbG95F59NoZ6ku16HFOgdJpwtmrZN0kqTMi/hI43bm
         fs2DfYXjKY+LDxtMgx2ZjAq7jfseloenf7WCI4nBV3p7SbQszTXbmYrrbJaN6lDD1L
         h4W8sWWGK5nuBmrJYHA3o4Zn2eThoMKJTUruQ3MT6v9kQk/U0WyCl76Wu/05CJi/uL
         u2y6G1DH+eM329NzpOZ5Fpj/mOlmyDwHAEBss3br542EhpeRBL517iY7mQ0Ae0UOeE
         QDhiutaLxSbNw==
From:   Roger Quadros <rogerq@kernel.org>
To:     miquel.raynal@bootlin.com, robh+dt@kernel.org
Cc:     richard@nod.at, krzk@kernel.org, vigneshr@ti.com, kishon@ti.com,
        nm@ti.com, linux-mtd@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Roger Quadros <rogerq@kernel.org>
Subject: [PATCH v2 0/3] mtd: rawnand: omap_elm: convert DT binding to yaml
Date:   Fri, 25 Mar 2022 14:37:04 +0200
Message-Id: <20220325123707.22020-1-rogerq@kernel.org>
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

 Documentation/devicetree/bindings/mtd/elm.txt | 16 ----
 .../devicetree/bindings/mtd/ti,elm.yaml       | 73 +++++++++++++++++++
 drivers/mtd/nand/raw/omap_elm.c               |  1 +
 3 files changed, 74 insertions(+), 16 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mtd/elm.txt
 create mode 100644 Documentation/devicetree/bindings/mtd/ti,elm.yaml

-- 
2.17.1

