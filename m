Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A880502C22
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 16:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354680AbiDOOt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 10:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351580AbiDOOtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 10:49:55 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C99728C7F5;
        Fri, 15 Apr 2022 07:47:26 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id kl29so6613786qvb.2;
        Fri, 15 Apr 2022 07:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3tZc/sDxSA7pYch9ELbn7khfDuX4s4QTkY73ST3PUqQ=;
        b=ZGWKTQSnUo5Tey22DxTS65N/VcRNb5BOHCYswh6L2Jpl0YupoHs2fYpN0rIavkINHu
         ZlxzPVnt9ImYCnW6Gv2HqXoES7i9u14MIInO0c+qRXYwCQ0fxvqAjHuStYbA8uDcN+Aq
         6pJiw6l50YlEgUV8xcfW5rXP9nnsayQtckuW4/zpEbwFwHKDIBNzvBSS0iOGhuIfxPhF
         WRY+rG/4qqvp3h0h0Yy+q1NfKeXHVgAMkquKmp3iz/pvDUHMWdhxGTrock1T7+Grr0NZ
         MR/Kq9xv1X5zXaxCxVY+xAx1b43Vwwzsm7YhRVhP4ztkl8TbJtT/hm6+w0djf6PGVnU9
         6/UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3tZc/sDxSA7pYch9ELbn7khfDuX4s4QTkY73ST3PUqQ=;
        b=BFH8Ys3Q2fXLOyWw3qY9Rb0dEkP5HKCpHvG+AUsHYFgW4NuuMrqYDnVo6bisrHOsc/
         xIhFPZmJmVacTU7lpN0krVAKpFB3uaa6r1NI+4kResEAdTwVt8CMXOSztpJJ+r/ui4PE
         mvTqTxGEXbBa7WtU4TxPyGWQAfnx8O/CMjsLubF/zh6K9xdWRk1DQnShXqa+01Zz9g28
         Eq14jio8lCD1YhDyfSaHuDvaR31qM/0KopOoJMTRMMQhpVdQBLUm+vTxfpsCB97rYvKV
         lywVfjpHkBPWAyUK8hzZVvbFMI+1mb4iIWUu9/kVZwi0XFPa6Bd5F+RT+3qOAbhCQcBh
         oGSQ==
X-Gm-Message-State: AOAM533fzL27g7lT5Nt5RMSiRkKdis8DgKKGczJKnYep32VReX6NVo39
        UVVr9QaGqkbwrdJke502cxw=
X-Google-Smtp-Source: ABdhPJzDuCTu5ptW/nWVY1Zlcjoo0oijfEaHHhMUQTQqzqZqXkLdTGuGyqfYaoa8jFnJplnqchgw+Q==
X-Received: by 2002:a05:6214:2307:b0:432:e753:e0c4 with SMTP id gc7-20020a056214230700b00432e753e0c4mr7664795qvb.55.1650034045905;
        Fri, 15 Apr 2022 07:47:25 -0700 (PDT)
Received: from shaak (modemcable055.92-163-184.mc.videotron.ca. [184.163.92.55])
        by smtp.gmail.com with ESMTPSA id w4-20020a05620a0e8400b0067b1bcd081csm2400925qkm.66.2022.04.15.07.47.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 07:47:25 -0700 (PDT)
Date:   Fri, 15 Apr 2022 10:47:23 -0400
From:   Liam Beguin <liambeguin@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Peter Rosin <peda@axentia.se>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v1 1/1] iio: afe: rescale: Make use of device properties
Message-ID: <YlmFezCYNeUxa8cL@shaak>
References: <20220413190117.29814-1-andriy.shevchenko@linux.intel.com>
 <Ylgwhu9zdmwwYnAq@shaak>
 <YlhT/yiJSD7pFsF8@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YlhT/yiJSD7pFsF8@smile.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2022 at 08:03:59PM +0300, Andy Shevchenko wrote:
> On Thu, Apr 14, 2022 at 10:32:38AM -0400, Liam Beguin wrote:
> > Hi Andy,
> > 
> > On Wed, Apr 13, 2022 at 10:01:17PM +0300, Andy Shevchenko wrote:
> > > Convert the module to be property provider agnostic and allow
> > > it to be used on non-OF platforms.
> 
> > > +#include <linux/mod_devicetable.h>
> > 
> > Is this really needed?
> 
> Yes.
> This header is missed. I can split its addition to a separate patch.

Understood, maybe a separate patch would make it more explicit.

Cheers,
Liam

> > device_get_match_data() is already defined in <linux/property.h>
> 
> It's indirectly related (just like we do when we clean up of.h). Since
> the original of.h is missed there is no header replacement, just adding.
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
