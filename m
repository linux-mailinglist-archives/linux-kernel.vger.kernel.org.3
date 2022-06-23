Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD285558315
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 19:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233690AbiFWRY3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 13:24:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234152AbiFWRXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 13:23:14 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6759C62C02
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 10:01:45 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id d129so4065pgc.9
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 10:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=d13U05lgVcA9IwB4xU4eCP+aqLe0CVa+pwLL0+/k+WM=;
        b=C5lpoezPBXRnQQ1Zp6sggOHddLA6Uc5ahxV2aIySaLqWVHpO4J8e3u/zLre61TN4+3
         mCB/H31H6wEea3PB8RWDNXLLtSxvhqbniWy1r5iCX+/R4tQP5QZ7kZpA5FKi/prdmSDd
         2kwkzD65EAqm29WpPxAo3Z/KAsLQKphrNebf0nzr1K0AQUfPYNH1KS5h+t4Mo//6UPvW
         SG6k2Z9egOqbTSrVV88/EevmYNLe2xgViRf/PvqY/VB+YMEblSA5MeGZxY5JxVYUM18b
         yTxEpyaQVXBwoMAjY6UgEtr3QhAZVuzfJB9yw3Ll1DIEyuE8ajwqDMwECrWLoLcy11j3
         YhuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=d13U05lgVcA9IwB4xU4eCP+aqLe0CVa+pwLL0+/k+WM=;
        b=JU+wPs7hFlk7tuNoavSnczY2afIZKdvNtsHO95IfBVbwzZd8NOPpe9I02QjxOuA/2P
         FFsCWENIrM1qnulPfQxg4BRzUKvBy1pIg3qJOWurTp0c3yDSUgAd9PiSPX6Ufq/9FmCO
         rzDr7Td/lB53jKQAq7rk80X7zI/N5t+SZe7FUKXouoik7Qb+bp4yIqekh2KTB3xSDImH
         zlwiNpRjad0NngCJAKyjXedEG2t8nZWRhiC0HFg3rAy1X4wMam4p2cKq55vNzcklF53J
         n6RUk/i0X0yzfPw9s/6ckxA95PCu30GtY0A84bEQKTz277/0vr++lLQB2KLhLuSMnF43
         2sog==
X-Gm-Message-State: AJIora9momx2HhELDsQ367PJxbXjHYXJy1FVp0PxYxLGY6fnOCtgvncl
        XJmfxf+cm+8kknIct1Ed0fGevQoIjek=
X-Google-Smtp-Source: AGRyM1svkR371G3bIxDdDwlnaJ9ZGxsCwfqK3CHEoOzbRjbqO7zrYzN4lsgBuY2JF3pfMtGl9/U/rA==
X-Received: by 2002:a05:6a00:140f:b0:4e0:6995:9c48 with SMTP id l15-20020a056a00140f00b004e069959c48mr41410349pfu.59.1656003701094;
        Thu, 23 Jun 2022 10:01:41 -0700 (PDT)
Received: from localhost ([2601:642:4c0a:3280:86c1:205f:2c98:d819])
        by smtp.gmail.com with ESMTPSA id z3-20020a17090a66c300b001ec9a3e9d4fsm2173151pjl.0.2022.06.23.10.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 10:01:40 -0700 (PDT)
Date:   Thu, 23 Jun 2022 10:01:39 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Alexander Lobakin <alexandr.lobakin@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [norov:fns 7/19] include/linux/compiler_types.h:352:45: error:
 call to '__compiletime_assert_600' declared with attribute error:
 BUILD_BUG_ON failed: !__builtin_constant_p(res)
Message-ID: <YrSccxLBlrJ3DyTx@yury-laptop>
References: <202206230121.wlBiPZcR-lkp@intel.com>
 <20220623110820.1017185-1-alexandr.lobakin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220623110820.1017185-1-alexandr.lobakin@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 23, 2022 at 01:08:20PM +0200, Alexander Lobakin wrote:
> From: kernel test robot <lkp@intel.com>
> Date: Thu, 23 Jun 2022 01:16:29 +0800
> 
> Hi Yury,
> 
> > tree:   https://github.com/norov/linux fns
> > head:   dc85542660535a9072c3b98819f4b80ff182b92a
> > commit: 2f52f0373b1a1bcf54a4aedc202518f6bed4c74f [7/19] lib: test_bitmap: add compile-time optimization/evaluations assertions
> > config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20220623/202206230121.wlBiPZcR-lkp@intel.com/config)
> > compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
> > reproduce (this is a W=1 build):
> >         # https://github.com/norov/linux/commit/2f52f0373b1a1bcf54a4aedc202518f6bed4c74f
> >         git remote add norov https://github.com/norov/linux
> >         git fetch --no-tags norov fns
> >         git checkout 2f52f0373b1a1bcf54a4aedc202518f6bed4c74f
> >         # save the config file
> >         mkdir build_dir && cp config build_dir/.config
> >         make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash
> 
> Can't reproduce it at all on x86_64 with the attached config, were
> there any other changes maybe that could cause this?

This is my working branch, and it shouldn't be that loud. But
anyways...

There are some patches on top of your series. This is my
work-in-progress. If you think it's not relevant, please ignore
this.

Thanks,
Yury
