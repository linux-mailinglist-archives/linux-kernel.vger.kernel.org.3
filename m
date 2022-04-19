Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06023506D97
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 15:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245181AbiDSNit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 09:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244693AbiDSNiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 09:38:46 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B260C37A1A;
        Tue, 19 Apr 2022 06:36:01 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 49A6C1F418A1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1650375360;
        bh=ocUjKBQRtS1wz0vGDv2AACyasED2cCrcmqG1Y3gxn9Q=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ovZBUC+TjhSYlr3SJZPhoeAJGHEPCMNOCfvTxnh7nkSaZ0lFdYd92Xe9Hk/5R2737
         ketAtfvETvX1Tpbx6Ht9EynGNgbe5JSmbZtfPDexpX+IduqggrhOlIJFqjYLqltUCV
         Yz2air4Wr/Yr7fjhVhVU/IQnFUJiAqHM3QD4S1PdWiW41aBELzgap5Blu7Oo5oLVTq
         +V537Qup6qp2XXNQsvnbo8P41LINm8cZFQpfJIxDH92sg2Aje1uBpRBNxOEAgUDmck
         cUfqM/naWGJ/2G+h4+0+S8PQl5yjVVxk+HnWNsI5/J6TgMVVpjYNdhW2eNxd9fQg2F
         o8O5rASOxoGlQ==
Message-ID: <4743441e-b89d-966d-ef9a-d1c306416587@collabora.com>
Date:   Tue, 19 Apr 2022 15:35:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v16 3/6] dt-bindings: soc: mediatek: move out common
 module from display folder
Content-Language: en-US
To:     Moudy Ho <moudy.ho@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
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
References: <20220418083018.1907-1-moudy.ho@mediatek.com>
 <20220418083018.1907-4-moudy.ho@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220418083018.1907-4-moudy.ho@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 18/04/22 10:30, Moudy Ho ha scritto:
> In order to share the same hardware information with MDP3,
> change the MUTEX dt-binding to the path "soc/mediatek".
> 
> Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
> Acked-by: Rob Herring <robh@kernel.org>
> Acked-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

