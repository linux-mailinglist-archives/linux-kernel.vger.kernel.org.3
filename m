Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7648A599B2D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 13:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348426AbiHSLfz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 07:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348339AbiHSLfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 07:35:51 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC36DF088;
        Fri, 19 Aug 2022 04:35:50 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id s3-20020a17090a2f0300b001facfc6fdbcso3926015pjd.1;
        Fri, 19 Aug 2022 04:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=iy8lmDGhsIwnTaLmmZhDWBI74/Bha6fyIeoZvYrYrsk=;
        b=e74GXecrJE3dp4SHTPnk/5XMJpIHtlGVVGifUdNe2Ho33RWLCYWQWTLntAlr4UcI85
         jYL3SIt/76jn2ytChATOkE6494mRDPF8ZeErS5oDhboRFacDkHBhJ1WCqK24D+JUrWgy
         g7StSpd036CC0oFN4MhNMip+7PaUxQg+BjPj87yS5cIEJIvA2C5uBnxpfoZlSSidSUU/
         wmgXjKS9P5TLxaUpn08+hkxcxhMK2xP+0HCwiw4y8Uh3xjk/qvLaXlFBPNCybgBsuOR2
         4d26vFj9gu2NcRY0zbIra58huOYY876rpaYtjRG06jQ60774Z8bhhVoN7zkym29nAwQT
         ylxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=iy8lmDGhsIwnTaLmmZhDWBI74/Bha6fyIeoZvYrYrsk=;
        b=aEgBCL0i5J86UWQGIWgBefZBwPbCe87Dx70UULWsEMEbJKJwN3sTfpDDyaYd8i4/sM
         a7w5ZRmxC0FNXZ7S/NFljibKBV8boX6XCR46h9oqNl0wMC105mIeQVLZkS5i+6XlPE0c
         Qd9mJEsf6PBZemssDmGS2vhIBkSLWsPKufjHI/1Zb9V/fy1QXDFCeFwd69Ta7XRaeUpP
         BTrmbnnc1fq+UhaJhy4t9LziJsAsCxOOQOoeX6Nqn1GQLgVchvlTcu41XpiqRimkpq9q
         YXL4oVO7rCP4/BKPQ8BRp3puglTzLxw2pJn0u7+nT9/832p/h2/bf63FH+tKgsynfa1v
         9N+g==
X-Gm-Message-State: ACgBeo1eTYHNABNLCZdxAWQBEbZkRKuzY3HBgmHHR5jwinOFm8w3Hbnn
        cRIX3rpmiPD8lqSbHtyfJZw=
X-Google-Smtp-Source: AA6agR4oj1UN5vemXmU8qD2wqoEj2dfaCVvXRkpez6YagwC4DXZKfVd0GidFSkvJ3BQU6HA/Lk3tmQ==
X-Received: by 2002:a17:902:8f8a:b0:170:8df4:eebd with SMTP id z10-20020a1709028f8a00b001708df4eebdmr7030005plo.116.1660908950093;
        Fri, 19 Aug 2022 04:35:50 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z18-20020a170903019200b0016bf5557690sm3043278plg.4.2022.08.19.04.35.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 04:35:49 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 19 Aug 2022 04:35:48 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Farber, Eliav" <farbere@amazon.com>
Cc:     jdelvare@suse.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, talel@amazon.com, hhhawa@amazon.com,
        jonnyc@amazon.com, hanochu@amazon.com, ronenk@amazon.com,
        itamark@amazon.com, shellykz@amazon.com, shorer@amazon.com,
        amitlavi@amazon.com, almogbs@amazon.com, dwmw@amazon.co.uk,
        rtanwar@maxlinear.com
Subject: Re: [PATCH v2 12/16] hwmon: (mr75203) modify the temperature equation
Message-ID: <20220819113548.GB3106213@roeck-us.net>
References: <20220817054321.6519-1-farbere@amazon.com>
 <20220817054321.6519-13-farbere@amazon.com>
 <20220818202324.GA3431316@roeck-us.net>
 <2cc79934-2280-79e6-6e63-0e3eb7107e1c@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2cc79934-2280-79e6-6e63-0e3eb7107e1c@amazon.com>
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

On Fri, Aug 19, 2022 at 10:44:06AM +0300, Farber, Eliav wrote:
> On 8/18/2022 11:23 PM, Guenter Roeck wrote:
> > On Wed, Aug 17, 2022 at 05:43:17AM +0000, Eliav Farber wrote:
> > > Modify the equation and coefficients to convert the digital output to
> > > temperature according to series 5 of the Moortec Embedded Temperature
> > > Sensor (METS) datasheet:
> > > T = G + H * (n / cal5 - 0.5) + J * F
> > > 
> > > The G, H and J coefficients are multiplied by 1000 to get the
> > > temperature
> > > in milli-Celsius.
> > > 
> > 
> > This is, at the very least, confusing. It doesn't explain the discrepancy
> > to the old code nor the change in constant values. I have no idea if this
> > change would result in erroneous readings on some other system where
> > the existing calculation may be the correct one.
> 
> When I tested the driver it was also not clear to me why the equation
> and coefficients in the code don't match the specifications in the data
> sheet.
> I reached out to Maxlinear engineers (@rtanwar) and they also couldn't
> explain the discrepancy.
> After further correspondence I aligned both the equation and coefficients
> in the driver code to the equation and coefficients defined in series 5
> of the Moortec Embedded Temperature Sensor (METS) datasheet which they
> provided.
> 

At least some of the discrepancy is because the original code is more
optimized and avoids overflow. Either case, the above needs to be explained
in the commit description.

> > On top of that, it seems overflow-prune in 32 bit systems.
> 
> I'll check if it can overflow, and if it can I'll fix in next version.
> 
> --
> Regards, Eliav
> 
