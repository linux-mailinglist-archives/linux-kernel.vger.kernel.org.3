Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77D4C4A81D6
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 10:50:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349909AbiBCJuv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 04:50:51 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:42650 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349900AbiBCJuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 04:50:44 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 1285E1F45313
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1643881843;
        bh=ipkRReMbtwAu7xVakE/HQLluSawAEt4oVRymv8x74FU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=LqzW7FjWzqe6QSgeaUlTZ4b9i0aa+yHVY30RH0JLBHzM7yQOpUdy3pEAiTscNHqdL
         po/03WDoy8jkq3f1W1y/z78nUavZPZN2urdpwQvaKRS4rMyBhCBuduRF6YNbLUtyE3
         f7TKw3rhI89QNKBgNZalAtAe+d50opRRylps1SpqO/ZyfHHdrf9lLtTXMS2Aj68TNv
         pUwfozQLqvOMm7ISQd3TkT/Yd8pl2ACujCgd6ZD0B2ziNrXW3DqPX7tyi5ViVGP+TZ
         ILrc/6zAtBJiQBoLGtd7KTVSXtQwq7X1aAQYx12iWBGCjb+FkqcO/MwW/ChCt7Vgmd
         GR1Tk5He8YrcQ==
Message-ID: <653343bc-701e-bc31-9e19-857c2881eaf2@collabora.com>
Date:   Thu, 3 Feb 2022 10:50:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v2 11/31] clk: mediatek: mux: Clean up included headers
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220202134834.690675-1-wenst@chromium.org>
 <20220202134834.690675-12-wenst@chromium.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220202134834.690675-12-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 02/02/22 14:48, Chen-Yu Tsai ha scritto:
> Some included headers aren't actually used anywhere, while other headers
> with the declaration of functions and structures aren't directly
> included.
> 
> Get rid of the unused ones, and add the ones that should be included
> directly.
> 
> On the header side, replace headers that are included purely for data
> structure definitions with forward declarations. This decreases the
> amount of preprocessing and compilation effort required for each
> inclusion.
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> Reviewed-by: Miles Chen <miles.chen@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

