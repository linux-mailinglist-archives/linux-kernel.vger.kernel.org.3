Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 919EB481A11
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 07:56:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236699AbhL3G4Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 01:56:25 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:33000 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229514AbhL3G4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 01:56:24 -0500
X-UUID: 31f773133e554b5c8a08136659f39100-20211230
X-UUID: 31f773133e554b5c8a08136659f39100-20211230
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1895940659; Thu, 30 Dec 2021 14:56:20 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Thu, 30 Dec 2021 14:56:18 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 30 Dec 2021 14:56:18 +0800
From:   <miles.chen@mediatek.com>
To:     <matthias.bgg@gmail.com>
CC:     <airlied@linux.ie>, <chunkuang.hu@kernel.org>, <daniel@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <miles.chen@mediatek.com>,
        <p.zabel@pengutronix.de>
Subject: Re: [PATCH] drm/mediatek: Fix unused-but-set variable warning
Date:   Thu, 30 Dec 2021 14:56:16 +0800
Message-ID: <20211230065616.32308-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <fcaccc97-e920-08eb-ec3f-4c4b11ea8925@gmail.com>
References: <fcaccc97-e920-08eb-ec3f-4c4b11ea8925@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>You are right, in both cases the bit is set, but the funciton does not do what 
>it is supposed to do.
>Will just clear all bits of the mask.
>
>Without your patch, we will just write the val to the register and don't care 
>what the register value was before that.
>
>We should somehow mention that in the commit message, as it's not only about a 
>not used variable, it actually has an influence on the value we write(-back) to 
>the register.

thanks for the comment. I understand that it's not only about a not used
variable. I talked to our hdmi experts and they think mtk_cec_mask() should
write tmp instead of write val to the register.

I will mention this in the commit message and submit next patch.

Happy new year!

Miles
