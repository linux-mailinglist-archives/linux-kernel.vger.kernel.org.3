Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 809AD55023E
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 05:00:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383924AbiFRDAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 23:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383967AbiFRDAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 23:00:35 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 037256C560;
        Fri, 17 Jun 2022 20:00:34 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 25I30PZs078245;
        Fri, 17 Jun 2022 22:00:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1655521225;
        bh=+5VI5pZBo8bqwisTLTBIUAHES2bOLGNcpeVYMMWFTD0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=kALr+PVdXblpTuhflIf9EavY8lhetJwxWDxYLBs7gkX1RbYVeZbRi8o3qMxnJLOzM
         CorkOh+8h6AeVnIOWUvXCMqwFUjcJQO7nle7aKTUrnMpwxAfdzz5NFPpJy0FtKi/EE
         ZJUKjjj5+ZexT0WPuY/z1yoDOS1VExvDGI2fEPYg=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 25I30PXv070105
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 17 Jun 2022 22:00:25 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 17
 Jun 2022 22:00:25 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 17 Jun 2022 22:00:25 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 25I30Poq125209;
        Fri, 17 Jun 2022 22:00:25 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Tony Lindgren <tony@atomide.com>, <linux-kernel@vger.kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <arm@kernel.org>,
        <olof@lixom.net>, <devicetree@vger.kernel.org>, <soc@kernel.org>,
        <robh+dt@kernel.org>, <vigneshr@ti.com>,
        Arnd Bergmann <arnd@arndb.de>,
        <linux-arm-kernel@lists.infradead.org>, <kristo@kernel.org>,
        <krzysztof.kozlowski@linaro.org>
CC:     Nishanth Menon <nm@ti.com>
Subject: Re: (subset) [PATCH 1/3] arm64: dts: ti: adjust whitespace around '='
Date:   Fri, 17 Jun 2022 22:00:15 -0500
Message-ID: <165552085007.28094.12509530167428789527.b4-ty@ti.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220526204139.831895-1-krzysztof.kozlowski@linaro.org>
References: <20220526204139.831895-1-krzysztof.kozlowski@linaro.org>
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

Hi Krzysztof Kozlowski,

On Thu, 26 May 2022 22:41:36 +0200, Krzysztof Kozlowski wrote:
> Fix whitespace coding style: use single space instead of tabs or
> multiple spaces around '=' sign in property assignment.  No functional
> changes (same DTB).
> 
> 

I have applied the following to branch ti-k3-dts-next on [1].

[1/3] arm64: dts: ti: Adjust whitespace around '='
      commit: 5888f1ed173e78fb06ebd2aae61061166dd6b359

I have applied the following to branch ti-keystone-dts-next on [1].

[3/3] ARM: dts: keystone: adjust whitespace around '='
      commit: 3ea73bf02225ad433e7cfbf8427b08aa8c593775

Thank you!

Tony: I think it is better if you pick up:
https://lore.kernel.org/all/20220526204139.831895-2-krzysztof.kozlowski@linaro.org/

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

