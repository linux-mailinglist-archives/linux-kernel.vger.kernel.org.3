Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4490C4937F7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 11:11:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353481AbiASKKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 05:10:47 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:55180 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1353436AbiASKKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 05:10:32 -0500
X-UUID: 0b54defdbd62445c9426f5360c516332-20220119
X-UUID: 0b54defdbd62445c9426f5360c516332-20220119
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1438925155; Wed, 19 Jan 2022 18:10:29 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 19 Jan 2022 18:10:28 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 19 Jan
 2022 18:10:22 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 19 Jan 2022 18:10:22 +0800
From:   Miles Chen <miles.chen@mediatek.com>
To:     <ardb@kernel.org>
CC:     <Jason@zx2c4.com>, <davem@davemloft.net>, <ebiggers@google.com>,
        <gregkh@linuxfoundation.org>, <herbert@gondor.apana.org.au>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <matthias.bgg@gmail.com>,
        <miles.chen@mediatek.com>, <samitolvanen@google.com>
Subject: Re: [PATCH] lib/crypto: blake2s: fix a CFI failure
Date:   Wed, 19 Jan 2022 18:10:22 +0800
Message-ID: <20220119101022.5176-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <CAMj1kXEuWRUbCqDBnxiWRaERt6OGL8ufQ1Q7naAGHqKK1oQB1w@mail.gmail.com>
References: <CAMj1kXEuWRUbCqDBnxiWRaERt6OGL8ufQ1Q7naAGHqKK1oQB1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

> We should try to understand why CFI thinks the prototypes of the two
> symbols are different. There are still a number of issues with CFI, so
> papering over them by reverting stuff that we want for good reasons is
> not the way to go imo.
> 
> In the short term, you can work around it by avoiding the indirect
> call to blake2s_compress, e.g.,

Thanks for the patch. I tried it and the issue remains.
As Jason said, he cannot reproduce this issue. I will try another version
of clang next.

Miles
