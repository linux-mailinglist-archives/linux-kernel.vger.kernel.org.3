Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 911D556978E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 03:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234606AbiGGBen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 21:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234357AbiGGBek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 21:34:40 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D17162ED56;
        Wed,  6 Jul 2022 18:34:39 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2671YZrB113243;
        Wed, 6 Jul 2022 20:34:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1657157675;
        bh=SzuxgK0E4o1NfZEnHk0MEoLrtuSS2A7IKxtq1pEZ6LY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=WwIOZgpIS3YggqKtUEGATdWcKUEUw2eUvduoguwW20ecJuygcU9MPOlgEf5ru87hf
         2OjZZRnJILlbRv89+d1NfbeFl4Zn4Vwp8rCrT2qlrP741mY6gRRavEiYcNpmXI0HIh
         qRPjRudabAESBdKgwpycuesmfqZBDYVpsUg50Ju0=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2671YZMC043481
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 6 Jul 2022 20:34:35 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 6
 Jul 2022 20:34:34 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 6 Jul 2022 20:34:34 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2671YYF4020369;
        Wed, 6 Jul 2022 20:34:34 -0500
From:   Nishanth Menon <nm@ti.com>
To:     <j-choudhary@ti.com>, <devicetree@vger.kernel.org>
CC:     Nishanth Menon <nm@ti.com>, <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>, <vigneshr@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <kristo@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH v2] arm64: dts: ti: k3-am62-main: Enable crypto accelerator
Date:   Wed, 6 Jul 2022 20:34:34 -0500
Message-ID: <165715764566.15442.6301245333078904255.b4-ty@ti.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220624043905.129207-1-j-choudhary@ti.com>
References: <20220624043905.129207-1-j-choudhary@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jayesh Choudhary,

On Fri, 24 Jun 2022 10:09:05 +0530, Jayesh Choudhary wrote:
> Add the node for sa3ul crypto accelerator.
> 
> 

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/1] arm64: dts: ti: k3-am62-main: Enable crypto accelerator
      commit: 8af893654c027fb679f67851aedb569ce7acb1e4

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

