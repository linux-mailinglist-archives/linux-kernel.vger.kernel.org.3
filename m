Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33C9B46977E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 14:49:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244850AbhLFNwi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 08:52:38 -0500
Received: from 8bytes.org ([81.169.241.247]:40344 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244804AbhLFNwV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 08:52:21 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id ED55F396; Mon,  6 Dec 2021 14:48:50 +0100 (CET)
Date:   Mon, 6 Dec 2021 14:48:49 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Yong Wu <yong.wu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        David Airlie <airlied@linux.ie>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Will Deacon <will.deacon@arm.com>,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, youlin.pei@mediatek.com,
        Matthias Kaehlcke <mka@chromium.org>, anan.sun@mediatek.com,
        yi.kuo@mediatek.com, acourbot@chromium.org,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Daniel Vetter <daniel@ffwll.ch>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Eizan Miyamoto <eizan@chromium.org>,
        anthony.huang@mediatek.com,
        Frank Wunderlich <frank-w@public-files.de>,
        mingyuan.ma@mediatek.com, yf.wang@mediatek.com,
        libo.kang@mediatek.com
Subject: Re: [PATCH v9 00/15] Clean up "mediatek,larb"
Message-ID: <Ya4UwQ6QhjLA+OiS@8bytes.org>
References: <20211112105509.12010-1-yong.wu@mediatek.com>
 <Ya35hNY0iAR/JPmI@8bytes.org>
 <657ad1fc-0a90-bfc5-d4f1-9ff007f9f672@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <657ad1fc-0a90-bfc5-d4f1-9ff007f9f672@xs4all.nl>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 06, 2021 at 01:33:36PM +0100, Hans Verkuil wrote:
> I think it might be easiest if it is all going through the media subsystem
> (except for the dts patches, we don't handle those unless specifically
> requested to do so). I need a resend for jpeg bindings txt to yaml
> conversion series first, though. This time with the linux-media mailinglist
> included :-)
> 
> I would need your Ack for the iommu patches as well, of course.

Okay, makes sense. IOMMU parts are 

Acked-by: Joerg Roedel <jroedel@suse.de>
