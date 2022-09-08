Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C2565B1D80
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 14:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231955AbiIHMoc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 08:44:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231977AbiIHMoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 08:44:19 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9BF8E582A
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 05:44:17 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id b21so4814914plz.7
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 05:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=khkD2dZzZ1EEcyqVqdCXrOdiAvPW7C2pQAJ2+w6ajfc=;
        b=G24+T71hHbRypj8u9LCRDMedhcqyK1IU0NXIT9GeHoIDnkHzYf6b8tKCBMsmBSGGI1
         ZHSoNdnvtkrtmj7+GgT02Tz7Euwof6zcruMiAAM2lZhO67Q5leUtR7+Wnl/zCBOi+AhX
         4iQrViZgH9hFLZi5GG5oSEATQZEuoM1MSF3YmwWEZcSaz8zCpo3T1WsoMlhbfrt1Pae6
         keBSbm/lzWialYu5kop6xuH+HLcomOtg3GQvpPrclERbTuhfXN7bymLzhT65I+Vw6cds
         +ILKJRLI1xKsvKKRXdJYwHWp9COvXG4+/XWwVzs4rGF1bWwiypjchPbw4bC9iY2LI3wK
         LSYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=khkD2dZzZ1EEcyqVqdCXrOdiAvPW7C2pQAJ2+w6ajfc=;
        b=44NkrUgfjnfFzMao22R3aBMWLXvWW72JhX+TtKxlwPtuOW0wVXZqB/unZ0dceSQp1W
         KrSEvbXmNd/ShzsIuhrL814pmD42E0C1g9u/aa/4ngydXwmbnWol+MSRsknmBunhYFJ8
         vWzrAg7B8rO1KiXZTrA07d/4oLNiCn/L/5MBZI7V0WkDPh69I3ouSF8999YKOg/UfXiI
         OYYFXYKxi0X7lm3LgpxoMy3QnVURkG3UPTvfU83N8VStcNLLIf6v+7vv8h+4nH1KhHnE
         jNBb3ttkxoY1ZFSTK0xGkGkiVoKOhqTl4ISxBmHU+YE8pAa+MM/6iWd+T7TxpWkcbk/0
         7qsw==
X-Gm-Message-State: ACgBeo1XbL/5kUm1e8wnSw26SkHSoIKSr0Y+9uA0wcFmv7wjg1ty8vCw
        iJyiUGICvH+Wj7onekrBQlpSORgtd9HO7mALR7o=
X-Google-Smtp-Source: AA6agR7MWp6ExrMDeku20UJ0zL1Z+aO74rWDLTG8O9WLEJoy0GLnr9VEy6q72voqmO5PrRAhhtvcRA==
X-Received: by 2002:a17:903:2282:b0:177:faeb:3606 with SMTP id b2-20020a170903228200b00177faeb3606mr1029332plh.135.1662641057008;
        Thu, 08 Sep 2022 05:44:17 -0700 (PDT)
Received: from leoy-huanghe.lan (ec2-13-208-210-110.ap-northeast-3.compute.amazonaws.com. [13.208.210.110])
        by smtp.gmail.com with ESMTPSA id f3-20020a17090a664300b001fd803f057bsm1640126pjm.33.2022.09.08.05.44.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 05:44:16 -0700 (PDT)
Date:   Thu, 8 Sep 2022 20:44:11 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     carsten.haitzler@foss.arm.com
Cc:     linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        suzuki.poulose@arm.com, mathieu.poirier@linaro.org,
        mike.leach@linaro.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Subject: Re: [PATCH v8 02/13] perf test: Add build infra for perf test tools
 for CoreSight tests
Message-ID: <Yxnjm7sA2Uit0X1M@leoy-huanghe.lan>
References: <20220906103044.761250-1-carsten.haitzler@foss.arm.com>
 <20220906103044.761250-3-carsten.haitzler@foss.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220906103044.761250-3-carsten.haitzler@foss.arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Carsten,

On Tue, Sep 06, 2022 at 11:30:33AM +0100, carsten.haitzler@foss.arm.com wrote:

[...]

> --- /dev/null
> +++ b/tools/perf/tests/shell/coresight/Makefile
> @@ -0,0 +1,26 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +# Carsten Haitzler <carsten.haitzler@arm.com>, 2021
> +include ../../../../../tools/scripts/Makefile.include
> +include ../../../../../tools/scripts/Makefile.arch
> +include ../../../../../tools/scripts/utilities.mak
> +
> +SUBDIRS =
> +
> +all: $(SUBDIRS)
> +$(SUBDIRS):
> +	$(Q)$(MAKE) -C $@
> +
> +INSTALLDIRS = $(SUBDIRS:%=install-%)
> +
> +install-tests: $(INSTALLDIRS)
> +$(INSTALLDIRS):
> +	$(Q)$(MAKE) -C $(@:install-%=%) install-tests
> +
> +CLEANDIRS = $(SUBDIRS:%=clean-%)
> +
> +clean: $(CLEANDIRS)
> +$(CLEANDIRS):
> +	$(Q)$(MAKE) -C $(@:clean-%=%) clean >/dev/null
> +
> +.PHONY: all clean $(SUBDIRS) $(CLEANDIRS) $(INSTALLDIRS)
> +

I observed that git reports warning when applied this patch:

Applying: perf test: Add build infra for perf test tools for CoreSight tests
.git/rebase-apply/patch:107: new blank line at EOF.
+

The last blank line is redundant, it's good to drop it.  When you fix the
warning for rst doc file, you could fix this together.

P.s. at my side, git can automatically fix the redundant blink line
since I added "whitespace = fix" in my gitconfig.

Thanks,
Leo
