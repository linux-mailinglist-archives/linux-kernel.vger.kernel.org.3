Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A76049C2F1
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 06:12:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231837AbiAZFMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 00:12:03 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:41980 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229691AbiAZFMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 00:12:01 -0500
X-UUID: fafe2870f8f34f8d95237fb10f976999-20220126
X-UUID: fafe2870f8f34f8d95237fb10f976999-20220126
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1316894194; Wed, 26 Jan 2022 13:11:56 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 26 Jan 2022 13:11:55 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 26 Jan
 2022 13:11:55 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 26 Jan 2022 13:11:55 +0800
From:   Miles Chen <miles.chen@mediatek.com>
To:     <david.laight@aculab.com>
CC:     <kiran.kumar1.s@intel.com>, <lakshmi.sowjanya.d@intel.com>,
        <linus.walleij@linaro.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <matthias.bgg@gmail.com>,
        <miles.chen@mediatek.com>
Subject: RE: [PATCH] pinctrl: fix a discarded-qualifiers build error
Date:   Wed, 26 Jan 2022 13:11:55 +0800
Message-ID: <20220126051155.25808-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <693a71e17b364afd987f2d2178b7e5cb@AcuMS.aculab.com>
References: <693a71e17b364afd987f2d2178b7e5cb@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

> You should change the type of 'grp' not add a cast.
> The compiler can warn about casts removing 'const' as well.
> 
> 	David

Thanks for the comment,
I just found that this issue has been fixed [1]


Miles

[1] https://lore.kernel.org/lkml/DM6PR11MB3660804C821D7CA7329B6CAFC45F9@DM6PR11MB3660.namprd11.prod.outlook.com/

