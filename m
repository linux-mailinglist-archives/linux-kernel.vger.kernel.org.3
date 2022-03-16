Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 561404DB661
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 17:43:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244921AbiCPQoU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 12:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355976AbiCPQoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 12:44:12 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5481DA19A;
        Wed, 16 Mar 2022 09:42:57 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id n2so2261510plf.4;
        Wed, 16 Mar 2022 09:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BW2d8Dyp2cExpWVtXoA7gtuiOGkjmYFfLPkZZvWUWuE=;
        b=KTPQ3uR8oeOAQeb5ExlWZJScxO5hlkacl9opU8+ox5Jddua98cFnBMapXDGeqN7AkN
         /j4abslLcK+1h1QI8EqWclCxcmHVY0VE8vFQJjy3dbM8ihSDevc9bLzIJbhAVHUzCfvX
         iD0ZW0Mt7qxvC64oowDzxsc22nMuPkrEIEf32pk/yj4DQEVw9oWcp/5niCeuejTEGEH3
         /Vi9J1E7nYZXK7tB9OVb/oDQqBr913EvSUfMpBT8x5fNq5upmuH4T8dO6ZoSnUiHkGzy
         FBiF6kWlU72k/jM0uVJLy89jT95HvLBO8VnM8p0WfYggGfXytUdIVrDYXLrGh8qD6mTf
         oCQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BW2d8Dyp2cExpWVtXoA7gtuiOGkjmYFfLPkZZvWUWuE=;
        b=SLU9ZCdkz88367MptDP3V2M7kPDi1j3QdXOO+wAC2M7ZQx6cJWgyxS/gBwTMWh5n9f
         6W3VLJqvpgMd/bCEdZDM9xiZ6DxFg8iK3TSQZjZ8OFg+wYZUqgvOjWuku0DlfHlhUtZE
         D2DVfojaleSdpfg5oJ6i0krzL12fAAdhVRUjbYWo4UPwRRXfQ1BOxhEVRCI10h+2IcvI
         zN9eTMywVMe8G2D83m4ixLduP7YktW2yG3nYAtzryNKm5a6oABwWQewH2Dhb+kxSovls
         Kq73EtHacgzfB8xmcgZdv0qG8mHYsWFsSzXNrU9ca9srhJLUCkiIBcAV3fu7BZ+wGs3N
         TW3w==
X-Gm-Message-State: AOAM532a5DIy+YaNAmTRfEY2sRf59l6ughuMwyGU437qeBpKTW95QPzv
        IRoiTh5hsEjR0FYjQPQ/sIy9aqdxLick7kHLx04=
X-Google-Smtp-Source: ABdhPJxnKoIl7zAlULOj1fpixYM20e2JbUK5BjJshGSKsdnWuYUurDE8vJC0f1qon7v4/DPLgFKc5Ioa6Hmgzs6ZUs0=
X-Received: by 2002:a17:902:f686:b0:151:d866:f657 with SMTP id
 l6-20020a170902f68600b00151d866f657mr534723plg.112.1647448976845; Wed, 16 Mar
 2022 09:42:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220316151327.564214-1-nfraprado@collabora.com> <20220316151327.564214-7-nfraprado@collabora.com>
In-Reply-To: <20220316151327.564214-7-nfraprado@collabora.com>
From:   Maya Matuszczyk <maccraft123mc@gmail.com>
Date:   Wed, 16 Mar 2022 17:42:20 +0100
Message-ID: <CAO_Mup+XApZBaSQLqBBxBPY5U1kOoRNwcWBhoaS+p_gCPx3XCg@mail.gmail.com>
Subject: Re: [PATCH v1 06/10] arm64: dts: mediatek: asurada: Add keyboard
 mapping for the top row
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=C5=9Br., 16 mar 2022 o 16:26 N=C3=ADcolas F. R. A. Prado
<nfraprado@collabora.com> napisa=C5=82(a):
>
> Chromebooks' embedded keyboards differ from standard layouts for the
> top row in that they have shortcuts in place of the standard function
> keys. Map these keys to achieve the functionality that is pictured on
> the printouts.
>
> Signed-off-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> ---
>
>  .../boot/dts/mediatek/mt8192-asurada.dtsi     | 29 +++++++++++++++++++
>  1 file changed, 29 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi b/arch/arm6=
4/boot/dts/mediatek/mt8192-asurada.dtsi
> index bd2730ab6266..1d1a4b9a989a 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
> @@ -525,3 +525,32 @@ &uart0 {
>
>  #include <arm/cros-ec-keyboard.dtsi>
>  #include <arm/cros-ec-sbs.dtsi>
> +
> +&keyboard_controller {
> +       function-row-physmap =3D <
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
> +       >;
> +       linux,keymap =3D <
> +               MATRIX_KEY(0x00, 0x02, KEY_BACK)
> +               MATRIX_KEY(0x03, 0x02, KEY_REFRESH)
> +               MATRIX_KEY(0x02, 0x02, KEY_ZOOM)
> +               MATRIX_KEY(0x01, 0x02, KEY_SCALE)
> +               MATRIX_KEY(0x03, 0x04, KEY_SYSRQ)
> +               MATRIX_KEY(0x02, 0x04, KEY_BRIGHTNESSDOWN)
> +               MATRIX_KEY(0x01, 0x04, KEY_BRIGHTNESSUP)
> +               MATRIX_KEY(0x02, 0x09, KEY_MUTE)
> +               MATRIX_KEY(0x01, 0x09, KEY_VOLUMEDOWN)
> +               MATRIX_KEY(0x00, 0x04, KEY_VOLUMEUP)
> +
> +               CROS_STD_MAIN_KEYMAP
> +       >;
> +};
> --
> 2.35.1
>
I'm honestly a bit confused about function of this.
Does this change the reported key codes via evdev interface?
Or is this just a hint to userspace? If yes, would libinput report
key presses as F-keys or the custom function keys?
Would users be able to use the usual key combination to switch
between TTYs?
Would programs requiring F-keys still work?

Best regards,
Maya Matuszczyk

>
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
