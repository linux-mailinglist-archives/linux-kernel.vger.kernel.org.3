Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59B9E4FDE1F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 13:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349654AbiDLLlb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 07:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354210AbiDLLis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 07:38:48 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 947E3275EE;
        Tue, 12 Apr 2022 03:19:35 -0700 (PDT)
Received: from janitor.denx.de (unknown [62.91.23.180])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: noc@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 5C20783608;
        Tue, 12 Apr 2022 12:19:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1649758773;
        bh=TaLy1sgu+awF5QuUc0m04US0G/xEcsVP/ABkdut84WM=;
        h=From:To:Cc:Subject:Date:From;
        b=R9hnsXytG4Ose4RqH2r2YtaaBkPTCf20u0yYl7xJy8Krr0KAlz7qKl8a76vLdjWIE
         nH+TvyQajwVwT3m3ymGEYjLgOqA4WgdpUXNLQUOJ4WNCN+SLP0eE4wXnGd+w1xR6wQ
         IcAFwJJd/fRpDGWkTnBeeopVVdKsQ+GXXKsCvBvTZT2x13FX5kZmpWQLxXO0d95qIn
         wVtmebN9kqdI+qKQ+qiB82JZ9es2l9aFE5ONwqcOO/0c1AVQUKs0VUYFWoWO6YaCwH
         wKikUqyAiJXy7q3Sn98XGWum1zHy2nk9WG+F8ruuWXONC1yzZZIzUuUIxbgf+jzKmR
         c78RpfHZAbATw==
Received: by janitor.denx.de (Postfix, from userid 108)
        id D2E19A02C3; Tue, 12 Apr 2022 12:19:32 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
Received: from xpert.denx.de (xpert.denx.de [192.168.0.4])
        by janitor.denx.de (Postfix) with ESMTPS id 34F45A005F;
        Tue, 12 Apr 2022 12:19:30 +0200 (CEST)
Received: by xpert.denx.de (Postfix, from userid 535)
        id 092B33E0786; Tue, 12 Apr 2022 12:19:30 +0200 (CEST)
From:   Philip Oberfichtner <pro@denx.de>
To:     devicetree@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Winker Matthias <Matthias.Winker@de.bosch.com>,
        Philip Oberfichtner <pro@denx.de>
Subject: [PATCH 0/2] arm: dts: Add device tree for bosch acc board
Date:   Tue, 12 Apr 2022 12:19:03 +0200
Message-Id: <20220412101905.514310-1-pro@denx.de>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.5 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dt and dt binding for bosch acc board, based on i.MX6 Dual.

Philip Oberfichtner (2):
  dt-bindings: arm: Add bosch acc board
  arm: dts: Add device tree for bosch acc board

 .../devicetree/bindings/arm/fsl.yaml          |    1 +
 arch/arm/boot/dts/Makefile                    |    1 +
 arch/arm/boot/dts/imx6q-bosch-acc.dts         | 1048 +++++++++++++++++
 3 files changed, 1050 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6q-bosch-acc.dts

-- 
2.34.1

