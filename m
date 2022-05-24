Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FEC553232C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 08:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234995AbiEXG2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 02:28:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235053AbiEXG2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 02:28:13 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5395772211
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 23:28:09 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id er5so21695612edb.12
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 23:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N3jdbvgtlnw8zIaSv0DQqGc3caOnAXLJMAe+8f0UCS0=;
        b=O5lAcyn/cym/3OrYhOLamVEgFGcZ2RXZc2FY/HnELt4FLoY5cU6Qzd1dh/CbLJMwNP
         qKUgSM+Muoz1BLCPqw4YgLhVdAV7cvJn8lsQADC+YX0odK5WcxdVUpSqQIpNLI+vWSVR
         bGYPWSffJOcjIzQxvLSsgg4r+doFWCFL4Ke0s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N3jdbvgtlnw8zIaSv0DQqGc3caOnAXLJMAe+8f0UCS0=;
        b=MV4N751V86XupXpLrF3DVC2+vixksPaZwZE3OMg2cb4TihS2Cyw7d06tZCLlUEJgRr
         rBY2kgzlwkfh8RJA9E+lucJ99xcsCA71K7ABhuwPrnzNOvLGF2KgTuqhVZoF6YFeoO7S
         V7L8jaTjNEMnTMiWi1B6qvtkCySSKrlMT0ISsa+FSYe88agfMisWofC9DFGQ7aVjL2Lj
         ZHMKT+yEPxooe0T6trHgCmlmM2AcXnwbs5e8I9O+dBJAb/6yF5hiYNTHEovdwZ3OXwg2
         Slq/aPFXHpel8MvikSi2EIuPqTzp976/MmXYKCWSx8UmWzsyaam2jHYd0NcbbDoeh6yD
         Elug==
X-Gm-Message-State: AOAM533MZrlc4sJFQJ8L+8O1oWvb82yuwPLNilCUTNl4ma8MJzyNaFvc
        qGdy4afXICUS+I6uzGJkWhAZKRtAW+dFSHszRbfxh3nwaCM=
X-Google-Smtp-Source: ABdhPJzBItlY43uGQ1di/pvyiuI5cG2uV8pK8/a3MYLK073piDHgVWBSg8bsrQX2VghdcQWs8SvYrgrhAjczS+pKxbA=
X-Received: by 2002:a05:6402:d51:b0:42a:b2cc:33b2 with SMTP id
 ec17-20020a0564020d5100b0042ab2cc33b2mr27392564edb.248.1653373687924; Mon, 23
 May 2022 23:28:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220523102339.21927-1-matthias.bgg@kernel.org>
In-Reply-To: <20220523102339.21927-1-matthias.bgg@kernel.org>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Tue, 24 May 2022 14:27:56 +0800
Message-ID: <CAGXv+5Gx6oGvvL1aSWfZC8cpE7mFyr5g66c=AHm3jkNCuXzakg@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] Delete MT8192 msdc gate (was "clk: mediatek:
 Delete MT8192 msdc gate")
To:     matthias.bgg@kernel.org
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        allen-kh.cheng@mediatek.com, weiyi.lu@mediatek.com,
        chun-jie.chen@mediatek.com, linux-kernel@vger.kernel.org,
        ikjn@chromium.org, miles.chen@mediatek.com, robh+dt@kernel.org,
        linux-mediatek@lists.infradead.org,
        krzysztof.kozlowski+dt@linaro.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        angelogioacchino.delregno@collabora.com,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 23, 2022 at 7:19 PM <matthias.bgg@kernel.org> wrote:
>
> From: Matthias Brugger <matthias.bgg@gmail.com>
>
>
> The mt8192-msdc clock is only a single clock gate. This gate is accessed
> from the mmc driver directly. With
> 4a1d1379ebf6 ("arm64: dts: mt8192: Add mmc device nodes")
> the only consumer of this binding was deleted. Delete the binding
> decription and the clock driver bound to it.
>
> Changes in v3:
> - Update commit message to explain better why we do ABI breakage here
> - add Reviewed-by tag
>
> Changes in v2:
> - Delete compatible in binding descprition as well
> - Add RvB tags
> - add Reviewed-by tag
>
> Matthias Brugger (2):
>   dt-bindings: ARM: Mediatek: Remove msdc binding of MT8192 clock
>   clk: mediatek: Delete MT8192 msdc gate

Whole series is

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
