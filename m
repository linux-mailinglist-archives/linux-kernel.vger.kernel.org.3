Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB7051D5CE
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 12:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243665AbiEFKhK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 06:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239211AbiEFKhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 06:37:06 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAAD363387;
        Fri,  6 May 2022 03:33:23 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 246AXAvG020549;
        Fri, 6 May 2022 05:33:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1651833190;
        bh=8uUnGT/N24coqfq/6qL08ut0CY2d7nA+ZUfYwYMNN7w=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=i5P/lB4rRgFSznAbjFXZYfwlw38KcGVe/nxQhco5V0x9UG26wuXaxw/ZV1rCqMWjj
         WHdxXGDidTj+1wHiCAADWBu4ITpTCfxn4hVBShucZqBcvYm+r8mnxZsbCkasp0bnMo
         /TPuQzA5Cxnns1bGRPkxdR0M5mDKAnUOXITXD9pA=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 246AXAiZ001531
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 6 May 2022 05:33:10 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 6
 May 2022 05:33:10 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 6 May 2022 05:33:10 -0500
Received: from uda0132425.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 246AX66x063627;
        Fri, 6 May 2022 05:33:07 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     <nm@ti.com>, Rahul T R <r-ravikumar@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        <laurent.pinchart@ideasonboard.com>, <kishon@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <tomi.valkeinen@ideasonboard.com>, <a-bhatia1@ti.com>,
        <kristo@kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>
Subject: Re: [PATCH v5 0/2] DSS: Add support for DisplayPort
Date:   Fri, 6 May 2022 16:02:54 +0530
Message-ID: <165183313632.3012624.14140588020592309194.b4-ty@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220429112639.13004-1-r-ravikumar@ti.com>
References: <20220429112639.13004-1-r-ravikumar@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rahul T R,
 
On Fri, 29 Apr 2022 16:56:37 +0530, Rahul T R wrote:
> The following series of patches enables DisplayPort on
> j721e-evm
> 
> v2:
>    - use phandle with a parameter to refer clocks insted of
>      sub nodes in serdes_wiz node
>    - move phy link node to board DTS file
> 
> [...]
 
I have applied the following to branch ti-k3-dts-next on [1].
Thank you!
 
[1/2] arm64: dts: ti: k3-j721e-*: add DP & DP PHY
      commit: 92c996f4ceabd5780bb7678138267db0a1e1a00e
[2/2] arm64: dts: ti: k3-j721e-common-proc-board: add DP to j7 evm
      commit: 8f984f60f2f1fa109f9ae8c9194b6989f6675c1d
 
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

