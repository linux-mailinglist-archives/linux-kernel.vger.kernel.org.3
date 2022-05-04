Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A57451AF62
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 22:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378256AbiEDUjZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 16:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378163AbiEDUiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 16:38:51 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A392DEEB
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 13:35:13 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id t6so3526189wra.4
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 13:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZEoxvbJ2coXtM9GkcSeuePyVXx2vfaBQhN50CPNKAwM=;
        b=ceU4b1kucAjbAxpJDSZu8SD9ryaZ3nHTD+M6HqFhW70BCTtOrdC+EPy9KZeIm8HoV2
         aCRfI+UaOXVibKEAuFdYMUESuMZyEP5gC0oMizHF8cc44rrIaEcaZ9W9yMr86MEJdjjK
         6MHEevKxbyOTkh/At8tuqzfrpw6AASit3NWA323FibIlrS7H3lps6AYWLOe9rgDOZJ6x
         xF+e8aK9lLYkHyBODgw5nTpEooV0dHu3+bPssrstdvu2rCXpFPVKZhdHVoNOXtDzApF2
         4W+UXqxV4fWkGlwhPnlaTU3OENAdnGyNNDunp3WOO17odKf/XSOKAVW4rP2kDL5+UPeO
         xnBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZEoxvbJ2coXtM9GkcSeuePyVXx2vfaBQhN50CPNKAwM=;
        b=qc91UifIomXpr+1KZJ3rBqqUkmsYMuNoNxK8uesqWQcwvhYYbhlaTYuan1yvEpOkTq
         CAf6uMxrnT2Tg6P69PP+jlE4NcJU4/5qmIvHbta/jsnM88XaZZXo1zlPdAh88GGYAPsi
         FQ0PVPxuDTxFYb/FxnyzO4svLy4wa4NkxEeJmOwUtpwUcwWVAPtBpSQAgAnPW148gqVN
         cMjYPPDwhvbn1tl7B2LjASr2Kpno8i9d2Aqnm0Dsu2qq0VAucB7QLlURLDOWUHfTwwmt
         mL6fxrXAOc1lvzd61yjC8y/m3ycZd456+n+7PFolYmksztKQdEPnoqJwb3EQ63tbwLtV
         RaBw==
X-Gm-Message-State: AOAM530nZ9WJdiWO53sjbMlReGZGGS+JwqN6Keac2utE4+FWFXkMTuUy
        Yfea7nACvrN2aYxUKQ0ypupRNQ==
X-Google-Smtp-Source: ABdhPJy6R0Oj6A1OuDX+ULxfI9lWNvJfwlUvuzXOEl90OAaIDqnk5zsRJ/sasn/yJ1t0AkgkVW725A==
X-Received: by 2002:a5d:47af:0:b0:20c:6701:50be with SMTP id 15-20020a5d47af000000b0020c670150bemr10881810wrb.148.1651696511558;
        Wed, 04 May 2022 13:35:11 -0700 (PDT)
Received: from henark71.. ([109.77.36.132])
        by smtp.gmail.com with ESMTPSA id l20-20020adfc794000000b0020c5253d8dfsm13330101wrg.43.2022.05.04.13.35.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 13:35:10 -0700 (PDT)
From:   Conor Dooley <mail@conchuod.ie>
To:     krzk+dt@kernel.org, palmer@dabbelt.com, robh+dt@kernel.org
Cc:     conor.dooley@microchip.com, Cyril.Jean@microchip.com,
        daire.mcnamara@microchip.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, palmer@rivosinc.com, arnd@arndb.de,
        heiko@sntech.de, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Conor Dooley <mail@conchuod.ie>
Subject: [PATCH v4 0/8] PolarFire SoC dt for 5.19
Date:   Wed,  4 May 2022 21:30:44 +0100
Message-Id: <20220504203051.1210355-1-mail@conchuod.ie>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey all,
Got a few PolarFire SoC device tree related changes here for 5.19.

Firstly, patches 1 & 2 of this series supersede [0] & are unchanged
compared to that submission, figured it would just be easier to keep
all the changes in one series.

As discussed on irc, patch 3 removes the duplicated "microchip" from
the device tree files so that they follow a soc-board.dts & a
soc{,-fabric}.dtsi format.

Patch 5 makes the fabric dtsi board specific by renaming the file to
mpfs-icicle-kit-fabric.dtsi & including it in the dts rather than
mpfs.dtsi. Additionally this will allow other boards to define their
own reference fabric design. A revision specific compatible, added in
patch 4, is added to the dt also.

The remainder of the series adds a bare minimum devicetree for the
Sundance Polarberry.

Thanks,
Conor.

Changes since v3:
- remove an extra line of wshitespace added to dt-binding
- remove unneeded "okay" status & sort status to node end
- sort polarberry dts entries in ~alphabetical order
- add a comment explaining why the second mac (mac0) is disabled on
  polarberry

Changes since v2:
- make ,icicle-reference compatible with ,mpfs & put it inside the enum

Changes since v1:
- fixed whitespace problems in the polarberry dts
- disabled mac0 for the polarberry as its port is on the optional
  carrier board

Conor Dooley (8):
  riscv: dts: microchip: remove icicle memory clocks
  riscv: dts: microchip: move sysctrlr out of soc bus
  riscv: dts: microchip: remove soc vendor from filenames
  dt-bindings: riscv: microchip: document icicle reference design
  riscv: dts: microchip: make the fabric dtsi board specific
  dt-bindings: vendor-prefixes: add Sundance DSP
  dt-bindings: riscv: microchip: add polarberry compatible string
  riscv: dts: microchip: add the sundance polarberry

 .../devicetree/bindings/riscv/microchip.yaml  |  2 +
 .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
 arch/riscv/boot/dts/microchip/Makefile        |  3 +-
 ...abric.dtsi => mpfs-icicle-kit-fabric.dtsi} |  2 +
 ...pfs-icicle-kit.dts => mpfs-icicle-kit.dts} |  5 +-
 .../dts/microchip/mpfs-polarberry-fabric.dtsi | 16 +++
 .../boot/dts/microchip/mpfs-polarberry.dts    | 97 +++++++++++++++++++
 .../{microchip-mpfs.dtsi => mpfs.dtsi}        | 11 +--
 8 files changed, 128 insertions(+), 10 deletions(-)
 rename arch/riscv/boot/dts/microchip/{microchip-mpfs-fabric.dtsi => mpfs-icicle-kit-fabric.dtsi} (91%)
 rename arch/riscv/boot/dts/microchip/{microchip-mpfs-icicle-kit.dts => mpfs-icicle-kit.dts} (95%)
 create mode 100644 arch/riscv/boot/dts/microchip/mpfs-polarberry-fabric.dtsi
 create mode 100644 arch/riscv/boot/dts/microchip/mpfs-polarberry.dts
 rename arch/riscv/boot/dts/microchip/{microchip-mpfs.dtsi => mpfs.dtsi} (98%)


base-commit: b6b2648911bbc13c59def22fd7b4b7c511a4eb92
-- 
2.36.0

