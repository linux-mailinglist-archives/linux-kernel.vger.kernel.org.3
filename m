Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92291599C9C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 15:09:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348915AbiHSNDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 09:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348363AbiHSNDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 09:03:44 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5B0723BD4;
        Fri, 19 Aug 2022 06:03:42 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id t2-20020a17090a4e4200b001f21572f3a4so4846622pjl.0;
        Fri, 19 Aug 2022 06:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=mFHCkrszYQi1Swot2EOM04F+Zu2lSS1RfdWrmuiHXu0=;
        b=GtYnP8vfUIgAvmgVH6CZ9vhJZdQo594bS0ij4mHOWQPYC0y0t9X9/C23a5QGszdhyu
         MUaFzN3BH2VETDxQG9JXFoQ9Tu13QJLUOrJOhAHAiCz4fHS4PmK+/ELD01biGdDIs0OO
         YKOWqAx5+nK1e+BoZY5yjbpRJvXCBTu+Kzjj/Byr+G9KzjJVInztCsyqQJLSmwVKYJHt
         O6ju6oAAbjd+eWggoK3d92cRI6t1uvka2/lz6na7fw/2tYvgIIPC2ASq9EcsVTNZMAtb
         IdGbxaRKTZpESjCn3JPxbVPKC3WpXP3Mop2l/S9WOBkGcvHgAzhGTpjAWxzy0H5LAQYy
         U9vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=mFHCkrszYQi1Swot2EOM04F+Zu2lSS1RfdWrmuiHXu0=;
        b=8HvxpiT+6SrH4fUh4L8cmS2uUX44EBRuCz9BV+j0wYN6RdzrmAMETVcPpGQ3hCvC6Z
         WJap4MkmgVwF3oYnlPYe/6ZYVu8e7lgV2WkI72rAZjyR0iYOc5SPFVrmY2HMzqsMhB69
         xne/8qf7euplkOYJ72qASjgAgfpnOeIjmeiEXZ2uSkUMVb2dZHrliSdaqe/sBhPMge5B
         BOiy/F7L5Gp4ZRuvcHnZzEYuaN9t9hU34bDsaRxDfFSGk8O9sGaNksUFCJ+8pRHxiC43
         sHhi6x3eEROo2SOL9yFCp4GMLW+GzfHu3I3zuJzYPnLDB8DLN863EFUO9hc1j0tYfBE/
         Uysg==
X-Gm-Message-State: ACgBeo2GZIN0M8c8P4scUL2fCg97WmAs75qnUmeLDSs2/fL8yqgt2rIG
        3w8WRx1fLJ1yMnRhAL9AwYGs2ZfRTqw=
X-Google-Smtp-Source: AA6agR7ia/W06DpubPa06tt5CEwwzJVvBol2D2PvqWP9GtWppnf/wLp2XXHdhWzSlLbM1doaLxaV1A==
X-Received: by 2002:a17:903:2403:b0:170:c6e2:5f87 with SMTP id e3-20020a170903240300b00170c6e25f87mr7356627plo.108.1660914222175;
        Fri, 19 Aug 2022 06:03:42 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q5-20020a170902a3c500b0016befc83c6bsm3133007plb.165.2022.08.19.06.03.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 06:03:41 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 19 Aug 2022 06:03:39 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-hwmon@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jean Delvare <jdelvare@suse.com>
Subject: Re: [PATCH v1 1/1] hwmon: (iio_hwmon) Make use of device properties
Message-ID: <20220819130339.GA3108215@roeck-us.net>
References: <20220730125024.87764-1-andriy.shevchenko@linux.intel.com>
 <20220818232256.GA3505808@roeck-us.net>
 <CAHp75Vc5CtOwFFJxLEe2kNTpU0xqWmcwDLAYtFgkhJVx7KvwqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75Vc5CtOwFFJxLEe2kNTpU0xqWmcwDLAYtFgkhJVx7KvwqA@mail.gmail.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 19, 2022 at 12:50:46PM +0300, Andy Shevchenko wrote:
> On Fri, Aug 19, 2022 at 2:52 AM Guenter Roeck <linux@roeck-us.net> wrote:
> > On Sat, Jul 30, 2022 at 03:50:24PM +0300, Andy Shevchenko wrote:
> > > Convert the module to be property provider agnostic and allow
> > > it to be used on non-OF platforms.
> > >
> > > Add mod_devicetable.h include.
> > >
> > What does that have to do with this patch ?
> 
> See below.
> 
> > > +#include <linux/mod_devicetable.h>
> 
> > > -#include <linux/of.h>
> 
> The of.h implicitly included missed headers. The mod_devicetable.h is
> necessary when we drop of.h. OTOH I haven't checked if
> mod_devicetable.h is still included indirectly. Either way the correct
> approach is to include mod_devicetable.h since we use a data type from
> it (of_device_id IIRC).
> 
Something like

"Include mod_devicetable.h explicitly to replace the dropped of.h which
 included mod_devicetable.h indirectly"

might be useful.

Thanks,
Guenter

> -- 
> With Best Regards,
> Andy Shevchenko
