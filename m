Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D37C564864
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 17:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232707AbiGCPZs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 11:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230446AbiGCPZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 11:25:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BC6862D3;
        Sun,  3 Jul 2022 08:25:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DEB1F60FF9;
        Sun,  3 Jul 2022 15:25:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42747C385A2;
        Sun,  3 Jul 2022 15:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656861945;
        bh=6FZRGuGyGXrR6uSqT9Lj6raevMBa8uPkB+swZksqT8g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Jnfjjziiv5MMxIuRaSg6LT5q52q+OIrul5gcUV0jYjn4deC7F6mQtgGFOJmSBdAl0
         7+SdkRcpFhexGoZb4lzRVq6mZJc1wAbKefVz+PuyV1KEBlpiX+/S6PdI99faDmJSAM
         mPIv2wcYy0abVEu8yIGwxAIQqPASjcut1yD92/ioHhVeYMDzFcrpVvRCWBpWlP/dUb
         OjauLPWnckOBclx4SUrUQEQga6KweAInZMgPn4uGvyFBOqpbqGUZQv+kYbP1fQn+IP
         ByMbqIZQJ054r4EcKqUaiiiIhZd/9yFR39F2DMSx+qBTYmKaQXRcf6ZWadBwm2oezA
         04iZwX3Ba/zbQ==
Received: by mail-wr1-f48.google.com with SMTP id s1so9977505wra.9;
        Sun, 03 Jul 2022 08:25:45 -0700 (PDT)
X-Gm-Message-State: AJIora/yYz6kxamyHbSBz8E4/alWFzcZzkEEjh5ftl8U0bcoNj9r94eW
        YyCxombS8TR9x/cgVpeTuc8I48MVyYWztsfFGg==
X-Google-Smtp-Source: AGRyM1t143YoHfhT1+OzPkK/w5os5HDfXvbtq7xkqhf03LIENcWrbQDx8MClno+Ey8csr1cLW8bxwuJ/Np9kf9yY7bQ=
X-Received: by 2002:a5d:6c62:0:b0:21d:2235:d800 with SMTP id
 r2-20020a5d6c62000000b0021d2235d800mr23103832wrz.381.1656861943448; Sun, 03
 Jul 2022 08:25:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220701090547.21429-1-allen-kh.cheng@mediatek.com>
 <20220701090547.21429-2-allen-kh.cheng@mediatek.com> <CAGXv+5FTXXWZU4FyqJ7uqoPGso7ofsb1=QS0mU8Ay2hSz7rFXQ@mail.gmail.com>
In-Reply-To: <CAGXv+5FTXXWZU4FyqJ7uqoPGso7ofsb1=QS0mU8Ay2hSz7rFXQ@mail.gmail.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Sun, 3 Jul 2022 23:25:28 +0800
X-Gmail-Original-Message-ID: <CAAOTY_8T4+hGscNwhYnnySjzOQiuDBKiH-dvazzntnNGr6u2mw@mail.gmail.com>
Message-ID: <CAAOTY_8T4+hGscNwhYnnySjzOQiuDBKiH-dvazzntnNGr6u2mw@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] drm/mediatek: Remove mt8192 display rdma compatible
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Allen:

Applied to mediatek-drm-next [1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-next

Regards,
Chun-Kuang.

Chen-Yu Tsai <wenst@chromium.org> =E6=96=BC 2022=E5=B9=B47=E6=9C=881=E6=97=
=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=886:37=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Fri, Jul 1, 2022 at 5:05 PM Allen-KH Cheng
> <allen-kh.cheng@mediatek.com> wrote:
> >
> > The compatible =E2=80=9Cmediatek,mt8192-disp-rdma=E2=80=9D is being use=
d for reading
> > the data into DMA for back-end panel driver in mt8192 but there is
> > no difference between mt8183 and mt8192 in rdma driver.
> >
> > Remove compatible =E2=80=9Cmediatek,mt8192-disp-rdma=E2=80=9D from the =
driver and
> > should use =E2=80=9Cmediatek,mt8183-disp-rdma=E2=80=9D as fallback in 8=
192 DTS
> > according to the mediatek,rdma.yaml.
> >
> > Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
>
> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
