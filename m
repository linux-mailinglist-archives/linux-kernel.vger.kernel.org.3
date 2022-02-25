Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B94954C4E21
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 19:55:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233780AbiBYSzr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 13:55:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233682AbiBYSzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 13:55:42 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 035DB1CBAB7
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 10:55:08 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id v4so5565295pjh.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 10:55:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3G8GLcsZ8TrBRC+vyuxIFFQQn6OCbNp1Ve7E2rgmM3Q=;
        b=E2M+MRUq5GKrNDVaVFM2PHjt7vpkcy9YyiyOu6Da4s8joDjCn8XJr9uWMohcSXzVdS
         lA+agkhg3n57B9iyWnXZxTU7Nb+7Lzv5UUMo8wxk++jYNY5ziJKwzoEs6/9hp3jicJKy
         FONbQsGQTNOXgpvrC/vymFPlJHT7yRGf/Qks4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3G8GLcsZ8TrBRC+vyuxIFFQQn6OCbNp1Ve7E2rgmM3Q=;
        b=IItEpJIe0N82qZN1fZBAo2PpvruD95UrMBwZEuthBJyOpYrybiPMLl+vse4guF2Qxg
         n9nRPMrCR96Mp9OuCoN4IkrKXvrsKvZMa9uSvG5bWrWJ0SPZ7nOoaWfpN8H740qvX4m/
         QeoA2LWMr4U7J37OOztom27ZZUVXqE1Vo+q4UinalDGOhItTa82L3Ttof4WrIKZq3D92
         yPIQOmKiES3+l4L+dtUW9MRC1Tp2jWT1YVzayqI5ZZWAiYhpk60AGmYmGQ7BiTUZaxJi
         59iFdw/5zGjioPsZdvlKIXxPb8anernB4abY5sfEA7YvlnoOLTnDnHuoydic4tQzQxZh
         +tpA==
X-Gm-Message-State: AOAM531gzgSp0jdzLj7v63qC8dVvSiZoCodoP2zrmTV2DJeRJP5siolz
        p8P039EJLyPJ3NofkwNQO+dKp8feAEXxTw==
X-Google-Smtp-Source: ABdhPJwelgtdqCD8aLtDkOXgZlZYmeiX3XAFTym52vAMUNrpD6bh6maPifeeHpzEx0UTvEB9a8/QNw==
X-Received: by 2002:a17:90a:c296:b0:1bc:7a6e:623b with SMTP id f22-20020a17090ac29600b001bc7a6e623bmr4512775pjt.68.1645815307360;
        Fri, 25 Feb 2022 10:55:07 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y5-20020a056a00190500b004f104b5350fsm4346076pfi.93.2022.02.25.10.55.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 10:55:07 -0800 (PST)
Date:   Fri, 25 Feb 2022 10:55:06 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Thorsten Leemhuis <linux@leemhuis.info>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stefano Zacchiroli <zack@upsilon.cc>,
        Steven Rostedt <rostedt@goodmis.org>,
        Laura Abbott <labbott@kernel.org>,
        Julia Lawall <julia.lawall@inria.fr>,
        Wenwen Wang <wenwen@cs.uga.edu>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] Documentation/process: Add Researcher Guidelines
Message-ID: <202202251044.F509C7F3@keescook>
References: <20220224001403.1307377-1-keescook@chromium.org>
 <974cf8f2-06f3-99a5-9a77-6d7b7cc8271a@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <974cf8f2-06f3-99a5-9a77-6d7b7cc8271a@leemhuis.info>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2022 at 09:19:24AM +0100, Thorsten Leemhuis wrote:
> On 24.02.22 01:14, Kees Cook wrote:
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
> > ---
> >  Documentation/admin-guide/index.rst           |   1 +
> >  .../admin-guide/researcher-guidelines.rst     | 141 ++++++++++++++++++
> 
> Hmm, the intro for "Documentation/admin-guide/" states that "The
> following manuals are written for users of the kernel", but the added
> text afaics providing nothing regular users care about. So wouldn't it
> be better if this lived below Documentation/process/ ? It might not a
> really good fit either, but I'd say it's the better place.
> 
> But well, the best person to know is Jonathan, who is listed as a
> Co-developer above, so maybe I'm wrong my suggestion is a bad one.

I started in process/ and eventually settled on admin-guide/ since that's
basically the "front page". But I agree, there isn't an obviously correct
place for it.

> > +Researcher Guidelines
> > ++++++++++++++++++++++
> > +
> > +The Linux kernel community
> 
> Nitpicking: wondering if this maybe should be something like "The Linux
> kernel developer community" (or "Linux kernel's..."?).

The idea was to lot limit this to strictly developers. (i.e. cast a wide
net.)

> [...]
> > +Passive research that is based entirely on publicly available sources,
> > +including posts to public mailing lists and commits to public
> > +repositories, is clearly permissible. Though, as with any research,
> > +standard ethics must still be followed.
> > +
> > +Active research on developer behavior,
> 
> Nitpicking: when reading this for the first time I here wondered what is
> precisely meant by "Active research". Is this maybe an established term
> in academia I'm simply not aware of? If not, maybe simply writing
> something like "Other research on developer behavior" or "Research on
> developer behavior where you engage in development" avoid this.
> 
> > however, must be done with the
> > +explicit agreement of, and full disclosure to, the individual developers
> > +involved. Developers cannot be interacted with/experimented on without
> > +consent; this, too, is standard research ethics.
> > +
> > +To help clarify: 
> 
> Follow up to above remark: If "Active research" stays above, I'd say it
> might be worth repeating the term here to make clear what's being clarified.

Hm, yeah, it was a "passive" / "active" comparison, in the sense of
trying to describe what is examining subject's artifacts (passive)
and interacting with subjects (active).

I don't think it's an academic term, but rather an engineering term?

> > sending patches to developers *is* interacting
> > +with them, but they have already consented to receiving *good faith
> > +contributions*. Sending intentionally flawed/vulnerable patches or
> > +contributing misleading information to discussions is not consented
> > +to. Such communication can be damaging to the developer (e.g. draining
> > +time, effort, and morale) and damaging to the project by eroding
> > +the entire developer community's trust in the contributor (and the
> > +contributor's organization as a whole), undermining efforts to provide
> > +constructive feedback to contributors, and putting end users at risk of
> > +software flaws.
> 
> Nitpicking again: Quite a long sentence. Maybe split it up with
> something like a "s!, undermining !; such an approach would thus undermine"

Yeah, I can tweak this. That did bother me a little too.

> > +Participation in the development of Linux itself by researchers, as
> > +with anyone, is welcomed and encouraged. Research into Linux code is
> > +a common practice, especially when it comes to developing or running
> > +analysis tools that produce actionable results.
> > +
> > +When engaging with the developer community, sending a patch has
> > +traditionally been the best way to make an impact. Linux already has
> > +plenty of known bugs -- what's much more helpful is having vetted fixes.
> > +Before contributing, carefully read the documentation on
> > +:doc:`submitting patches <../process/submitting-patches>`,
> > +:doc:`reporting issues <reporting-issues>`, and
> > +:doc:`handling serious flaws <security-bugs>`.
> 
> Wonder if Documentation/process/{development-process.rst,5.Posting.rst}
> should be linked as well.

I wasn't sure what the balance should be between not enough and too much
information. :)

> Additionally not my area of expertise, but from what I'd noticed it
> seems it's better to avoid the :doc:`foo` tag if there is no strict need
> (and I don't think there is one in this case). For the background see here:
> 
> https://lore.kernel.org/all/cover.1623824363.git.mchehab+huawei@kernel.org/
> 
> Most of those patches got applied meanwhile afaik.

Oh! Thanks for pointing that out; I'll drop all of that.

> [...]
> > +If you are a first time contributor it is recommended that the patch
> > +itself be vetted by others privately before being posted to public lists.
> > +(This is required if you have been explicitly told your patches need
> > +more careful internal review.) These people are expected to have their
> > +"Reviewed-by" tag included in the resulting patch. Finding another
> > +developer familiar with Linux contribution, especially within your own
> > +organization, and having them help with reviews before sending them to
> > +the public mailing lists tends to significantly improve the quality of the
> > +resulting patches, and there by reduces the burden on other developers.
> 
> I like the section, but I wonder why it's needed here. Is there anything
> specific to patches produced from research in it there I missed when
> reading it? If not: Wouldn't it be better to include that section as a
> TLDR in Documentation/process/submitting-patches.rst and point there
> instead? We already have at least two places describing how to submit
> patches, creating yet another one (even if it's just in such a brief
> version) somehow feels slightly wrong to me.

Yeah, there is some redundancy here, but I wanted to have an example
specifically tuned to the scenario of really fleshing out the parts we'd
expect from a researcher to help show what context developers are
expecting.

Thanks for the review!

-Kees

-- 
Kees Cook
