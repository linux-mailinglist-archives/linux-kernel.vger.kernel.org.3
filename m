Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D19345AEE87
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 17:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236506AbiIFPVQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 11:21:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234077AbiIFPUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 11:20:48 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A65D882775;
        Tue,  6 Sep 2022 07:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662474755; x=1694010755;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=qG3Bej6hJ4TQz0puewsLzsIK+e7tE5X81aIMQEWh8IQ=;
  b=cKT1WNwzzVMJLLUnrtCsTylCOS6ge4fnkIvMtopIHGL3jvCHPmCXN/9I
   IMcR8j2P2aZkzDrUPGFWrpmHzQrEmPYgFuhLebVqIZmUG2ItSr0S42jvL
   2v5/pVHWmjnVLFNfSeHU20mmPTi+oQlHEQpmzEZYEaut2nBLT+9gCE14n
   mJNtrlRpP+Vn6rSkOttLGUAQmQxBcyj425BinQts7KbVOxDRa2COwbTYZ
   cujstG+TtVvRO6QBfA73t5mJXus03985037HiFhrGUBU97nuTjLE9+PZ2
   YnID+nwQwx2HiAcH1WVcSvlk7hDjN+mplM9PwH3yMSOxQVQBMA7+6vP6/
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="360555613"
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="360555613"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 07:31:28 -0700
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="647247933"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 07:31:25 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1oVZbm-0099jt-1o;
        Tue, 06 Sep 2022 17:31:22 +0300
Date:   Tue, 6 Sep 2022 17:31:22 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Martyn Welch <martyn.welch@collabora.co.uk>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Martyn Welch <martyn.welch@collabora.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/5] dt-bindings: gpio: pca95xx: add entry for
 pcal6534 and PI4IOE5V6534Q
Message-ID: <YxdZunqeEnozlQSO@smile.fi.intel.com>
References: <20220906082820.4030401-1-martyn.welch@collabora.co.uk>
 <20220906082820.4030401-2-martyn.welch@collabora.co.uk>
 <Yxc6zptiJEf2TzP5@smile.fi.intel.com>
 <CACRpkdZHKEW+WJAdCCf2DN7gN+ZM7pFpeSXfccB508N4=-LkoQ@mail.gmail.com>
 <YxdI/TLBrzJP3RKi@smile.fi.intel.com>
 <CACRpkdaQ+0wbreyCEaoBnjKT0rtgPEnotZQw_Eh=y4xktwrwHQ@mail.gmail.com>
 <CAL_JsqJru+ajo4zqsAHeXUsvGDE_S0k3H7q4d3PvCYV4Qexa_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_JsqJru+ajo4zqsAHeXUsvGDE_S0k3H7q4d3PvCYV4Qexa_w@mail.gmail.com>
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

On Tue, Sep 06, 2022 at 09:19:52AM -0500, Rob Herring wrote:
> On Tue, Sep 6, 2022 at 8:33 AM Linus Walleij <linus.walleij@linaro.org> wrote:
> > On Tue, Sep 6, 2022 at 3:20 PM Andy Shevchenko
> > <andriy.shevchenko@intel.com> wrote:
> > > On Tue, Sep 06, 2022 at 03:08:00PM +0200, Linus Walleij wrote:

...

> > > Mysterious ways of DT...
> >
> > It's not DT, it's YAML that is mysterious. DT itself is a pretty
> > straight-forward
> > grammar, while YAML is a meta-grammar describing the DT grammar
> 
> Not YAML, but json-schema is the grammar. YAML is just the file format
> and it's a JSON compatible subset of YAML (no anchors, refs, tags).
> 
> > (ML stands for Meta Language).
> 
> Huh? yaml.org says: YAML Ain't Markup Language™

But Markup != Meta :-)

-- 
With Best Regards,
Andy Shevchenko


