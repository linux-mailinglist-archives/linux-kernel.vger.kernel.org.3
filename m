Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75191550255
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 05:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384019AbiFRDFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 23:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383998AbiFRDFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 23:05:09 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 820326CAAE;
        Fri, 17 Jun 2022 20:05:08 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 25I354wm079086;
        Fri, 17 Jun 2022 22:05:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1655521504;
        bh=R416NYq2tWsKvc/qVJsB74b95PeOAvQha6wc6gVkOT4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=WVkkkhCq4oHl4xGS8aXtuOQkAseLfIhVTVRtlFPC33haR0IVwr4laRt5D5E8IOOST
         rd41aF0oiekKLm9sbMQJH85zZkuI/bSKJ1svdBIgZ6dlVoYtdtz3D4WJvgHUwlJ8/U
         P8ZfyCKRldv/1KPUEJ/mlq0p0Z91mBRst3oX969o=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 25I353d5009942
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 17 Jun 2022 22:05:04 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 17
 Jun 2022 22:05:02 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 17 Jun 2022 22:05:02 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 25I352Lr026899;
        Fri, 17 Jun 2022 22:05:02 -0500
From:   Nishanth Menon <nm@ti.com>
To:     <vigneshr@ti.com>
CC:     Nishanth Menon <nm@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <grygorii.strashko@ti.com>,
        <faiz_abbas@ti.com>, <krzysztof.kozlowski+dt@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] arm64: dts: ti: k3-am64-main: Remove support for HS400 speed mode
Date:   Fri, 17 Jun 2022 22:05:01 -0500
Message-ID: <165552135775.28605.6156297577884423572.b4-ty@ti.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220512064859.32059-1-a-govindraju@ti.com>
References: <20220512064859.32059-1-a-govindraju@ti.com>
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

Hi Aswath Govindraju,

On Thu, 12 May 2022 12:18:58 +0530, Aswath Govindraju wrote:
> AM64 SoC, does not support HS400 and HS200 is the maximum supported speed
> mode[1]. Therefore, fix the device tree node to reflect the same.
> 
> [1] - https://www.ti.com/lit/ds/symlink/am6442.pdf
>       (SPRSP56C – JANUARY 2021 – REVISED FEBRUARY 2022)
> 
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/1] arm64: dts: ti: k3-am64-main: Remove support for HS400 speed mode
      commit: 0c0af88f3f318e73237f7fadd02d0bf2b6c996bb

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

