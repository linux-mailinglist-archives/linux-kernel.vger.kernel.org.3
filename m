Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCC6E4B8E57
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 17:41:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236675AbiBPQlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 11:41:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236527AbiBPQk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 11:40:56 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03D0925DA45;
        Wed, 16 Feb 2022 08:40:40 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 21GGeJqZ026382;
        Wed, 16 Feb 2022 10:40:19 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1645029619;
        bh=w9bCP3/CICxOfqQKSa3r2RKaoS9MwRJ1oCJRygAlF78=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=B05ZVVVh7aHvqfLoHxGuUuXtPExuWiLbA0Ki4mhIhWm62XvcR0ncRD/EvI1YCW6Ew
         RA1Az+ihbbxPxHKx1foH8IChjyptCeEt2abBnrcvoCS9nnmXd7mRsJ1AftnnSgq7gC
         iDxEGqT5sunkA9WTdBldLpKKE2MOV1ZAyRQXXF+s=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 21GGeJcE045587
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 16 Feb 2022 10:40:19 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 16
 Feb 2022 10:40:18 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 16 Feb 2022 10:40:18 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 21GGeH7n110602;
        Wed, 16 Feb 2022 10:40:17 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Rob Herring <robh+dt@kernel.org>, <jan.kiszka@siemens.com>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>
CC:     Nishanth Menon <nm@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: (subset) [PATCH v2 1/2] arm64: dts: ti: k3-am65: disable optional peripherals by default
Date:   Wed, 16 Feb 2022 10:40:16 -0600
Message-ID: <164502944352.22599.4383149138221913907.b4-ty@ti.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220203140240.973690-1-matthias.schiffer@ew.tq-group.com>
References: <20220203140240.973690-1-matthias.schiffer@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias Schiffer,

On Thu, 3 Feb 2022 15:02:39 +0100, Matthias Schiffer wrote:
> All peripherals that require pinmuxing or other configuration to work
> should be disabled by default. Dependent DTS are adjusted accordingly.
> 
> The following nodes are now "disabled" according to dtx_diff and were not
> overridden to "okay", as they define no pinctrl:
> 
> k3-am654-base-board:
> - mcu_i2c0
> - mcu_spi0..2
> - mcu_uart0
> - cal
> - main_i2c3
> - ehrpwm0..5
> - main_uart1..2
> - main_spi1..4
> 
> [...]

Patch 1 of the series, I have'nt pickedup given the argumentation we have had
in the thread.. if we need a broader alignment, I am all for it, but lets
start pushing from updating a process document as a discussion point.. I bet
that should start triggering more debates.

I have applied the following (patch #2) to branch ti-k3-dts-next on
[1] with minor cosmetic (subject line capitalization, message format
to 70 char) fixups..


Thank you!

[2/2] arm64: dts: ti: k3-am65*: remove #address-cells/#size-cells from flash nodes
      commit: 292b0dd7cdc1b00a8acb199605ecf73bb253c5b5

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

[1] git://git.kernel.org/pub/scm/linux/kernel/git/ti/linux.git
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

