Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED044FB686
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 10:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343971AbiDKI6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 04:58:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344117AbiDKI6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 04:58:11 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0E271D328;
        Mon, 11 Apr 2022 01:55:57 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 89C741F42DB8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1649667356;
        bh=6eM5QaDtwIp81r/ywmhqNWM0S8ebBuPxIDRHQ0pR/n0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=l83H0X/KHAtu0rwTlcbBW8wYWAVHPqo+kmkE4Q5qUSDrFD66vNkwLzl4ftYvooe+P
         Y21W0NK4vsVl9jetFQDoSUSIpvkAlY8YGMnCGnjaWSQTeDt5CcuCR7clPb+maI/NZR
         Swx2eQO2mprdEIWy5T3xXDwLgr2qlKXXJ8MOpUx9zcCHXG6cGkFlXI4IyVs8wvHE7Z
         1yv+DyaZcAAzzJItButc02SQ4NWOKoSBNxqmXo8kbKsiDLEWlFIOtSo0IEgV9yEhvQ
         0ZSy9rRYK1CjjeMjF/fA7IgnuY2z1Jsp29xFr0EUThJvh/BRn8xuXf4a53ioeMRDTS
         9/ocGOf2lI1hw==
Message-ID: <34c30f7c-70e2-dc95-a664-9379f91f5aed@collabora.com>
Date:   Mon, 11 Apr 2022 10:55:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2] remoteproc: mtk_scp: Fix a potential double free
Content-Language: en-US
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <1d15023b4afb94591435c48482fe1276411b9a07.1648981531.git.christophe.jaillet@wanadoo.fr>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <1d15023b4afb94591435c48482fe1276411b9a07.1648981531.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 09/04/22 08:27, Christophe JAILLET ha scritto:
> 'scp->rproc' is allocated using devm_rproc_alloc(), so there is no need
> to free it explicitly in the remove function.
> 
> Fixes: c1407ac1099a ("remoteproc: mtk_scp: Use devm variant of rproc_alloc()")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


