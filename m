Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CDE2473A34
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 02:31:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244563AbhLNBbT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 20:31:19 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:34566 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S239113AbhLNBbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 20:31:17 -0500
X-UUID: afa802f74dd5491abb05b9d488ed79cf-20211214
X-UUID: afa802f74dd5491abb05b9d488ed79cf-20211214
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <mark-pk.tsai@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1180143756; Tue, 14 Dec 2021 09:31:12 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Tue, 14 Dec 2021 09:31:11 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 14 Dec
 2021 09:31:11 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 14 Dec 2021 09:31:11 +0800
From:   Mark-PK Tsai <mark-pk.tsai@mediatek.com>
To:     <mathieu.poirier@linaro.org>
CC:     <bjorn.andersson@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-remoteproc@vger.kernel.org>, <mark-pk.tsai@mediatek.com>,
        <matthias.bgg@gmail.com>, <ohad@wizery.com>,
        <yj.chiang@mediatek.com>
Subject: Re: [PATCH v2] remoteproc: use %pe format string to print return error code
Date:   Tue, 14 Dec 2021 09:31:11 +0800
Message-ID: <20211214013111.17634-1-mark-pk.tsai@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20211213165538.GA1396405@p14s>
References: <20211213165538.GA1396405@p14s>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> https://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.git/log/?h=for-next
> 

Got it, thanks!

