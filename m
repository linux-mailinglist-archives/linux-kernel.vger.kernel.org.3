Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 987D34DACA8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 09:40:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354599AbiCPIlT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 04:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354572AbiCPIlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 04:41:10 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41A3264BCB;
        Wed, 16 Mar 2022 01:39:57 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 58FF01F42D16
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1647419996;
        bh=6WPOPppOizB/g6/lobcK77bh8kHrOplZbelFC9CpIUA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=TsC6ZfsFhZMI8I3s5v4tGkqvD7QjPvEUK4JAC9QWKIRtcvTmcegSpYoLXW3QEvOaV
         zY8g2543I8SuerAb5P+hrNx8jktdaljoKpX+hlFAOdpANKmF95IajB0G3ggtFH9RjP
         F6OVWzO7QIeeEHT8GfP81mzL4kIYkFbcx1pUt+V8atadstuNrlNLvexxKsKYEexyAg
         fvI7DdBNwLiPPX29THesY728mJHPDGh9hJkIUSAGuwOSOZUDDkUZuab7DgJuTHsuoX
         d2/yRSVZJ/qrqZ+kJjcNdLgI3iiF/6fxz0woGZHMzrTsH2zrBgV1Zj9boZyCupIseq
         jgKkJ+lGw61tQ==
Message-ID: <4d602be6-e357-2a6a-cd99-c89c67a98f17@collabora.com>
Date:   Wed, 16 Mar 2022 09:39:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v1 2/4] dt-bindings: pinctrl: mt8192: Add
 mediatek,drive-strength-adv property
Content-Language: en-US
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     kernel@collabora.com, Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20220315211936.442708-1-nfraprado@collabora.com>
 <20220315211936.442708-3-nfraprado@collabora.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220315211936.442708-3-nfraprado@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 15/03/22 22:19, Nícolas F. R. A. Prado ha scritto:
> Add the mediatek,drive-strength-adv property to the pinctrl-mt8192
> dt-binding to allow further drive current adjustments for I2C nodes on
> MT8192. It is the same as in mt8183-pinctrl.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

