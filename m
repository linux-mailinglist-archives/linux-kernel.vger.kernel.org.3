Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 737405705B0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 16:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbiGKOfA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 10:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiGKOe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 10:34:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D04121E11;
        Mon, 11 Jul 2022 07:34:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 40A4DB80FE4;
        Mon, 11 Jul 2022 14:34:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02176C341CF;
        Mon, 11 Jul 2022 14:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657550096;
        bh=BfPr1lGxE1jbjl8a2QBj/0+WuY7JwR7vYpOdLGWms+U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jKvURwjH1YokH78vUQBfl4K9tGp1uvivl4KEzA1uJwxZh0X2T3pO0Gmp32iOR3Nw8
         Tgj1qyFRZkseQV1A1SsnMycfHLo/n13IMA490X79FaOy9Jl17f7XbfbTDUOqIp8DVV
         jt8GDn3xOxWZofALT3Ty/2TfWKU/VG5L7v8n2b3cOngOQjneaRqFLVZqvF91hFAjaU
         oUhFl/+7iMu1CIhDvVelUkYWKFeiPOy/i/XenApeniAAiaAyNzMpBKg3y+D1ckl8sJ
         SIJqNp9sOIlou/IetLQd01XHp8K+ISpmYY8oLSRGdyfO1EP2/xcfzNltdCtvMKOzWr
         WmlEr8TRHKnbQ==
Received: by mail-vk1-f181.google.com with SMTP id 7so1179859vkq.0;
        Mon, 11 Jul 2022 07:34:55 -0700 (PDT)
X-Gm-Message-State: AJIora9kRTT2E2uP9wpQkb5iPOz1H+S5/tQRT3/goWc4Luj3HVso0GzA
        ijtEJF0jQSJuRaIWbw+IZE1do6n48z2SV5NFww==
X-Google-Smtp-Source: AGRyM1sn++ZlUgWuTp7oyb/3PdW+mv3fyNFcVHoEbwlabyq3J/yuM6fMBU549T4VLj9nFYJduODWz+doU+d3OwEOSzE=
X-Received: by 2002:a1f:1ec8:0:b0:36c:643a:e985 with SMTP id
 e191-20020a1f1ec8000000b0036c643ae985mr6189642vke.14.1657550094933; Mon, 11
 Jul 2022 07:34:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220708192605.43351-1-nfraprado@collabora.com>
In-Reply-To: <20220708192605.43351-1-nfraprado@collabora.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 11 Jul 2022 08:34:43 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJPguT+nntX6R7Y6yFnF8CPrQWT0tnEuVSWMs_T7ttp-A@mail.gmail.com>
Message-ID: <CAL_JsqJPguT+nntX6R7Y6yFnF8CPrQWT0tnEuVSWMs_T7ttp-A@mail.gmail.com>
Subject: Re: [PATCH] Revert "dt-bindings: usb: mtk-xhci: Make all clocks required"
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux USB List <linux-usb@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 8, 2022 at 1:26 PM N=C3=ADcolas F. R. A. Prado
<nfraprado@collabora.com> wrote:
>
> This reverts commit ebc4969ae125e65fdb563f66f4bfa7aec95f7eb4. That
> commit was supposed to make the binding better reflect the MediaTek XHCI
> hardware block by requiring all clocks to be present. But doing that
> also causes too much noise in the devicetrees, since it requires
> updating old MediaTek DTs to add clock handles for the fixed clocks, and
> going forward every new clock added to the binding would require even
> more updates.
>
> The commit also didn't update the example to match the changes, causing
> additional warnings.
>
> Instead let's keep the clocks optional so that old devicetrees can keep
> omitting the fixed clocks, and we'll just add the clocks as required on
> new DTs.
>
> Signed-off-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
>
> ---
>
>  Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Acked-by: Rob Herring <robh@kernel.org>
