Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1478150299D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 14:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353371AbiDOM1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 08:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353260AbiDOM1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 08:27:10 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED21C1C80;
        Fri, 15 Apr 2022 05:24:19 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id AFB501F47DF9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1650025458;
        bh=73ucGu/y9Fj2jgks6l90mU2E2Kbo6O9LHhb+jGSfg4k=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=V91+vG3gf8C7ASUV3EFyUt6oMRQ2HlwZkXvGanr2aqYIb9/swBt4qAtm7LpvTKldX
         pHrWJDwVAYlq+uFQXGjis4beVW5nKu0E2FekXFo35ZbVa2ffk3XrXYCwYBUgPqYSGq
         6JYIscL7jDmQ6ao7Cke/OfRsTvPpwuv50j9lu8MDdHdbMYRpmtXeXG87Wjbx+GaydI
         tAyX1N4SHeZx1dMlADkDpLxR0j8t+UrHrS0oHCUuSW4C7OjyLfneFHS0rKnZXtW3k6
         nmhWbfjSEBD0oSWTFLC6yFUeqXy4T88n5p9fxoZzs6pTmQ7HxaexbYm6iYM/ckKK9e
         eXNtZeyBUSBVA==
Message-ID: <f478224a-d854-7900-6489-dd5aabdf7846@collabora.com>
Date:   Fri, 15 Apr 2022 14:24:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH V3 06/15] cpufreq: mediatek: Move voltage limits to
 platform data
Content-Language: en-US
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>, rafael@kernel.org,
        viresh.kumar@linaro.org, robh+dt@kernel.org, krzk+dt@kernel.org,
        matthias.bgg@gmail.com
Cc:     jia-wei.chang@mediatek.com, roger.lu@mediatek.com,
        hsinyi@google.com, khilman@baylibre.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220415055916.28350-1-rex-bc.chen@mediatek.com>
 <20220415055916.28350-7-rex-bc.chen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220415055916.28350-7-rex-bc.chen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 15/04/22 07:59, Rex-BC Chen ha scritto:
> From: Jia-Wei Chang <jia-wei.chang@mediatek.com>
> 
> Voltages and shifts are defined as macros originally.
> There are different requirements of these values for each MediaTek SoCs.
> Therefore, we add the platform data and move these values into it.
> 
> Signed-off-by: Jia-Wei Chang <jia-wei.chang@mediatek.com>
> Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>


Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>




