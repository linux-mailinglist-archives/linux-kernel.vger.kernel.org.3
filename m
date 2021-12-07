Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1528646BE4F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 15:54:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238300AbhLGO6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 09:58:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238289AbhLGO6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 09:58:23 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99F32C061748
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 06:54:53 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id i5-20020a05683033e500b0057a369ac614so18344720otu.10
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 06:54:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YDnXzaIjA0B+oe/SZBP1rR8TVXnlVHcIKBm5X/ow/c8=;
        b=TF05PyjsBqxmiBptnFtNclQ++tzEa/1hGdB6cVF1nxsE8SlCyx69D4dh89V/wvdGdk
         kKeiEMF/Hah9C8axROromNduAnMZoSWfbKXTVD+hHtG5OP0XLCmu0Mzr9LZxjRHSW+W6
         uimB4JUaFb71L14tIxp6R+DPW7qAmc3Vu6yysVnFw6AnNdrVSEt8gWJAwN5hJCGMe7S9
         4HWOMcDW/gclcknppNeFx9MaGkMZRBAUBTZSa97+DdkS4GQ6i5Jmj8MiH9MAo0Q+/6oD
         pRTUo9Oe423ANutC1JPAsdez+LAZlBpcVS13vqDZaeLetCxQqVpv6WcoRMFSt/q264EO
         yU+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YDnXzaIjA0B+oe/SZBP1rR8TVXnlVHcIKBm5X/ow/c8=;
        b=wT4IzEQNXIQN0CaVff6xQU0AdpW/jdI6crpBAd24NmaO0pBRlFQDfGmyEPnLkY3wdK
         StZ6q24JNycWAKF5Kyq83fF3P5VvFC7o4JI8ziCJSJGQWYYBivEWe/ArkAjwcRY12UD4
         tBKCOBmZATdbQu62TKe+ivGupoJZKM3C48OgzdgL/BIwvkanlTME21SFtwDhZNvrkZdw
         qKpzG44Tpt0L1kQ7NKDTswTRWJG7uFjztoIdT0r7zCxPsmsLLNZCpIbSnmcNCaCgYI2A
         c3bJCvRO9l4DuKaNnKkzuTg0OWCPOd0zfCq7hQF/bu+qbQnC6+WMHc70+IDlim7/EpJQ
         0v9w==
X-Gm-Message-State: AOAM530x5iTUAdgEBrQLm/8hnRkViopfBrD8wOUHu/QSxp5k9/G/xzhN
        +9GvKh6NC1vHhOnzbCswCC2GwQ==
X-Google-Smtp-Source: ABdhPJyojwQh5ai4cAsqQce5Fw0CD9rq904xG9yRgAnuclktrY69vn9nOyv7eD8FYwwwfBo80hsT3A==
X-Received: by 2002:a05:6830:1c70:: with SMTP id s16mr35635191otg.59.1638888892976;
        Tue, 07 Dec 2021 06:54:52 -0800 (PST)
Received: from ripper (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id k16sm2816382otp.21.2021.12.07.06.54.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 06:54:52 -0800 (PST)
Date:   Tue, 7 Dec 2021 06:56:17 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/15] arm64: dts: qcom: sm8450-qrd: Add reserved gpio
 range for QRD
Message-ID: <Ya92EdytQOYC7tqR@ripper>
References: <20211201072915.3969178-1-vkoul@kernel.org>
 <20211201072915.3969178-5-vkoul@kernel.org>
 <7449e40f-d8ac-3ee9-c453-163c1310ca9d@somainline.org>
 <Ya2lXXDzN83pYxqn@matsya>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ya2lXXDzN83pYxqn@matsya>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 05 Dec 21:53 PST 2021, Vinod Koul wrote:

> On 01-12-21, 16:07, Konrad Dybcio wrote:
> > 
> > On 01.12.2021 08:29, Vinod Koul wrote:
> > > Some tlmm gpios are reserved, so mark them as such in QRD DTS
> > >
> > > Signed-off-by: Vinod Koul <vkoul@kernel.org>
> > > ---
> > >  arch/arm64/boot/dts/qcom/sm8450-qrd.dts | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > >
> > > diff --git a/arch/arm64/boot/dts/qcom/sm8450-qrd.dts b/arch/arm64/boot/dts/qcom/sm8450-qrd.dts
> > > index 127d32502555..8dcd41c4e5ab 100644
> > > --- a/arch/arm64/boot/dts/qcom/sm8450-qrd.dts
> > > +++ b/arch/arm64/boot/dts/qcom/sm8450-qrd.dts
> > > @@ -24,6 +24,10 @@ &qupv3_id_0 {
> > >  	status = "okay";
> > >  };
> > >  
> > > +&tlmm {
> > > +	gpio-reserved-ranges = <28 4>, <36 4>;
> > > +};
> > > +
> > >  &uart7 {
> > >  	status = "okay";
> > >  };
> > >
> > Personally I'd squash this into the patch that introduced the DT and
> 
> I feel it is the right things to do, a patch should not touch a
> different file. soc dts and board dts and two different entities and
> should be patched separately!
> 

You could introduce the qrd.dts slightly later in the series and squash
this in there.

Regards,
Bjorn

> > move it to the end of the series, but I reckon it's fine either way..
> > 
> > 
> > Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> 
> Thanks for the detailed review.
> 
> -- 
> ~Vinod
