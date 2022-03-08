Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 058224D19AB
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 14:53:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347192AbiCHNye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 08:54:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347143AbiCHNyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 08:54:32 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 279F849C81;
        Tue,  8 Mar 2022 05:53:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D18CDB817D0;
        Tue,  8 Mar 2022 13:53:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90AACC340EE;
        Tue,  8 Mar 2022 13:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646747613;
        bh=kKuMXY/kWFSEwzOQtBmx7VatX+a2ZHwU2N6wSzEqcP8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Oa5hkzpmXwNAti5EpS06CldZNsUwpV8quKSv/Xq4a/0cBSgHioYKjsh2dqRvjpywB
         yxperyflVotiv7FEAewxEIEIMSEmKLl9oYdwZwNPCgUncPJVUHNl1FO0u4vLlg7pPo
         wJGIPRvZcNFHyef6P4tOq0cLs0mqSLp+93CoJKLAWdt5ajCqwTVgkQpzeQqNX7EHUe
         QIP9E8ncohi/UAVgTMXuDvr21shroLq+XfAguy7TURInnnntNPOAh3SOhnQ6aJ237e
         MYn4G1gWUTTtkR9AUS9l+rwaiVZVSi+BL1GiFRcNdQ55GtDFkEW6bx5Rjz7AgObkEv
         eKzEOqhWJsgdg==
Received: by mail-ej1-f48.google.com with SMTP id bi12so26288795ejb.3;
        Tue, 08 Mar 2022 05:53:33 -0800 (PST)
X-Gm-Message-State: AOAM531J8t8FoIfXZf203iTrtln9qdg2n1UKDnkQxNCAWeddi5cu5lq4
        Af+xmrrMoQDmA9A7NvTwSJ4quxomsthBx/cqzw==
X-Google-Smtp-Source: ABdhPJzboOw2MvvOqexJGjBvi3QJGsITzv7M/nIKxqkOwm4WPxLh9N4kBnOgz8nMdZEHDlkXjaC9jzahExCVprRjbfM=
X-Received: by 2002:a17:906:9913:b0:6d6:dc48:5d49 with SMTP id
 zl19-20020a170906991300b006d6dc485d49mr13522321ejb.325.1646747611776; Tue, 08
 Mar 2022 05:53:31 -0800 (PST)
MIME-Version: 1.0
References: <20220308094911.2680291-1-robert.foss@linaro.org> <20220308094911.2680291-2-robert.foss@linaro.org>
In-Reply-To: <20220308094911.2680291-2-robert.foss@linaro.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 8 Mar 2022 07:53:20 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLL9j77ym0ZTsBwsW==9E8x2jf7A-R-VaSE_yYR5Y=QJg@mail.gmail.com>
Message-ID: <CAL_JsqLL9j77ym0ZTsBwsW==9E8x2jf7A-R-VaSE_yYR5Y=QJg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: drm/bridge: anx7625: Revert DPI support
To:     Robert Foss <robert.foss@linaro.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Xin Ji <xji@analogixsemi.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 8, 2022 at 3:49 AM Robert Foss <robert.foss@linaro.org> wrote:
>
> Revert DPI support from binding.
>
> DPI support relies on the bus-type enum which does not yet support
> Mipi DPI, since no v4l2_fwnode_bus_type has been defined for this
> bus type.
>
> When DPI for anx7625 was initially added, it assumed that
> V4L2_FWNODE_BUS_TYPE_PARALLEL was the correct bus type for
> representing DPI, which it is not.
>
> In order to prevent adding this mis-usage to the ABI, let's revert
> the support.
>
> Signed-off-by: Robert Foss <robert.foss@linaro.org>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> ---
>
> Changes since v1:
> - Rob: Instead of reverting the entire commit introducing this,
>        do a partial revert of only the relevant parts.
>
>  .../display/bridge/analogix,anx7625.yaml      | 19 +------------------
>  1 file changed, 1 insertion(+), 18 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
