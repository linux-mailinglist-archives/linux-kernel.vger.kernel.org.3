Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0EA5522DD9
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 10:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238684AbiEKIES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 04:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243399AbiEKIEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 04:04:02 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 168BA8F195;
        Wed, 11 May 2022 01:03:59 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id D83611F44C79
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652256237;
        bh=rHxWTERdNk4Yn2qQ3l99Wkt4OciBw5SAAHBYUVwgMjI=;
        h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
        b=F8dtqKHodXJaflkn78tiHZVUD3rdaQHxtgZaG11wQt6u9lXnnnEXsW1FcnkrNez7g
         yyruKMsi5Jeixps/EDL7jIZLhVUPodcqzRfAhmbeXD2mkQNalL6oYQw5XcyjWYJ+KP
         a2/jcHMj00BFUsuGa/v0+C/1jNm3w4vwKiAJagwKwNLSJ9r/w4yOMnm3aoYY7P5WP0
         nfuuB0z+Quzmv/fTisag1HhlkeEpdi5HJX/dbV0m/gW7d6boelyxOuYMuZmrCofdQs
         ut4rB/8Ijm2QcxEfyKYPQrjBQpU3mssRe5meJKXZRglxShhvoBAPiU5g/6PSfflkNZ
         x8FZnPhf910CQ==
Message-ID: <18fee6fe-2378-391e-993d-425c887ba40a@collabora.com>
Date:   Wed, 11 May 2022 10:03:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v2 00/11] clk: mediatek: Move to struct clk_hw provider
 APIs
To:     Chen-Yu Tsai <wenst@chromium.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        linux-clk@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220510104804.544597-1-wenst@chromium.org>
Content-Language: en-US
In-Reply-To: <20220510104804.544597-1-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 10/05/22 12:47, Chen-Yu Tsai ha scritto:
> Hi everyone,
> 
> This is v2 of part 2 of my proposed MediaTek clk driver cleanup work [1].
> 
> Changes since v1:
> - Rebased and added coverage of new MT8186 clk drivers
> - Split patch "clk: mediatek: Replace 'struct clk' with 'struct clk_hw'"
>    into arbitrary pieces so that they don't bounce from the mailing lists
> 
> This was tested on MT8183 Juniper. Apppreciate any help testing on non-
> ChromeOS devices.
>

For the entire series:

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

...and this entire series was tested on:
MT8173/92/95 and MT6795 (Sony Xperia M5 smartphone, clock drivers not sent
upstream yet), so you also get my:

Tested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

...and last, but not least:

Thank you! :-)
