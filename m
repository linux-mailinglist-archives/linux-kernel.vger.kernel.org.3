Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F3FF4A78EF
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 20:50:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241778AbiBBTuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 14:50:37 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:44018 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346977AbiBBTue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 14:50:34 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 212JoSCj069396;
        Wed, 2 Feb 2022 13:50:28 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1643831428;
        bh=PDV41FIeSzz6CCLPpJKxpTZ+EEr1ZsxD91v3CVrekpw=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Byts02izTV24QPqQMvm1o8HQgFwAlPuhRXuVHdTQwuSTrSpon3CwGUodX5Rf8Ja2c
         Kx10LjFBxnsOyB7F+q01zlk8J/m9Ehk9rx2dFqhLyh76s6oWtXHYiabA79zi6+p9N+
         3FDnO835o+5SZvlIiKiVwBeOpNQGT/d2NfubiI0o=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 212JoSDs004660
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 2 Feb 2022 13:50:28 -0600
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 2
 Feb 2022 13:50:28 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 2 Feb 2022 13:50:28 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 212JoSHW004263;
        Wed, 2 Feb 2022 13:50:28 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        <maz@kernel.org>, <ssantosh@kernel.org>, <kristo@kernel.org>
CC:     Nishanth Menon <nm@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH] firmware: ti_sci: Fix compilation failure when CONFIG_TI_SCI_PROTOCOL is not defined
Date:   Wed, 2 Feb 2022 13:50:27 -0600
Message-ID: <164383139483.1725.16513553485038742707.b4-ty@ti.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <e6c3cb793e1a6a2a0ae2528d5a5650dfe6a4b6ff.1640276505.git.christophe.jaillet@wanadoo.fr>
References: <e6c3cb793e1a6a2a0ae2528d5a5650dfe6a4b6ff.1640276505.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe JAILLET,

On Thu, 23 Dec 2021 17:23:00 +0100, Christophe JAILLET wrote:
> Remove an extra ";" which breaks compilation.
> 
> 

I have applied the following to branch ti-drivers-soc-next on [1].
Thank you!

[1/1] firmware: ti_sci: Fix compilation failure when CONFIG_TI_SCI_PROTOCOL is not defined
      commit: 043cfff99a18933fda2fb2e163daee73cc07910b

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

