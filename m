Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 413034AD9D5
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 14:29:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350207AbiBHN2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 08:28:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350678AbiBHN1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 08:27:48 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B8CEC03E962;
        Tue,  8 Feb 2022 05:23:13 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 4DFC81F44D85
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1644326592;
        bh=o7erjfdlSIRztr8BR7vLoN0cESgk0yvfG32LdmIoclY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=MpQZw6E3e1cJJYtYYjILxSITbmds6umcehEJcVUFODDcrZbvN0T6wG8oEzbHHsBab
         ZKxV9JRPkSUzA2arqrCdZjyZ0uDhGcAMuT0VhfIn9dZc1QwGX5pAi+va/Sctp/4u6k
         CHDkUfUlwKJ/BnPIZa583SFtyrGkUUKZpYsqkMCZZVqL6/w4TSifDE7FTooGrhdLGV
         Uo+lgVfET7BvfX6j5BMsjKFUq68rZXH/5KU8OV2FFQbgIa2zD5MNXW1p9PUgY0j6I0
         GZ4TRnDfRlG4v2YghoEfSyx0edNq2CTKSQkRnatvpWLWJBUySOQKodBl0hZle67fV4
         aEpDEl5wxsD1Q==
Message-ID: <68fda288-cc2f-aa35-8b21-e7f91d9f3b49@collabora.com>
Date:   Tue, 8 Feb 2022 14:23:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v3 29/31] clk: mediatek: mt8195: Implement error handling
 in probe functions
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220208124034.414635-1-wenst@chromium.org>
 <20220208124034.414635-30-wenst@chromium.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220208124034.414635-30-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 08/02/22 13:40, Chen-Yu Tsai ha scritto:
> Until now the mediatek clk driver library did not have any way to
> unregister clks, and so all drivers did not do proper cleanup in
> their error paths.
> 
> Now that the library does have APIs to unregister clks, use them
> in the error path of the probe functions for the mt8195 clk drivers
> to do proper cleanup.
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
