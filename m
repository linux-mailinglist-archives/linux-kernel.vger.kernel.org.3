Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41DC15A9A34
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 16:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234782AbiIAOZk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 10:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234684AbiIAOXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 10:23:17 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD7C5302B;
        Thu,  1 Sep 2022 07:22:57 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 281EMpOP016749;
        Thu, 1 Sep 2022 09:22:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1662042172;
        bh=DufLtdvu5GcQ5C94WiV6e3wj5DPCbSMzA1B1Ef6yJQQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=eS9uLpEIvir6gF6wxDDNeA3MtsU89lzE5VdXbxQA0sNPDA7pMemyg95djvkwbJDO9
         DSjn0Vx2YjFmGwTCfEPsosH3cFxr+D8Ur75XRJzdFtxsfgObxEayzN9dbIWoaO1u8P
         GMff57XhiZEpFdmX2v+yn8UoLItKXRT8TpiSZ6CE=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 281EMpNi053344
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 1 Sep 2022 09:22:51 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Thu, 1 Sep
 2022 09:22:51 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Thu, 1 Sep 2022 09:22:51 -0500
Received: from uda0132425.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 281EMmdq029774;
        Thu, 1 Sep 2022 09:22:49 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     <nm@ti.com>, Roger Quadros <rogerq@kernel.org>
CC:     Vignesh Raghavendra <vigneshr@ti.com>, <kishon@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 0/2] arm64: dts: ti: k3-am64-main: Add GPMC & ELM nodes
Date:   Thu, 1 Sep 2022 19:52:36 +0530
Message-ID: <166204207692.900930.14532847277832309029.b4-ty@ti.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220802104456.11069-1-rogerq@kernel.org>
References: <20220802104456.11069-1-rogerq@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roger Quadros,

On Tue, 2 Aug 2022 13:44:54 +0300, Roger Quadros wrote:
> This series adds GPMC and ELM controller device tree nodes to
> AM64 SoC's dtsi file.
> 
> Changelog:
> v4
> - Rebased to v5.19
> - use 'ti,am64-elm' compatible for ELM node
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/2] arm64: dts: ti: k3-am64-main: Add GPMC memory controller node
      commit: 5ec06904310da6441097c8f2d6e3fb196f42bca1
[2/2] arm64: dts: ti: k3-am64-main: Add ELM (Error Location Module) node
      commit: c920a6caba68196f48f8ee57cc193e396f941011

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

