Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 280EB511EA1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239588AbiD0PWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 11:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239059AbiD0PWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 11:22:16 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DB782E44AE;
        Wed, 27 Apr 2022 08:19:04 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 23RFIiJc063793;
        Wed, 27 Apr 2022 10:18:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1651072724;
        bh=7crZu6YYiAa0Iu/QzOgXqeBWJRUCSihpfp1rzFST0lM=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=jWhCpo7gT9zuc7u+wFFjWAU/MuPlLKuY9ktPiJj1bDA8v6SAsgEMzdoatWZ07Q/eY
         89kLqn5ieB83rLU4zEPEz4MZd9SWqJ6vCRfsrM/vY4odjl+uUk1QgnW7DSHSGKzWSS
         tqvTAmtlVuwo881EJFGV1crz0EZlK+8nP1Xo9Y1Y=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 23RFIiuH106825
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 27 Apr 2022 10:18:44 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 27
 Apr 2022 10:18:44 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 27 Apr 2022 10:18:44 -0500
Received: from uda0132425.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 23RFIeGZ032733;
        Wed, 27 Apr 2022 10:18:41 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Aparna M <a-m1@ti.com>, <kristo@kernel.org>,
        <devicetree@vger.kernel.org>, <kishon@ti.com>,
        <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>, <nm@ti.com>,
        <linux-arm-kernel@lists.infradead.org>
CC:     Vignesh Raghavendra <vigneshr@ti.com>, <nikhil.nd@ti.com>,
        <praneeth@ti.com>
Subject: Re: [RESEND PATCH v3] arm64: dts: ti: k3-am642-sk: Enable WLAN connected to SDHCI0
Date:   Wed, 27 Apr 2022 20:48:37 +0530
Message-ID: <165107250533.1111532.7195096097912705329.b4-ty@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220414133612.13365-1-a-m1@ti.com>
References: <20220414133612.13365-1-a-m1@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aparna M,
 
On Thu, 14 Apr 2022 19:06:12 +0530, Aparna M wrote:
> From: Kishon Vijay Abraham I <kishon@ti.com>
> 
> WL1837 module is connected to SDHCI0 in AM642 SK. Enable it here.
> This will enable the WiFi functionaliy on the board.
> 
> 
 
I have applied the following to branch ti-k3-dts-next on [1].
Thank you!
 
[1/1] arm64: dts: ti: k3-am642-sk: Enable WLAN connected to SDHCI0
      commit: 065d62612e264e228c153afe9aa31d85aeea3d17
 
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

