Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F0155B1CEE
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 14:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231797AbiIHM1m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 08:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231801AbiIHM1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 08:27:39 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E490E5823
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 05:27:37 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id o4so17603005pjp.4
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 05:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=pQPlhLxrKUNUGTT4UOEL+mGa9lFxIOncWroqIuDltN8=;
        b=tW20rFmZpvEE9PcDR25OPbtNdACwy3ALWQtURbFgjo2pAxM1JTivGbbWy8H0uyZ3CL
         tp9Ya/o0+yNCPCHPT8AQKImBMvWjQC0mFABjicY8thJm7L/PkfMNPmZrA8tT6sk1kGJm
         wi1Rrp3XXCI/mzh6gKqa+j71V4tKCr4WVxYrrLM8VTsnmUfUgguxf/8j0Kk1ZWdO9jcG
         6vgFIn4ZUSm6WHNQi94RiI5O5a/UbJVhriXr5K2S0bb/sGl/jqEYC8F1TIA28lIRt0+V
         iJPOgtQ7jh/rgsd2hHHOrlAlplQlPyNFE+alrCBg9OoMWHwOgmA1anuPNbP3XF1uscf4
         kRQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=pQPlhLxrKUNUGTT4UOEL+mGa9lFxIOncWroqIuDltN8=;
        b=Tax/6PWqa0MnfrNWosOm9fgAqG3tOrW+Q+TrhT9942LF7g0L/IOzDrWfCXi4JO8cPU
         lrG3GxqElEsZq434YlVfJGrq29jPIQgvc24RiXr5eYYP0ut0JBCz8ZBjHM7QofIcl2GV
         qn78KHbcNlq4zenYSgPqgBi0mQW3PfERbs1FENNziZYMno4oR1XrrJS+GyScDeEEugC4
         aPgkigVkUS4ycSSUnVJ2fLrTkJtP0a8rYoe2rp+x0ock1akT9DvwW4aLCyXRvS33thpU
         xqeL9kI9kDEy9kL/a2f2mNucNFHWPAFakYLwvvauG/rb19SyAgX/stEV53RUalRzUdi6
         7wsw==
X-Gm-Message-State: ACgBeo1Wxkpf2vbdnIm5Con0O54hG5B/KG/qVsJDoj8X/zjQh8w7CSQv
        WX+atXAfvFpeXatGN3kEXL0j6w==
X-Google-Smtp-Source: AA6agR5E+bAEHThTzp/7s2iat30vdE5DsbUgfAc82lgbf2JJS+5Tz54CTRthqTfQAcxepyz108I4Vw==
X-Received: by 2002:a17:90a:5783:b0:200:4aa8:a18d with SMTP id g3-20020a17090a578300b002004aa8a18dmr4100091pji.38.1662640056827;
        Thu, 08 Sep 2022 05:27:36 -0700 (PDT)
Received: from leoy-huanghe.lan (ec2-13-208-210-110.ap-northeast-3.compute.amazonaws.com. [13.208.210.110])
        by smtp.gmail.com with ESMTPSA id x14-20020aa79ace000000b0054087e1aeb4sm1621200pfp.111.2022.09.08.05.27.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 05:27:36 -0700 (PDT)
Date:   Thu, 8 Sep 2022 20:27:31 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     kernel test robot <lkp@intel.com>
Cc:     carsten.haitzler@foss.arm.com, linux-kernel@vger.kernel.org,
        kbuild-all@lists.01.org, coresight@lists.linaro.org,
        suzuki.poulose@arm.com, mathieu.poirier@linaro.org,
        mike.leach@linaro.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Subject: Re: [PATCH v8 13/13] perf test: Add relevant documentation about
 CoreSight testing
Message-ID: <YxnfZSeYzPCJzIp9@leoy-huanghe.lan>
References: <20220906103044.761250-14-carsten.haitzler@foss.arm.com>
 <202209071000.s5lvO8sV-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202209071000.s5lvO8sV-lkp@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 07, 2022 at 10:59:55AM +0800, kernel test robot wrote:

[...]

> All warnings (new ones prefixed by >>):

Thanks for reporting!

> >> Documentation/trace/coresight/coresight-perf.rst:102: WARNING: Inline emphasis start-string without end-string.
> 
> vim +102 Documentation/trace/coresight/coresight-perf.rst
> 
>     96	
>     97	   CoreSight / ASM Pure Loop
>     98	   CoreSight / Memcpy 16k 10 Threads
>     99	   CoreSight / Thread Loop 10 Threads - Check TID
>    100	   etc.
>    101	
>  > 102	These perf record tests will not run if the tool binaries do not exist
>    103	in tests/shell/coresight/*/ and will be skipped. If you do not have
>    104	CoreSight support in hardware then either do not build perf with
>    105	CoreSight support or remove these binaries in order to not have these
>    106	tests fail and have them skip instead.
>    107	

Hi Carsten,

Just note that I reproduced the warning at my side; after I used the
escape for '*' like below, the warning can be dismissed.

  tests/shell/coresight/\*/

Thanks,
Leo
