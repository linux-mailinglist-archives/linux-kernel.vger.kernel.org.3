Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E86851357E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 15:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347560AbiD1Nq2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 09:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235229AbiD1NqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 09:46:25 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DA4A5D1B5;
        Thu, 28 Apr 2022 06:43:11 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 1FBCA1F4516F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1651153390;
        bh=jtU+WO0fmgPPR6L7wrSaeI4hXJDXg/PCMWOcmgAp16Y=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=luzJRjNH0Ru6qWc5wZ7acZPBOtwq3KjC0YAq7TnrkmLPOW+0QB7E1CPDkGUyYTkhu
         LPqdvgOsn5RmvpdGMOiRFlm/m4Wq0RRFvYvoXgMFW55I6EpQfY4yEWNQXHbKzJo2/S
         1rPxjg0j2ThfK8UI+a3Q1/Dcl4NSOOPe5fgxERSKZ9ctNuDZQo0FwiJE7hoWibkxiI
         Yk+vpeIt5pW3wZidIZh+ALZTrf+fB8ovhzQ+FGvC8ON+Kx/2u6WIgl3W61JdGRt9/x
         /745LKZghT22ah/a62x36yFKkE0JRqdOtNrKPEahvNJxfmJkneHDokwsc+dz+zDalI
         9Wajofo8lLDaQ==
Message-ID: <d39d3dd9-cfe8-0a59-6616-a4cd4e393582@collabora.com>
Date:   Thu, 28 Apr 2022 15:43:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH V5 15/16] arm64: dts: mediatek: Add infra #reset-cells
 property for MT8192
Content-Language: en-US
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>, mturquette@baylibre.com,
        sboyd@kernel.org, matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     p.zabel@pengutronix.de, chun-jie.chen@mediatek.com,
        wenst@chromium.org, runyang.chen@mediatek.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220428115620.13512-1-rex-bc.chen@mediatek.com>
 <20220428115620.13512-16-rex-bc.chen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220428115620.13512-16-rex-bc.chen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 28/04/22 13:56, Rex-BC Chen ha scritto:
> To support reset of infra, we add property of #reset-cells.
> 
> Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

