Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 644A34E66B0
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 17:11:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351559AbiCXQNM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 12:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351615AbiCXQNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 12:13:09 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73B18A0BE1;
        Thu, 24 Mar 2022 09:11:37 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 9C9361F4588F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1648138296;
        bh=NQIbmrCja9vafgXukwQnvA7dnbY+ovzFjWjQXecy4AA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=dqy5Fb7iHQn86liK/eKe2su/+aDIi7weA2TyPNWDCh4TZxEia+Au+iB3QA+0knXHi
         v9OC54dzY/aJgT6k4wUUZQRLXnmamQ5avMGrgRYovcncTBspQ4dmWC2HMFM34N7AEs
         OXsgPqUsSdJUP/1lIy2oAWDMY4x8IQ1YDWXolT8zmUDr5CkTelhIE5hHXoz2iZvo8o
         jMBiic0OQg5fCjbxd/eOVOsET3iqnD+84AgDRMw0kOIFUQcVDVdhkRMsnSvUi8eJeY
         tdb7LSDKooX8fWK3OqhJHV9tbIlD3j19t7twPEQpNpWNxPbMU/EeFjuJaMTMLQh7m8
         QNeahEts2FRYQ==
Message-ID: <9268bdf3-d1f2-b308-48ca-078f10dede31@collabora.com>
Date:   Thu, 24 Mar 2022 17:11:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v4 1/6] ASoC: mediatek: mt8195: revise
 mt8195-mt6359-rt1019-rt5682.c
Content-Language: en-US
To:     Trevor Wu <trevor.wu@mediatek.com>, broonie@kernel.org,
        tiwai@suse.com, robh+dt@kernel.org, matthias.bgg@gmail.com
Cc:     alsa-devel@alsa-project.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, aaronyu@google.com, tzungbi@google.com,
        miles.chen@mediatek.com, yc.hung@mediatek.com
References: <20220324053851.27350-1-trevor.wu@mediatek.com>
 <20220324053851.27350-2-trevor.wu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220324053851.27350-2-trevor.wu@mediatek.com>
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
> Revise driver for the coming driver combination.
> There are two major parts including in the patch.
> 1. Apply some suggested changes used in mt8195-mt6359-rt1011-rt5682.c.
> 2. Reorder the layout for centralizing the codec related code.
> 
> Signed-off-by: Trevor Wu <trevor.wu@mediatek.com>
> Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

