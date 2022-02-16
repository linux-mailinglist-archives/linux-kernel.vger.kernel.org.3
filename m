Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 117A74B8E58
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 17:41:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236801AbiBPQlb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 11:41:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236764AbiBPQlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 11:41:16 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7AAD2AF939;
        Wed, 16 Feb 2022 08:40:50 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 21GGeeoJ102406;
        Wed, 16 Feb 2022 10:40:40 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1645029640;
        bh=fOV21O1V2aQIITI7O/Q7rDXQYjEhIQpEebP+9w66ozQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=QsGAbf7UeEUUuaYCb0kZFONtSfC5vddan2uM482oS8lsurArsIVMzhL6k26wUkmNW
         KcXNbuZ5QfH6T7Wkt3fyH771KsKvDS/abqtMn9yKKV2oFg/W/AW1icaWYFL7aQuoQK
         Y5LRj1hTK/jOKh73Ai/BqOGGE8YyKW+l7dlPeLb8=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 21GGeeRx103372
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 16 Feb 2022 10:40:40 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 16
 Feb 2022 10:40:40 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 16 Feb 2022 10:40:40 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 21GGeeDK118318;
        Wed, 16 Feb 2022 10:40:40 -0600
From:   Nishanth Menon <nm@ti.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        Hari Nagalla <hnagalla@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Nishanth Menon <nm@ti.com>, <robh+dt@kernel.org>,
        <kristo@kernel.org>, <vigneshr@ti.com>
Subject: Re: [PATCH v1] arm64: dts: ti: k3-am64: Add ESM0 to device memory map
Date:   Wed, 16 Feb 2022 10:40:39 -0600
Message-ID: <164502962527.22838.5260379976754363882.b4-ty@ti.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220210172246.27871-1-hnagalla@ti.com>
References: <20220210172246.27871-1-hnagalla@ti.com>
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

Hi Hari Nagalla,

On Thu, 10 Feb 2022 11:22:46 -0600, Hari Nagalla wrote:
> AM64x SoCs have two ESM modules, with one in MAIN voltage domain and the
> other in MCU voltage domain. The error output from Main ESM module can
> be routed to the MCU ESM module. The error output of MCU ESM can be
> configured to reset the device. The MCU ESM configuration address space
> is already opened and this patch opens the MAIN ESM configuration
> address space.
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/1] arm64: dts: ti: k3-am64: Add ESM0 to device memory map
      commit: 2aeb0696b8e801c20c2176d9dbe512b6a5aa2f79

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

