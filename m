Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B1594C415C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 10:25:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239081AbiBYJZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 04:25:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239083AbiBYJZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 04:25:14 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67895182D87;
        Fri, 25 Feb 2022 01:24:23 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id EF4A81F45AF2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1645781062;
        bh=u9idag57rvmc8+kE2xwXHO4QSmwf2cUfuVZYpVWwzno=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=HHWrpRKDWWODvpKgHH2FJgoYRczWBTVoDmcsJ+U2u8Xqo6LJt2XZnraOXJYYETihN
         hg3T7TC/JSIXJjq1Z314B3P/rZ/SkucOhzZtf3qRY4kVe6BOebMcswRYwEsD5oKJGb
         SUlO7LNPCnyG/O1XvC9dESgyC1ZcYSXHF1vM0piUlEGYLVFjWub+tOFcqqilkm1CWL
         yqsipCrQwrnh3Icd1weux1eKwl5VO7wKVc1uIhcdfU00QzeoFbT6S3bMGUyCRiOSoD
         QOr0dW+2w6ppmynj2Qhb4dkptB4Sj6YEGP2Lxf2VC6/uj6wVnhObM1FwrS/FG2ziV7
         R2W5gl8OWHw6g==
Message-ID: <5d87e367-4ca8-9f61-bc17-e1998be0ed6c@collabora.com>
Date:   Fri, 25 Feb 2022 10:24:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v7, 11/15] media: mtk-vcodec: record capture queue format
 type
Content-Language: en-US
To:     Yunfei Dong <yunfei.dong@mediatek.com>,
        Alexandre Courbot <acourbot@chromium.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomasz Figa <tfiga@google.com>
Cc:     George Sun <george.sun@mediatek.com>,
        Xiaoyong Lu <xiaoyong.lu@mediatek.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Fritz Koenig <frkoenig@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Irui Wang <irui.wang@mediatek.com>,
        Steve Cho <stevecho@chromium.org>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, srv_heupstream@mediatek.com,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220223034008.15781-1-yunfei.dong@mediatek.com>
 <20220223034008.15781-12-yunfei.dong@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220223034008.15781-12-yunfei.dong@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 23/02/22 04:40, Yunfei Dong ha scritto:
> Capture queue format type is difference for different platform,
> need to calculate capture buffer size according to capture queue
> format type in scp.
> 
> Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>


This change is ok, but the commit message should be changed to advertise
that this is preparation for the new stateless H264 decoding driver.
Besides, I suggest to reorder the commits sequence, so that this commit
goes in between "Extract H264 common code" and
"support stateless H.264 decoding for mt8192", as this last one is
the actual real user of this change.


Anyway, this is my commit message proposal:

The capture queue format type may be differ depending on platform:
for stateless decoder drivers, we need to calculate the capture buffer
size according to the capture queue format type in SCP.

As a preparation for introducing drivers for stateless decoding, save
the current capture queue type on a per vcodec context basis.

After fixing,
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
