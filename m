Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6FB0517818
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 22:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387395AbiEBUao (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 16:30:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382969AbiEBUam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 16:30:42 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 842199FE2;
        Mon,  2 May 2022 13:27:12 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id p18so17844740edr.7;
        Mon, 02 May 2022 13:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to;
        bh=OAT/69wtRvffN89vC/NPyLjFTXggz4+XzDvpqQchKZY=;
        b=ZcvUi6TuwK26g91Wj+BvOBvLkRS94l9430HQO9Evx23oGlUQUwiM6EAtJ8xNLHowPI
         mzffkJfkvuli2lMkWMQvt0t2os+zeKmDan94eeKbiMPrd9pkb38RNFZ63UVdP4aGnMNx
         qJhVD6u6kosJmBSKPQS2Fe0/hhrIR483kNVdAoRII7mzG+Y7MbQ4FTn9+cXOxyhZArbK
         ZbBtWI1anOlcbRILbG7LW2IEzQoFdzVve4X1P97neVIhR0s99jZlDnUwFbM7mZYeNVJQ
         +Z93Q4GpFI5wCA9VtGDBg6AZG1qrBbjYA6Zzx92OshkCiJaWyCPk7GFQfY6SB0MfPB0g
         Aubw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=OAT/69wtRvffN89vC/NPyLjFTXggz4+XzDvpqQchKZY=;
        b=8FZXwy6fqqTiAdWVojFu79C7EhX5ecMwslFgsPfz1luUf+mREoHTGnDWZiwRiRRkhH
         A6fORbZbk9JPMemc07dpPc3PAPnZOZAzQYHfGhjsDh4xm165jBxslVST9JDExQ/9aWKF
         V614HV3Pj56nvj3nXqEDe1ARrJCvDAA00SPihta4fIzKmrBvAQ5yKny3M8xV7XbWhgFK
         /4iqwkyaHzjyQ49qNdRASQu17xkG6O6uE816HoDFyStZKP031zNjP5zlEpc7pqZYxdG3
         GSFmqJEpxX/FFog/+PVJoU3uYh+txsONqle+q69GaxiKwZGjtDnamCpv1kdDrSKWIk5G
         B0xQ==
X-Gm-Message-State: AOAM532dqvY1ZY3Vc0Fp0p5DcyiIXPMnuc/K6GLlZK6gU/zdXB2+n9xs
        tkBmFurht6SFnoQMNoiMgTg=
X-Google-Smtp-Source: ABdhPJxODcFVbGH31VOkUTUnzD2LetaTmezsuSwjzyi7qh/PBLv/FTPz30bmyJeVSg8Xe5f/ZplNfg==
X-Received: by 2002:a05:6402:335:b0:425:e3e0:5a90 with SMTP id q21-20020a056402033500b00425e3e05a90mr14497509edw.14.1651523230760;
        Mon, 02 May 2022 13:27:10 -0700 (PDT)
Received: from Ansuel-xps. (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.gmail.com with ESMTPSA id e19-20020a056402105300b0042617ba6384sm7034024edu.14.2022.05.02.13.27.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 13:27:10 -0700 (PDT)
Message-ID: <62703e9e.1c69fb81.23bb7.9395@mx.google.com>
X-Google-Original-Message-ID: <YnA11BpBNqgolvXs@Ansuel-xps.>
Date:   Mon, 2 May 2022 21:49:40 +0200
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH v2 3/3] dt-bindings: arm: msm: Convert kpss-gcc driver
 Documentation to yaml
References: <20220430060125.9124-1-ansuelsmth@gmail.com>
 <20220430060125.9124-4-ansuelsmth@gmail.com>
 <fec305d1-d4b3-3f9d-bc31-bc33490d1ad7@linaro.org>
 <626d4cbf.1c69fb81.e6965.76b4@mx.google.com>
 <0711b822-506b-7b90-6b63-50c5c0ce4f6e@linaro.org>
 <626fb971.1c69fb81.fcab0.5f71@mx.google.com>
 <b3bda9d7-2c50-547d-35ab-510ecab4f7d2@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3bda9d7-2c50-547d-35ab-510ecab4f7d2@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 02, 2022 at 10:18:31PM +0200, Krzysztof Kozlowski wrote:
> On 02/05/2022 12:40, Ansuel Smith wrote:
> > 
> > The idea is that you put the clk name in 'clock-output-names' and the
> > driver needs to have support for it (and set the clk name based on the
> > name defined in the dts)
> > 
> > This driver doesn't have support for it and is actually hardcoded.
> > So you are right and I should just drop it.
> > 
> > But now another question... Since #clock-cells was added as a
> > requirement for clock-output-names, should I drop also that?
> > 
> > In theory #clock-cells should always be declared for clock providers, is
> > it right to add it in the conversion commit or I should put this change
> > in another commit? (since it's now an addition and now something required
> > to fix a bot warning)
> 
> These are not the best bindings to convert, if you are not into the qcom
> DTS and drivers. :)
>

As I said some times ago main problem of these thing is that they are
ancient and they were not in a good state from the start. So it's hard
to fix this in a sane way. (i'm trying tho so sorry for any mess i'm
making in the process)

> It looks like the bindings were added to match current Linux
> implementation and in this implementation the device is not used in DTS
> as a clock provider (even though it registers a clock) but as a syscon.
> I am not even sure if it is used as a clock provider outside of DTS
> (through using a fixed clock name in some clock consumer).
> 
> Probably this should be made either a proper clock controller or
> something stripped down to the point matching current usage (accepting
> the fact that bindings are incomplete). Anyway your choice should be
> made according to how this device and its driver fit to entire system.
> IOW, it's not a simple binding conversion and you should not just
> convert it to make dtbs_check happy.

I wonder if I should just drop this patch from the series and push it
later in another series as a rework directly (with also the other
relevant changes to fix the current problem we have with all the dts).

The intention of this series was to try to push small changes that could
be merged in a short time.

> 
> Best regards,
> Krzysztof

-- 
	Ansuel
