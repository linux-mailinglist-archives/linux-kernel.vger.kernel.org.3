Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 696BB534FB4
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 14:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347456AbiEZM6W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 08:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234058AbiEZM6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 08:58:15 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F39985C763;
        Thu, 26 May 2022 05:58:10 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id BC0671F45606
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1653569889;
        bh=0EdiI4UQ62Oms7jhkCwXc010LL9bgAzrmJqjHMZq+s4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=hG8tTMicAxc9tkcBCjll+kmxdI0KFOZiKfGF9HkmV4NeA+m4JIMBbQDAjbWgltFtR
         7w1ziS85DOPFjNMrevW86fNGRfvTHsa5a5jhO0DvcGC1gn15X7lk5ECX33Qe7doS3A
         GwniaDrRNj7O2brEBTb3egVMxLIZ7O2wznwCKm9Dt+izVDe+weTTO6JTK4O3bE4znv
         CBuDXV+Ywa9AP5H5YfOpZXphRkUErFnCFDkxwYYiJy2bAmTK9if+z2lFBcJaGrgssV
         aTa07hwR7m8JPTw4OKv3rQ/SFXrRVJlsQpfQkSDfiYt1cLU/3kmRBDv2mmyShIM8tf
         YhV2HtQqPGpiA==
Message-ID: <3d2b130c-9826-1440-3ec9-28a44b767de9@collabora.com>
Date:   Thu, 26 May 2022 14:58:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v7 1/6] thermal: mediatek: Relocate driver to mediatek
 folder
Content-Language: en-US
To:     Alexandre Bailon <abailon@baylibre.com>, rafael@kernel.org,
        rui.zhang@intel.com, daniel.lezcano@linaro.org, amitk@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        khilman@baylibre.com, mka@chromium.org, robh+dt@kernel.org,
        krzk+dt@kernel.org, matthias.bgg@gmail.com, p.zabel@pengutronix.de,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, james.lo@mediatek.com,
        fan.chen@mediatek.com, louis.yu@mediatek.com,
        rex-bc.chen@mediatek.com, Michael Kao <michael.kao@mediatek.com>,
        Ben Tseng <ben.tseng@mediatek.com>
References: <20220524152552.246193-1-abailon@baylibre.com>
 <20220524152552.246193-2-abailon@baylibre.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220524152552.246193-2-abailon@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 24/05/22 17:25, Alexandre Bailon ha scritto:
> From: Michael Kao <michael.kao@mediatek.com>
> 
> Add Mediatek proprietary folder to upstream more thermal zone and cooler
> drivers. Relocate the original thermal controller driver to it and rename
> as soc_temp.c to show its purpose more clearly.
> 
> Signed-off-by: Michael Kao <michael.kao@mediatek.com>
> Signed-off-by: Ben Tseng <ben.tseng@mediatek.com>
> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


