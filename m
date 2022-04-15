Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB3515029A8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 14:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353397AbiDOM2L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 08:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353271AbiDOM1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 08:27:11 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 371279FCB;
        Fri, 15 Apr 2022 05:24:28 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id BCD431F47E0F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1650025467;
        bh=6Z+gWy9qIs5W0hqsy0FIxSakYLRz+BXCwJ6EprEUa2c=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Paj4zcJG2Xe9RP8XaVi2C+ydlxAxfCUITLHVzfag8SfMH+Au8N0hhwwUKQ8VDOuQO
         5ep+3UL62D8S23GqLbmJEtyY9OBUCmrQWiMOG+v+tlf270fivWoQjPPfrntTwVHGFI
         lnom6cW1Iy2/ZGl7U3xCV3mIC4Kr62HRRXrzkOowaNklV+xnMhhySA8uHQdO9L2gXS
         b5Kdic8/5BpfxkdSiiogCMuePNOKJLTDlsfpuCAvqWPVgmeWv7QmMhnhYLvgTGRYLv
         mCkKvdKWle1EP2QQFvZd61UUMC26sPmLLCpnBmKlXLPf1zt8kiD0ZS/PGGpCMDneRd
         e+eNl7EPqS1SA==
Message-ID: <bcaeefa7-82e9-b40a-faac-a51bc78d9481@collabora.com>
Date:   Fri, 15 Apr 2022 14:24:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH V3 02/15] cpufreq: mediatek: Use device print to show logs
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
 <20220415055916.28350-3-rex-bc.chen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220415055916.28350-3-rex-bc.chen@mediatek.com>
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
> - Replace pr_* with dev_* to show logs.
> - Remove usage of __func__.
> 
> Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com


