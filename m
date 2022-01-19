Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0D5B493A56
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 13:34:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354483AbiASMef (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 07:34:35 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:49780 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S240879AbiASMed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 07:34:33 -0500
X-UUID: 55ce44f881114e7aae3a5b0eed8ec05b-20220119
X-UUID: 55ce44f881114e7aae3a5b0eed8ec05b-20220119
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1313548519; Wed, 19 Jan 2022 20:34:31 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Wed, 19 Jan 2022 20:34:30 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 19 Jan 2022 20:34:30 +0800
From:   Miles Chen <miles.chen@mediatek.com>
To:     <jason@zx2c4.com>
CC:     <ardb@kernel.org>, <davem@davemloft.net>,
        <gregkh@linuxfoundation.org>, <herbert@gondor.apana.org.au>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <matthias.bgg@gmail.com>,
        <miles.chen@mediatek.com>, <nathan@kernel.org>,
        <ndesaulniers@google.com>
Subject: Re: [PATCH] lib/crypto: blake2s: fix a CFI failure
Date:   Wed, 19 Jan 2022 20:34:30 +0800
Message-ID: <20220119123430.9846-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <CAHmME9pPKjRLmR6zpYFZT7rOOfHsG2ESnDi+QQrDJuGLo1X4JQ@mail.gmail.com>
References: <CAHmME9pPKjRLmR6zpYFZT7rOOfHsG2ESnDi+QQrDJuGLo1X4JQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> We're back in business! I was able to reproduce this using FullLTO
> rather than ThinLTO.

Great!

I tried two clang (r437112b/r437112) but the issue remains.


Miles
