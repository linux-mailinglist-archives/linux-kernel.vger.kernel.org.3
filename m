Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 596345AE7F7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 14:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240162AbiIFMWz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 08:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239876AbiIFMWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 08:22:17 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50F2A63A8;
        Tue,  6 Sep 2022 05:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662466775; x=1694002775;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KQTMsv1yhvhCcEL/EloMGHlPeDQobGkj3xDPxZxwKII=;
  b=Fd96dfQ/B1u+ZsSLreCs45hxy38Dv7AYivSDxi/lEAfERz0J85YMiJMR
   EHTswDFyxVkBj1s8b/zWTPXgyx1qUtVAOc0B6P08AWqIQdDVNSPCnBy4l
   v6ygwwvsstNdvpyZzUYd2iVN1eDp+p1clrLAyWdkBLGCY8iVX7mz/QWvq
   kh7y8MXxEEMhAQH31b/GUNi6c17EYcFrFmhnCWqTRJC5P2ozmzVKhWg1R
   q2IwH9tPhQkpzFlHam+LgGslSjR+Ouk6vXsZUJlf9+MvmCZVXaUghy1d8
   5Sk2HolJ3ypHPHxuQcFWkORcy6iw+hwberUcDKV3OtWXjbJEKglCuDs4E
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10461"; a="276971338"
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="276971338"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 05:19:32 -0700
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="647210389"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 05:19:29 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1oVXY6-0096tg-2T;
        Tue, 06 Sep 2022 15:19:26 +0300
Date:   Tue, 6 Sep 2022 15:19:26 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Martyn Welch <martyn.welch@collabora.co.uk>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Martyn Welch <martyn.welch@collabora.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/5] dt-bindings: gpio: pca95xx: add entry for
 pcal6534 and PI4IOE5V6534Q
Message-ID: <Yxc6zptiJEf2TzP5@smile.fi.intel.com>
References: <20220906082820.4030401-1-martyn.welch@collabora.co.uk>
 <20220906082820.4030401-2-martyn.welch@collabora.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220906082820.4030401-2-martyn.welch@collabora.co.uk>
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

On Tue, Sep 06, 2022 at 09:28:16AM +0100, Martyn Welch wrote:
> From: Martyn Welch <martyn.welch@collabora.com>
> 
> The NXP PCAL6534 is a 34-bit I2C I/O expander similar to the PCAL6524. The
> Diodes PI4IOE5V6534Q is a functionally identical chip provided by Diodes
> Inc.

...

> +    oneOf:
> +      - items:
> +        - const: diodes,pi4ioe5v6534q
> +        - const: nxp,pcal6534

^^^

> +      - items:
> +        - enum:

> +          - nxp,pcal6534

^^^

Not sure why is this dup?

-- 
With Best Regards,
Andy Shevchenko


