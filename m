Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 520BB50C532
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 01:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbiDVXcH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 19:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbiDVXbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 19:31:50 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B0611D839F;
        Fri, 22 Apr 2022 16:10:35 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 23MNARUn122407;
        Fri, 22 Apr 2022 18:10:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1650669027;
        bh=ZZ/QtBCCPXr1BiXBtjLSNK3sFCTt3ukLuz8jgWXTpoc=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=L/VlDCiTml6RY/kZhpNKUXZNUCvs9HWRRIxMFVHUFRmcic4i4Ez/wzSbV0mgXhSgv
         rkhtTERX2G3OlxStOLixhVVYrMA2J4MVtl0QDzoFx8vJ+tqxix3yPJkR5RnIjFl8Vv
         GorLWOMkVKPtMkcIAby+9d06B7pbICo9HWrOzAUg=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 23MNARqt059488
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 22 Apr 2022 18:10:27 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 22
 Apr 2022 18:10:27 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 22 Apr 2022 18:10:27 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 23MNARdH028478;
        Fri, 22 Apr 2022 18:10:27 -0500
From:   Nishanth Menon <nm@ti.com>
To:     <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     Nishanth Menon <nm@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH v2 1/2] ARM: dts: keystone: align SPI NOR node name with dtschema
Date:   Fri, 22 Apr 2022 18:10:26 -0500
Message-ID: <165066895341.31707.1212055932669760544.b4-ty@ti.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220420090247.73410-1-krzysztof.kozlowski@linaro.org>
References: <20220420090247.73410-1-krzysztof.kozlowski@linaro.org>
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

Hi Krzysztof Kozlowski,

On Wed, 20 Apr 2022 11:02:46 +0200, Krzysztof Kozlowski wrote:
> The node names should be generic and SPI NOR dtschema expects "flash".
> 
> 

I have applied the following to branch ti-keystone-dts-next on [1].
Thank you!

[1/2] ARM: dts: keystone: align SPI NOR node name with dtschema
      commit: 625f5c507994fd8ff9c70b2477902b0e3e1f355f
[2/2] ARM: dts: keystone: fix missing fallback and case in SPI NOR node compatible
      commit: 6273a1864d437553ab4220d1abc010c5bb758ad2


-> Side note: this probably needs fixes in yaml, but the sitn is no different
than before, but improved due to the fixup . (minor fixes done in commit for
capitalization)

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

