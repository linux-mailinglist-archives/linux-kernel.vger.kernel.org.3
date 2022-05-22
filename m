Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D36C3530651
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 23:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351806AbiEVVov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 17:44:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiEVVoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 17:44:44 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E2FF37BF6;
        Sun, 22 May 2022 14:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=92HYTjkI0L8pG37FsCTnBzOvYuZbyWQaGiDdaOuAdG0=; b=NRVCIhf/cXPoap06GyEW7QIfNG
        U76Hr9iRxy+v9F6r0eJ62VhPQpY8q8Yy9dQlkiGwgAl+COZQhM4puXv81iPbhCIpcWlSYJD+FBo0z
        O3A6kz+QCNbwLKNVu93pWK3uti4mNKZ5MEPYHoqq4rptT18Rw0OqDhWBbqTX6fCNlUAU=;
Received: from p200300ccff4f2e001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff4f:2e00:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1nstNA-0007G9-0T; Sun, 22 May 2022 23:44:24 +0200
Received: from andi by aktux with local (Exim 4.94.2)
        (envelope-from <andreas@kemnade.info>)
        id 1nstN9-0014L4-BC; Sun, 22 May 2022 23:44:23 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        arnd@arndb.de, olof@lixom.net, soc@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, l.stach@pengutronix.de,
        alexander.stein@ew.tq-group.com, marcel.ziswiler@toradex.com,
        linux@rempel-privat.de, andreas@kemnade.info,
        matthias.schiffer@ew.tq-group.com, cniedermaier@dh-electronics.com,
        sebastian.reichel@collabora.com, leoyang.li@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, nicolecrivain@gmail.com
Subject: [PATCH 0/2] ARM: dts: add Kobo Aura 2
Date:   Sun, 22 May 2022 23:44:13 +0200
Message-Id: <20220522214415.254959-1-andreas@kemnade.info>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.0 (-)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a basic device tree for the Kobo Aura 2 Ebook reader.
It is equipped with an i.MX6SL SoC.

Andreas Kemnade (2):
  dt-bindings: arm: fsl: add compatible string for Kobo Aura 2
  ARM: dts: imx: Add devicetree for Kobo Aura 2

 .../devicetree/bindings/arm/fsl.yaml          |   1 +
 arch/arm/boot/dts/Makefile                    |   1 +
 arch/arm/boot/dts/imx6sl-kobo-aura2.dts       | 595 ++++++++++++++++++
 3 files changed, 597 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6sl-kobo-aura2.dts

-- 
2.30.2

