Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56676562AD9
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 07:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233770AbiGAFZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 01:25:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232695AbiGAFZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 01:25:13 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD84B205FF
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 22:25:12 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-31bf327d4b5so12855267b3.13
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 22:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XTOOhYSz2Wo3skXNKI7YNt40yz1EYPv8kOg9CCS27tM=;
        b=OUVBm9UxYy8zUYolvkYKO2nN8kvaVrHfPshLWiz0dIbiqpLsnYO6NS8OQe7K61FvgG
         xlFLGudBSW9dFhmMZTMxw8rmKFA8aNvSEK+JjYGsDksY1MDQUtONRgS8zB9+Cq40w3GZ
         AkQXnp9ANfc3yECwFgfym9eIp0xkR7YYdxN48=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XTOOhYSz2Wo3skXNKI7YNt40yz1EYPv8kOg9CCS27tM=;
        b=w5GuNOQ4GeF64nekPUlXe95dGG7FRNCelDbhr9qeA42+BEMCAMBSVvpvHrd4GXwRGk
         +z+ZoHXarrGBD16HpIA7C2PIIWCWAWJEkTEiNAjz1B2tCd6Dh4q2b17+k54bro6XKVNG
         Hb/E5UH83l4FFH7nLqMslThimsg1E6Sif2ZbJxqlyF1TrJkaRhnZX+gcGy1oVj+yeDj/
         NM6AMA3Sptus1Yt+TFJe65e9N+FKGoqcIMSEqmdcjixsY3f2HQflWV+yqvifNGVOVnJB
         MgUNxjY1HnCIsvvVmN/2DAg0KkQPMEkTjyUunRNgGvloHOLRiJxMNVBpaUE98u0806Uk
         eoFg==
X-Gm-Message-State: AJIora/xGefqnoa29fQCJ96qYVy7BFG4FC872aOtdk9CXGqPiyacXZBE
        xrwGEQ0EHs9wqnh/LXoD6tjKJGs3rVlgjZLlhcbMvQ==
X-Google-Smtp-Source: AGRyM1tzFRf+vWswFtN/NIUdUvvppuw3iV6XZTQB0jFpMstnBu/FE0ARw+3sZHiT20dCyvZqYsyn3NLnLK+W5NulKng=
X-Received: by 2002:a81:19ca:0:b0:31b:732c:15e9 with SMTP id
 193-20020a8119ca000000b0031b732c15e9mr14884710ywz.167.1656653112137; Thu, 30
 Jun 2022 22:25:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220629121358.19458-1-allen-kh.cheng@mediatek.com>
 <20220629121358.19458-4-allen-kh.cheng@mediatek.com> <20220629232429.c5oysjgy6gflqhct@notapiano>
 <99342f13190cb4ea103c4227e6672eb5cad63b82.camel@mediatek.com> <20220630134210.7j665amh6tbeaecv@notapiano>
In-Reply-To: <20220630134210.7j665amh6tbeaecv@notapiano>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Fri, 1 Jul 2022 13:25:01 +0800
Message-ID: <CAGXv+5EKK_eicvD6-nFG0CkirYA2sFUJp59m6RK7y534HvYwbg@mail.gmail.com>
Subject: Re: [PATCH 3/5] arm64: dts: mt8192: Add display nodes
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>
Cc:     "allen-kh.cheng" <allen-kh.cheng@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2022 at 9:42 PM N=C3=ADcolas F. R. A. Prado
<nfraprado@collabora.com> wrote:
>
> On Thu, Jun 30, 2022 at 05:41:31PM +0800, allen-kh.cheng wrote:
> > Hi N=C3=ADcolas,
> >
> > On Wed, 2022-06-29 at 19:24 -0400, N=C3=ADcolas F. R. A. Prado wrote:
> > > On Wed, Jun 29, 2022 at 08:13:56PM +0800, Allen-KH Cheng wrote:
> > > > Add display nodes and gce info for mt8192 SoC.
> > > >
> > > > GCE (Global Command Engine) properties to the display nodes in
> > > > order to
> > > > enable the usage of the CMDQ (Command Queue), which is required for
> > > > operating the display.
> > > >
> > > > Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> > > > Reviewed-by: AngeloGioacchino Del Regno <
> > > > angelogioacchino.delregno@collabora.com>
> > > > ---
> > > >  arch/arm64/boot/dts/mediatek/mt8192.dtsi | 136
> > > > +++++++++++++++++++++++
> > > >  1 file changed, 136 insertions(+)
> > > >
> > > > diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> > > > b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> > > > index a07edc82d403..26d01544b4ea 100644
> > > > --- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> > > > +++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> [..]
> > > > +         rdma0: rdma@14007000 {
> > > > +                 compatible =3D "mediatek,mt8192-disp-rdma";
> > >
> > > dtbs_check is complaining that there isn't a "mediatek,mt8183-disp-
> > > rdma"
> > > fallback compatible here. But given that the rdma driver matches
> > > directly to the
> > > mt8192 compatible, I think the node here is fine, and the binding is
> > > the one
> > > that should be updated.
> > >
> >
> > I have checked the binding and driver again.
> >
> > I prefer use "mediatek,mt8186-disp-rdma" as fallback and remove mt8192
> > compatible and data in mtk_disp_rdma.c because they are the same with
> > mt8183.
> >
> > Do you think it is okay?
>
> Sure, that sounds good to me as well.

That's backwards. MT8192 was released well before MT8186. The latter hasn't
even hit the market yet.

Please use "mediatek,mt8183-disp-rdma" as fallback. And you need to keep
"mediatek,mt8192-disp-rdma" as the most specific compatible string, because
we want SoC specific compatible strings.

For the driver, there isn't any difference between mt8183 and mt8192 for
the rdma part, so we might as well just remove the mt8192 compatible from
the driver.


Regards
ChenYu
