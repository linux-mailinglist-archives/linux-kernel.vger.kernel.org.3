Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A6B751BACB
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 10:41:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349932AbiEEIpd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 04:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232818AbiEEIpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 04:45:31 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF17E49F8C;
        Thu,  5 May 2022 01:41:52 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id EA1B11F41053
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1651740111;
        bh=/QeZ5vMr5HKTzS4nnc319BmT5r9JF4pfYQjq6kNPoOE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=H7GjKQm0tpa2/3pSsk5EGKWYdgv+In5yZAveILwiE6K5rA4yrAqG9Rj4hIFKuAo6V
         eezcCF+lfVm/9WJak5nUmDJM7ZSbQm9RYLS6CQ/ws1nLk0BJmMinmKpKdkfPMuU2da
         OrTUYRAmF39kan7DMHJbGd9J4yvHaWKfmBKZ0Qo5upAeLI1unSBRY6xS7W74/H+yyV
         uA6npuFaiLvjC9ujvkEWi/FyqcEnN6eNbri3Qgc2UvHSi0r1qVwNngb2yckVCiDBb/
         puY8qRD9oqY3uANsEHzkWuBrZtswj0zjjQDtE9lVWSYyYTwG7dPqyytCIliydTBqOH
         xeNN0y34Gbl2g==
Message-ID: <5d532a9c-8227-610c-d0ae-9352b91b42e5@collabora.com>
Date:   Thu, 5 May 2022 10:41:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v5 1/9] dt-bindings: cpufreq: mediatek: Add MediaTek CCI
 property
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
References: <20220504130540.5902-1-rex-bc.chen@mediatek.com>
 <20220504130540.5902-2-rex-bc.chen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220504130540.5902-2-rex-bc.chen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 04/05/22 15:05, Rex-BC Chen ha scritto:
> MediaTek Cache Coherent Interconnect (CCI) uses software devfreq module
> for scaling clock frequency and adjust voltage.
> The phandle could be linked between CPU and MediaTek CCI for some
> MediaTek SoCs, like MT8183 and MT8186.
> 
> The reason we need the link status between cpufreq and MediaTek cci is
> cpufreq and mediatek cci could share the same regulator in some MediaTek
> SoCs. Therefore, to prevent the issue of high frequency and low voltage,
> we need to use this to make sure mediatek cci is ready.
> 
> Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

