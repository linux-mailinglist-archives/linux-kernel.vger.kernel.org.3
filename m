Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EC4347EDC0
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 10:27:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352230AbhLXJ1T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 04:27:19 -0500
Received: from m-r2.th.seeweb.it ([5.144.164.171]:60931 "EHLO
        m-r2.th.seeweb.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241570AbhLXJ1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 04:27:18 -0500
Received: from IcarusMOD.eternityproject.eu (unknown [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id B84233EF19;
        Fri, 24 Dec 2021 10:27:15 +0100 (CET)
Subject: Re: [PATCH v7 3/4] dt-bindings: pinctrl: mt8195: add wrapping node of
 pin configurations
To:     Tinghan Shen <tinghan.shen@mediatek.com>, robh+dt@kernel.org,
        linus.walleij@linaro.org, matthias.bgg@gmail.com,
        broonie@kernel.org
Cc:     bgolaszewski@baylibre.com, sean.wang@mediatek.com,
        bayi.cheng@mediatek.com, gch981213@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-spi@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20211220121825.6446-1-tinghan.shen@mediatek.com>
 <20211220121825.6446-4-tinghan.shen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Message-ID: <6317bb3b-38b1-3f5e-9f6c-ebacec9ebfef@somainline.org>
Date:   Fri, 24 Dec 2021 10:27:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211220121825.6446-4-tinghan.shen@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 20/12/21 13:18, Tinghan Shen ha scritto:
> On mt8195, the pinctrl node has pinctrl groups to group pin
> configurations by users' need. In each pinctrl group, it has
> subnode(s) to list pins needed and pin configurations. By supporting
> multiple subnodes, we can configure different pin characteristics
> (driving/pull-up/pull-down/etc.) in a pinctrl group.
> 
> Update pinctrl-mt8195.yaml to add subnode in pinctrl groups and an
> example to illustrate the usage.
> 
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

Acked-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

