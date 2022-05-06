Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E15B551D5D0
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 12:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391025AbiEFKht (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 06:37:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379956AbiEFKhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 06:37:38 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E42266235;
        Fri,  6 May 2022 03:33:54 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 246AXhwc020640;
        Fri, 6 May 2022 05:33:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1651833223;
        bh=e+7AI/dqFdCrizADn3J7H7sfNd/IfokBRf3E1qWvvtw=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Mz/SKS5acFjRQpK2/OH+7vC+UYspkwAwXJ6H3tnkKAurTvQ5ydx7B09gP3EVBdyjQ
         XZAH5OSWQNZVBLG7ke9NCtoKOYuWfxi4eOE1I69Y2S0RGCJE3TCQEQjsmESYuIsRA0
         B1zkOe/8VYh/Wk9s/YFEWHpCHnG7i8tGuVeYm9Tg=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 246AXhaH001674
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 6 May 2022 05:33:43 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 6
 May 2022 05:33:43 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 6 May 2022 05:33:43 -0500
Received: from uda0132425.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 246AXdjB064082;
        Fri, 6 May 2022 05:33:39 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     <nm@ti.com>, Rahul T R <r-ravikumar@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        <laurent.pinchart@ideasonboard.com>, <kishon@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <tomi.valkeinen@ideasonboard.com>, <a-bhatia1@ti.com>,
        <kristo@kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>
Subject: Re: [PATCH v2 0/2] Add support for DP and HDMI on j721e-sk
Date:   Fri, 6 May 2022 16:03:31 +0530
Message-ID: <165183313633.3012624.13058548556780163817.b4-ty@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220505090709.9252-1-r-ravikumar@ti.com>
References: <20220505090709.9252-1-r-ravikumar@ti.com>
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
 
On Thu, 5 May 2022 14:37:07 +0530, Rahul T R wrote:
> The following series of patches enables DisplayPort and
> HDMI on j721e-sk
> 
> v2:
>    - Fix name for dpi1 dss endpoint
> 
> This series depends on
> https://lore.kernel.org/all/20220429112639.13004-1-r-ravikumar@ti.com/
> which adds required nodes in the SoC dtsi file
> 
> [...]
 
I have applied the following to branch ti-k3-dts-next on [1].
Thank you!
 
[1/2] arm64: dts: ti: k3-j721e-sk: Enable DisplayPort
      commit: d4f3c8a169ab82b91ba1e10a495e900477a75cf5
[2/2] arm64: dts: ti: k3-j721e-sk: Enable HDMI
      commit: 7d4686fc3c2ad9bfd1eaf3c54515d6469e542578
 
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

