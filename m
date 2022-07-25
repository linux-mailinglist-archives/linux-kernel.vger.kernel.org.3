Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4327A57FAA1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 09:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232667AbiGYH7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 03:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbiGYH7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 03:59:39 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D2EB13D3F
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 00:59:36 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id b143so17435384yba.11
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 00:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7LVjJZ3vZnsHBYWH91XFfNQq4hkSx4/m7XWPR5zW2rM=;
        b=A4yPo/waVaMIqiTi1D3gcMPCRhfFyDMubfV4Ye7jWo15S5jIz6uB9pGlDRNwR+UEkD
         GkoQ3T2bTCUVib5nqdJFiKC8TuGcSIUhW73cMzUYc15erc9PJ3bJNVk1tZAsuMvah8/F
         WAuTrmKmpbQ9GW7vd23p41ImSbU8YL34psKJQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7LVjJZ3vZnsHBYWH91XFfNQq4hkSx4/m7XWPR5zW2rM=;
        b=E4HSLJlMRvQu4Mx5RvEGmToOjiNo7BVPAE6uoxtwszPZkQvGIk6DFwmnLL+3bR9R9+
         hGFkeD9xQ++/ZKJ7PbjcbisTdK9p6kDaMQVze6HEsDX22gcjaidRn06dYnGN0ZCdW+dR
         84L19q3MVh1Ssvj4ARV+pdgW2bK929/Gz4y4xbM+nHlqza/TgfmJePd64610mSkMKTeQ
         8QacpnpATNZRchziVjKaRTp9fg8fcrvEmA11xqopzYLW+Vb6pvZd9rGfX1aLbfd1JvD1
         YBEzZLOt1scxaV8s9hvW8slw+Hq5RMzlHer36pEmb5V2ndlh7rXFZZbejtcUpnxIGSfH
         VXGw==
X-Gm-Message-State: AJIora8cQaccSHYJ48B/H9vX7M8LPCXHfzpjcyxqnd2Yv1wSecQJFdnV
        rpeqXOrUxDMHd23tC0gJd6dJwee+DSd+AkEmpdeMUw==
X-Google-Smtp-Source: AGRyM1v0HxzW8vtags5zI75LJuEW/+tx6Jwb+I4b5Af0gdhsPwG/G07wonpdlzb5E5ap46RBTKqTtHsQt/XnayBqYFE=
X-Received: by 2002:a25:d852:0:b0:66f:259c:17b6 with SMTP id
 p79-20020a25d852000000b0066f259c17b6mr8769449ybg.438.1658735975662; Mon, 25
 Jul 2022 00:59:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220721145017.918102-1-angelogioacchino.delregno@collabora.com> <20220721145017.918102-4-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220721145017.918102-4-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Mon, 25 Jul 2022 15:59:24 +0800
Message-ID: <CAGXv+5E_Q6Z9RA6VQDHyn6E9xb-C0AmEx7JR8Lc65ofT1YE0sw@mail.gmail.com>
Subject: Re: [PATCH v2 3/8] arm64: dts: mediatek: cherry: Add keyboard mapping
 for the top row
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 21, 2022 at 10:52 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Chromebooks' embedded keyboards differ from standard layouts for the
> top row, as this one doesn't have the standard function keys but
> shortcuts instead: map these keys to achieve the functionality that
> is pictured on the printouts.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
Tested-by: Chen-Yu Tsai <wenst@chromium.org>

> ---
>  .../boot/dts/mediatek/mt8195-cherry.dtsi      | 30 +++++++++++++++++++
>  1 file changed, 30 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
> index 87ac2b4f9814..2853f7f76c90 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
> @@ -821,3 +821,33 @@ &xhci3 {
>
>  #include <arm/cros-ec-keyboard.dtsi>
>  #include <arm/cros-ec-sbs.dtsi>
> +
> +&keyboard_controller {
> +       function-row-physmap = <
> +               MATRIX_KEY(0x00, 0x02, 0)       /* T1 */
> +               MATRIX_KEY(0x03, 0x02, 0)       /* T2 */
> +               MATRIX_KEY(0x02, 0x02, 0)       /* T3 */
> +               MATRIX_KEY(0x01, 0x02, 0)       /* T4 */
> +               MATRIX_KEY(0x03, 0x04, 0)       /* T5 */
> +               MATRIX_KEY(0x02, 0x04, 0)       /* T6 */
> +               MATRIX_KEY(0x01, 0x04, 0)       /* T7 */
> +               MATRIX_KEY(0x02, 0x09, 0)       /* T8 */
> +               MATRIX_KEY(0x01, 0x09, 0)       /* T9 */
> +               MATRIX_KEY(0x00, 0x04, 0)       /* T10 */

I wonder if we want to add the sleep button to this list, since it is
technically part of the first row.

ChenYu
