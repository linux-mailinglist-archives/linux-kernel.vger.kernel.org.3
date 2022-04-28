Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85D53513536
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 15:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347240AbiD1Ngc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 09:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347245AbiD1Nga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 09:36:30 -0400
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B914C36322;
        Thu, 28 Apr 2022 06:33:15 -0700 (PDT)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-deb9295679so5152508fac.6;
        Thu, 28 Apr 2022 06:33:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MkPYC4wT6c/VEzdCj0wFf0XUJgHVgHaxvf4ri5zul6g=;
        b=RcZtELW2TcWDRKSRKXL4rsuZjl//w0sXHcz4x8N1xAf/r5Sgvl6vDlIWOYEUAA/A7e
         EflF8wvwYREF9zLrFJDrsMWH4P105CviJsV6VhoRhneejW+z/f05PCZpWxfLlibiTz+k
         vf26WpkgR4/Ij6XNZ69nZbxmy7Fhrq0O4q8DMcLdkieesv6t/wGSrsnq3D46pnHMENqg
         c840KqJorlw7QHJaH5I4Q4E842DDgZFWI6kRBz1gn5U9CLP8tE4SbRlPZmToFDgKzdx6
         e1D9bcRQMb7i+Eg9t0MB4Y2G/9yHBOS8aggQ7TDi7W/xKZltQ5L38KOGwX+lkFRRGaMA
         Szsg==
X-Gm-Message-State: AOAM533YFPEyRItYvcta+DxKasXsgWamtl46/IRjcbFzBhoZCxi8ew1E
        iWdatBeSqBByqHffkLxzmQ==
X-Google-Smtp-Source: ABdhPJyyg4xxehRJ6S6u/e8qGxKkazJCdf8F+SPH8Hd67CeOr+MmYpGdtq1tiHMic/2BoR0ZYp2jMQ==
X-Received: by 2002:a05:6870:2187:b0:e9:7872:c7f6 with SMTP id l7-20020a056870218700b000e97872c7f6mr4563491oae.257.1651152795039;
        Thu, 28 Apr 2022 06:33:15 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id q22-20020a056870e89600b000e686d13895sm1819310oan.47.2022.04.28.06.33.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 06:33:14 -0700 (PDT)
Received: (nullmailer pid 2104457 invoked by uid 1000);
        Thu, 28 Apr 2022 13:33:13 -0000
Date:   Thu, 28 Apr 2022 08:33:13 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        devicetree@vger.kernel.org, Dinh Nguyen <dinguyen@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Scott Branden <sbranden@broadcom.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        linux-samsung-soc@vger.kernel.org,
        Broadcom Kernel Team <bcm-kernel-feedback-list@broadcom.com>,
        linux-kernel@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Liviu Dudau <liviu.dudau@arm.com>, Ray Jui <rjui@broadcom.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 08/10] ARM: dts: exynos: use proper
 'dma-channels/requests' properties
Message-ID: <YmqXmTau/YbZjrrn@robh.at.kernel.org>
References: <20220427155840.596535-1-krzysztof.kozlowski@linaro.org>
 <CGME20220427160347eucas1p23ce51e0fb49160d437961d98fd682c28@eucas1p2.samsung.com>
 <20220427155840.596535-9-krzysztof.kozlowski@linaro.org>
 <5eeac2a0-4293-675e-9dc2-25ed8ab3fb8f@samsung.com>
 <6981f93a-ef01-6ba0-4451-26526372d666@linaro.org>
 <05c908ce-217f-6938-6745-7405ac39d8ea@samsung.com>
 <1399774c-f188-81f1-4d15-367b9d0e4a59@linaro.org>
 <99c80fb6-c6cc-9370-b93d-ed736c7f2192@samsung.com>
 <813bd5f2-38b6-9642-6993-94ad78f5c08a@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <813bd5f2-38b6-9642-6993-94ad78f5c08a@linaro.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2022 at 12:09:02PM +0200, Krzysztof Kozlowski wrote:
> On 28/04/2022 12:05, Marek Szyprowski wrote:
> >>>>> I also don't see any code that would read those properties. IMHO they
> >>>>> should be simply removed at all, at least for the PL330 related nodes.
> >>>> In current Linux implementation they indeed are not used. Nothing parses
> >>>> them. However:
> >>>> 1. They describe (hopefully correct) the hardware.
> >>>> 2. They might be used by other implementations of pl330 driver.
> >>>>
> >>>> I would not remove them from existing sources, but indeed maybe there is
> >>>> no need to add for new files.
> >>> What's the point in having dt properties duplicating data that might be
> >>> read from the driver registers?
> >> Hm, indeed, there is no point in this. Since they are read from
> >> registers, what was the idea behind in commit 42cf20980cde?
> > 
> > #dma-cells is indeed required, but the rest seems to be the cargo-cult 
> > of some kind.
> 
> Rob,
> 
> Any guidance from your side? Is there any benefit in describing the
> hadrware (dma-channels/dma-requests) if the same value can be read from
> registers?

Drop the properties. They should only be an override if ever needed.

Rob
