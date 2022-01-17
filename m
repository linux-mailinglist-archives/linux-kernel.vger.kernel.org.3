Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F06E84905C9
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 11:19:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235846AbiAQKTP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 05:19:15 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:49610 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231768AbiAQKTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 05:19:14 -0500
X-UUID: 4f9e45adb6464056bc8db3761e065897-20220117
X-UUID: 4f9e45adb6464056bc8db3761e065897-20220117
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <lecopzer.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1640374202; Mon, 17 Jan 2022 18:19:11 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 17 Jan 2022 18:19:10 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 17 Jan 2022 18:19:10 +0800
From:   Lecopzer Chen <lecopzer.chen@mediatek.com>
To:     <kernelfans@gmail.com>
CC:     <acme@kernel.org>, <akpm@linux-foundation.org>,
        <alexander.shishkin@linux.intel.com>, <catalin.marinas@arm.com>,
        <jolsa@redhat.com>, <keescook@chromium.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <mark.rutland@arm.com>,
        <masahiroy@kernel.org>, <maz@kernel.org>, <mingo@redhat.com>,
        <namhyung@kernel.org>, <peterz@infradead.org>, <pmladek@suse.com>,
        <samitolvanen@google.com>, <santosh@fossix.org>,
        <sumit.garg@linaro.org>, <wangqing@vivo.com>, <will@kernel.org>,
        <yj.chiang@mediatek.com>, <lecopzer.chen@mediatek.com>
Subject: Re: [PATCHv3 0/4] watchdog_hld cleanup and async model for arm64
Date:   Mon, 17 Jan 2022 18:19:10 +0800
Message-ID: <20220117101910.14999-1-lecopzer.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20211014024155.15253-1-kernelfans@gmail.com>
References: <20211014024155.15253-1-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pingfan,

Is this thread sill in progress?
We are looking for the upstream solution for ARM64 Hardlockup detector.

I'd appreciate it if someone keep working on it,
if not, I can take over it.



thanks!

-Lecopzer


