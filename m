Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E3F74FEB9A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 01:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbiDLXtM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 19:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231447AbiDLXs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 19:48:58 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AAE913E08
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 16:44:00 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 125so113767pgc.11
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 16:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VU9lamI5SC1v1PEkHOXanlr6Bu5BMP3jBswdNfiKvIQ=;
        b=NM7LQJaUFLfZJuurMa99JDAcodT6/NkyxUNSaCP4tMIQ/62Y0Sx5IhV8eE61wE51cG
         0ZvWfb+hv4tq3A+3o0ppm5eLCGH3NIWKNL3uHrjEuD7i3GSgcEHeuDQsvLKZBsdnC9D4
         aTTBptwt8A3GdOWNLnCuZ23PLnOpSt2m/S7n4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VU9lamI5SC1v1PEkHOXanlr6Bu5BMP3jBswdNfiKvIQ=;
        b=Rm0/i8/wXwMTeD5CpZmcMJQgTImO+7axH6w/encyCCGMCzwH3v2Vrq+VuuQI0CaB+L
         bxynTzXHSxqtG3BA4Gv5sNpf3ZZ+CPKi56IaO0G5ueBCbZSt5PomDY8vIRUm5pNFKsde
         neFFEUuAVXf7+zmOOmpGUOHtjGMTWb3U8g/BseI4icIaQrCCiJ0rn/YWzstEsDdZZ0z6
         L1jPOsqaOwAl28AWdiL3jOq+k/sno0xIyxq0Urin2UH19XW0Pqqxa+21+xJZ4xr0bgcy
         UjiInu4UM2+1JKOdejCltxIMw5DuY/Od3vx301Uhm3mcYzycEE8MiSrYFkG6GG6IYghV
         LsMw==
X-Gm-Message-State: AOAM530yOa4YTJrPk4XmCBQTdnC03niJeIp6GN9Rp8FM65ekN2JJOVwn
        y/WFsuoaIyQ1g1LmK4yPTahO+A==
X-Google-Smtp-Source: ABdhPJxNXKAaV4IqGlohWzqhZmvrIFVjMoymPiM1ubqd8P9LQ4+qOPnOC3+57Gry/tXWIjUz340EBw==
X-Received: by 2002:a05:6a00:a15:b0:4fb:4112:870e with SMTP id p21-20020a056a000a1500b004fb4112870emr40298678pfh.11.1649807039988;
        Tue, 12 Apr 2022 16:43:59 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:3a41:5079:6f1b:397c])
        by smtp.gmail.com with UTF8SMTPSA id b12-20020a17090aa58c00b001ca977b49d5sm618740pjq.31.2022.04.12.16.43.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Apr 2022 16:43:59 -0700 (PDT)
Date:   Tue, 12 Apr 2022 16:43:57 -0700
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
Message-ID: <YlYOvf71AZxXPSAL@google.com>
References: <1649685184-8448-1-git-send-email-quic_srivasam@quicinc.com>
 <1649685184-8448-3-git-send-email-quic_srivasam@quicinc.com>
 <YlSCWC47tITuW/BZ@google.com>
 <9bacee6d-ab44-2975-c523-38164d016af5@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9bacee6d-ab44-2975-c523-38164d016af5@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 12, 2022 at 06:18:33PM +0530, Srinivasa Rao Mandadapu wrote:
> 
> On 4/12/2022 1:02 AM, Matthias Kaehlcke wrote:
> Thanks for your time Matthias!!!
> > On Mon, Apr 11, 2022 at 07:23:04PM +0530, Srinivasa Rao Mandadapu wrote:
> > > Add LPASS LPI pinctrl node required for Audio functionality on sc7280
> > > based platforms.
> > > 
> > > Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> > > Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> > > Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> > > ---
> > >   arch/arm64/boot/dts/qcom/sc7280-idp.dtsi |  84 ++++++++++++++++++++++++
> > >   arch/arm64/boot/dts/qcom/sc7280.dtsi     | 107 +++++++++++++++++++++++++++++++
> > >   2 files changed, 191 insertions(+)
> > > 
> > > diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> > > index 4ba2274..ea751dc 100644
> > > --- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> > > +++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> > > @@ -238,6 +238,90 @@
> > >   	modem-init;
> > >   };
> > > +&dmic01 {
> > Shouldn't these nodes be in the PINCTRL section at their respective
> > positions in alphabetical order?
> 
> These are not part of tlmm pin control section. These are part of lpass_tlmm
> section.

Agreed, these shouldn't be in the tlmm section, but it still seems nice to
separate them from device nodes.

Some sc7180-trogdor devices have a section like this:

/* PINCTRL - modifications to sc7180-trogdor.dtsi */

In any case I don't care too much about the IDP, but this might come up again
for sc7280-herobrine boards.

> In your previous comment you asked to remove &lpass_tlmm. Hence brought out.
> 
> > 
> > nit: since you are keeping the groups the group names are a bit generic IMO.
> > e.g. it is fairly obvious that 'dmic01_clk' refers to a clock pin, however
> > just 'dmic01' is a bit vague. You could consider adding the prefix 'lpass_'
> > to the group names for more clarity.
> as dmic01 has both clk and data section, I don't think keeping clk is
> appropriate here.

Agreed, _clk isn't appropriate as long as it's a group of pins, that would be
for a label per pin.

> >  From the schematics I interpret that the LPASS GPIOs 0-9 are mapped to the
> > SC7280 GPIOs 144-153. Is that correct?
> Yes. But we refer with GPIOs 0-9 in driver.

Thanks, just wanted to make sure my understanding is correct.
