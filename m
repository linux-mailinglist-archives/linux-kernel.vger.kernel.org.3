Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A93704FFAAB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 17:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236695AbiDMPxh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 11:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233622AbiDMPxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 11:53:35 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ED5C41F8E
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 08:51:12 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id a21so2350528pfv.10
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 08:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ktdcJE0+30gvr9r7EYxc/n6a/sk6R5sRkRDY4FumPA0=;
        b=X6jodKKqi2fJU3vHm3zdbwDCLEhgSwBGbqJ2kgbtRcm1DAWRnnQwgqFSn1ZsMWOOgp
         MiSqkAlq4iH/UtPSnMCOs8X52JJSq7K7vcibK936ZPUbBoBXyXou0osGJjRCCLO30b9C
         M0gqvNvKfP8Yk61wYL2ow02+TBqlavbevFaso=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ktdcJE0+30gvr9r7EYxc/n6a/sk6R5sRkRDY4FumPA0=;
        b=4U8P43fQZM8nOZr12PLdiXY2PoFGy/QxnLmh9wMyh0DOcPVbBS1HPKI9RWt2mVEbzx
         toYbxl81Fu2u61Fe7VGV9NiqRLERCxuo+fyd9G28smG2t3AjicBBTjVCNVUoYnq0mlON
         jKckkVGukXTpQjvhT2ZwcWDRE7t3YPC5dgdKL5rd+kD8dEThytwZ3Pgh0BjoRPLi6cvo
         nawbSH6ADzi935h8RjbaCE4d7B1hJe8MJG6WtQ7UVSxFfNl8iK4a8uGAXwSECJT154l7
         GvQrN2IwJ5jgmdJ5oDw8ZhzS6o+aejO+17BNymiXJBr72htZ9p0MP+sjM9s9WRfF6Bnn
         D52w==
X-Gm-Message-State: AOAM532f45PqVE3C9zhOgUBpCH3+t2VXaA2f58XOT5DtHwBcgpwRF/9R
        MZMiFudv1+OQlIh4pvBACgHSGA==
X-Google-Smtp-Source: ABdhPJxJGwhh1/pIKBHVTqjXPi34hfWoRdia57+tIETxWGWgBmKGnYJKD7OizWDi9oaN68IVYIgNjw==
X-Received: by 2002:a65:6753:0:b0:385:fa8a:188f with SMTP id c19-20020a656753000000b00385fa8a188fmr36059244pgu.499.1649865071928;
        Wed, 13 Apr 2022 08:51:11 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:6a4f:9277:743f:c648])
        by smtp.gmail.com with UTF8SMTPSA id v16-20020aa78090000000b0050583cb0adbsm18658298pff.196.2022.04.13.08.51.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Apr 2022 08:51:11 -0700 (PDT)
Date:   Wed, 13 Apr 2022 08:51:08 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_rohkumar@quicinc.com,
        srinivas.kandagatla@linaro.org, dianders@chromium.org,
        swboyd@chromium.org, judyhsiao@chromium.org,
        Venkata Prasad Potturu <quic_potturu@quicinc.com>
Subject: Re: [PATCH v7 2/2] arm64: dts: qcom: sc7280: add lpass lpi pin
 controller node
Message-ID: <YlbxbDaQRjbC+y1G@google.com>
References: <1649685184-8448-1-git-send-email-quic_srivasam@quicinc.com>
 <1649685184-8448-3-git-send-email-quic_srivasam@quicinc.com>
 <YlSCWC47tITuW/BZ@google.com>
 <9bacee6d-ab44-2975-c523-38164d016af5@quicinc.com>
 <be8c6dae-20b1-3ba1-db3f-119da1e4ebfe@quicinc.com>
 <YlYSe5/wm06oTJej@google.com>
 <478125e6-7b8f-a69d-4ffb-00344611229d@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <478125e6-7b8f-a69d-4ffb-00344611229d@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2022 at 08:12:20PM +0530, Srinivasa Rao Mandadapu wrote:
> 
> On 4/13/2022 5:29 AM, Matthias Kaehlcke wrote:
> Thanks for your time and valuable suggestions Matthias!!!
> > On Tue, Apr 12, 2022 at 06:41:25PM +0530, Srinivasa Rao Mandadapu wrote:
> > > On 4/12/2022 6:18 PM, Srinivasa Rao Mandadapu wrote:
> > > > On 4/12/2022 1:02 AM, Matthias Kaehlcke wrote:
> > > > Thanks for your time Matthias!!!
> > > > > On Mon, Apr 11, 2022 at 07:23:04PM +0530, Srinivasa Rao Mandadapu wrote:
> > > > > > Add LPASS LPI pinctrl node required for Audio functionality on sc7280
> > > > > > based platforms.
> > > > > > 
> > > > > > Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> > > > > > Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> > > > > > Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> > > > > > ---
> > > > > >    arch/arm64/boot/dts/qcom/sc7280-idp.dtsi |  84
> > > > > > ++++++++++++++++++++++++
> > > > > >    arch/arm64/boot/dts/qcom/sc7280.dtsi     | 107
> > > > > > +++++++++++++++++++++++++++++++
> > > > > >    2 files changed, 191 insertions(+)
> > > > > > 
> > > > > > diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> > > > > > b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> > > > > > index 4ba2274..ea751dc 100644
> > > > > > --- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> > > > > > +++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> > > > > > @@ -238,6 +238,90 @@
> > > > > >        modem-init;
> > > > > >    };
> > > > > >    +&dmic01 {
> > > > > Shouldn't these nodes be in the PINCTRL section at their respective
> > > > > positions in alphabetical order?
> > > > These are not part of tlmm pin control section. These are part of
> > > > lpass_tlmm section.
> > > > 
> > > > In your previous comment you asked to remove &lpass_tlmm. Hence brought
> > > > out.
> > > > 
> > > > > nit: since you are keeping the groups the group names are a bit
> > > > > generic IMO.
> > > > > e.g. it is fairly obvious that 'dmic01_clk' refers to a clock pin,
> > > > > however
> > > > > just 'dmic01' is a bit vague. You could consider adding the prefix
> > > > > 'lpass_'
> > > > > to the group names for more clarity.
> > > > as dmic01 has both clk and data section, I don't think keeping clk is
> > > > appropriate here.
> > > As these nodes are part of SC7280, i.e. qcom specific chipset, I feel lpass_
> > > is redundant.
> > It helps to provide some context about the pins which might not be evident
> > from their short names like 'dmic01' or 'rx_swr'. A nice side effect is that
> > the pins/groups would grouped automatically together in alphabetic ordering.
> > 
> > In terms of 'redundancy' it is similar to 'qup_' prefix for the I2C/SPI/UART
> > pins.
> Agree. Will change accordingly. similarly will append lpass_ torx/tx/va mcro
> device node names.
> > 
> > > If we add lpass_ to all dmic nodes, some node names are too lengthy.
> > The longest would be like 'lpass_dmic01_sleep' or 'lpass_rx_swr_sleep', which
> > doesn't seem outrageous.
> > 
> > In any case it's not super important. If it bothers someone enough later
> > on they can always send a patch that changes it.
> Okay.

I meant to say whether you change it or not is not super important, it's up
to you :)
