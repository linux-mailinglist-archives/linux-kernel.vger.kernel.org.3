Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5FDC4B9C4C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 10:43:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238807AbiBQJmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 04:42:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238797AbiBQJmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 04:42:06 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9C991704A;
        Thu, 17 Feb 2022 01:41:48 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id D02991F45872
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1645090907;
        bh=2au26a2pUUKO9XqAr3U0rSJiLwbbAivsU5W+9bDSiT0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=VMCg3wVBo5/cDjYCSAZaXU+iTi1rSSmSg0GY+5dmWH/sPjr7oHhFBuwVl8PwCGvra
         hZTn0pQzhKE1qe9AsqDiHXfS7TVv6eL9RM2UAMUIdyTjH8uCgsv98EHcCIhLWGhK9C
         4ybY4grpadFXTBsLr8p7EVNHtISarntW8d+dtEwejEmt8mShJv7rlGXkaO563J/DFc
         YCZ5+dJDp2nkREk1upnv5ZKIxbEcshWZfvxzBjkySJZ5SMzNxG9jvZ6L6ugHzkscNw
         u8V8SXn9pb2eOclaBeP/MKK4MvS+7DHa/LJDhN5X3ubQLQKQOCPgx8cbMjpjCd5cQO
         Nf/iRt2HZgDLQ==
Message-ID: <f510614b-8e64-52cb-7f7d-5cc07de7d5a6@collabora.com>
Date:   Thu, 17 Feb 2022 10:41:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [v6 1/3] dt-bindings: mediatek: convert mtk jpeg decoder/encoder
 to yaml
Content-Language: en-US
To:     Hsin-Yi Wang <hsinyi@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, linux-media@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        yong.wu@mediatek.com
References: <20211206130425.184420-1-hsinyi@chromium.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20211206130425.184420-1-hsinyi@chromium.org>
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

Il 06/12/21 14:04, Hsin-Yi Wang ha scritto:
> Convert mediatek jpeg decoder and encoder bindings to yaml.
> 
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Tested-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> ---
> v5->v6: no change, rebase to latest linux-next
> ---
>   .../bindings/media/mediatek-jpeg-decoder.txt  | 38 --------
>   .../bindings/media/mediatek-jpeg-decoder.yaml | 89 +++++++++++++++++++
>   .../bindings/media/mediatek-jpeg-encoder.txt  | 35 --------
>   .../bindings/media/mediatek-jpeg-encoder.yaml | 80 +++++++++++++++++
>   4 files changed, 169 insertions(+), 73 deletions(-)
>   delete mode 100644 Documentation/devicetree/bindings/media/mediatek-jpeg-decoder.txt
>   create mode 100644 Documentation/devicetree/bindings/media/mediatek-jpeg-decoder.yaml
>   delete mode 100644 Documentation/devicetree/bindings/media/mediatek-jpeg-encoder.txt
>   create mode 100644 Documentation/devicetree/bindings/media/mediatek-jpeg-encoder.yaml
> 
