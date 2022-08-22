Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3498759C428
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 18:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237039AbiHVQbs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 12:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236433AbiHVQbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 12:31:46 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 012ED7663;
        Mon, 22 Aug 2022 09:31:45 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id x19so8063124pfq.1;
        Mon, 22 Aug 2022 09:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=PtAIPgFqoQUO64v/KOef+4bUGN2kfRm6hDdkk4Zv0oY=;
        b=e0sOAQG//vdFW8vX8cBOSYtya0lKnR3J+a2ptFpwoPbBYh7CqNBP3TeMwcDjOlHM7g
         aG4pH3P3g/vp3zPV39J9NnnLtsGhOhP/mVWpqJY27K7VBzg//FdO0PjV9NkMAl+t6PBP
         MktEu4fDcCGeOdNgaLF3JFuMZoCXnzrJrIbpiqkZf1IAvqJsFoD0WyDGNfli0n9KwDeg
         YPBC9aXZJRUtElZZ8eOVdJqJj8a2KblBtOwuMCzuCOFFpGJnjPArfd24/2ncBlZ12ADw
         tro1FiBMtkSu2aUyT4RZeM24z2CeBJv8+b5lbjpH1JKCOA6hWO0qFqMZOF3kr9ra2KFl
         W/6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=PtAIPgFqoQUO64v/KOef+4bUGN2kfRm6hDdkk4Zv0oY=;
        b=39ddLldHcTCj98Vre3NH+TdJcqSIGl1IG7jw2EXmpNuB3TYk+XwJ3OpEhQXYIvwsPO
         AmMUrFSGeB1jkwYjdVx5VCOjcrzHGoYpicj6GMrWlvmbRcFaRRjms2r6bgDNpB+h5Ev1
         Ai3Tf5laJm1pELStWCmxAz1qMy0MIn1CBr3M0OGzf0Loi6tuQqbb6SfhRhKRspFyYu7V
         vRv8DeU8Qc1NXh9A/1VRN11tQS6pjG3E+u1FqRkgCZRZpLG5WLrtI8YTSgY+cynYRbSn
         s8gyfloRMeZUR9+CCYLLXXX6uxMXDUG6bg/0/E3EYcn6mxdWmTvfMXN8sgMuU9yZbtiI
         3+/A==
X-Gm-Message-State: ACgBeo0/KsPkd1xaxzTzy/KYB+e/xwSG+ssrgNmPTNKnZPcLZUjlnZzG
        OMCYapEUHLosemVZMyr0JyU=
X-Google-Smtp-Source: AA6agR7z5YapYBS8d6KsvLkx1zI+Bq8Uhhlzd9ItkhULgaEp2zf6sfdvo49KhvVG2pxr44J2zprxdA==
X-Received: by 2002:a05:6a00:1a0c:b0:528:6baa:a2e3 with SMTP id g12-20020a056a001a0c00b005286baaa2e3mr21815051pfv.27.1661185904408;
        Mon, 22 Aug 2022 09:31:44 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x64-20020a628643000000b005368192372fsm3251656pfd.200.2022.08.22.09.31.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 09:31:43 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 22 Aug 2022 09:31:42 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Farber, Eliav" <farbere@amazon.com>
Cc:     jdelvare@suse.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, talel@amazon.com, hhhawa@amazon.com,
        jonnyc@amazon.com, hanochu@amazon.com, ronenk@amazon.com,
        itamark@amazon.com, shellykz@amazon.com, shorer@amazon.com,
        amitlavi@amazon.com, almogbs@amazon.com, dwmw@amazon.co.uk,
        rtanwar@maxlinear.com
Subject: Re: [PATCH v2 14/16] hwmon: (mr75203) parse thermal coefficients
 from device-tree
Message-ID: <20220822163142.GE4098765@roeck-us.net>
References: <20220817054321.6519-1-farbere@amazon.com>
 <20220817054321.6519-15-farbere@amazon.com>
 <20220818202839.GA3431511@roeck-us.net>
 <e0b133e7-ac81-acf4-3783-44edf58d6426@amazon.com>
 <20220819113842.GD3106213@roeck-us.net>
 <20200e60-c4e2-d272-1417-005994766380@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200e60-c4e2-d272-1417-005994766380@amazon.com>
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

On Mon, Aug 22, 2022 at 04:41:07PM +0300, Farber, Eliav wrote:
> On 8/19/2022 2:38 PM, Guenter Roeck wrote:
> > On Fri, Aug 19, 2022 at 10:57:58AM +0300, Farber, Eliav wrote:
> > > On 8/18/2022 11:28 PM, Guenter Roeck wrote:
> > > > The calculation was just changed to use new defaults in a previous
> > > > patch. This patch makes it quite clear that the coefficients
> > > > are implementation (?) dependent. So the previous patch just changes
> > > > the defaults to (presumably) the coefficients used in your system.
> > > > That is inappropriate. Adding non-default corefficients is ok
> > > > and makes sense is supported by the chip, but changing defaults
> > > > isn't.
> > > The calculation was changed in previous patch to match series 5 of the
> > > Moortec Embedded Temperature Sensor (METS) datasheet.
> > > In our SOC we use series 6 which has a slightly different equation and
> > > different coefficients.
> > 
> > If the coefficients are different based on the series, it would probably
> > make sense to create a separate devicetree compatible property for
> > series 6
> > instead or requiring the user to list the actual coefficients. Those can
> > still be present, but the code should be able to use the defaults for
> > each series.
> There is a different set of coefficients for series 5 and for series 6,
> so it would make sense to add a single property (e.g. series) instead
> of adding 4 properties, one for each coefficient.
> But that would not always be enough.
> The Moortec datasheet explicitly says that coefficients can vary between
> product and product, and be different from the default values.
> That is the situation in our SOC.
> The coefficients we use are slightly different from the defaults for
> series 6.
> So just adding a single series property would not be enough, and we would
> anyway want to have the option to specifically determine the coefficient
> values.
> Do you suggest to add both, also series and also coefficients? (and I can
> fail the probe in case both are set, to avoid conflicts).
> 

It should not be necessary to provide explicit default values for any of the
series. Yes, default values can be overwritten with explicit coefficient
properties, but it should not be necessary to provide those if the defaults
are used. So I would expect separate compatible properties for each of the
supported series plus separate coefficient properties.

However, since we are discussiong DT properties here, I'll step back and let
DT maintainers decide.

Thanks,
Guenter
