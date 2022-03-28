Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD31D4E9EE2
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 20:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245179AbiC1SXa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 14:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234885AbiC1SX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 14:23:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A91728E08;
        Mon, 28 Mar 2022 11:21:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EC96160F4B;
        Mon, 28 Mar 2022 18:21:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50F83C34112;
        Mon, 28 Mar 2022 18:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648491707;
        bh=/hes25yU3YvOd5H4gdqZgtO6BmQMj0GOVhwieQHFZC8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Y3QBOeE45tCdVprMsjGLhZlFYzWBlJSWFm+ayqCtpno9EM3H/L8qTyfR82lNHNj5d
         j3FaXSvSjdUBIZWYEw3TMFnz7Acw/ekopa8kgWViL4E9TYOk7kDHN8iECu6x0Aa9kw
         WeFWsjp0s7xF8A/XERp4kPA7KUuk8NbazZId2klK+rp9jeQvKmTSyIC3+HEX1/BjYN
         +pmQ0Np5twFrrOQUlqXdtUjIwEuZk6Nd6NJl3Fn4ryqacVqt5hn4kScj4xYWV3KJcx
         BMS72Wa/+Imo4F6uxou6AtZjm/BblVKTw3un+ZLzMu0/hmvpLljjE8HjNk7d6XZJmK
         olceDM7ZW4Z/w==
Received: by mail-ej1-f45.google.com with SMTP id dr20so30407118ejc.6;
        Mon, 28 Mar 2022 11:21:47 -0700 (PDT)
X-Gm-Message-State: AOAM532+dqQd39r6FHLVhuLiSUQPf3xsB8g/mjmaCBOk0oJmVqGyO9v5
        i1VFlRvkdcjHobCt8t4Z7HUW4Ud0b6yu41C7TQ==
X-Google-Smtp-Source: ABdhPJyBS6Yqu8DRRebdgTJ8I6WtYN5VWc6v7Ptjdf8OtDush1axetkjF2N3WNYaWT7JCDrp9+ia9rMS2pC0YQOyHHg=
X-Received: by 2002:a17:906:5418:b0:6df:a07f:764b with SMTP id
 q24-20020a170906541800b006dfa07f764bmr28174092ejo.27.1648491705248; Mon, 28
 Mar 2022 11:21:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220328152923.90623-1-krzysztof.kozlowski@linaro.org>
 <CAA8EJprWoxWwk5EWEfWdLquPR+2=u6V0-v1-+wHMHOk8HiEyNw@mail.gmail.com>
 <YkHtY9absUjmqmW7@matsya> <12b0056b-8032-452b-f325-6f36037b5a80@linaro.org>
In-Reply-To: <12b0056b-8032-452b-f325-6f36037b5a80@linaro.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 28 Mar 2022 13:21:33 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+6rx0UU6ryH+z_8KLQqKKuhTCnh=Oft2F03bcze+EV0Q@mail.gmail.com>
Message-ID: <CAL_Jsq+6rx0UU6ryH+z_8KLQqKKuhTCnh=Oft2F03bcze+EV0Q@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: display: msm: dsi: remove address/size cells
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Krishna Manikandan <mkrishn@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 28, 2022 at 12:18 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 28/03/2022 19:16, Vinod Koul wrote:
> > On 28-03-22, 19:43, Dmitry Baryshkov wrote:
> >> On Mon, 28 Mar 2022 at 18:30, Krzysztof Kozlowski
> >> <krzysztof.kozlowski@linaro.org> wrote:
> >>>
> >>> The DSI node is not a bus and the children do not have unit addresses.
> >>>
> >>> Reported-by: Vinod Koul <vkoul@kernel.org>
> >>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >>
> >> NAK.
> >> DSI panels are children of the DSI device tree node with the reg = <0>; address.
> >> This is the convention used by other platforms too (see e.g.
> >> arch/arm64/boot/dts/freescale/imx8mq-evk.dts).
> >
> > So we should add reg = 0, i will update my dtsi fix
> >
>
> To "ports" node? No. The reg=0 is for children of the bus, so the
> panels. How to combine both without warnings - ports and panel@0 - I
> don't know yet...

I don't think that should case a warning. Or at least it's one we turn off.

Rob
