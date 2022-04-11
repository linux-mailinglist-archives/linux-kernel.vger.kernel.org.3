Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 849D24FB58D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 10:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343527AbiDKIDu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 04:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343504AbiDKIDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 04:03:47 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C62DCDEB5;
        Mon, 11 Apr 2022 01:01:33 -0700 (PDT)
X-UUID: 30d83f129b184af7830987d6559bfc34-20220411
X-UUID: 30d83f129b184af7830987d6559bfc34-20220411
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <ping-lei.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 840804785; Mon, 11 Apr 2022 16:01:29 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 11 Apr 2022 16:01:28 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 11 Apr 2022 16:01:28 +0800
From:   James_Lin <Ping-lei.Lin@mediatek.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Arnd Bergmann <arnd@arndb.de>,
        Ricardo Ribalda <ribalda@chromium.org>,
        Ming Qian <ming.qian@nxp.com>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        <linux-media@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <ping-lei.lin@mediatek.com>,
        <lecopzer.chen@mediatek.com>, <max.yan@mediatek.com>,
        <sherlock.chang@mediatek.com>, <tm.wu@mediatek.com>,
        James_Lin <Ping-lei.Lin@mediatek.com>
Subject: [PATCH v2 0/2] media: Add H265 pixel format
Date:   Mon, 11 Apr 2022 16:01:18 +0800
Message-ID: <20220411080120.26008-1-Ping-lei.Lin@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

This patch series aims to add H265 pixel format (aka hevc).
High Efficiency Video Coding (HEVC), also known as H.265 and MPEG-H Part 2.
They describe the same video encoding method.
So for handling their behavior is the same.
However, when external camera device describes this encoding method, 
some use hevc, some use h265.
There is no uniform specification to describe this encoding method.
So if an external camera device use h265 to describe this encoding method,
driver will not recognize it.
Therefore, this patch series aims to add H265 pixel format 
to avoid this situation

James_Lin (2):
  media: usb: uvc: Add H265 pixel format
  media: v4l: Add H265 pixel format 

 .../userspace-api/media/v4l/pixfmt-compressed.rst      | 10 ++++++++++
 drivers/media/usb/uvc/uvc_driver.c                     |  5 +++++
 drivers/media/usb/uvc/uvcvideo.h                       |  3 +++
 drivers/media/v4l2-core/v4l2-ioctl.c                   |  1 +
 include/uapi/linux/videodev2.h                         |  1 +
 5 files changed, 20 insertions(+)

-- 
2.18.0

