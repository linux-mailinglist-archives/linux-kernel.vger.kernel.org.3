Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC8E54DD85
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 10:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376659AbiFPIuv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 04:50:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376635AbiFPIu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 04:50:28 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77B325E775;
        Thu, 16 Jun 2022 01:48:48 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A7C776601749;
        Thu, 16 Jun 2022 09:48:46 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1655369327;
        bh=KA13VqCDgHgef3ZpqRd5dKhIy17RNSMxo/QI/sH1ruk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=B5WQEl4RgDw+NJwI0Y8l4j9efQ7tyGQSlkKl5B/GgxCW0oir70nMtIF8h4TYa44yx
         InunNn+EEFvDmpBB/xdAVSSoDslOtSs6EWNhH8HP5At8nVpg1MZqXfLNBqZDdgDgxM
         byED472+WBo7Ef6sNU15KUQuHC/SA5U5orLv8IXYVYcp7Ae91FQ+OVEF35i7Zy8OQi
         aQIrDlvC7ygLfBVkgv0+bSj0cRQwW+hjcBZYOYiIcskS3TF8BkBCc+fHlV+VZA6qgD
         KxavUC0Xhm9UzFE7abx1iNGrem4H9I+8OH118kuf3MQhw0SVDYmVpxnQoR89a3+Iii
         lhgRWXkptZ9sA==
Message-ID: <88be9f00-2b1a-977d-dadd-95a131bf7f1f@collabora.com>
Date:   Thu, 16 Jun 2022 10:48:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] clk: mediatek: clk-mt8195-vdo0: Set rate on
 vdo0_dp_intf0_dp_intf's parent
Content-Language: en-US
To:     Stephen Boyd <sboyd@kernel.org>, mturquette@baylibre.com
Cc:     matthias.bgg@gmail.com, wenst@chromium.org,
        miles.chen@mediatek.com, chun-jie.chen@mediatek.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        rex-bc.chen@mediatek.com
References: <20220614091020.21472-1-angelogioacchino.delregno@collabora.com>
 <20220616024442.1337EC3411E@smtp.kernel.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220616024442.1337EC3411E@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 16/06/22 04:44, Stephen Boyd ha scritto:
> Quoting AngeloGioacchino Del Regno (2022-06-14 02:10:20)
>> Add the CLK_SET_RATE_PARENT flag to the CLK_VDO0_DP_INTF0_DP_INTF
>> clock: this is required to trigger clock source selection on
>> CLK_TOP_EDP, while avoiding to manage the enablement of the former
>> separately from the latter in the displayport driver.
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
> 
> Any Fixes tag?

Backporting is useless because there's no DisplayPort driver that supports MT8195
in the previous kernel versions, so this clock (and whatever logic behind it) is
unused.

Though, if you think that's going to be useful in any way, I can add one?

Regards,
Angelo
