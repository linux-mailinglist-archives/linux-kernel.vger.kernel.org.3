Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAD2E4F4677
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 01:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240468AbiDEUcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 16:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391010AbiDEPdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 11:33:38 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A55844B1F6;
        Tue,  5 Apr 2022 06:39:58 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 0F47F1F4343B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1649165997;
        bh=gQ3Pg9KvJsy1nFjnsiFdGRFbG2pjxVLA/rIpxmBYnwQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=bCaiTvvM0EjvxPHg+Cq7O5T0+4hFiZUiI5RpINvgXIufUIWOgU+JCWbOLVPG4UdzK
         vl5GkV8ZyYkDoDat6rI53qT2r39VItbOp2S9bVyr7ze61LtNTD6ql1dbDHp1eYSytk
         Bk98QgZiyNDZ2omvmhhIYaq1PgqlZXI/SYHQLr+G0kHbhrMu80gamnya1o9f3R8YpT
         Im9GzEyXmk5wA7PHXkesFA9m76uC3vjsu0FW1KIAX5HqrSml/R12UNuqDrjvuk4jJk
         pe+LYZhlL84lF3r5Ouk4u2IJlRSzVwgTA9q/KiaooZQyL7co0i1bW8x9BNoHG8rtlc
         kCeCgITqZw9eg==
Message-ID: <0762b013-6c13-ef57-5796-902c9899ee95@collabora.com>
Date:   Tue, 5 Apr 2022 15:39:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2] media: mediatek: vcodec: Fix v4l2 compliance decoder
 cmd test fail
Content-Language: en-US
To:     Yunfei Dong <yunfei.dong@mediatek.com>,
        Alexandre Courbot <acourbot@chromium.org>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
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
References: <20220401081302.9475-1-yunfei.dong@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220401081302.9475-1-yunfei.dong@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 01/04/22 10:13, Yunfei Dong ha scritto:
> Will return -EINVAL using standard framework api when test stateless
> decoder with cmd VIDIOC_(TRY)DECODER_CMD.
> 
> Using another return value to adjust v4l2 compliance test for user
> driver(GStreamer/Chrome) won't use decoder cmd.
> 
> Fixes: 8cdc3794b2e3 ("media: mtk-vcodec: vdec: support stateless API")
> Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

