Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4CF4F96FD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 15:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236437AbiDHNjq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 09:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236412AbiDHNjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 09:39:22 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1E4523CC6D;
        Fri,  8 Apr 2022 06:37:10 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id A7CDF1F47188
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1649425029;
        bh=54quhn/zcNV/OyUct9dWukFBbRxR9hvJRWQMiW6sCMY=;
        h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
        b=a790tagqq/cSScw2+pEAkFZs4ODYsEALKzkYipCfDpIgNBZYrz7neYeDHeemMDPXM
         1Do4MamfK4mhCqkPB6gJ9tktP35c0Vq+S2oCTgd8xeu2LClyqD2GzojfTquNlBdpFy
         gJnmoMWvh8rfh1jOKBMUKqTpbx95X5ZjvLj1fbfEHNM8+ewAnhUTEJYHfRR2/zOnZS
         JPPQOuxJzG/MWoyBtRd9vYQtsZ6pzfmKCfIwR78KfQutxG+id6T2RLrcMHpJjvx7wK
         6zmpDLJvtA3PclMYGXkxgn0D+k1uvuSuyEKCs0/sO1kA56joBVPzlupNx0aNBkrD0i
         FrIjwJ0OyncaA==
Message-ID: <3e0225dc-810a-4890-47d0-796ff79b7175@collabora.com>
Date:   Fri, 8 Apr 2022 15:37:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH V2 14/15] cpufreq: mediatek: Add support for MT8186
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>, rafael@kernel.org,
        viresh.kumar@linaro.org, robh+dt@kernel.org, krzk+dt@kernel.org
Cc:     matthias.bgg@gmail.com, jia-wei.chang@mediatek.com,
        roger.lu@mediatek.com, hsinyi@google.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220408045908.21671-1-rex-bc.chen@mediatek.com>
 <20220408045908.21671-15-rex-bc.chen@mediatek.com>
Content-Language: en-US
In-Reply-To: <20220408045908.21671-15-rex-bc.chen@mediatek.com>
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
> The platform data of MT8186 is different from previous MediaTek SoCs,
> so we add a new compatible and platform data for it.
> 
> Signed-off-by: Jia-Wei Chang <jia-wei.chang@mediatek.com>
> Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

