Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA6E4CB370
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 01:35:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbiCCABf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 19:01:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbiCCABc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 19:01:32 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04B365007D;
        Wed,  2 Mar 2022 16:00:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 945BE61BA9;
        Thu,  3 Mar 2022 00:00:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00CE8C36AE3;
        Thu,  3 Mar 2022 00:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646265647;
        bh=Gh+Iw395lx9OcmDBaop4139TbIG8zRBjlYsZzNBFWco=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BocpuqTmutORsZYOiNSdm6lbdqku4oUyiaGBbawYajhypmeyVq/AFKrfpskEbcDf1
         Q4/3uRPtQVWQFi13n7scGMH2Wid9LMjelDkVKUG+YEX7DHDQZ0KWBXrrawYLftXc3k
         imwIMLlwqpUJdpgJFKoH1Z3B51kHkMs0QNYnA8bhbSTXwnhU0Cu1B3wklft1sYv1Q5
         sZrEciaPDY3ZaKJyqH1bwFDtdS/e3oeCQj2G8VxNKQ5Z3e8195bISM1iV0JOy11v3j
         OMssM1DtJK+tk/y6B7eunZOi4e+gNL/pU1dRgivstJDAtlfMwXfKDmZjslIiDbLCgP
         ZdiHHAR5HAnQQ==
Received: by mail-ed1-f50.google.com with SMTP id y11so3921809eda.12;
        Wed, 02 Mar 2022 16:00:46 -0800 (PST)
X-Gm-Message-State: AOAM5322o6RgSTMaVRROWjOUvDSonuRi5Mz0sizM6JGQY6JDMqWB4vnE
        BtX3oFBEUZlJqqEC969QDVjoY3UBrp98QXXdYQ==
X-Google-Smtp-Source: ABdhPJyCWS2G7IAO37h6jGUTcYx1AHcHdPNzIqNZZelMR25IBMLn05AR7M7SJt01irflojL+S4EdT9nvnMtxT4pRjgc=
X-Received: by 2002:aa7:df12:0:b0:410:a50b:de00 with SMTP id
 c18-20020aa7df12000000b00410a50bde00mr31738511edy.2.1646265645243; Wed, 02
 Mar 2022 16:00:45 -0800 (PST)
MIME-Version: 1.0
References: <20220126071932.32615-1-jason-jh.lin@mediatek.com>
 <20220126071932.32615-4-jason-jh.lin@mediatek.com> <CAAOTY__K_0sp6+VdL0yi=wF9wA_uag4HKqK3ST7uySdkzfCHBA@mail.gmail.com>
 <CAAOTY__Xz0Pu30tmUrNJ=Nji=03Xv_3Qw526_hT-zELME36Bxw@mail.gmail.com>
In-Reply-To: <CAAOTY__Xz0Pu30tmUrNJ=Nji=03Xv_3Qw526_hT-zELME36Bxw@mail.gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 2 Mar 2022 18:00:34 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLU0m9C1OPdiBPTkofB4sfiAeUPbFHp0w8caWyP4XPOEw@mail.gmail.com>
Message-ID: <CAL_JsqLU0m9C1OPdiBPTkofB4sfiAeUPbFHp0w8caWyP4XPOEw@mail.gmail.com>
Subject: Re: [PATCH v15 03/12] dt-bindings: display: mediatek: disp: split
 each block to individual yaml
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        "jason-jh . lin" <jason-jh.lin@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Fei Shao <fshao@chromium.org>,
        Moudy Ho <moudy.ho@mediatek.com>,
        "roy-cw.yeh" <roy-cw.yeh@mediatek.com>, CK Hu <ck.hu@mediatek.com>,
        Fabien Parent <fparent@baylibre.com>,
        Jitao shi <jitao.shi@mediatek.com>,
        Nancy Lin <nancy.lin@mediatek.com>, singo.chang@mediatek.com,
        DTML <devicetree@vger.kernel.org>,
        "moderated list:ARM/STM32 ARCHITECTURE" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 7, 2022 at 5:07 PM Chun-Kuang Hu <chunkuang.hu@kernel.org> wrote:
>
> OK, it seems no one has comment on this patch, so

No comment because the patch was not in PW. That's most likely due to this:

Subject: [PATCH v15 03/12] dt-bindings: display: mediatek: disp: split
each block to individual yaml
Date: Wed, 26 Jan 2022 15:19:23 +0800 [thread overview]
Message-ID: <20220126071932.32615-4-jason-jh.lin@mediatek.com> (raw)
In-Reply-To: <20220126071932.32615-1-jason-jh.lin@mediatek.com>

[-- Warning: decoded text below may be mangled, UTF-8 assumed --]
[-- Attachment #1: Type: text/plain; charset="y", Size: 50916 bytes --]

"y" is not a valid charset. This is caused when git-send-email asks
for the encoding and you answer 'y' rather than <enter>.

Rob
