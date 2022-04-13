Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D42134FF1E4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 10:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233562AbiDMIbI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 04:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbiDMIbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 04:31:05 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C01D40E55;
        Wed, 13 Apr 2022 01:28:45 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 0A4221F4026D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1649838524;
        bh=N54+8i5GUyHSDn86OtM+MFFxhEgsk+oZTT3Swq47gYo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=TtN3ilS8e9E2b8QG9QL3kpeSfFSwoY6ox6+4eryA/KxxCTqFN5hSdKPSIYfIEXOd3
         K6YnceetuB9KQ+nREL3U9E5bzwGxk6eoQiQ9OIeW/LtqUm+gh9vZI4SbWirnupLA8B
         wcrIFf4fZp0WZSUVadqb2p0wrzsjHiZxCMWxiPe/aRn7a3uG1zJQHUNHqLRBTFPZT6
         5O7Pmj5SUmxZtaOjdQR+iNAUivMfaklEESNx19n9CssTCH5kCSeECTk7NXnbyChshD
         g8G3YVvJzUyNPAAO8LAQ8Zon6IyqyCBBI6eX3YbG0FM/I+BKSmdwLnw+A5ct95U4z1
         sx3Y8l7MPrqyQ==
Message-ID: <58e91911-1521-2353-342c-5de0d86ac9ae@collabora.com>
Date:   Wed, 13 Apr 2022 10:28:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v14 3/6] dt-bindings: soc: mediatek: move out common
 module from display folder
Content-Language: en-US
To:     Moudy Ho <moudy.ho@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Landley <rob@landley.net>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Courbot <acourbot@chromium.org>, tfiga@chromium.org,
        drinkcat@chromium.org, pihsun@chromium.org, hsinyi@google.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        daoyuan huang <daoyuan.huang@mediatek.com>,
        Ping-Hsun Wu <ping-hsun.wu@mediatek.com>,
        allen-kh.cheng@mediatek.com, xiandong.wang@mediatek.com,
        randy.wu@mediatek.com, jason-jh.lin@mediatek.com,
        roy-cw.yeh@mediatek.com, river.cheng@mediatek.com,
        srv_heupstream@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220411072403.24016-1-moudy.ho@mediatek.com>
 <20220411072403.24016-4-moudy.ho@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220411072403.24016-4-moudy.ho@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 11/04/22 09:24, Moudy Ho ha scritto:
> In order to share the same hardware information with MDP3,
> change the MUTEX dt-binding to the path "soc/mediatek".
> 
> Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
> Acked-by: Rob Herring <robh@kernel.org>
> Acked-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

