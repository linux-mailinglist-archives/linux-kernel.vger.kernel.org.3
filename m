Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF7494F8964
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 00:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231982AbiDGWMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 18:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231909AbiDGWMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 18:12:17 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EADE52DBFD2;
        Thu,  7 Apr 2022 15:10:15 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nfraprado)
        with ESMTPSA id 78BBF1F46A48
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1649369414;
        bh=gBmyi6WpjYRqp8rOwRWdLr6uxk3Fb3AIfix85A+GbHY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i8qXB9Z/vpMHT8OX9TLKlXvyZenUwkBuXRjgc2ThZiWsJCS/hWCF+l3F7qBXM8cAY
         EshP6vwOeD2lPBnaLXIEWGoW56r/ruIBM1VWI4X5loYETqG0r+sUx+1QGp9XFutv2y
         4DqjcC1cQaLLS6lc0lTTP5zuQ9z/lNCWxqdZik9vGxf3l4ajIk4NR1WKDzT+ZR3JyM
         5jrtsVwQ8s3OxSgYrRmJ7ZlibO0z8gNnxrXCIbsApIH8Oz4H8v2I7FE2ElZG2Dxi7O
         YJH1tAwfrRxEBO+vOnkhURB3zL7JlKRfN84PxReBH6Dn5MpzRhYxNYkAWPKgWOHnNi
         fndHj0tpEinTQ==
Date:   Thu, 7 Apr 2022 18:10:08 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Jiaxin Yu <jiaxin.yu@mediatek.com>
Cc:     broonie@kernel.org, robh+dt@kernel.org, tzungbi@google.com,
        angelogioacchino.delregno@collabora.com, aaronyu@google.com,
        matthias.bgg@gmail.com, trevor.wu@mediatek.com, linmq006@gmail.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Rob Herring <robh@kernel.org>
Subject: Re: [v9 1/4] ASoC: dt-bindings: mt8192-mt6359: add new compatible
 and new properties
Message-ID: <20220407221008.5rhd5s2m5n3o3xmf@notapiano>
References: <20220406100514.11269-1-jiaxin.yu@mediatek.com>
 <20220406100514.11269-2-jiaxin.yu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220406100514.11269-2-jiaxin.yu@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiaxin,

On Wed, Apr 06, 2022 at 06:05:11PM +0800, Jiaxin Yu wrote:
> 1. Adds new compatible string "mt8192_mt6359_rt1015p_rt5682s" for machines
> with rt1015p and rt5682s.
> 2. Adds new property "headset-codec" for getting headset codec.
> 3. Adds new property "speaker-codecs" for getting speaker codecs.
> 
> Signed-off-by: Jiaxin Yu <jiaxin.yu@mediatek.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Tested-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Thanks,
Nícolas
