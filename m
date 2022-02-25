Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38D024C4144
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 10:24:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239048AbiBYJY6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 04:24:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239067AbiBYJYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 04:24:55 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 363A827C22D;
        Fri, 25 Feb 2022 01:24:17 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id D2D471F45AF1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1645781056;
        bh=I+K+WOpJ+r6DzLexypzmkpiWw1dTAUKgNSN2s8sEiy8=;
        h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
        b=WfURaTEDQnEej5+Sudz4lL8wPrk+0kg3IGFSRQ3tbw7TpHioE70OscGnCSm7DjSRL
         M9Ho4VtG97o6cHpF7p74pMpWfd7b8dt1SxAOUBIMmXiEBwNJFe6uk6eONZMryVJgoo
         SyqHKMrAJqUmRhJVQcvcZXvvsTAfYTPCWFlLU8zrr3f0mVchjPUKyo0iR//RMdTpwk
         kx4Fxcd57anWEYyotX1EiaSIM9zBRXYK5wN/vqpKrwzRc4BztyMlUb/b6kR49l2bLd
         GP6DJ2v7dH6qK4NEyhSZaREYRr/a06x0yKP+gcnNmAEKEYg8TWKJ5UeHIUHnmqPr8W
         NVr2lMjeR3bMQ==
Message-ID: <cd5cb589-9e3e-eb3a-4adf-9f57f3d22359@collabora.com>
Date:   Fri, 25 Feb 2022 10:24:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v7, 08/15] media: mtk-vcodec: Add format to support MT21C
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
 <20220223034008.15781-9-yunfei.dong@mediatek.com>
Content-Language: en-US
In-Reply-To: <20220223034008.15781-9-yunfei.dong@mediatek.com>
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
> Needs to use mediatek compressed mode for mt8192 decoder.
> 
> Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

