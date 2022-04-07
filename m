Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB714F8A4E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 00:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbiDGV0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 17:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231180AbiDGV03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 17:26:29 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EACA81947B6;
        Thu,  7 Apr 2022 14:24:26 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nfraprado)
        with ESMTPSA id 9D6F51F46A45
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1649366665;
        bh=ZM2JW5hpiHTPcC5mYT0UabIz9BN1FEYm0emgVb8w8vQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LiryOxC+H+6BonxWrZ4+pNbcRKz86e6YgydNpcl43YPOLnyxpjUYiuoJfDqPbWNjP
         za8u8bpPBJ2SUcPe72Vh0zPerv8izJOtPuyw7OH62o+US/bHtLN2nWjGExklAJZa0O
         bn45EReCe/JewyiEtM9fqb8GTOeZuirZ3BEyzoZbSnk0Dw9ET+f7p7neAGzBslUxZu
         LiuamJvfs1iYdtbMoc+KagPnr+mPm1qTutqlk/ISg5k1/QqMJTQDK/yJekAndw4APh
         Ct6w5Zg6lWpsHRJalImfqOHkw9c3inpZsON6kjdmQHIRTNg2i7lOizfBqNpYmJRIUg
         Fl8PimTFnVqvA==
Date:   Thu, 7 Apr 2022 17:24:20 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Jiaxin Yu <jiaxin.yu@mediatek.com>
Cc:     broonie@kernel.org, robh+dt@kernel.org, tzungbi@google.com,
        angelogioacchino.delregno@collabora.com, aaronyu@google.com,
        matthias.bgg@gmail.com, trevor.wu@mediatek.com, linmq006@gmail.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [v9 2/4] ASoC: mediatek: mt8192: refactor for I2S3 DAI link of
 speaker
Message-ID: <20220407212420.tncc576jo5iwaqk7@notapiano>
References: <20220406100514.11269-1-jiaxin.yu@mediatek.com>
 <20220406100514.11269-3-jiaxin.yu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220406100514.11269-3-jiaxin.yu@mediatek.com>
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

On Wed, Apr 06, 2022 at 06:05:12PM +0800, Jiaxin Yu wrote:
> MT8192 platform will use rt1015 or rt1015p codec, so through the
> snd_soc_of_get_dai_link_codecs() to complete the configuration
> of dai_link's codecs.

Suggestion for the commit message:

As part of the refactoring to allow the same machine driver to be used for the
rt1015(p) and rt5682(s) codecs on the MT8192 platform, parse the rt1015(p)
codecs from the speaker-codecs property in the devicetree and wire them to the
I2S3 backend, instead of hardcoding the links and selecting through the
compatible.

> 
> Signed-off-by: Jiaxin Yu <jiaxin.yu@mediatek.com>

Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Tested-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

- Tested on mt8192-asurada-spherion (rt1015p and rt5682). All audio paths still
  work as previous to this refactor. And it's still possible to omit
  mediatek,hdmi-codec.

Thanks,
Nícolas
