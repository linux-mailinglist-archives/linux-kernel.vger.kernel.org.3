Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB8D651C34B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 17:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380994AbiEEPH7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 11:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243206AbiEEPH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 11:07:57 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A300B56430;
        Thu,  5 May 2022 08:04:18 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 754D41F45912
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1651763057;
        bh=CvWL0d92LTexS+0TabDQSn5dqaw57JFYhNx34gLvT+4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=FymySwbCbDQl4GF3l/lIkKKEPFBziW0d1hu4fmNOOGncPJRlggPbECJOkic3hNT4K
         cl9A3RkP/QPmQDeirnZHyngRLX4MiVEMNuB47cfXJDaf9/N04OxMj6DVK9KqCli+eY
         HBxIeetLXKDJqR+9jTcyxpK6KqMhCt8/Rge//og6LNx/ealuvT/J03zU0NUjfGmG+q
         S7N3hSGeKfBF8wmWRrHdtQq+dGZ9cH6VPj6PjhHU6wm9ToIptVUtdhRqPbjq4PvcSi
         k0fH6vBYIICtwFYmnIrAXhTSSAICy1h1N7HiosBncuBXhwud9Ul1ibgP5YYY7BzoAz
         z/rTsZqbcatTA==
Message-ID: <af9724fe-181d-3ba4-79b9-bf3fab1ca80d@collabora.com>
Date:   Thu, 5 May 2022 17:04:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v6 02/10] cpufreq: mediatek: Add
 platform_device_unregister when driver exit
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
References: <20220505115226.20130-1-rex-bc.chen@mediatek.com>
 <20220505115226.20130-3-rex-bc.chen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220505115226.20130-3-rex-bc.chen@mediatek.com>
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

Il 05/05/22 13:52, Rex-BC Chen ha scritto:
> We register the platform device when driver inits. However, we do not
> unregister it when driver exits.
> To resolve this, we declare the platform data to be a global static
> variable and rename it to be "cpufreq_pdev".
> With this global variable, we can do platform_device_unregister() when
> driver exits.
> 
> Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>

Hello Rex,
this commit needs a Fixes: tag.

Cheers,
Angelo

