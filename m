Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E6E45AED55
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 16:31:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241861AbiIFObE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 10:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241340AbiIFOaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 10:30:00 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA53F93526;
        Tue,  6 Sep 2022 06:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662472569; x=1694008569;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=d9B85ofz+viBJy76Mzjwvk1LEpgb+PU3N1e8G7iPrHs=;
  b=Ogwf/dwYyeYl4KHhAoHk0PLkGLUP+h4cgfb9gBojvSGIcY6ZXGTXywtv
   qID1qKe8fGVbFxi2QCW09jz8xKaSrBlX9FZSvdXwU/baiw4E3fYziQWNF
   GEa4sU6SGHYWHnywf+3hTs8L9ar48AV0nL2a0a1UUWlN4hUVAFTsTIu01
   YhvyP8YiLcegN/bNbFji9yyKoC3qAVRNoYCJaXNdglx8JolzTHdNIgdzh
   eA2fpv9bCHW9iV04ZagHptmZF8d9yyGejX/NuEYyqj+M8JruqDJgEs2f2
   uLN9WN7nqT8tkLWfGjZbAVQgs01LRJadilGOHXHyNV/wUtFysjfP0YYxn
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="276335082"
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="276335082"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 06:53:09 -0700
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="647235077"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 06:53:06 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1oVZ0h-0098vZ-2g;
        Tue, 06 Sep 2022 16:53:03 +0300
Date:   Tue, 6 Sep 2022 16:53:03 +0300
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
Message-ID: <YxdQv99FoFNx+11c@smile.fi.intel.com>
References: <20220906082820.4030401-1-martyn.welch@collabora.co.uk>
 <20220906082820.4030401-2-martyn.welch@collabora.co.uk>
 <Yxc6zptiJEf2TzP5@smile.fi.intel.com>
 <CACRpkdZHKEW+WJAdCCf2DN7gN+ZM7pFpeSXfccB508N4=-LkoQ@mail.gmail.com>
 <YxdI/TLBrzJP3RKi@smile.fi.intel.com>
 <CACRpkdaQ+0wbreyCEaoBnjKT0rtgPEnotZQw_Eh=y4xktwrwHQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdaQ+0wbreyCEaoBnjKT0rtgPEnotZQw_Eh=y4xktwrwHQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 06, 2022 at 03:33:34PM +0200, Linus Walleij wrote:
> On Tue, Sep 6, 2022 at 3:20 PM Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
> > On Tue, Sep 06, 2022 at 03:08:00PM +0200, Linus Walleij wrote:
> > > On Tue, Sep 6, 2022 at 2:19 PM Andy Shevchenko
> > > <andriy.shevchenko@intel.com> wrote:
> > > > On Tue, Sep 06, 2022 at 09:28:16AM +0100, Martyn Welch wrote:

...

> > > > > +    oneOf:
> > > > > +      - items:
> > > > > +        - const: diodes,pi4ioe5v6534q
> > > > > +        - const: nxp,pcal6534
> > > >
> > > > ^^^
> > > >
> > > > > +      - items:
> > > > > +        - enum:
> > > >
> > > > > +          - nxp,pcal6534
> > > >
> > > > ^^^
> > > >
> > > > Not sure why is this dup?
> > >
> > > No that is how DT compatibles work. One version of the component,
> > > bought from NXP will look like this:
> > >
> > > compatible = "nxp,pcal6534";
> > >
> > > Another version bought from diodes will look like this:
> > >
> > > compatible = "diodes,pi4ioe5v6534q", "nxp,pcal6534";
> > >
> > > Then the drivers are probed matching from left to right,
> > > with the "most compatible" matching first.
> > >
> > > This also answers your question on the implementation.
> >
> > Then I don't understand why the const list above is only for new chips
> > and not for the old one where the same can be applied.
> 
> That's YAML. It's because the const list is the most compact way
> to express two precise items following after each other, and the enum
> list is an implicit list of single-item const:s, as you cannot enum
> tuples.

This makes a lot of sense, thank you for explaining this. Indeed, now I
understand the absence of Diodes in the code.

> > Mysterious ways of DT...
> 
> It's not DT, it's YAML that is mysterious. DT itself is a pretty
> straight-forward
> grammar, while YAML is a meta-grammar describing the DT grammar
> (ML stands for Meta Language).
> 
> All meta languages are mysterious.

Yeah :-)

-- 
With Best Regards,
Andy Shevchenko


