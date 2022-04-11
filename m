Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31F944FC553
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 21:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349745AbiDKTz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 15:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349743AbiDKTzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 15:55:54 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 955FD36E0B
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 12:53:36 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id a21so586491pfv.10
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 12:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HQW6p5XHkDmFdXcFFMAKSTMR7c12bQrCmTxneppa4IY=;
        b=XvKXaBY0+FG1tmG2ZLkX8lj/1RrGPbuWStt06IKqgUgYXG7WbsoyWzr/CPktw6vaSt
         9u8QllcxrheruT/2xpSBgn5YwZTJCIq6Er+X7a0dVcaWxTy7gOiWb/kZsyeqW6kXI4XK
         g4M4l8yBaZLKP85vov6kQkDBpdgna/tx6D9HQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HQW6p5XHkDmFdXcFFMAKSTMR7c12bQrCmTxneppa4IY=;
        b=n3mC9w6K3ibBoHrQ8UzwwHTpus7JGktasd1XgaQh69NPehz/Kp90t0/uxrsqIsBHZt
         bPriYsP51eaNEBstsrxboFVgSFAQO/hj0/cjvbzXGxMgJRPx4h0rt05ggEURCewUyhsc
         06HIM4LzlZp1zjGebwLg5GZGgvBtlD+YAroaDGRoRsvErUeUIv05Th4YOefVTGxHEBHt
         J9Y/7zVa2MrfaVM633ugtdadPjK5JwxboQFnwkomOWDzArudO3LacsMYGQQ6GlpnGQKE
         K8jJ2tnU19ghBx1p6smo+eYJgENJYUbW7sdYAZRN+M834K5HXtwuyQik9va7QdUlcVIT
         Y18Q==
X-Gm-Message-State: AOAM531aJ2I5TvuuFsVYbrqgeWKWYZ659pBnT2B/Eus7GxPlEl/zZ7/K
        /CLxeJzHe0XWWTEPzB5foVy6HA==
X-Google-Smtp-Source: ABdhPJy46Nb67XtLDVVS/w6pd6omc5Ct5ml3k8IojyyCxOY1LCYD4hjqOd6yvjcWEYJbLnmUIjJs1A==
X-Received: by 2002:a65:614e:0:b0:380:bfd9:d4ea with SMTP id o14-20020a65614e000000b00380bfd9d4eamr27582317pgv.92.1649706816054;
        Mon, 11 Apr 2022 12:53:36 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:eb96:76ba:e2a1:2442])
        by smtp.gmail.com with UTF8SMTPSA id nv11-20020a17090b1b4b00b001c71b0bf18bsm292189pjb.11.2022.04.11.12.53.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Apr 2022 12:53:35 -0700 (PDT)
Date:   Mon, 11 Apr 2022 12:53:33 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, srinivas.kandagatla@linaro.org,
        dianders@chromium.org, swboyd@chromium.org, judyhsiao@chromium.org,
        Venkata Prasad Potturu <quic_potturu@quicinc.com>,
        quic_rohkumar@quicinc.com
Subject: Re: [PATCH v6 1/3] arm64: dts: qcom: sc7280: Add nodes for va tx and
 rx macros and external codecs
Message-ID: <YlSHPU7XITS2dju/@google.com>
References: <1649157220-29304-1-git-send-email-quic_srivasam@quicinc.com>
 <1649157220-29304-2-git-send-email-quic_srivasam@quicinc.com>
 <Yky2Iwt+tvxvu4/S@google.com>
 <8fea1165-c8b6-6ce2-86dc-82274af8c43d@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8fea1165-c8b6-6ce2-86dc-82274af8c43d@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 11, 2022 at 07:32:33PM +0530, Srinivasa Rao Mandadapu wrote:
> 
> On 4/6/2022 3:05 AM, Matthias Kaehlcke wrote:
> Thanks for your time Matthias!!!
> > On Tue, Apr 05, 2022 at 04:43:38PM +0530, Srinivasa Rao Mandadapu wrote:
> > > SC7280 has VA, TX and RX macros with SoundWire Controllers to attach with
> > > codecs like WCD938x, max98360a using soundwire masters and i2s bus.
> > > Add these nodes for sc7280 based platforms audio use case.
> > > Add tlmm gpio property in wcd938x node for switching CTIA/OMTP Headset.
> > > 
> > > Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> > > Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> > > Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> > > ---
> > A change log would be helpful for reviewers
> Change log added in cover letter.

From my perspective as a reviewer I find it more practical to have a
change log per patch.

> > > diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
> > > index de646d9..c6a04c3 100644
> > > --- a/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
> > > +++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
> > > @@ -20,6 +20,14 @@
> > >   #include "sc7280-chrome-common.dtsi"
> > >   / {
> > > +	max98360a: audio-codec-0 {
> > > +		compatible = "maxim,max98360a";
> > > +		pinctrl-names = "default";
> > > +		pinctrl-0 = <&amp_en>;
> > > +		sdmode-gpios = <&tlmm 63 GPIO_ACTIVE_HIGH>;
> > > +		#sound-dai-cells = <0>;
> > > +	};
> > > +
> > This node shouldn't be at top but with the other device nodes, in
> > alphabetical order, i.e. before 'pwmleds'.
> 
> Actually we are sorting as per node name. Hence kept it here. As per
> previous reviewer comments, sorted accordingly.
> 
> Please suggest better approach.

True, I forgot the node names are used for sorting, not the labels.

> > > diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> > > index db74fc3..78ec84c 100644
> > > --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> > > +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> > > @@ -822,6 +822,127 @@
> > >   			#power-domain-cells = <1>;
> > >   		};
> > > +		rxmacro: codec@3200000 {
> > These node are not at the correct position. They should be sorted by
> > address and hence be inserted between 'lpasscc@3000000' and
> > 'interconnect@3c40000'.
> 
> Actually we are sorting as per node(codec) name. Hence kept it here. As per
> previous reviewer comments, sorted accordingly.

Could you provide a pointer to those comments?

My understanding is that we are sorting by node name when nodes don't have
addresses or for overrides in board files/snippets, however the nodes under
'soc@0' are sorted by address.

Another nit: 'rx_macro, tx_macro, va_macro' instead of the labels without
underscore? Not really important, but maybe slightly more readable and
would match the 'spelling' of the compatible strings.
