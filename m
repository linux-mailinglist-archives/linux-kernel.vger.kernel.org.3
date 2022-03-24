Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ABC64E66B1
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 17:12:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351576AbiCXQNQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 12:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238183AbiCXQNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 12:13:10 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8992A0BE1;
        Thu, 24 Mar 2022 09:11:38 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id D00651F45890
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1648138297;
        bh=326GQpe6Pue2Q7/zbKDs+rrjArsHHkgS+jpDRGw9S48=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=lb96OBHHXuEZ2m2LlS0Xe5dnXMhqIrEt2g29/hMrrNVrjy4bYGfpukL51o3kSnelb
         ekjjR6a7w6e5HWn1N+EQq9teLNxhViG5o1IjRLB5956SAWA754snvzls6ImNZd6G0n
         m9ePqveP4Io14TttTGuUhOdcfO2cZqme+pZKj+tXI+3XD9J/U34SfZrW2ZuOYBdWfh
         Q+h26phTI+sLUGNMsIHQHb+5lPuZTMd/6xTxnhdByEoeyZ7kMIBrhFhee5dFW4uGZF
         BrAf2nsnyeA7kgW87stdvRXK7LUmK71fyNP03mCmLqibp2ioVTluDl0ktb2kltW+Rf
         DvOWCzMcu5N+A==
Message-ID: <c026dd04-3cc1-4408-e6e4-8ab8a8dbcb70@collabora.com>
Date:   Thu, 24 Mar 2022 17:11:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v4 4/6] ASoC: mediatek: mt8195: rename card controls
Content-Language: en-US
To:     Trevor Wu <trevor.wu@mediatek.com>, broonie@kernel.org,
        tiwai@suse.com, robh+dt@kernel.org, matthias.bgg@gmail.com
Cc:     alsa-devel@alsa-project.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, aaronyu@google.com, tzungbi@google.com,
        miles.chen@mediatek.com, yc.hung@mediatek.com
References: <20220324053851.27350-1-trevor.wu@mediatek.com>
 <20220324053851.27350-5-trevor.wu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220324053851.27350-5-trevor.wu@mediatek.com>
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
> In order to be able to reuse the same configurations in user space,
> rename the controls to generic names.
> 
> "Headphone Jack" -> "Headphone"
> "Speakers" -> "Ext Spk"
> "Left Speaker" -> "Left Spk"
> "Right Speaker" -> "Right SPk"
> 
> Signed-off-by: Trevor Wu <trevor.wu@mediatek.com>
> Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

