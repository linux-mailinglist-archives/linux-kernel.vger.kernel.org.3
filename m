Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E21D14D5959
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 04:58:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346162AbiCKD7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 22:59:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346149AbiCKD7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 22:59:01 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B20EA7746
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 19:57:51 -0800 (PST)
X-UUID: 2e3d5d31846a4dd495aea231f9835e5b-20220311
X-UUID: 2e3d5d31846a4dd495aea231f9835e5b-20220311
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1802190452; Fri, 11 Mar 2022 11:57:48 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Fri, 11 Mar 2022 11:57:47 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 11 Mar 2022 11:57:47 +0800
From:   Miles Chen <miles.chen@mediatek.com>
To:     <chun-jie.chen@mediatek.com>
CC:     <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <drinkcat@chromium.org>, <eballetbo@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <matthias.bgg@gmail.com>,
        <miles.chen@mediatek.com>, <srv_heupstream@mediatek.com>
Subject: Re: [PATCH v1] soc: mediatek: pm-domains: Fix the power glitch issue
Date:   Fri, 11 Mar 2022 11:57:47 +0800
Message-ID: <20220311035747.20551-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <3a55f44998645308bb1b4fd65ef550682ebe6ba0.camel@mediatek.com>
References: <3a55f44998645308bb1b4fd65ef550682ebe6ba0.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chun-Jie,

> Hi Miles,
> 
> This control sequence is suggested by hardware designer,
> and when PWR_RST_B from 0 -> 1, it will trigger to exit from reset
> state to running state, if we still enable isolation then can't start
> running normally, so we need to disable isolation first in power on
> sequence.
>

Thanks for your explanation.

Reviewed-by: Miles Chen <miles.chen@mediatek.com>

Thanks,
Miles
