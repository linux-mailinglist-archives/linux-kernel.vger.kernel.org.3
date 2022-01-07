Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3E26486FC0
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 02:41:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345207AbiAGBkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 20:40:51 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:37520 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229538AbiAGBku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 20:40:50 -0500
X-UUID: 8a7ed46a2971447993db1053b65d8e16-20220107
X-UUID: 8a7ed46a2971447993db1053b65d8e16-20220107
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1649835202; Fri, 07 Jan 2022 09:40:47 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 7 Jan 2022 09:40:46 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 7 Jan 2022 09:40:46 +0800
From:   Miles Chen <miles.chen@mediatek.com>
To:     <matthias.bgg@gmail.com>
CC:     <airlied@linux.ie>, <chunkuang.hu@kernel.org>, <daniel@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>, <jie.qiu@mediatek.com>,
        <junzhi.zhao@mediatek.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <llvm@lists.linux.dev>,
        <p.zabel@pengutronix.de>
Subject: Re: [PATCH v3] drm/mediatek: Fix unused-but-set variable warning
Date:   Fri, 7 Jan 2022 09:40:46 +0800
Message-ID: <20220107014046.30492-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220102234633.31709-1-miles.chen@mediatek.com>
References: <20220102234633.31709-1-miles.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

>> I'm still not happy with the commit subject, I think it is misleading. Clang 
>> only helped to find the bug, but the we are fixing something else, that's not 
>> just a clang warning. But I don't want to nit-pick too much so:
>> 
>> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> thanks. I think you are right.
> I will change the subject to "drm/mediatek: Fix mtk_cec_mask()", remove the 
> clang part and submit patch v4.

I posted patch v4 https://lore.kernel.org/linux-mediatek/20220103054706.8072-1-miles.chen@mediatek.com/
without your reviewed-by tag.

Would you mind taking a look at the patch?

Miles
