Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6504D7FC4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 11:25:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238513AbiCNK0e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 06:26:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238193AbiCNK0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 06:26:30 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1BF743483;
        Mon, 14 Mar 2022 03:25:21 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id CFA991F43502
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1647253520;
        bh=yIg0sOPQ7n3pZ3uL8omVK+Yinivb2f5C8PjuJhAz0ag=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=VVz+omXpnFBWYJtO9Kbp8aAHf1WMdAbBbYkF+/cZGalGFONJI07ZqnaFuEXHVx2L4
         k+SDs+MR6jppolMcSbNdzPzNzpVswWVBWJQZbEBjNNLsUW1Z9WD9GDK5QberBMu/y0
         +nEZF0PvEhfemowgypatod4dDtPX7YCEwjvikdWWQLnsWSUGgC78zFhgEhzggGv9bP
         sEHD2RCzY/p+ONffLaUusXH0uYc/4XaPiahdgnH6hQ7xLQy7eJ+VfC+iE7FKHF2UHS
         Tj2vkiYym73NU/+dSoA5XaFPJAJKVitmd3O3TRNmSAWjoiNb1idzv+FWI4WvK/NzK5
         zsapokAOiiIKA==
Message-ID: <eecc3d4c-c259-878c-bc0c-145ef8ab48df@collabora.com>
Date:   Mon, 14 Mar 2022 11:25:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [v3 06/19] ASoC: mediatek: mt8186: support hw gain in platform
 driver
Content-Language: en-US
To:     Jiaxin Yu <jiaxin.yu@mediatek.com>, broonie@kernel.org,
        robh+dt@kernel.org
Cc:     aaronyu@google.com, matthias.bgg@gmail.com, trevor.wu@mediatek.com,
        tzungbi@google.com, julianbraha@gmail.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220313151023.21229-1-jiaxin.yu@mediatek.com>
 <20220313151023.21229-7-jiaxin.yu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220313151023.21229-7-jiaxin.yu@mediatek.com>
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

Il 13/03/22 16:10, Jiaxin Yu ha scritto:
> Add mt8186 hw gain dai driver.
> 
> Signed-off-by: Jiaxin Yu <jiaxin.yu@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> ---
>   .../soc/mediatek/mt8186/mt8186-dai-hw-gain.c  | 236 ++++++++++++++++++
>   1 file changed, 236 insertions(+)
>   create mode 100644 sound/soc/mediatek/mt8186/mt8186-dai-hw-gain.c
> 

