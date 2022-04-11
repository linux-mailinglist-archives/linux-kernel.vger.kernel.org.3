Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 079454FBFB8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 16:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347581AbiDKPA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 11:00:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347580AbiDKPAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 11:00:47 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B69911EAE5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 07:58:32 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 23BEwP8j036059;
        Mon, 11 Apr 2022 09:58:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1649689105;
        bh=dj6CfkKKT+UoMmHhDMzXNUWRTVBPwxkriT6HERhWaq4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=a9pL1b7N/DMin1ujWokjfWTbRdfMgjAnKA92+OIbMwbRugglNu2qUPKvcCnTLsIy6
         M+zWxGZfMiuh8zs6FDExgMofzz65xvETuNFRCn1/+FyattIMOku+HibJNrQl/dVjwa
         M18gKUjSRerqBirqg32aPA9SO7ygURY/QOb8ujm8=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 23BEwPT1021324
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 11 Apr 2022 09:58:25 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 11
 Apr 2022 09:58:25 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 11 Apr 2022 09:58:25 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 23BEwP0T119964;
        Mon, 11 Apr 2022 09:58:25 -0500
From:   Nishanth Menon <nm@ti.com>
To:     <cgel.zte@gmail.com>
CC:     Nishanth Menon <nm@ti.com>, <ssantosh@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Minghao Chi <chi.minghao@zte.com.cn>,
        <linux-kernel@vger.kernel.org>, Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] soc: ti: pruss: using pm_runtime_resume_and_get instead of pm_runtime_get_sync
Date:   Mon, 11 Apr 2022 09:58:25 -0500
Message-ID: <164968909300.29224.373851351948580159.b4-ty@ti.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220408080853.2494292-1-chi.minghao@zte.com.cn>
References: <20220408080853.2494292-1-chi.minghao@zte.com.cn>
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

Hi cgel.zte@gmail.com,

On Fri, 8 Apr 2022 08:08:53 +0000, cgel.zte@gmail.com wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> Using pm_runtime_resume_and_get is more appropriate
> for simplifing code
> 
> 

I have applied the following to branch ti-drivers-soc-next on [1].
Thank you!

[1/1] soc: ti: pruss: using pm_runtime_resume_and_get instead of pm_runtime_get_sync
      commit: f25d2b2b554133b935e72c61deb40d82287a6f75

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

