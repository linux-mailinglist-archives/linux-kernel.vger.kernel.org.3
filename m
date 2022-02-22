Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB80C4BF07E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 05:10:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241546AbiBVDWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 22:22:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241551AbiBVDWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 22:22:03 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F28A27142
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 19:21:27 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id d21so15956929yba.11
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 19:21:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MZmWgceQ6d0EJDvYHIwt2SeSJZCWvvIDtaWqqmY4OMA=;
        b=DrPJ477mHkIvsVG73tpIaNLu6pLFpEIIqmAUrwV2BmcWkzPeUA+j1IusCbgfZ0t3nV
         zroHaYD7xo6WtfwZMIE85TsMJ39VJhAZQt4cXKPZjcljp1PxYz8OLCkamgJl+wJ7kREv
         SR4lEk4X+3DQyQX7tgFVZS1Pqp1kyT5uurxnc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MZmWgceQ6d0EJDvYHIwt2SeSJZCWvvIDtaWqqmY4OMA=;
        b=5pZ/BIXinEvO9rOAMFfpt9NNhJ5ASUD/kTDwhWjqFB0JQgAJQ689BHmjNhebsgSvc/
         vwZM1X7k56ajTr49K1hrxM5TU3l3pgM+zNJKQ20fCOROqFsZXQQBcCgc5+9YqDjMdTV2
         NhFuCF12KXXqv2Z9gTZDk9ANfKHPSMic8K5AErRET0FevTWoMXfn1u1zqX4joN003iNM
         mPFy+fKhWPnbqhdBg7fJw4MtD9JUEgkobrxYTZLQRZWa337Bb25USV4hGspltXZcaPcq
         pRXbhwQ/XKtyedptzSn7HTdyhZVl7ZwfVpoX4TtrEDNBttgW6VlGdq10pfWnquF6TJJl
         sJfg==
X-Gm-Message-State: AOAM530tTBRjNBHRVj0jcPnLUcfSZyhrw9bDOMCkmWKJE9uyJ92PPYmY
        oPlOvVerfQEEr9zh5utNB7uc6UTeDOC1S9tyaKYe+Yii2lo=
X-Google-Smtp-Source: ABdhPJxt7WwycTtizv9sQEejATOIAE0jfqZbArOAZiarEyoXEA95Nu+HBOjjRAGBu2adA3cQSIpv+e7ZPkkikuTfZUg=
X-Received: by 2002:a25:d314:0:b0:624:6c1a:6f2d with SMTP id
 e20-20020a25d314000000b006246c1a6f2dmr11111568ybf.189.1645500087178; Mon, 21
 Feb 2022 19:21:27 -0800 (PST)
MIME-Version: 1.0
References: <20220218091633.9368-1-allen-kh.cheng@mediatek.com>
In-Reply-To: <20220218091633.9368-1-allen-kh.cheng@mediatek.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Tue, 22 Feb 2022 11:21:16 +0800
Message-ID: <CAGXv+5EHLi0TpZaZq3rbOZeUjiFA_0t3QwZtjSLPZEe_zFO6XA@mail.gmail.com>
Subject: Re: [PATCH v2 00/23] Add driver nodes for MT8192 SoC
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        "--to=Krzysztof Kozlowski" <krzysztof.kozlowski@canonical.com>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Ryder Lee <ryder.lee@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 18, 2022 at 5:16 PM Allen-KH Cheng
<allen-kh.cheng@mediatek.com> wrote:
>
> This series are based on tag: next-20220216, linux-next/master
> and apply the below patchs
> https://patchwork.kernel.org/project/linux-mediatek/patch/20220207094024.22674-1-allen-kh.cheng@mediatek.com/

It would make things easier if you incorporated the above patch into this
series when you send v3.

ChenYu

> https://patchwork.kernel.org/project/linux-mediatek/patch/20220217135620.10559-1-allen-kh.cheng@mediatek.com/
>
> There some patches are missed in PATCH v1.
> I resend series again and also add display related nodes in PATCH v2.
>
> changes since v1:
> - add usb-phy node for xhci node
> - move infracfg_rst patch in front of PCIe patch
> - add display nodes, i2c aliases and pwm node.
>
> Allen-KH Cheng (23):
>   arm64: dts: mt8192: Add power domains controller
>   arm64: dts: mt8192: Add pwrap node
>   arm64: dts: mt8192: Add spmi node
>   arm64: dts: mt8192: Add gce node
>   arm64: dts: mt8192: Add SCP node
>   arm64: dts: mt8192: Add usb-phy node
>   arm64: dts: mt8192: Add xhci node
>   arm64: dts: mt8192: Add audio-related nodes
>   arm64: dts: mt8192: Add infracfg_rst node
>   arm64: dts: mt8192: Add PCIe node
>   arm64: dts: mt8192: Correct nor_flash status of mt8192
>   arm64: dts: mt8192: Add efuse node
>   arm64: dts: mt8192: Add mmc device nodes
>   arm64: dts: mt8192: Add mipi_tx node
>   arm64: dts: mt8192: Add m4u and smi nodes
>   arm64: dts: mt8192: Add H264 venc device node
>   arm64: dts: mt8192: Add vcodec lat and core nodes
>   arm64: dts: mt8192: Add dpi node
>   arm64: dts: mt8192: Add i2c aliases
>   arm64: dts: mt8192: Add display nodes
>   arm64: dts: mt8192: Add dsi node
>   arm64: dts: mt8192: Add gce info for display nodes
>   arm64: dts: mt8192: Add pwm node
>
>  arch/arm64/boot/dts/mediatek/mt8192.dtsi | 1000 +++++++++++++++++++++-
>  1 file changed, 989 insertions(+), 11 deletions(-)
>
> --
> 2.18.0
>
