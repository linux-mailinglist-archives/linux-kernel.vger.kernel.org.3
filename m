Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBCFD50B2C6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 10:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444816AbiDVIX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 04:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245737AbiDVIXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 04:23:53 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B77C48318;
        Fri, 22 Apr 2022 01:21:01 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id E015C1F46406
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1650615659;
        bh=Uq22ST8tg/3VSbKXQa4LlPnOLdWxLdYFWpazq5VOgvA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=PNHttXg3qvDP50AbR5o7jik6tcpUEYAbW5Z3O1+mjt8DSVD/Efz0AtSoYlbiLJAx0
         M+znfCN8R9bV0qAYw9OlumcO5Jtx5FRwps8idzv2/iTsMAHZU3I9fmkpMD7N2dCioO
         dGwH623LET81oXimpmetdPh6swbJkBE/IBhHkuc6poKHx642rxEDez+KOqyXkxOkQg
         z0l1StcONm2NrihHlRAyaIExhUGl2lGA2yIuv/PqXPo0y7HPkr+bP8NPVZkGDdJ806
         xaU+i+kReLZZ+y0Ka2TyMAajFdDj34T/5336+zPGmFEJWNQ1RHf25+cFt7JuiuOKRV
         KqjbOjHF+ICrg==
Message-ID: <a33f7217-1be9-7d8b-b774-acaf7f3a3594@collabora.com>
Date:   Fri, 22 Apr 2022 10:20:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH V4 12/14] arm64: dts: mediatek: Add opp table and clock
 property for MT8183 cpufreq
Content-Language: en-US
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>, rafael@kernel.org,
        viresh.kumar@linaro.org, robh+dt@kernel.org, krzk+dt@kernel.org,
        matthias.bgg@gmail.com
Cc:     jia-wei.chang@mediatek.com, roger.lu@mediatek.com,
        hsinyi@google.com, khilman@baylibre.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        "Andrew-sh . Cheng" <andrew-sh.cheng@mediatek.com>
References: <20220422075239.16437-1-rex-bc.chen@mediatek.com>
 <20220422075239.16437-13-rex-bc.chen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220422075239.16437-13-rex-bc.chen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 22/04/22 09:52, Rex-BC Chen ha scritto:
> - Add cpufreq opp table.
> - Add MediaTek cci opp table.
> - Add property of opp table and clock fro cpufreq.
> 
> Signed-off-by: Andrew-sh.Cheng <andrew-sh.cheng@mediatek.com>
> Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

