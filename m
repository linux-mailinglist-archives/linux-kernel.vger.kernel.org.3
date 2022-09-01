Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BA315A9A2D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 16:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234687AbiIAOYc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 10:24:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234133AbiIAOX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 10:23:57 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 573914B4A2;
        Thu,  1 Sep 2022 07:23:33 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 281ENLO6027586;
        Thu, 1 Sep 2022 09:23:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1662042201;
        bh=2qQvQY0l9GhxyKyiVwjjsDqTN4a9J3mLbQGw/fpEoWg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=tLgAtvN0ot0d3bZ/1kRH5GWGSrDcAXiqf5OLl344bxlPx8pXgLd1ddMCUA1PERzoX
         O1WminmxRuzgVFbLM8QI4rF08+lOsucfFyopGnCysoda0Zp2ES59Nel9m4WNZE4VkU
         4KvCPGgoKF6eL4T5rM/UOR8EQirCebdmBWswiCe4=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 281ENLo1026732
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 1 Sep 2022 09:23:21 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Thu, 1 Sep
 2022 09:23:21 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Thu, 1 Sep 2022 09:23:21 -0500
Received: from uda0132425.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 281ENIxp108287;
        Thu, 1 Sep 2022 09:23:19 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     <nm@ti.com>, Jayesh Choudhary <j-choudhary@ti.com>,
        <devicetree@vger.kernel.org>
CC:     Vignesh Raghavendra <vigneshr@ti.com>, <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kristo@kernel.org>,
        <linux-kernel@vger.kernel.org>, <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH v2 0/2] Enable SA2UL support on AM64X
Date:   Thu, 1 Sep 2022 19:53:14 +0530
Message-ID: <166204207692.900930.17592300086074188441.b4-ty@ti.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220711085743.10128-1-j-choudhary@ti.com>
References: <20220711085743.10128-1-j-choudhary@ti.com>
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

Hi Jayesh Choudhary,

On Mon, 11 Jul 2022 14:27:41 +0530, Jayesh Choudhary wrote:
> This series enables sa2ul support for TI SoC AM64X.
> It is based on another series posted by Suman Anna:
> <https://lore.kernel.org/linux-arm-kernel/20210514210725.32720-1-s-anna@ti.com/>
> 
> rng node has been disabled due to its indirect access from OP-TEE.
> 
> Since the sa2ul hardware is being used by OP-TEE as well,
> it should be requested using shared TI-SCI flag. So the flag
> has been changed from TI-SCI-EXCLUSIVE to TI-SCI-SHARED.
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/2] arm64: dts: ti: k3-am64: Add SA2UL address space to Main CBASS ranges
      commit: e66e5b2d7f43d92fffb940988ed2822a1b28143b
[2/2] arm64: dts: ti: k3-am64-main: Enable crypto accelerator
      commit: e170ae6dd67a00f750996820d55b144c5189be66

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

