Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C92294C4E75
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 20:14:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234432AbiBYTPV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 14:15:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234423AbiBYTPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 14:15:20 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 790C221CD21
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 11:14:47 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id j10-20020a17090a94ca00b001bc2a9596f6so5669337pjw.5
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 11:14:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6TzSVbO7CAlKKKNDPMiJF1hXMClDXXEAlVuEkRBMQjc=;
        b=LUCZd9vts6uMIQJI0tEJIJ1Tgn0YV2D9weQmTNVOx+Sa7lnTj821tU5iGiRgnn92ud
         UUjkrvTANrtlKCA4rI2PrDPqN+wGgc/23Nnn6psw6iza7bba+5WmqZC2SpxvyO94a+XX
         U4YBr0mwcqXFDNTY/D4S/+imbp1lQYSz2DMog=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6TzSVbO7CAlKKKNDPMiJF1hXMClDXXEAlVuEkRBMQjc=;
        b=wdpIRjuYn4sp4xZwUen9Ci6zRJcyEFOm52QkDHaqgPuwBG6Aq46ChCaqTWJDAHPvlw
         865z6nvGt/HdEHoBINUl6Y8prfWN+5IYUHTqWCNN/K65PSDxyO3QcBjmSXvW8xRB3fBi
         80HudgtmnLucRnaAaqcYutvWISB+y+LVefEW6rpsaZ8h9w0uXNvwS9oOqFhIkITWsA4A
         jUUOu/QAi8VDwCXxghjUhlVqyG+wn2CezoofNOaD39q03ml++nHNbG3f9uWukahy7XnQ
         JxG7kLgzXNo5v1jZTR2I95jsUcnpJJZ1/bTH+SMSAZn9C4Clwc6bAQ9oA7PYfrXi2WwR
         ZEQw==
X-Gm-Message-State: AOAM530HF2ri3t2HAqGhPdDs+n95GLeQMovdXJtmzK6e0RafXq32xjm0
        YpJoMmGWDEhil0cTlON/0Ss/Vw==
X-Google-Smtp-Source: ABdhPJzTngnc6l31QB7geRC3iMZbzricw6FfFuGhk/CFHb1cGs09hkdNs/yO12Ae5ugrCxFXtuQ8/g==
X-Received: by 2002:a17:90a:6882:b0:1bc:495:45e0 with SMTP id a2-20020a17090a688200b001bc049545e0mr4587824pjd.208.1645816486946;
        Fri, 25 Feb 2022 11:14:46 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k13-20020a056a00134d00b004f35ee59a9dsm4533557pfu.106.2022.02.25.11.14.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 11:14:46 -0800 (PST)
Date:   Fri, 25 Feb 2022 11:14:44 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stefano Zacchiroli <zack@upsilon.cc>,
        Steven Rostedt <rostedt@goodmis.org>,
        Laura Abbott <labbott@kernel.org>,
        Julia Lawall <julia.lawall@inria.fr>,
        Wenwen Wang <wenwen@cs.uga.edu>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] Documentation/process: Add Researcher Guidelines
Message-ID: <202202251114.058F4EB3@keescook>
References: <20220224001403.1307377-1-keescook@chromium.org>
 <20220224010030.GA1282918@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220224010030.GA1282918@embeddedor>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 23, 2022 at 07:00:30PM -0600, Gustavo A. R. Silva wrote:
> On Wed, Feb 23, 2022 at 04:14:03PM -0800, Kees Cook wrote:
> > As a follow-up to the UMN incident[1], the TAB took the responsibility
> > to document Researcher Guidelines so there would be a common place to
> > point for describing our expectations as a developer community.
> > 
> > Document best practices researchers should follow to participate
> > successfully with the Linux developer community.
> > 
> > [1] https://lore.kernel.org/lkml/202105051005.49BFABCE@keescook/
> > 
> > Co-developed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Co-developed-by: Jonathan Corbet <corbet@lwn.net>
> > Signed-off-by: Jonathan Corbet <corbet@lwn.net>
> > Co-developed-by: Stefano Zacchiroli <zack@upsilon.cc>
> > Signed-off-by: Stefano Zacchiroli <zack@upsilon.cc>
> > Co-developed-by: Steven Rostedt <rostedt@goodmis.org>
> > Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
> > Acked-by: Steve Rostedt <rostedt@goodmis.org>
> > Acked-by: Laura Abbott <labbott@kernel.org>
> > Reviewed-by: Julia Lawall <julia.lawall@inria.fr>
> > Reviewed-by: Wenwen Wang <wenwen@cs.uga.edu>
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> 
> Acked-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> 
> See a comment below...
> 
> > ---
> >  Documentation/admin-guide/index.rst           |   1 +
> >  .../admin-guide/researcher-guidelines.rst     | 141 ++++++++++++++++++
> >  2 files changed, 142 insertions(+)
> >  create mode 100644 Documentation/admin-guide/researcher-guidelines.rst
> 
> [..]
> 
> > +* What is the specific problem that has been found?
> > +* How could the problem be reached on a running system?
> > +* What effect would encountering the problem have on the system?
> > +* How was the problem found? Specifically include details about any
> > +  testing, static or dynamic analysis programs, and any other tools or
> > +  methods used to perform the work.
> > +* Which version of Linux was the problem was found on? Using the most
> 
> I think there is an extra "was" in the question above.

Oops! Thanks; I'll fix it. :)

-- 
Kees Cook
