Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82BC74F96F4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 15:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236410AbiDHNjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 09:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236372AbiDHNjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 09:39:18 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22BFA20D501;
        Fri,  8 Apr 2022 06:37:05 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 2425C1F471A5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1649425023;
        bh=vUqOZIPLx1XwB9++8jhHrxqr5wzBNjLzr7972tFmOiw=;
        h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
        b=dtJuyo9V92+nr2q94QT+uv2g+jJKYduy9fZgPSOXb8UlVadnzrlSfjpZ9iHIHeRAR
         vv9X6/7PntDhVPLu4CziVyERzNsY8P20Jz56qnAafbp1LwtlbYTTOe8uaLz6ZNdAIi
         2YsEZlXE6r3ikFSEf5Ab/9Cwv0OhHWG4dfb5HrH+wsIX4ai6Q18qsm6EJUj8XBHCZ9
         YtG6XHZbWyGYPs9PbbRxCKOhXMtn7lPyc5eUNvobxLsFhubOkSG2vXJRiCANeH57SO
         zxrXAa0ZezuctycgmZBalAZnPb3DvzDf9c56W8tpvFCzcKzN1LFZDUURXAqZtHLmpp
         mesVS/4JuNHog==
Message-ID: <8a2cf094-07f0-9497-c966-4667c51b8b0c@collabora.com>
Date:   Fri, 8 Apr 2022 15:37:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH V2 10/15] cpufreq: mediatek: Make sram regulator optional
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>, rafael@kernel.org,
        viresh.kumar@linaro.org, robh+dt@kernel.org, krzk+dt@kernel.org
Cc:     matthias.bgg@gmail.com, jia-wei.chang@mediatek.com,
        roger.lu@mediatek.com, hsinyi@google.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220408045908.21671-1-rex-bc.chen@mediatek.com>
 <20220408045908.21671-11-rex-bc.chen@mediatek.com>
Content-Language: en-US
In-Reply-To: <20220408045908.21671-11-rex-bc.chen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 08/04/22 06:59, Rex-BC Chen ha scritto:
> From: Jia-Wei Chang <jia-wei.chang@mediatek.com>
> 
> For some MediaTek SoCs, like MT8186, it's possible that the sram regulator
> is shared between CPU and CCI.
> 
> Signed-off-by: Jia-Wei Chang <jia-wei.chang@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
