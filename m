Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E67A45ADC7F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 02:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233139AbiIFAgA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 20:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232486AbiIFAf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 20:35:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E40567C97;
        Mon,  5 Sep 2022 17:35:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 93B0EB8159F;
        Tue,  6 Sep 2022 00:35:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F28EC43145;
        Tue,  6 Sep 2022 00:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662424551;
        bh=AFVELCe6kckm5eVg8tSkLGzu73jpu1k+AHFc6+CYBcw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nI77n7PyLi5FxsG5xVGzM7IPkRddyT0b0CMVM4SXMhWb+vUNwAV0WGNt4PA9n8CqS
         zxVkXOyN5M/JlTZh6GqixESF8eOED5NoosbhPX2Hsbo0g74HUvcD5IqIAIzpnj5CaD
         d4ygcuWBgqOpLZM9kiHSPuHX97fV/gU10RfgBZV6i4M0nptUl44AJG2NDDPrJ3KyGn
         1mg1nut4G2j0qOt/ZUizGE05HWc7HSg5muHqEVTDVysQf1oTx2lYiY2aW+xCf1axIQ
         MnFiCmpbeoQzdH1L8YqUu19CRdilnf4OtxFGR0RF0l82/TvXGOFtk+ukltv8mWvtx4
         CmdEvf4qo/wqw==
Received: by mail-ot1-f49.google.com with SMTP id m21-20020a9d6ad5000000b00638df677850so7112274otq.5;
        Mon, 05 Sep 2022 17:35:51 -0700 (PDT)
X-Gm-Message-State: ACgBeo1irLWI9k40WIIAZUzn+PUxbCUun/ta0nMlF7gXXQveqVBkCJz6
        /gv/1dF3FWqxO41xCbpdUKyXzy9lVYDMFwar1g==
X-Google-Smtp-Source: AA6agR7JB46gDLcqHlczb2XMcJBrFON4MTYWbTLa6xhusijh7jtXlCYbGmC4KWVKQpa3XwKRkOEL4frns62DfuOfGIw=
X-Received: by 2002:a05:6830:6999:b0:61d:26f8:94c1 with SMTP id
 cy25-20020a056830699900b0061d26f894c1mr20597426otb.278.1662424550394; Mon, 05
 Sep 2022 17:35:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220901044149.16782-1-rex-bc.chen@mediatek.com>
 <af23462c-2d3b-470a-7fd6-2bf09a3174cb@gmail.com> <80985882-c46f-cfb1-b077-a92866536678@collabora.com>
In-Reply-To: <80985882-c46f-cfb1-b077-a92866536678@collabora.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Tue, 6 Sep 2022 08:35:31 +0800
X-Gmail-Original-Message-ID: <CAAOTY_-C8fmabcTrytpHowbHe8Y+tTmv=5SV+oKPjUNRLTaU9w@mail.gmail.com>
Message-ID: <CAAOTY_-C8fmabcTrytpHowbHe8Y+tTmv=5SV+oKPjUNRLTaU9w@mail.gmail.com>
Subject: Re: [PATCH v17 00/10] Add MT8195 DisplayPort driver
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        DTML <devicetree@vger.kernel.org>, linux-fbdev@vger.kernel.org,
        Guillaume Ranquet <granquet@baylibre.com>,
        Jitao Shi <jitao.shi@mediatek.com>, liangxu.xu@mediatek.com,
        linux-kernel <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Markus Schneider-Pargmann <msp@baylibre.com>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Bo-Chen Chen <rex-bc.chen@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Matthias Brugger <matthias.bgg@gmail.com>, deller@gmx.de,
        David Airlie <airlied@linux.ie>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Dmitry:

Dmitry Osipenko <dmitry.osipenko@collabora.com> =E6=96=BC 2022=E5=B9=B49=E6=
=9C=885=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=886:53=E5=AF=AB=E9=81=
=93=EF=BC=9A
>
> On 9/4/22 15:59, Dmitry Osipenko wrote:
> > 01.09.2022 07:41, Bo-Chen Chen =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> >> This patch is separated from v10 which is including dp driver, phy dri=
ver
> >> and dpintf driver. This series is only contained the DisplayPort drive=
r.
> >>
> >> This series can be tested using 5.19-rc2 kernel and I test it in MT819=
5
> >> Tomato Chromebook. Modetest these modes:
> >
> > Applied to drm-misc-next, thanks!
>
> Hello Chun-Kuang Hu,
>
> Angelo told me today that you wanted to pick up the MTK driver patches
> and I applied them all to the drm-misc instead just of the "video/hdmi"
> patch. The series was fully reviewed and tested, so I had no doubts when
> applied all the patches.
>
> The applied patches can't be reverted, so if you have more changes
> prepared for the MTK driver, then please rebase them on top of the
> latest drm-misc-next.
>
> Apologizes for this confusion. Please let us know if we can help you.

OK, if this cannot be reverted, I could only accept this. Normally,
drm/mediatek patches would go though medaitek-drm-* branch. To prevent
any confusion, it's better to discuss before pick up.

Regards,
Chun-Kuang.

>
> --
> Best regards,
> Dmitry
