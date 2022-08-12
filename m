Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57D16590CE6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 09:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237645AbiHLHxb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 03:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236480AbiHLHx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 03:53:28 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20B5FA721E;
        Fri, 12 Aug 2022 00:53:23 -0700 (PDT)
X-UUID: 32d70552f3984b9eb0471fe447add870-20220812
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=4h8pJ2DKLxVCS5J3QoilhwJF0fUMj4gWuIsoPrZPKMA=;
        b=OVDxWKk9vFU15CuVqRNpSrlngitUq0dgTq7sz2huy7vWqlE1IxWe1lte892zsC/X9DSF+axG99lqSyOBfaUDuV1eyIRUtDRNAy0Z3fbQPykD8gP57NZ0egm+mGpRbXyAe7Y2FK5EUMqt6PyR+GXMcj+BARtQGjW5ywov4Na06HE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.9,REQID:2ee0ce42-0f46-42e8-a41f-c7c0dc9483f0,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_H
        am,ACTION:release,TS:0
X-CID-META: VersionHash:3d8acc9,CLOUDID:6e47789c-da39-4e3b-a854-56c7d2111b46,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:-5,EDM:-3,IP:nil,URL:0,File:ni
        l,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 32d70552f3984b9eb0471fe447add870-20220812
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1587919333; Fri, 12 Aug 2022 15:53:16 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Fri, 12 Aug 2022 15:53:15 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Fri, 12 Aug 2022 15:53:15 +0800
From:   Miles Chen <miles.chen@mediatek.com>
To:     <linus.walleij@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <sre@kernel.org>, <trix@redhat.com>
Subject: Re: [PATCH] power: supply: ab8500: remove unused static local variable
Date:   Fri, 12 Aug 2022 15:53:15 +0800
Message-ID: <1660290795-612-1-git-send-email-miles.chen@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <CACRpkdafsWC4VM4c623Q2prkG4uaQPpY0fUkM0wbmWqM0J4TFQ@mail.gmail.com>
References: <CACRpkdafsWC4VM4c623Q2prkG4uaQPpY0fUkM0wbmWqM0J4TFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> cpp_check reports
>> [drivers/power/supply/ab8500_chargalg.c:493]: (style) Variable 'ab8500_chargalg_ex_ac_enable_toggle' is assigned a value that is never used.
>>
>> From inspection, this variable is never used. So remove it.
>>
>> Fixes: 6c50a08d9dd3 ("power: supply: ab8500: Drop external charger leftovers")
>> Signed-off-by: Tom Rix <trix@redhat.com>
>
>Thanks Tom!
>Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>
>Yours,
>Linus Walleij

Hi Sebastian,

It looks like that this patch is not in linux-next 20220812
and I can still observe this build error with ARCH=arm, defconfig=allyesconfig.

Would you pick up this fix, please?

Thanks,
Miles
