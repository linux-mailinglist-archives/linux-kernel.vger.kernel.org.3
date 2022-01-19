Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2A74936FF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 10:16:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352852AbiASJQh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 04:16:37 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:53414 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1352882AbiASJQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 04:16:31 -0500
X-UUID: f7433a76f4a14f8b8af01be528ce64f4-20220119
X-UUID: f7433a76f4a14f8b8af01be528ce64f4-20220119
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 974005258; Wed, 19 Jan 2022 17:16:27 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 19 Jan 2022 17:16:26 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 19 Jan 2022 17:16:26 +0800
From:   Miles Chen <miles.chen@mediatek.com>
To:     <jason@zx2c4.com>
CC:     <ardb@kernel.org>, <davem@davemloft.net>,
        <gregkh@linuxfoundation.org>, <herbert@gondor.apana.org.au>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <matthias.bgg@gmail.com>,
        <miles.chen@mediatek.com>
Subject: Re: [PATCH] lib/crypto: blake2s: fix a CFI failure
Date:   Wed, 19 Jan 2022 17:16:23 +0800
Message-ID: <20220119091626.3636-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <CAHmME9rWs_w_dMfDLFuD-tr79cnVyuny4fLn9Wh0+bs76Nt0MA@mail.gmail.com>
References: <CAHmME9rWs_w_dMfDLFuD-tr79cnVyuny4fLn9Wh0+bs76Nt0MA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>typedef void (*blake2s_compress_t)(struct blake2s_state *state,
>				   const u8 *block, size_t nblocks, u32 inc);
>
>should become
>
>typedef void (*blake2s_compress_t)(struct blake2s_state *state,
>				   const u8 *block, size_t nblocks, const u32 inc);
>
>Does making that change fix things for you?
>
>Thanks,
>Jason

Thanks for your fast response.
It does not work. I tried this before reverting the commit 6048fdcc5f26.

Miles
