Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0757D4E66AA
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 17:10:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351555AbiCXQLs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 12:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351552AbiCXQLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 12:11:46 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABC9B2981F;
        Thu, 24 Mar 2022 09:10:13 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 644EC1F4588F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1648138211;
        bh=EwHy9mWfSuvvqMimVBgvIfNMqN76TuyvYhpTkRpZ2mY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=YbwjaZuSY3rU3Yk34+j0IN39Nb0q9CbL2386wWKs6DQDuScq7BoiG/R1eZtGHpVPP
         1Mg8LvlcNYHAwZ6OvFhRirYcEebf7Q262A+kMh3t3jVqA8WGpa9tsqWAhoTlu0Jwxl
         ECZvz5TWxtJr/C8UUvGzoOqLdqzUCYEHExLvKrNY4+4UCk9vFIg0rEPprIuHg4i31E
         fUtdDqlvq9QLgv3bmn3HQuRmi+tDjc77o0vd40iYf9rttMuzRfqfX42AcWxn6crrHD
         ZCHo3m1TckA+Jn2XXesjXA2CY48xu5kp8EYNQaZOEgbODYkwWO1B50uVqywZ6JfJsj
         gdX3Dy4O2aWSQ==
Message-ID: <18525f9a-e5b3-f6c2-e88f-3e0c5b789cad@collabora.com>
Date:   Thu, 24 Mar 2022 17:10:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v4 2/6] ASoC: mediatek: mt8195: merge machine driver
Content-Language: en-US
To:     Trevor Wu <trevor.wu@mediatek.com>, broonie@kernel.org,
        tiwai@suse.com, robh+dt@kernel.org, matthias.bgg@gmail.com
Cc:     alsa-devel@alsa-project.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, aaronyu@google.com, tzungbi@google.com,
        miles.chen@mediatek.com, yc.hung@mediatek.com
References: <20220324053851.27350-1-trevor.wu@mediatek.com>
 <20220324053851.27350-3-trevor.wu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220324053851.27350-3-trevor.wu@mediatek.com>
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

Il 24/03/22 06:38, Trevor Wu ha scritto:
> Because most functions can be reused in different codec combinations,
> mt8195 machine drivers are combined to one common file.
> 
> The model and compatible string are used to decide which codecs are
> being used.
> 
> As a result, We can prevent from copy-paste functions when new codec
> combination is introduced.
> 
> Signed-off-by: Trevor Wu <trevor.wu@mediatek.com>

Thanks for this much appreciated big cleanup!

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

