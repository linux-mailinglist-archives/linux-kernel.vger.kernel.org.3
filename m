Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D23857F994
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 08:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231467AbiGYGpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 02:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbiGYGpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 02:45:15 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 194A460DD
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 23:45:14 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-31e7c4b593fso98836167b3.13
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 23:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=koE1sOchZGcuAQ6ZIasz8+3z8ouCYYjQCDzwRp9wkxE=;
        b=Rcjc8ntxdRRnzxYtaeC8PNuN5mEqizkS+usqu0ltMEG3LntntbO+oSzNniJmafQwEQ
         kWd8OOtIHmb4VWGTZbhqaaHlPmIQAX9jcNBMHFE8lMInOR9PsqFDldUjdXu3A1P3iDIq
         2cUPz3TadTV49aFZGesO2kJgSOwPxjfjIh/UQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=koE1sOchZGcuAQ6ZIasz8+3z8ouCYYjQCDzwRp9wkxE=;
        b=d3DkDchGLfgIAYEhW5aMcNsByG1pSmA9yUnkKXKCpAwQ2jpkJYdP4bdvw/Hcg7GsBQ
         nJ/wiHwuC4JzpAuWG8u43/DveEwShmR2WI+M8+EAfsCxTXKmXVurJUfXB9/oICpiBAzm
         G5XwnfTRQGP1wSuVQL348qvk7p4dyU50figKRfOoWiUPIFhCSbYnxVPDHEV8oDgpxcpR
         UTnvSw3TkTk7qzRzHR81qEaYXst/iwksVtwjL0X9OY4nlxY5gyFOCBFMxSdambrqy25U
         NR9MZpJvCf+c/F5Bm/FzMO/dsurFDFltpxXC0tMgg08BJXOhP6AelEvqr2xzE64RQ3iD
         RrMw==
X-Gm-Message-State: AJIora8kINwY637yNMUbcKOeFwbBAGkADv0N9U0IEWDZeOP6FFRcpUSE
        LK2fyDu4l6+W7p/to/kN2TszrdAa77UrjWlLnLKb4g==
X-Google-Smtp-Source: AGRyM1tWX8v8lA94PgQz8q4L+DWzhvEaTMIwan7i6g4iVoqzmL5YsXQN/5N9OGYvaAFxZcMla6oIVbP/pg4cyghjqs0=
X-Received: by 2002:a81:610:0:b0:31e:4822:6807 with SMTP id
 16-20020a810610000000b0031e48226807mr8670649ywg.354.1658731513346; Sun, 24
 Jul 2022 23:45:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220712114046.15574-1-allen-kh.cheng@mediatek.com>
In-Reply-To: <20220712114046.15574-1-allen-kh.cheng@mediatek.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Mon, 25 Jul 2022 14:45:02 +0800
Message-ID: <CAGXv+5FmXVYTtOusB8gqh1SprWHuNJYcC5MNEHQUGKQx8yrrLQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] Complete driver nodes for MT8192 SoC
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2022 at 7:40 PM Allen-KH Cheng
<allen-kh.cheng@mediatek.com> wrote:
>
> This series are based on matthias.bgg/linux.git, for-next.
>
> I remove vcodec lat and core nodes PATCH from series and will comfirm
> clocks usage then resend PATCH.
>
> Also should reference below PATCH for dsi in chunkuang.hu/linux.git
> dt-bindings: display: mediatek: dsi: Convert dsi_dtbinding to .yaml
>
> changes since v2:
>  - add mmsys #reset-cells PATCH
>  - add missing fallback compatible
>  - add display aliases
>  - remove vcodec lat and core nodes PATCH
>
> changes since v1:
>  - add Reviewed-by Tag
>  - rename dsi-phy from dsi-dphy
>  - add missing power-domains in disp mutex
>  - Add remove mt8192 display rdma compatible PATCH in series
>  - use "mediatek,mt8183-disp-rdma" as fallback
>  - remove mediatek,larb from rdma node
>  - remove syscon-dsi and add power-domains in dsi
>  - add reset property in dsi and mt8192-resets.h
>  - correct Typo: s/ndoe/node in commit message
>
> Allen-KH Cheng (5):
>   arm64: dts: mt8192: Add pwm node
>   arm64: dts: mt8192: Add mipi_tx node
>   arm64: dts: mediatek: Add mmsys #reset-cells property for mt8192
>   arm64: dts: mt8192: Add display nodes
>   arm64: dts: mt8192: Add dsi node

With additional changes to asurada.dtsi I have a working internal display.
Needs a fix [1] for mtk-drm from Angelo on top of next-20220722.

For the whole series

Tested-by: Chen-Yu Tsai <wenst@chromium.org>

[1] https://lore.kernel.org/lkml/20220721172727.14624-1-angelogioacchino.delregno@collabora.com/
