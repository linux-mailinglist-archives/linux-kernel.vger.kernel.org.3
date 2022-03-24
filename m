Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30F8D4E5D8A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 04:28:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347968AbiCXD3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 23:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235030AbiCXD3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 23:29:41 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8855C1DA65;
        Wed, 23 Mar 2022 20:28:08 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id u16so4778514wru.4;
        Wed, 23 Mar 2022 20:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=pol0ZkQp+j4kokRt/dZYhfgwVZZCa7zqZ+o3acmsvpo=;
        b=mqzMmMtaA+zjTsLWlBiRE8+4B/qBc1IECKiKVLZAbk9y3xB0CH8rFWfKmXvTjdkoz7
         6rDetp5TBMNXixwS9TFcJ8o546eLcczPRBso4jPuZNXjeYqUpvCW28JVCqmjOsG+9INy
         x+0Gw7KvxrNxJyxe7ucq0arIw68NHr9kT1my4XuxqT7n4TdPDnIoPgOnctfXM98EglAS
         /9aw6a3bPUz79PDvOr0QfSJrf7OHz+1MXgCkszOCldmUErTjQytDzCL+y+zX2w9B3q5V
         gwSG521Z1VvGLuk98W8qDKs+6bqRbjAxOj96Y+K2d4Qk1Ck9s4ixDLIoxhqMzP6Urbin
         DBSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=pol0ZkQp+j4kokRt/dZYhfgwVZZCa7zqZ+o3acmsvpo=;
        b=n1HoNgpHmvqcfNosemDZuCyz/rIhezvUtojEKFMENBgsKY/xZforpk0hb1P1U9GcfA
         9zqHjDW0m89bf8XPFSaO2lSTolwUmcXEqs6p1ELZG3hgXvMxARXEAjYkVdxvFWWMzWSP
         nbKzS5mrDqjQdrHY2YRl4q8JF/8NVF8Z2QH0uoxyC0Md0bt9K2ZGzjU9K0UYlZ4DFlrw
         bmkvSeMhq7Y4u7bWvFrhyVeh6zfM4aMLn8A3sep7+KfAicoF12JftCSrQtdlZpQ4EShj
         J9OKWa1G4nhguZ0kxMG3g4c/So3ls9YBcwUOnInMw3Tj5KxR8ZwPidOom7TMy+jrjxVc
         0nhQ==
X-Gm-Message-State: AOAM530VN970AzKpomXE3qGuOfyfK8XQlkSaXF3QVt4fdWEGvggMfhuk
        8oR8bHGsdl4E1S2rbLS0VEc=
X-Google-Smtp-Source: ABdhPJwvPAtjyhLCTmPLisuZrts23SDyEhd49+HTmZZzAB3DDsm2Pak7N3yJzZccqwzbYtB7skzpQw==
X-Received: by 2002:a5d:598d:0:b0:205:8b74:8db4 with SMTP id n13-20020a5d598d000000b002058b748db4mr2604727wri.573.1648092487115;
        Wed, 23 Mar 2022 20:28:07 -0700 (PDT)
Received: from hermes ([2604:3d09:e80:800::72d9])
        by smtp.gmail.com with ESMTPSA id k5-20020a5d66c5000000b00203fd25f4ecsm1375650wrw.16.2022.03.23.20.28.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 20:28:06 -0700 (PDT)
Date:   Wed, 23 Mar 2022 21:28:02 -0600
From:   Manuel =?iso-8859-1?Q?Sch=F6nlaub?= <manuel.schoenlaub@gmail.com>
To:     Bastien Nocera <hadess@hadess.net>
Cc:     Filipe =?iso-8859-1?Q?La=EDns?= <lains@riseup.net>,
        jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: logitech-hidpp: support Color LED feature (8071).
Message-ID: <YjvlQrvRS+ZKNbZ5@hermes>
References: <Yifr4etBFPu1a2Ct@hermes>
 <275245e8048fa124055d9ff3d10ce6562294483a.camel@riseup.net>
 <ce3adf7013ba01aad54fb65bf9c657dd9d0b7d23.camel@hadess.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ce3adf7013ba01aad54fb65bf9c657dd9d0b7d23.camel@hadess.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 23, 2022 at 11:24:18PM +0100, Bastien Nocera wrote:
> On Wed, 2022-03-23 at 21:22 +0000, Filipe Laíns wrote:
> > On Tue, 2022-03-08 at 16:50 -0700, Manuel Schönlaub wrote:
> > > The HID++ protocol allows to set multicolor (RGB) to a static
> > > color.
> > > Multiple of such LED zones per device are supported.
> > > This patch exports said LEDs so that they can be set from
> > > userspace.
> > > 
> > > Signed-off-by: Manuel Schönlaub <manuel.schoenlaub@gmail.com>
> > > ---
> > >  drivers/hid/hid-logitech-hidpp.c | 188
> > > +++++++++++++++++++++++++++++++
> > >  1 file changed, 188 insertions(+)
> > 
> > *snip*
> > 
> > Hi Manuel,
> > 
> > Thanks for putting this forward, although I am not sure if this is
> > the best way
> > to handle this.
> > 
> > Before anything, could you elaborate a bit on what lead to you
> > wanting this?
> > 
> > There are a couple of reasons why merging this in the kernel might be
> > problematic.
> > 
> > 1) I don't think we will ever support the full capabilities of the
> > devices, so
> > configuration via userspace apps will always be required, and here we
> > are
> > introducing a weird line between the two.
> > 
> > 2) There is already an ecosystem of userspace configuration apps,
> > with which
> > this would conflict. They might not be in the best maintenance state
> > due to lack
> > of time from the maintainers, but moving this functionality to the
> > kernel, which
> > is harder change, and harder to ship to users, will only make that
> > worse.
> 
> There's already an API for LEDs in the kernel, why shouldn't it be used
> to avoid user-space needing to know how to configure Logitech, and
> every other brand of keyboards?
> 
> systemd has code to save and restore LED status, as well as code to
> change the level of backlight. I can imagine that it wouldn't take much
> to make it aware of RGB LEDs so it handles them properly, whether it's
> for Logitech, or another brand of keyboards, or laptops.

Teaching systemd-backlight about mulicolor backlights might be a nice project
too. But their use case seems to be more about screen backlights as it seems.
Did I overlook something here?

Oh and yeah, IMHO another argument could be that obviously at some point
the LED management could be removed from those user space tools, as the
kernel would already know about them.

After all the LED class devices should be there for a reason ;-)

Cheers,

Manuel

