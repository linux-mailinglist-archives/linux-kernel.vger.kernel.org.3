Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5B9250D0D2
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 11:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238807AbiDXJfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 05:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235905AbiDXJfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 05:35:45 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 458B11EED0;
        Sun, 24 Apr 2022 02:32:45 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id j15so3621002wrb.2;
        Sun, 24 Apr 2022 02:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ihBOps3aqfFGtyAnjbwJw3NFhLQ2itqLG+oaeiipt2o=;
        b=Wysgh/5jB+pe0wLmoUMwLkv0Wf0DzYM8dZMuDYy/NcUbfZThR4gjlnMrOEK8/QcY6b
         wRBhQXLaxa0nXEx2L8PsAYsSH3dFjhs0WviGWqrTb6/Jdl/XMm0mmNHcde9912/6MNc4
         wl9c+1APpP0rk1ZWw6ydHMZ7YGhFu0zJ/Hrf5LIxSuGhHJkp/9To6bk9PQZMOi5ck3Qh
         Qp/VWRpl4eVTbO0Zkc4urC6ElH7FEPR1qUh/eI6parxap8JC+cSOWO5qWsSvuz6mWdgN
         Bzvy7/s4Utz1W7kHdkf90jfVUpCzI+a2ikSnaBgyATxsez7kDzErn3RS/v3sId+zU6l9
         MoHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ihBOps3aqfFGtyAnjbwJw3NFhLQ2itqLG+oaeiipt2o=;
        b=e9yJo/DhDQt+vJGJcd3Gyaj7Mrvf6jPi2nmI8hW8JteZYSD/WExGNLhMO0XwVJvfph
         BPFeZQthmtb8URRNFiaMM6I7G/Xy6fSVon0cDJqya9Bnx/oe/rf1h6GZGu3uCkXlehU8
         fCEjzxu8KAz+6teaJxleJSJU67z/kLPWMEs6XDFiH3je9o7/xf5z3jMv+6+2ss/W7e/l
         9yIOX5Tw5MszU6XQBtaIf4i9wq52I8N/8SnPCK9OBSExJGuqSExQJZ3C1bTBk/X8oFzL
         LQbB8+Ef7fFmADZrnO86AmGFLv8xVYivq7qWtP4fmtLFspPwE0HezCuA7r+jt4+eYALt
         yboA==
X-Gm-Message-State: AOAM532TRbZkp4ZJkyM0vYWxNKcPMemGe1Fnop2v4kJzc92DixezvdTL
        lKo/+8sUFtyxRptD68dy8MI=
X-Google-Smtp-Source: ABdhPJzraQqtj+/Gy7TVenq61g+3wc/zfRNPK3Oc5EpStPMjIn+lPmL8UxmX2ckJkwLGn1VvJRZDtA==
X-Received: by 2002:adf:dc0b:0:b0:20a:a549:d3a6 with SMTP id t11-20020adfdc0b000000b0020aa549d3a6mr9908630wri.34.1650792763634;
        Sun, 24 Apr 2022 02:32:43 -0700 (PDT)
Received: from elementary ([94.73.37.128])
        by smtp.gmail.com with ESMTPSA id g3-20020a5d64e3000000b0020aaa0fea8bsm5930096wri.49.2022.04.24.02.32.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Apr 2022 02:32:43 -0700 (PDT)
Date:   Sun, 24 Apr 2022 11:32:39 +0200
From:   =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
To:     Stefan Berzl <stefanberzl@gmail.com>
Cc:     jikos@kernel.org, benjamin.tissoires@redhat.com, spbnick@gmail.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Status on hid xppen patch
Message-ID: <20220424093239.GA4380@elementary>
References: <941a793a-d2f7-9c2c-59be-b3930e1acfec@gmail.com>
 <20220423172330.32585-1-jose.exposito89@gmail.com>
 <95576534-1f5e-c2e3-4f73-c1b0a8300b56@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <95576534-1f5e-c2e3-4f73-c1b0a8300b56@gmail.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stefan,

On Sun, Apr 24, 2022 at 01:19:30AM +0200, Stefan Berzl wrote:
> >> Hello everynyan!
> >>
> >> A while ago I sent in a patch to add support for newer Xp-pen tablets 
> >> that even made it into patchwork:
> >>
> >> https://patchwork.kernel.org/project/linux-input/patch/b401e453-9c66-15e3-1a1d-21f33b7a64e8@gmail.com/
> >>
> >> I have never actually gotten any feedback on it though and am wondering 
> >> if everything is to your liking. Anyway it doesn't build against the 
> >> current tree anymore. Assuming there is any value it, should I rewrite 
> >> it against hid master or hid uclogic?
> >>
> >> Many thanks
> >>
> >> Stefan Berzl
> > 
> > Hi Stefan,
> > 
> > I just saw your email in the mailing list.
> > 
> > Your patch doesn't apply against the current tree because of the changes
> > from Nikolai/the DIGImend project I'm sending upstream. For reference,
> > here is the latest batch of patches, with links to the previous ones:
> > 
> > https://lore.kernel.org/linux-input/20220421175052.911446-1-jose.exposito89@gmail.com/T/
> > 
> > Please note that I'm not the maintainer of the driver, I'm just a web
> > developer who does free software as a hobby, i.e., this is not my area
> > of expertise, so take my words as suggestions, not as the path to
> > follow ;)
> > 
> > The development of the uclogic driver takes place on the DIGImend
> > project (inactive right now):
> > https://github.com/DIGImend/digimend-kernel-drivers
> > 
> > Like you, I wanted to add support for my tablet/improve my kernel
> > dev skills, but I noticed that I needed some patches from DIGImend, so,
> > instead of taking what I needed, I decided to upstream all the patches.
> > 
> > At the moment of writing this email, 24 patches from DIGImend have been
> > merged, 5 are under review and 7 more need to be sent. We are close to
> > the end.
> > 
> > My tablet (Parblo A610 PLUS V2) also needs some magic data to be enabled.
> > Actually, the data is pretty similar to the one in your patch.
> > You can see my implementation here:
> > https://github.com/JoseExposito/linux/commit/f1f24e57fab45a2bcf4e0af5ba9d8f5a2245670b
> > 
> > I just refactored my patch and extracted the code to send the magic data
> > to its own function (uclogic_probe_interface), so we can share it.
> > 
> > I'd suggest rebasing your code on top of DIGImend's code + my patch
> > so we can share some code and once all patches are upstream, you can
> > send it with minor or without conflicts.
> > 
> > What do you think?
> > 
> > José Expósito
> > 
> 
> Hello José,
> 
> nice hearing from you. I was actually thinking of just asking if you
> want to take my patch under your wing, since you seem to be doing a lot
> of uclogic related work. But your idea is even better, just submitting  
> my patch once everything has settled down seems to be the way to go.

Cool, let's do that. I'll cc you on the last batch of patches so you
get notified when they get merged.
 
> You are actually the first person to ever contact me about this. I was  
> pretty worried that the patch is no good, but then I saw that there is  
> quite a backlog in the maintainers patchwork and some of your patches
> haven't been reviewed either. Originally I tried showing it to Nikolai,
> but he said he was rather busy too and then some guys in the Digimend
> project tried to get me interested in some userspace driver that works  
> around all the issues of like init-packets and stuff. I always imagined
> the kernel as this highly organzied, well-structured endeavor where
> things would be quickly scrutinized and suggestions offered to assure 
> the highest quality. Yet here we have two web developers working on the
> graphics tablet driver. Let me say that it's really great you take the
> time and effort to mainline these patches and help everyone enjoy their
> tablets on linux!

Well, the kernel is well-structured, but as you mentioned, there is a
*lot* of work on the maintainers side and I think there is not a big
community supporting this driver. It's normal that it takes some time
to get everything reviewed.

> On the technical side, the magic bytes really are very similar, the only
> difference being the two additional trailing 0x00 for mine. Also my
> tablet sends a response after activating this new interface which can 
> get interpreted as a button press if it's not discarded. Is there a nice
> way to work around this, with subreports or anything?

Same here, my tablet responds with: 02 b1 04 00 00 00 00 00 00 00.

In my case, button presses look like: 02 F0 XX XX 00 00 00 00 00 00.
Because of the 0xF0 subreport, I think this data gets ignored, but I'll
do some extra testing just in case.

How did you test it?

> Lastly, do you have an idea in which kernel version the bulk of your
> patches will have been merged, just so I know when to start looking at
> this again? I don't mean to belittle the kernel maintainers of course,  
> for I am sure they have more pressing and difficult issues on their
> plate, like eBPF and such.   

I couldn't tell, I can imagine that 5.19 or 5.20. Anyway, I'll cc you
so you can have a good idea about what's going on.

Best wishes,
José Expósito

> Lets fixie wixie this fucksy uppsy!
> 
> Bye
> 
> 
> Stefan Berzl
