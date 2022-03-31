Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA52F4EDDF0
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 17:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239317AbiCaPxf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 11:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233019AbiCaPxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 11:53:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 649B7606F4;
        Thu, 31 Mar 2022 08:51:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E324560C35;
        Thu, 31 Mar 2022 15:51:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53C6AC34111;
        Thu, 31 Mar 2022 15:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648741905;
        bh=k9Ttwe47dSKB//4XyhIsQOi+168C1hhlSrXlQ8RS5Qc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XsUXwi1IjUUN7j7u1Sp3CxErD4DzJAqg0jgz4skj1CR320YstT+0KB3Chzlk9I1Y+
         /vlM+RTDgly9Q9QJ5ZCp3JpilOqC7oX8ltxA8QafU91Vt47feMV80dxYHYdo3PZKqn
         TTlHO2nlB1gV3C2iMg+7tS7rznDLl0Zm6uAaSTlKkpwQV6mtQbUHWbL3JZrXXpjqie
         kILZeYH9I1J7gFoYYiGPYqLUKvmcOrWTpoQ8DEcc0wwm7DS5Z6aIJE0Jh3E7iHg+H9
         dCR2SeLuvs1+yca1ZRKXp7mxOEc6sRx+FkbVpgDPuVVlmaOMo5Xj9W9Hao9ap1keJ6
         i2GNzDRUUwuMA==
Received: by mail-il1-f169.google.com with SMTP id t15so52099ilq.12;
        Thu, 31 Mar 2022 08:51:45 -0700 (PDT)
X-Gm-Message-State: AOAM532mp7hf6bQvSjpQ1rNhs8QAClmhcrZfrGI3gCs1xPPfrkgGOCsy
        c3Tkw4QG8VoVVV35glY/eVFli6yLoFPodAxTqw==
X-Google-Smtp-Source: ABdhPJwfhuDLSTUugNUrq3UCbhD/GyXM9vgEU4DBm47fXU5hBu6gsJGmx+1IQd9N12SFQjndRYNBevb+f+MIHqebLD0=
X-Received: by 2002:a05:6e02:1c2b:b0:2c9:b42e:981b with SMTP id
 m11-20020a056e021c2b00b002c9b42e981bmr10724018ilh.37.1648741904453; Thu, 31
 Mar 2022 08:51:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220328152923.90623-1-krzysztof.kozlowski@linaro.org>
 <CAA8EJprWoxWwk5EWEfWdLquPR+2=u6V0-v1-+wHMHOk8HiEyNw@mail.gmail.com>
 <YkHtY9absUjmqmW7@matsya> <12b0056b-8032-452b-f325-6f36037b5a80@linaro.org>
 <CAL_Jsq+6rx0UU6ryH+z_8KLQqKKuhTCnh=Oft2F03bcze+EV0Q@mail.gmail.com>
 <YkKmPSesQfS6RLCD@matsya> <YkMrPnRbsl3FBig8@robh.at.kernel.org>
 <YkVEsqiRamfTmNi0@matsya> <CAA8EJpqTqB10JkmK4GfbO6uP4wAUtqPzY+N4f+=Lt6Vy3a+g4Q@mail.gmail.com>
In-Reply-To: <CAA8EJpqTqB10JkmK4GfbO6uP4wAUtqPzY+N4f+=Lt6Vy3a+g4Q@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 31 Mar 2022 10:51:33 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLsCEf7R89HEYzU2i9o3AFaSk-TeDV-sWQkULxnvr+8cw@mail.gmail.com>
Message-ID: <CAL_JsqLsCEf7R89HEYzU2i9o3AFaSk-TeDV-sWQkULxnvr+8cw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: display: msm: dsi: remove address/size cells
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
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

On Thu, Mar 31, 2022 at 4:35 AM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Thu, 31 Mar 2022 at 09:05, Vinod Koul <vkoul@kernel.org> wrote:
> >
> > On 29-03-22, 10:52, Rob Herring wrote:
> > > On Tue, Mar 29, 2022 at 12:01:52PM +0530, Vinod Koul wrote:
> > > > On 28-03-22, 13:21, Rob Herring wrote:
> > > > > On Mon, Mar 28, 2022 at 12:18 PM Krzysztof Kozlowski
> > > > > <krzysztof.kozlowski@linaro.org> wrote:
> > > > > >
> > > > > > On 28/03/2022 19:16, Vinod Koul wrote:
> > > > > > > On 28-03-22, 19:43, Dmitry Baryshkov wrote:
> > > > > > >> On Mon, 28 Mar 2022 at 18:30, Krzysztof Kozlowski
> > > > > > >> <krzysztof.kozlowski@linaro.org> wrote:
> > > > > > >>>
> > > > > > >>> The DSI node is not a bus and the children do not have unit addresses.
> > > > > > >>>
> > > > > > >>> Reported-by: Vinod Koul <vkoul@kernel.org>
> > > > > > >>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > > > > > >>
> > > > > > >> NAK.
> > > > > > >> DSI panels are children of the DSI device tree node with the reg = <0>; address.
> > > > > > >> This is the convention used by other platforms too (see e.g.
> > > > > > >> arch/arm64/boot/dts/freescale/imx8mq-evk.dts).
> > > > > > >
> > > > > > > So we should add reg = 0, i will update my dtsi fix
> > > > > > >
> > > > > >
> > > > > > To "ports" node? No. The reg=0 is for children of the bus, so the
> > > > > > panels. How to combine both without warnings - ports and panel@0 - I
> > > > > > don't know yet...
> > > > >
> > > > > I don't think that should case a warning. Or at least it's one we turn off.
> > > >
> > > > Well in this case I think we might need a fix:
> > > > Here is the example quoted in the binding. We have ports{} and then the
> > > > two port@0 and port@1 underneath.
> > >
> > > It's the #address-cells/#size-cells under 'ports' that applies to 'port'
> > > nodes. As 'ports' has no address (reg) itself, it doesn't need
> > > #address-cells/#size-cells in its parent node.
> > >
> > > >
> > > > So it should be okay to drop #address-cells/#size-cells from dsi node
> > > > but keep in ports node...
> > >
> > > Yes.
> > >
> > > > Thoughts...?
> > >
> > > But I thought a panel@0 node was being added? If so then you need to add
> > > them back.
> >
> > I guess we should make this optional, keep it when adding panel@0 node
> > and skip for rest where not applicable..? Dmitry is that fine with you?
>
> This sounds like a workaround. When a panel node is added together
> with the '#address-cells' / '#size-cells' properties, we will get
> warnings for the 'ports' node.

What warning exactly? Is that with W=1?

Some warnings are more "don't do this on new designs" rather than
never allowed and need to fix current bindings/dts. As such, these
warnings will probably never be enabled by default.

Rob
