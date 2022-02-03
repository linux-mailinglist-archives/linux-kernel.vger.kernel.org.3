Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D33F14A81E7
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 10:51:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349999AbiBCJvV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 04:51:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242004AbiBCJvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 04:51:10 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25623C06173D;
        Thu,  3 Feb 2022 01:51:10 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 886281F45310
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1643881869;
        bh=ptiKbsHZErNDbAu/yWlD4QcTqQ3y4yW4Py3C5IJ/ugc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=DKrruJ4cTiRBzpKB2v9+OKnfdLDTrE48MAqAarxZU4gxNWHS7+c56lp2tqnzOze15
         Gfsq8G3MaWG/v7EhhFEViHAetu+uTgEt3G3Hx2/gIrPZ9X8NTGiSFu5vF8KWhBK/D2
         mUadDO2n5mZTb9J6ZG6GUp41OPgwOEdsyFZuLZDEQ19mwAo3BCOfUjs9OdoRE2+KZ5
         BUCp5WqP/AZsWFylhBVAWeIWTmmmPYXBl9R5zt3aOVBbyyY9uf91Pri1x24xIldwmC
         umermoHwmv5UmRJbC8ZprQM7sATOguf8O5fm4zuTWViO8D2BmJtE3OKDsk2j/LuFEg
         G1YtfhZgnDELQ==
Message-ID: <b9081cb8-f938-2a30-da8b-e9d9c6397af2@collabora.com>
Date:   Thu, 3 Feb 2022 10:51:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v2 01/31] clk: mediatek: Use %pe to print errors
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220202134834.690675-1-wenst@chromium.org>
 <20220202134834.690675-2-wenst@chromium.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220202134834.690675-2-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 02/02/22 14:48, Chen-Yu Tsai ha scritto:
> If %pe is used to print errors, a string representation of the error
> would be printed instead of a number as with %ld. Also, all the sites
> printing errors are deriving the error code from a pointer. Using %pe
> is more straightforward.
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> Reviewed-by: Miles Chen <miles.chen@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
