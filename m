Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3E7D5AE95F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 15:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239599AbiIFNU2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 09:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240434AbiIFNUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 09:20:10 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D6526FA0F;
        Tue,  6 Sep 2022 06:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662470405; x=1694006405;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0poroha2pRJ/QnwPxU4fazv8nwog0d9tBFn8gBHmv00=;
  b=AfDeZO6Fslvjc+pcSHdUWVWNb5T0lMXxmy1rlIKzcddM3KVY+mmkSMfE
   sIlCcs0i9rOvtxw3BYexE4qszv+OV15u9hrSx509k/jCXxgOnAnj56lbm
   CVGY9ObiQSJHcH9VRj7JymIxw2K/tLJTo6y+0coidi551GcDex2hH6Z01
   qHUdTnzqpTATDl47SUP18BsZDV1oxIHhFtsNohw10+KDcmrz7ZaGtGtss
   GuAgBnZjwtmjBNCAbcsKNSpttNUFkRmcoAD70IDLD+MT2uuv4Yszv+GCh
   PeJTl7V2cEAFz3/6zn3/izggTS0s0Hy2tw312C9DjB9SLaVq9faBdeeL3
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="360538043"
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="360538043"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 06:20:03 -0700
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="565089710"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 06:20:01 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1oVYUg-0098Ft-0R;
        Tue, 06 Sep 2022 16:19:58 +0300
Date:   Tue, 6 Sep 2022 16:19:57 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Martyn Welch <martyn.welch@collabora.co.uk>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Martyn Welch <martyn.welch@collabora.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/5] dt-bindings: gpio: pca95xx: add entry for
 pcal6534 and PI4IOE5V6534Q
Message-ID: <YxdI/TLBrzJP3RKi@smile.fi.intel.com>
References: <20220906082820.4030401-1-martyn.welch@collabora.co.uk>
 <20220906082820.4030401-2-martyn.welch@collabora.co.uk>
 <Yxc6zptiJEf2TzP5@smile.fi.intel.com>
 <CACRpkdZHKEW+WJAdCCf2DN7gN+ZM7pFpeSXfccB508N4=-LkoQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdZHKEW+WJAdCCf2DN7gN+ZM7pFpeSXfccB508N4=-LkoQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 06, 2022 at 03:08:00PM +0200, Linus Walleij wrote:
> On Tue, Sep 6, 2022 at 2:19 PM Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
> > On Tue, Sep 06, 2022 at 09:28:16AM +0100, Martyn Welch wrote:
> > > From: Martyn Welch <martyn.welch@collabora.com>
> > >
> > > The NXP PCAL6534 is a 34-bit I2C I/O expander similar to the PCAL6524. The
> > > Diodes PI4IOE5V6534Q is a functionally identical chip provided by Diodes
> > > Inc.
> >
> > ...
> >
> > > +    oneOf:
> > > +      - items:
> > > +        - const: diodes,pi4ioe5v6534q
> > > +        - const: nxp,pcal6534
> >
> > ^^^
> >
> > > +      - items:
> > > +        - enum:
> >
> > > +          - nxp,pcal6534
> >
> > ^^^
> >
> > Not sure why is this dup?
> 
> No that is how DT compatibles work. One version of the component,
> bought from NXP will look like this:
> 
> compatible = "nxp,pcal6534";
> 
> Another version bought from diodes will look like this:
> 
> compatible = "diodes,pi4ioe5v6534q", "nxp,pcal6534";
> 
> Then the drivers are probed matching from left to right,
> with the "most compatible" matching first.
> 
> This also answers your question on the implementation.

Then I don't understand why the const list above is only for new chips
and not for the old one where the same can be applied.

Mysterious ways of DT...

-- 
With Best Regards,
Andy Shevchenko


