Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A87DF4C3F38
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 08:45:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238229AbiBYHoy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 02:44:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238214AbiBYHow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 02:44:52 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE5052272E3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 23:44:20 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id 132so3930606pga.5
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 23:44:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pebQAfXF6XweYjs0eGI3bFR9spMrRG1FqYYUkNhfn+E=;
        b=Kl/dwA7J9l0gxrWs8kMoBqr+lcMx8XxtSxViisuumNbHcyG2PUWuPy3+a5v+k4wPxW
         Hv0eHcxH9z1uv+5779eWO9UV65SXJflq3eRoH531R/3kG35qboZIhDdFJhvGkg5hh+Rw
         oMYmH/tYn66ot8W98dH0/liRAWSshqbU7RjtWMIcg7vQDIB5zlDRsLYwJJpVSvE65WH2
         /BqanM+9joXU9QGK6FPHIIOBtuw2CqmFaWdT36d/R3FEt45+8uLFzltsKshoQ3ofxO+o
         sXAfLGSrU79VemMHEXTCZVyYq6CSWkZRQdUZtFY/pWonsuew09I1qG3gb5k8MD3rwUoa
         WYNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pebQAfXF6XweYjs0eGI3bFR9spMrRG1FqYYUkNhfn+E=;
        b=yxQD/mblKpnA2QJPSD+55dcDINUNiRW6FXISdPDaqLxECgWhMVuXI1oMXPiU2szP9E
         nRoEhvkzcftvHb+2sacPZ3yxTGKPhhEAeoh+QxjrVA7dQUrykNZHzCr5K9GSiS3nmSg2
         K7iOWCFPBYj3GDu63gfB5QKJ1qwFQvV+wxcyipoZ0JXW6M0IZJ76jbwipHC9FAlR0uKZ
         WZsClS9JY+QC2cJAFd4WX6qXQNfXWFi7D0Y/WfOT0w7MVryQKvaWcM79MDLfEpnCxr03
         N+huGbJj7AjOxAed/8fkO7Bvojjhch7tMXBIMUTq1WjWwQG784dAjTxZWocXyWaWWuhi
         APrw==
X-Gm-Message-State: AOAM530gUIvxjfukIcBSnIFVWm6hQf7Q1x0zEuWYB60B9FI+vvEhqzvZ
        Avw4/oitXIwwHcK5eAue8sa4
X-Google-Smtp-Source: ABdhPJysLEw5Fe2Qq+cY1LBZd0c6mBCnomaQ6NxvOIVAGyd6cEKU6O+Dheso6fSjReAysM8+HH2yIA==
X-Received: by 2002:a63:ba5e:0:b0:372:9bb2:c12d with SMTP id l30-20020a63ba5e000000b003729bb2c12dmr5253196pgu.380.1645775060237;
        Thu, 24 Feb 2022 23:44:20 -0800 (PST)
Received: from thinkpad ([220.158.159.240])
        by smtp.gmail.com with ESMTPSA id nn17-20020a17090b38d100b001bc5a705fb2sm1480029pjb.26.2022.02.24.23.44.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 23:44:19 -0800 (PST)
Date:   Fri, 25 Feb 2022 13:14:15 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Rohit Agarwal <quic_rohiagar@quicinc.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>, agross@kernel.org,
        robh+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: qcom: Add chosen node information for SDX65.
Message-ID: <20220225074415.GF274289@thinkpad>
References: <1644574845-23248-1-git-send-email-quic_rohiagar@quicinc.com>
 <YhfgAL8z6rO+zU3w@builder.lan>
 <b9205016-1f33-74fd-c314-c307412bfca3@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9205016-1f33-74fd-c314-c307412bfca3@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 25, 2022 at 12:46:26PM +0530, Rohit Agarwal wrote:
> 
> On 2/25/2022 1:14 AM, Bjorn Andersson wrote:
> > On Fri 11 Feb 04:20 CST 2022, Rohit Agarwal wrote:
> > 
> > > Add chosen node in the base dtsi file of SDX65.
> > > 
> > While this happens to be the same on most boards, it is still a
> > board-specific decision which UART is the debug uart, or if there is one
> > at all...
> > 
> > So this property should remain in the dts.
> > 
> > Thanks,
> > Bjorn
> 
> Without the chosen node in base dtsi, the device is not booting up.
> Can we have an empty chosen node in the base dtsi and the board-specific
> details
> updated in the respective dts file. The device boots up with this.
> 

I believe this is something to do with bootloader. But still I don't understand
how this matters at all since the bootloader finally parses the "dtb" only.

Is the bootloader picking up correct dtb?

Thanks,
Mani

> Thanks,
> Rohit
> 
> > > Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
> > > ---
> > >   arch/arm/boot/dts/qcom-sdx65-mtp.dts | 4 ----
> > >   arch/arm/boot/dts/qcom-sdx65.dtsi    | 4 ++++
> > >   2 files changed, 4 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/arch/arm/boot/dts/qcom-sdx65-mtp.dts b/arch/arm/boot/dts/qcom-sdx65-mtp.dts
> > > index 59457da..3a75c21 100644
> > > --- a/arch/arm/boot/dts/qcom-sdx65-mtp.dts
> > > +++ b/arch/arm/boot/dts/qcom-sdx65-mtp.dts
> > > @@ -14,10 +14,6 @@
> > >   	aliases {
> > >   		serial0 = &blsp1_uart3;
> > >   	};
> > > -
> > > -	chosen {
> > > -		stdout-path = "serial0:115200n8";
> > > -	};
> > >   };
> > >   &blsp1_uart3 {
> > > diff --git a/arch/arm/boot/dts/qcom-sdx65.dtsi b/arch/arm/boot/dts/qcom-sdx65.dtsi
> > > index 796641d..653df15 100644
> > > --- a/arch/arm/boot/dts/qcom-sdx65.dtsi
> > > +++ b/arch/arm/boot/dts/qcom-sdx65.dtsi
> > > @@ -17,6 +17,10 @@
> > >   	qcom,msm-id = <458 0x10000>, <483 0x10000>, <509 0x10000>;
> > >   	interrupt-parent = <&intc>;
> > > +	chosen {
> > > +		stdout-path = "serial0:115200n8";
> > > +	};
> > > +
> > >   	memory {
> > >   		device_type = "memory";
> > >   		reg = <0 0>;
> > > -- 
> > > 2.7.4
> > > 
