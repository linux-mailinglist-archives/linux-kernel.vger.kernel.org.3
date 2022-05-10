Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 114B9521259
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 12:38:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239958AbiEJKmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 06:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239830AbiEJKmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 06:42:06 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95C03267C21
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 03:38:09 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id s30so29881976ybi.8
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 03:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=18Z/sTz+IhJS4WIQidF8Pkf7x0QFtzeGTd5zgt1XcsI=;
        b=mce5YmBbmq67J2zhZTHGEv91yobyh5mk7B2CT3fMjjAqcnjQubzRIntpwRppCEnqp+
         rmbixFACXH1Fa3+8SQbPTl8SgT/K4WNPHtxz5QmUUgQ0SUdbjb5qhG6im/W3dUulSp/u
         HJ+wUlbTR0YAU9r1YHMPQhrxD5BLUFa1TOZJo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=18Z/sTz+IhJS4WIQidF8Pkf7x0QFtzeGTd5zgt1XcsI=;
        b=fRXx4ibbZz/wdgbd7s0I/5c25DDgNTcTKB9OmxrgR7CE4/dGHiY8PqOcaHGiPX2USE
         BuBiKq3z0S1W+IzWnBiiMmN4V+dj/AmybRdiVhA/I6i/ErbWSvkecgVtfUuH6uhhIWTO
         atTGikPKLdGnQC6Kcb76JVs7GMw7Ml1WU2zA0EIx7NfDEn+b8LzhVrLE79Q8WPZmqZC2
         /duVYf1uqO/B85mBawx9fvYKr/XSRhuf2goicbaWuXjDPW21SpnbQkk3WmnKVeaR5A8s
         tmxhus4y95Ae8FWjPJ9GHu9jfy6L33JbS2t0onQsa3qUJ5uEcQ7rCNLyG/S6+xOUXLiI
         Y4dA==
X-Gm-Message-State: AOAM532u+mJvJC2o45fy+57op7yRYF12J+I5r88//6FC6x3lD5/EVE4e
        v6KnJylQW7xb2TzpgodBYrDK9d7/4C4EFhMA8eknRQ==
X-Google-Smtp-Source: ABdhPJydfNAKQMhJh5sK/HAXZvb2Kunl4GtH2wnKZ/ZK7z6LCCVG+1efFg9HYbdUR9Jq5koVxnXByhS4ux49LykcTBs=
X-Received: by 2002:a05:6902:1501:b0:649:ff91:5409 with SMTP id
 q1-20020a056902150100b00649ff915409mr17647450ybu.278.1652179088847; Tue, 10
 May 2022 03:38:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220509044302.27878-1-rex-bc.chen@mediatek.com>
 <20220509044302.27878-2-rex-bc.chen@mediatek.com> <a5c9e7ad-c4b5-e757-cd6d-f79de47d1ff3@linaro.org>
 <fbbbc7e6a951bdde648ddd896f1fa163dafa16f1.camel@mediatek.com> <1c3fd336-1450-9b68-df81-2f01cc2ba32f@linaro.org>
In-Reply-To: <1c3fd336-1450-9b68-df81-2f01cc2ba32f@linaro.org>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Tue, 10 May 2022 18:37:57 +0800
Message-ID: <CAGXv+5EHFjqiVQbXgcJWCo+TmaTU_z4e0g85beMLCNjyx5qJcw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: mediatek: add vdosys1 RDMA definition
 for mt8195
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rex-BC Chen <rex-bc.chen@mediatek.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "airlied@linux.ie" <airlied@linux.ie>,
        =?UTF-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        =?UTF-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10, 2022 at 6:28 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 09/05/2022 10:45, Rex-BC Chen wrote:
> >>> +    soc {
> >>> +        #address-cells = <2>;
> >>> +        #size-cells = <2>;
> >>> +
> >>> +        vdo1_rdma0: mdp-rdma@1c104000 {
> >>
> >> Generic node name. dma-controller (if it does not conflict with
> >> dma-common.yaml schema)?
> >
> > We don't understand what dma-controller you are referring to? Can you
> > help explain more? Thanks!
>
> Use a generic node name, as Devicetree spec asks:
> "The name of a node should be somewhat generic, reflecting the function
> of the device and not its precise programming
>
> model. If appropriate, the name should be one of the following choices:"
>
> I proposed dma-controller, but feel free to find better generic node name.

dma-controller is covered by dma-controller.yaml, which references
dma-common.yaml in its entirety, so I don't think that would work.

What about "blitter"? I think that is a generic term that is/was commonly
used with display hardware and sort of describes the function of the RDMA
& WDMA blocks, and if only one side is memory and the other is the display
pipeline.


Regards
ChenYu
