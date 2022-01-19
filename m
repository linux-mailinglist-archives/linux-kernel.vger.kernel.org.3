Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D070493C27
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 15:47:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355251AbiASOq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 09:46:59 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:41192 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1355235AbiASOq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 09:46:58 -0500
X-UUID: 06ce7e1cedd24fa3a48e2a28b2d036cc-20220119
X-UUID: 06ce7e1cedd24fa3a48e2a28b2d036cc-20220119
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1089773830; Wed, 19 Jan 2022 22:46:54 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 19 Jan 2022 22:46:52 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 19 Jan 2022 22:46:52 +0800
From:   Miles Chen <miles.chen@mediatek.com>
To:     <jason@zx2c4.com>
CC:     <ardb@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <miles.chen@mediatek.com>,
        <ndesaulniers@google.com>, <samitolvanen@google.com>
Subject: [PATCH] lib/crypto: blake2s: avoid indirect calls to compression function for Clang CFI
Date:   Wed, 19 Jan 2022 22:46:52 +0800
Message-ID: <20220119144652.12349-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220119135450.564115-1-Jason@zx2c4.com>
References: <20220119135450.564115-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Test-by: Miles Chen <miles.chen@mediatek.com>

Thank Jason & Ard for your help!

Miles
