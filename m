Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE92A497E3F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 12:49:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237911AbiAXLtp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 06:49:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237737AbiAXLto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 06:49:44 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD4CCC06173B;
        Mon, 24 Jan 2022 03:49:43 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 777391F435C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1643024982;
        bh=FSC7K3juKE1eNNYIPrdbq7OnFxlkDzU7nCffIASlRCY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=CKJ8A1n3NySKOB/dkSSLGnk+EZTf6gzzmu3PRyPsb8skJ7ZaZCUyNI3rXDejvTBC/
         Kdk5BjFgN0tV5ckYE1J9k8tybsX6uh2SG89yZYKCjK+dTrt9zZEbWHnOJD8MogqWJM
         4aBlQWaWQKIO85Pe+eENUzkiTzvtP5RtHhMNUY1HRUjyG4ZPiP8L+42K7YZT2nPJ5P
         h+qLSoLa/SMjabbDANxg8FsXbZ75XCqPBpaanhbY7kOhbTW7Zjcref85vdcXBVB8K1
         pALpT+IXth7FC4Z1ZJvNcfcnajuuq0YbgT2uqRIpwM/VbBmSnMGjLdnROppk7ZEOMk
         IoNEssr8ByMiw==
Subject: Re: [PATCH v21 7/8] arm64: dts: mt8192: add svs device information
To:     Roger Lu <roger.lu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Enric Balletbo Serra <eballetbo@gmail.com>,
        Kevin Hilman <khilman@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Nicolas Boichat <drinkcat@google.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Fan Chen <fan.chen@mediatek.com>,
        HenryC Chen <HenryC.Chen@mediatek.com>,
        Xiaoqing Liu <Xiaoqing.Liu@mediatek.com>,
        Charles Yang <Charles.Yang@mediatek.com>,
        Angus Lin <Angus.Lin@mediatek.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Nishanth Menon <nm@ti.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Guenter Roeck <linux@roeck-us.net>
References: <20220107095200.4389-1-roger.lu@mediatek.com>
 <20220107095200.4389-8-roger.lu@mediatek.com>
 <010f9b6a-d6bf-b27a-cb2d-c5fd181c3ac7@collabora.com>
 <3d3518ff5c332129af5d10766477b9776bbbf55e.camel@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <ffafbbf6-3049-ec14-da24-18b6f1b4d147@collabora.com>
Date:   Mon, 24 Jan 2022 12:49:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <3d3518ff5c332129af5d10766477b9776bbbf55e.camel@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 24/01/22 11:48, Roger Lu ha scritto:
> Hi AngeloGioacchino,
> 
> On Fri, 2022-01-07 at 15:33 +0100, AngeloGioacchino Del Regno wrote:
>> Il 07/01/22 10:51, Roger Lu ha scritto:
>>> Add compitable/reg/irq/clock/efuse/reset setting in svs node.
>>
>> Typo: compitable => compatible
>> .. also, you're not only adding the svs node, but also efuse: please add that
>> information in the commit description.
>>
>>>
>>> Signed-off-by: Roger Lu <roger.lu@mediatek.com>
>>
>> This patch seems to not apply on top of the current linux-next, can you please
>> rebase it? That would resolve issues with this series and would be picked
>> sooner.
>>
>> Apart from that...
> 
> Sorry to make you confuse. After having discussion internally, we'll submit
> another complete mt8192.dtsi patch including this svs node. Therefore, I'll drop
> this path from svs patchset in order not to make the reviewer confuse. Thanks
> for the comments a lot.
> 

Yes that decision looks good to me, as this allows different maintainers
to apply patches on a per-subsystem basis.
Thanks!

Regards,
Angelo
