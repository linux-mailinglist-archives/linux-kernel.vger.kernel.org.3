Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96A6052D133
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 13:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237331AbiESLMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 07:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbiESLMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 07:12:52 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 516E1939D0;
        Thu, 19 May 2022 04:12:51 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 6A87D1F45A60
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652958770;
        bh=0vp1+rP2qL80xLM2XgWzvi9l9uo7sa3pk6bo6A5h2Vo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=f2B4bry+j0yvryUxmZg2H1K29X9GmcJfHZDBxvFkIq4B/tq75Xpgqt7B3spqBjSiT
         L6yqlvRU4XTH0XdMMaPu79pdpFTMut6BAObhrgr6H/Z7qaxI0GDCXDqTj+IhNW3giX
         t8jVGzI7dtz5WWnabWZFjmdtVnJ6RT7m8BZ2oHQDTlkqkdRsW7CNH1Li2ichemwnX0
         nQL1W8xHPX1BeOMgXbulyE2fJKLGe3q5lRJcVN/TlQ1kqFhKHEqY7X04MnN5noKuI3
         HOwS6U/KHnqLCrf+AMO10ISvuOx6R2NVuBBoZ41pEcL3i+NCs14z84Qs02ebCYZIo6
         uvw+sUDCTVJ+g==
Message-ID: <aed584c0-f097-fdef-8078-a7c457d1cb1a@collabora.com>
Date:   Thu, 19 May 2022 13:12:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [v10 1/1] thermal: mediatek: add another get_temp ops for thermal
 sensors
Content-Language: en-US
To:     James Lo <james.lo@mediatek.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pm@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Fan Chen <fan.chen@mediatek.com>,
        Louis Yu <louis.yu@mediatek.com>,
        Michael Kao <michael.kao@mediatek.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Ben Tseng <ben.tseng@mediatek.com>
References: <20220519101044.16765-1-james.lo@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220519101044.16765-1-james.lo@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 19/05/22 12:10, James Lo ha scritto:
> Provide thermal zone to read thermal sensor
> in the SoC. We can read all the thermal sensors
> value in the SoC by the node /sys/class/thermal/
> 
> In mtk_thermal_bank_temperature, return -EAGAIN instead of -EACCESS
> on the first read of sensor that often are bogus values.
> This can avoid following warning on boot:
> 
>    thermal thermal_zone6: failed to read out thermal zone (-13)
> 
> Signed-off-by: Michael Kao <michael.kao@mediatek.com>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> Signed-off-by: Ben Tseng <ben.tseng@mediatek.com>
> Signed-off-by: James Lo <james.lo@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

