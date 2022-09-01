Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90DC65A9A20
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 16:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234633AbiIAOW5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 10:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234686AbiIAOWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 10:22:16 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FCD5760D1;
        Thu,  1 Sep 2022 07:22:13 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 281EM1mX116947;
        Thu, 1 Sep 2022 09:22:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1662042121;
        bh=FKmC4JLsRogIkhLlI8/LwvBBow/yayBkmdAZPERKEJU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=h2NRpw2WhT7/FaJQbVREgAr6Y3HIOyPFpUxIuji5pGv07+TPzuj9EVLw74O8HtfnS
         gi8m2nsnSXWL4/4JvLNbV/BOUzf1v9wq5UJf+7N1RN6bpgV9h6UmxP3n1SuKzGGDlW
         golpzKyFuRxLmXCN+Kb58ifWkx8C/ZwULUCrx7oI=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 281EM049023486
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 1 Sep 2022 09:22:01 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Thu, 1 Sep
 2022 09:22:00 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Thu, 1 Sep 2022 09:22:00 -0500
Received: from uda0132425.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 281ELvOR086348;
        Thu, 1 Sep 2022 09:21:58 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Andrew Davis <afd@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Tero Kristo <kristo@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH] arm64: dts: ti: k3-j7200-main: Add main domain watchdog entries
Date:   Thu, 1 Sep 2022 19:51:48 +0530
Message-ID: <166204207691.900930.3562407276066506695.b4-ty@ti.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220822235006.7081-1-afd@ti.com>
References: <20220822235006.7081-1-afd@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew Davis,

On Mon, 22 Aug 2022 18:50:06 -0500, Andrew Davis wrote:
> From: Gowtham Tammana <g-tammana@ti.com>
> 
> Add DT entries for main domain watchdog instances.
> 
> 

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/1] arm64: dts: ti: k3-j7200-main: Add main domain watchdog entries
      commit: 6038f1171162faaebbbe3acd1c6712a18a161a41

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent up the chain during
the next merge window (or sooner if it is a relevant bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/ti/linux.git
--
Vignesh

