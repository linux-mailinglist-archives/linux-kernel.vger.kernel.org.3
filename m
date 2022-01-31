Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7E474A4092
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 11:57:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239761AbiAaK5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 05:57:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239633AbiAaK5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 05:57:04 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA714C061714;
        Mon, 31 Jan 2022 02:57:03 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 6EEF21F4312B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1643626622;
        bh=AhIlSPFIs8ak0I/I8Ku1qwLQESsLxE26HyIIypM3mfI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=VtX2wMwZbmlVio86rbbyFReXPbkiIl33IMybSs+olR6XD2iuZtBgwcgoZGtzFZxut
         SEPrxE9Y/T3VWOod7FCLJjutTvjmDiIzA3Nb1kYOXfIYdPWG65bUF8jwCdxZWGuC3+
         r5S9a4nWHlmo4C1GF5+cj55SF0DSFdv++YxwL/eOIebuovdwygIlKG6muH9/h3UdKF
         CVOZ7tpZiAkVRiQdmU6hPKolqXWg7uqua8QmEbLLGNxT1N9DqFnzWwAEqEMz4wBbyh
         UzSG1O7T6kr1mZunW5yXiqHkXjij1CDgNJ3y9OtqSTIhMANM7pgftW1YTrOPv3fQrl
         X52Pp5ab6/brw==
Message-ID: <59582e31-66d7-ad07-dd64-4ebb223cf809@collabora.com>
Date:   Mon, 31 Jan 2022 11:56:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v22 7/7] soc: mediatek: SVS: add mt8192 SVS GPU driver
Content-Language: en-US
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
References: <20220127033956.24585-1-roger.lu@mediatek.com>
 <20220127033956.24585-8-roger.lu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220127033956.24585-8-roger.lu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 27/01/22 04:39, Roger Lu ha scritto:
> mt8192 SVS GPU uses 2-line (high/low bank) HW architecture to provide
> bank voltages. High bank helps update higher frequency's voltage
> and low bank helps update lower frequency's voltage.
> 
> Signed-off-by: Roger Lu <roger.lu@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

