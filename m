Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D50655022A
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 04:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383950AbiFRCw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 22:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235542AbiFRCwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 22:52:54 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 242B21208F
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 19:52:53 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 25I2qhZO076887;
        Fri, 17 Jun 2022 21:52:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1655520763;
        bh=KadYZrWBZwDw7rGeYt0aw1+RNohuZjS/h4dDR1Xw6+I=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=GAWjXzG3aOMNTgWAuiPWaB1u9ou0wgjXKTIF4q0aEPX0uzN4tG7F+q6U45UE5Dc7/
         XHX52ZJPmmosQEZRIrzgvXo5grStcAR/Ifz203ZxfxlcSnkK7pcjjN+YPWp9/Wmt+d
         +o6dib04gk0XbFmOzeUtacIijtDD1sEaLZbfbGQs=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 25I2qhC3034782
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 17 Jun 2022 21:52:43 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 17
 Jun 2022 21:52:43 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 17 Jun 2022 21:52:43 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 25I2qhkK118075;
        Fri, 17 Jun 2022 21:52:43 -0500
From:   Nishanth Menon <nm@ti.com>
To:     <yang.lee@linux.alibaba.com>
CC:     Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        <abaci@linux.alibaba.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] soc: ti: wkup_m3_ipc: remove unneeded semicolon
Date:   Fri, 17 Jun 2022 21:52:42 -0500
Message-ID: <165552073850.27755.10004474010126334056.b4-ty@ti.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220504225125.45830-1-yang.lee@linux.alibaba.com>
References: <20220504225125.45830-1-yang.lee@linux.alibaba.com>
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

Hi Yang Li,

On Thu, 5 May 2022 06:51:25 +0800, Yang Li wrote:
> Eliminate the following coccicheck warning:
> ./drivers/soc/ti/wkup_m3_ipc.c:691:2-3: Unneeded semicolon
> 
> 

I have applied the following to branch ti-drivers-soc-next on [1].
Thank you!

[1/1] soc: ti: wkup_m3_ipc: remove unneeded semicolon
      commit: b710673e2ddef96ccf74185e72e379520d7984fd

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

