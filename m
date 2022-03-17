Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56ED84DC90B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 15:41:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235341AbiCQOlq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 10:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235301AbiCQOlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 10:41:36 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27209169B01;
        Thu, 17 Mar 2022 07:40:19 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nfraprado)
        with ESMTPSA id D03801F4553E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1647528017;
        bh=Cesbt6p5WFob0le5pX7ODJlISn8Jpc+6x+rij6eji3A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b1PDqsPe7a5WBBMFJBlXg/tGajNYV6rCJ+tQ2XjUO8eNFGxZ8fsciKUccfOKWrW0w
         M5qnA7hoiZcwaS+7hIo1ZbR+zyRmQ2kstSUHEoFcpre8vIUAHlvh35eN+RMKnI6fbw
         fT+MObMAZLQ6KZvDqMpzI9JBcn7gTRa8MjNToo7pW0pEiaBukmBktsWWCW4qJqSlpN
         dB9k6oBI4JADyITu1raH78ex+b3s4hwC3914sExai+KYTv9+wGPUOGNGTlIwjzDjXW
         d7hnN/pCRjYuB8+qcePFPqiO8+yinyfQWnQrubofENnapV1tFzWsa8JdmG3ZlKYUfN
         k+aQi3t9U6VJw==
Date:   Thu, 17 Mar 2022 10:40:12 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Maya Matuszczyk <maccraft123mc@gmail.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v1 06/10] arm64: dts: mediatek: asurada: Add keyboard
 mapping for the top row
Message-ID: <20220317144012.m7efcweyyqj3jtyt@notapiano>
References: <20220316151327.564214-1-nfraprado@collabora.com>
 <20220316151327.564214-7-nfraprado@collabora.com>
 <CAO_Mup+XApZBaSQLqBBxBPY5U1kOoRNwcWBhoaS+p_gCPx3XCg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAO_Mup+XApZBaSQLqBBxBPY5U1kOoRNwcWBhoaS+p_gCPx3XCg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maya,

On Wed, Mar 16, 2022 at 05:42:20PM +0100, Maya Matuszczyk wrote:
> śr., 16 mar 2022 o 16:26 Nícolas F. R. A. Prado
> <nfraprado@collabora.com> napisał(a):
> >
> > Chromebooks' embedded keyboards differ from standard layouts for the
> > top row in that they have shortcuts in place of the standard function
> > keys. Map these keys to achieve the functionality that is pictured on
> > the printouts.
> >
> > Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> > Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> > ---
> >
> >  .../boot/dts/mediatek/mt8192-asurada.dtsi     | 29 +++++++++++++++++++
> >  1 file changed, 29 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
> > index bd2730ab6266..1d1a4b9a989a 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
> > +++ b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
> > @@ -525,3 +525,32 @@ &uart0 {
> >
> >  #include <arm/cros-ec-keyboard.dtsi>
> >  #include <arm/cros-ec-sbs.dtsi>
> > +
> > +&keyboard_controller {
> > +       function-row-physmap = <
> > +               MATRIX_KEY(0x00, 0x02, 0)       /* T1 */
> > +               MATRIX_KEY(0x03, 0x02, 0)       /* T2 */
> > +               MATRIX_KEY(0x02, 0x02, 0)       /* T3 */
> > +               MATRIX_KEY(0x01, 0x02, 0)       /* T4 */
> > +               MATRIX_KEY(0x03, 0x04, 0)       /* T5 */
> > +               MATRIX_KEY(0x02, 0x04, 0)       /* T6 */
> > +               MATRIX_KEY(0x01, 0x04, 0)       /* T7 */
> > +               MATRIX_KEY(0x02, 0x09, 0)       /* T8 */
> > +               MATRIX_KEY(0x01, 0x09, 0)       /* T9 */
> > +               MATRIX_KEY(0x00, 0x04, 0)       /* T10 */
> > +       >;
> > +       linux,keymap = <
> > +               MATRIX_KEY(0x00, 0x02, KEY_BACK)
> > +               MATRIX_KEY(0x03, 0x02, KEY_REFRESH)
> > +               MATRIX_KEY(0x02, 0x02, KEY_ZOOM)
> > +               MATRIX_KEY(0x01, 0x02, KEY_SCALE)
> > +               MATRIX_KEY(0x03, 0x04, KEY_SYSRQ)
> > +               MATRIX_KEY(0x02, 0x04, KEY_BRIGHTNESSDOWN)
> > +               MATRIX_KEY(0x01, 0x04, KEY_BRIGHTNESSUP)
> > +               MATRIX_KEY(0x02, 0x09, KEY_MUTE)
> > +               MATRIX_KEY(0x01, 0x09, KEY_VOLUMEDOWN)
> > +               MATRIX_KEY(0x00, 0x04, KEY_VOLUMEUP)
> > +
> > +               CROS_STD_MAIN_KEYMAP
> > +       >;
> > +};
> > --
> > 2.35.1
> >
> I'm honestly a bit confused about function of this.
> Does this change the reported key codes via evdev interface?

Yes.

> Or is this just a hint to userspace? If yes, would libinput report
> key presses as F-keys or the custom function keys?
> Would users be able to use the usual key combination to switch
> between TTYs?
> Would programs requiring F-keys still work?

Not with this keyboard, since the embedded keyboard on Chromebooks doesn't have
F-keys.

This patch is just setting the keymap present on this platform, so that the
devicetree correctly describes the hardware.

Thanks,
Nícolas

> 
> Best regards,
> Maya Matuszczyk
> 
> >
> > _______________________________________________
> > Linux-mediatek mailing list
> > Linux-mediatek@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-mediatek
