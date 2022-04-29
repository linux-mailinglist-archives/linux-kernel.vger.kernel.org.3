Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D604F514310
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 09:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355036AbiD2HRL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 03:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351856AbiD2HRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 03:17:06 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EFAF36177
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 00:13:49 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 23T7DVYn124323;
        Fri, 29 Apr 2022 02:13:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1651216411;
        bh=s9gGyJc2yY/WVQlutBWnwPVD6v4SVBvahRupanyTCOg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=sMYqKCZU65FF2m+TUQRTyxSP8DfffrZanenHlMlZvhYQsmyhIG0mKyC1V2NPn9P79
         YcRo7f+Xngkhwzvta7QxOrGEEppKdtcxB3lemUOBZKj1IhUHQlA7TxhJkCReGcZBCn
         9DLkVySpQeXW9fM/53SIbp+ljTOPrlsEwtVpf6mM=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 23T7DVu9027519
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 29 Apr 2022 02:13:31 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 29
 Apr 2022 02:13:30 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 29 Apr 2022 02:13:30 -0500
Received: from uda0132425.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 23T7DRKs050269;
        Fri, 29 Apr 2022 02:13:28 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     <arnd@arndb.de>, <krzk@kernel.org>, <catalin.marinas@arm.com>,
        Rahul T R <r-ravikumar@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>, <nm@ti.com>,
        <linux-kernel@vger.kernel.org>, <tomi.valkeinen@ideasonboard.com>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v4] arm64: defconfig: Enable configs for DisplayPort on J721e
Date:   Fri, 29 Apr 2022 12:43:15 +0530
Message-ID: <165121630309.1811039.880476312631472082.b4-ty@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220426152926.20953-1-r-ravikumar@ti.com>
References: <20220426152926.20953-1-r-ravikumar@ti.com>
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

Hi Rahul T R,
 
On Tue, 26 Apr 2022 20:59:26 +0530, Rahul T R wrote:
> Enable DRM and PHY configs required for supporting
> DisplayPort on J721e
> 
> 
 
I have applied the following to branch master on [1].
Thank you!
 
[1/1] arm64: defconfig: Enable configs for DisplayPort on J721e
      commit: b7d8a9973374e57a85e7296f429f50770ca68000
 
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

