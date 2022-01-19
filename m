Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50D7049379E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 10:44:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353116AbiASJo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 04:44:28 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:41914 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1353210AbiASJnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 04:43:46 -0500
X-UUID: 7c2429a6521c484594ae70b615a45057-20220119
X-UUID: 7c2429a6521c484594ae70b615a45057-20220119
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1035585861; Wed, 19 Jan 2022 17:43:43 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 19 Jan 2022 17:43:42 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 19 Jan 2022 17:43:42 +0800
From:   Miles Chen <miles.chen@mediatek.com>
To:     <ardb@kernel.org>
CC:     <Jason@zx2c4.com>, <davem@davemloft.net>, <ebiggers@google.com>,
        <gregkh@linuxfoundation.org>, <herbert@gondor.apana.org.au>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <matthias.bgg@gmail.com>,
        <miles.chen@mediatek.com>, <samitolvanen@google.com>
Subject: Re: [PATCH] lib/crypto: blake2s: fix a CFI failure
Date:   Wed, 19 Jan 2022 17:43:42 +0800
Message-ID: <20220119094342.4515-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <CAMj1kXGUtg1BOauCjxB+S7yMTPArQrPnHf5jnfhOihL-FHrFZA@mail.gmail.com>
References: <CAMj1kXGUtg1BOauCjxB+S7yMTPArQrPnHf5jnfhOihL-FHrFZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>Ehm, maybe not. As Jason points out, the typedef does not have quite
>the right type, so that is most likely the culprit, and this
>workaround would trigger CFI in exactly the same way.
>
>Interestingly, the compiler does not seem to mind, right? Or are you
>seeing any build time warnings on the reference to blake2s_compress in
>the call to __blake2s_update() ?

No, no warnings as the -Wcast-function-type is globally enabled.
I cleaned some cast-function-type errors but no warnings in
__blake2s_update.


Miles
