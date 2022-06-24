Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D47CB559E4C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 18:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbiFXQIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 12:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231160AbiFXQIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 12:08:21 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9838929CA2;
        Fri, 24 Jun 2022 09:08:16 -0700 (PDT)
Received: from notapiano (pool-98-113-53-228.nycmny.fios.verizon.net [98.113.53.228])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 0780866017FA;
        Fri, 24 Jun 2022 17:08:13 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1656086895;
        bh=KGOY/hKSjd6Fa8Gy3cPJe3LIX1aHDy62+SKTc+gQNls=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OJhEKwCxKH5CaQUTh954WJwlHVZYeXRtFfVXE2QIBRMmZ7N2GrutyjZCdOEGPRfM6
         aHeFF1YHf8ADrGN+qK55wKTxMEno1UP3hpuVT01p/e2xg2O8GA1NRsJC33r7Efto3/
         U7tp7icBQ4A2PSTnpKfODdpbHccrb7EdpnLQirrA+za60VqxGv19t+2mvz63GUq0zL
         qZE6BNBgJ5AbfC4R0baa62JmjqPu6MhczBVBN+p1Wa+V50F4VWwGsru8lnySjhaFfQ
         gtKxdP1rMIDyKJCYyTl+qlx3mjoIQ8tdz/R+vaZD5yglBziQ8METSLVenQu7fvMQTL
         bx1yGvPrmk2LA==
Date:   Fri, 24 Jun 2022 12:08:10 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Guodong Liu <guodong.liu@mediatek.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v2 4/5] pinctrl: mediatek: dropping original advanced
 drive configuration function
Message-ID: <20220624160810.alotw7iwvivp5zg6@notapiano>
References: <20220624133700.15487-1-guodong.liu@mediatek.com>
 <20220624133700.15487-5-guodong.liu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220624133700.15487-5-guodong.liu@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guodong,

On Fri, Jun 24, 2022 at 09:36:59PM +0800, Guodong Liu wrote:
> Function bias_combo getter/setters already handle all cases advanced drive
> configuration, include drive for I2C related pins.

This commit message could be improved. I suggest using the following commit
message:

The bias_combo getter/setter is already able to handle advanced drive
configuration, which is the reason commit 353d2ef77f2b ("dt-bindings: pinctrl:
mt8192: Use generic bias instead of pull-*-adv") dropped the pull-up-adv and
pull-down-adv properties from the binding. With those properties removed,
there's no longer any use for the adv_pull callbacks, so drop them.

> 
> Signed-off-by: Guodong Liu <guodong.liu@mediatek.com>

Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Tested-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Thanks,
Nícolas
