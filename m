Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF33B4E540A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 15:10:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237062AbiCWOLo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 10:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237000AbiCWOLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 10:11:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B88CA65D2E;
        Wed, 23 Mar 2022 07:10:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 55529616DC;
        Wed, 23 Mar 2022 14:10:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2E77C36AE3;
        Wed, 23 Mar 2022 14:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648044610;
        bh=v/gFT/8y2QNpM7jRFtSw7CA3jwTKUwu7o9yrZABFACw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=P+6qju7KgrYR9PKOtOje2vk3T7msB9Dbk7AF0A6rKiZ4l/NA6fVLIOeq3Q6cV+Psf
         U84/Q23zl09bnN8MmrJjFmHzNc81xjaoIyVcteZphR5iwnf4GUrKAf7mFyK+6N7KHm
         EG4lUIiy6K8tUjZDXzdcRdcCcvSJt4/uklymGD4IuW8MRu9R07+LmehP+aLa6mWBmY
         spWoBaerVe1to5cHJfmrazOGYhZPDtoEp87mWUIRLkNPy92wYLGbW7sBeozCw0xjqO
         AEYz6xqgfySUJC3MtfNsIUw+ygBR/olYwNushte6FdFdsu5fcTHKqD0xpmqYL3DWPJ
         7kBtA+yI0JovQ==
Received: by mail-ej1-f42.google.com with SMTP id qx21so3040535ejb.13;
        Wed, 23 Mar 2022 07:10:10 -0700 (PDT)
X-Gm-Message-State: AOAM532Z3a4MZqvJRbWl8wqqU0tcSkALkbMaekU4iU2lC1M9gZozVpws
        bFmEkrzRYKEVL8hQW1emOVm4iOPykw/e9KR4mg==
X-Google-Smtp-Source: ABdhPJyoHAOLWCGsvMFbQN/cBB3l1ZQVSPRNagAHnYdBe/ediYewgN8QArA8v7kajXGSiPzjYVmw0poiMS0XEAnD4uA=
X-Received: by 2002:a17:906:d204:b0:6d6:df17:835e with SMTP id
 w4-20020a170906d20400b006d6df17835emr161839ejz.20.1648044608892; Wed, 23 Mar
 2022 07:10:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220309134702.9942-1-jason-jh.lin@mediatek.com>
In-Reply-To: <20220309134702.9942-1-jason-jh.lin@mediatek.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 23 Mar 2022 09:09:57 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+=hTKTjB8rR77_uQYKDWHzLyTdeU7zbixSCZCNrdmNvg@mail.gmail.com>
Message-ID: <CAL_Jsq+=hTKTjB8rR77_uQYKDWHzLyTdeU7zbixSCZCNrdmNvg@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Fix MediaTek display dt-bindings issues
To:     "jason-jh.lin" <jason-jh.lin@mediatek.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Fei Shao <fshao@chromium.org>,
        Moudy Ho <moudy.ho@mediatek.com>,
        "roy-cw.yeh" <roy-cw.yeh@mediatek.com>, CK Hu <ck.hu@mediatek.com>,
        Fabien Parent <fparent@baylibre.com>,
        Nancy Lin <nancy.lin@mediatek.com>, singo.chang@mediatek.com,
        devicetree@vger.kernel.org,
        "moderated list:ARM/STM32 ARCHITECTURE" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 9, 2022 at 7:47 AM jason-jh.lin <jason-jh.lin@mediatek.com> wrote:
>
> The vdosys0 series carried a nice dt-bindings conversion of the old
> txt documentation for the entire mediatek-drm driver, but some of
> the issues in there weren't seen.
>
> This series is fixing all of the issues pointed out by a
> `dt_binding_check` run, followed by `dtbs_check`.
>
> Change in v2:
> - remove mediatek,ethdr.yaml file
> - change include header of mediatek,ovl-2l.yaml from mt8173 to mt8183
>
> AngeloGioacchino Del Regno (3):
>   dt-bindings: display: mediatek, mutex: Fix mediatek, gce-events type
>   dt-bindings: display: mediatek, ovl: Fix 'iommu' required property
>     typo
>   dt-bindings: display: mediatek: Fix examples on new bindings
>
> jason-jh.lin (1):
>   Revert "dt-bindings: display: mediatek: add ethdr definition for
>     mt8195"

Can this series get applied soon? linux-next is still broken.

If it hits Linus' tree, I will be applying them.

Rob
