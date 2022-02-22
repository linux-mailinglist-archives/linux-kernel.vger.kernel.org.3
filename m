Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4DE94C0214
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 20:32:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235211AbiBVTcm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 14:32:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234445AbiBVTch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 14:32:37 -0500
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40F1D8BE2F;
        Tue, 22 Feb 2022 11:32:11 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 21MJW6bh032536;
        Tue, 22 Feb 2022 13:32:06 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1645558326;
        bh=VMSzmceLGTfxcOmF2qmhWIVBgsfVi18L43a4m1NAcZM=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=u7bRFqRQILl9UWJYJIADHH1J66+fDuVqlBxJ1GCpkGcJdJwW000z9VHrIMMp8P2MC
         7O3tLmwN+DCEQMHoP+s+C+0BtIkUD1I7jm2ugSrzparTWuV+XXZsPEpBkV+4oHFylO
         M7CiaPVUHwiAK+Ojua49JnhZrxnYCelgCHk41toQ=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 21MJW6vD005628
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 22 Feb 2022 13:32:06 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 22
 Feb 2022 13:32:05 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 22 Feb 2022 13:32:05 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 21MJW5M0077569;
        Tue, 22 Feb 2022 13:32:05 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Pratyush Yadav <p.yadav@ti.com>
CC:     Nishanth Menon <nm@ti.com>, <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH 1/2] arm64: dts: ti: k3-*: Fix whitespace around flash@0 nodes
Date:   Tue, 22 Feb 2022 13:32:04 -0600
Message-ID: <164555831294.27295.15758870545966791533.b4-ty@ti.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220217181025.1815118-1-p.yadav@ti.com>
References: <20220217181025.1815118-1-p.yadav@ti.com>
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

Hi Pratyush Yadav,

On Thu, 17 Feb 2022 23:40:24 +0530, Pratyush Yadav wrote:
> The OSPI flash nodes are missing a space before the opening brace. Fix
> that.
> 
> 

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/2] arm64: dts: ti: k3-*: Fix whitespace around flash@0 nodes
      commit: 672e89d731c46b1f4118a070366dc117afed0f7c
[2/2] arm64: dts: ti: k3-*: Drop address and size cells from flash nodes
      commit: cd9342109a7a901a115227978b86a3db6ee3d7a9

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

