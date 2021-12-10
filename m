Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5575D46FC54
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 09:08:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238196AbhLJIMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 03:12:16 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:39200 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S238185AbhLJIMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 03:12:15 -0500
X-UUID: 718ca2f059a44c8bb5d7d0ab3865303b-20211210
X-UUID: 718ca2f059a44c8bb5d7d0ab3865303b-20211210
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <james.lo@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 642917699; Fri, 10 Dec 2021 16:08:38 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Fri, 10 Dec 2021 16:08:37 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 10 Dec 2021 16:08:36 +0800
Message-ID: <a8275c2ee2a7fad619605b433d61077a03ed4796.camel@mediatek.com>
Subject: Re: [PATCH v16 0/4] Add SPMI support for Mediatek SoC IC
From:   James Lo <james.lo@mediatek.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Fri, 10 Dec 2021 16:08:37 +0800
In-Reply-To: <20211210021215.0EE19C004DD@smtp.kernel.org>
References: <20211119034613.32489-1-james.lo@mediatek.com>
         <20211210021215.0EE19C004DD@smtp.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2021-12-09 at 18:12 -0800, Stephen Boyd wrote:
> Quoting James Lo (2021-11-18 19:46:09)
> > This series adds support for new SoC MT6873/MT8192/MT8195 to the
> > spmi driver.
> > This series is based on Chun-Jie's patches[1].
> > 
> > [1] 
> > https://urldefense.com/v3/__https://patchwork.kernel.org/project/linux-mediatek/list/?series=521655__;!!CTRNKA9wMg0ARbw!ycJplySfH-hTtYCIdjkF0VvfKgtq2B1NeOaBAOw5GU05898X6B7FN21KLkKTZiPC$
> >  
> 
> This isn't needed though right? I've picked these four patches up
> into
> spmi-next.

Yes. You are right.
It's just for notice the patch dependency.
Many Thanks!

