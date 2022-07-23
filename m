Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A91857F12F
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 21:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236194AbiGWT22 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 15:28:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbiGWT2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 15:28:25 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03FC41A803;
        Sat, 23 Jul 2022 12:28:16 -0700 (PDT)
Received: from leknes.fjasle.eu ([46.142.49.77]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1N0G9p-1nJwwl29Rv-00xO4Q; Sat, 23 Jul 2022 21:27:40 +0200
Received: by leknes.fjasle.eu (Postfix, from userid 1000)
        id 9155C3C0AD; Sat, 23 Jul 2022 21:27:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fjasle.eu; s=mail;
        t=1658604452; bh=5dOBQSoGfDi2GpyYLUB7CO3HcDaHKUtWgbJke65oXTc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=orMNljqk+ulcwjzM2c6TW5a71GPVV3k+fVeiiMEO4zmcA12hQkSJPmJwm/CSOOXTZ
         9c9754lP2DMnl4E0EjMPzWbRMYz18fY0njrgUuLxZmgKdcsDis+02V5RI+l3Ff+bJ+
         a8S81rekIOVeVwN2caxtQQfwbzYgyCfDhxUfoOMQ=
Date:   Sat, 23 Jul 2022 21:27:32 +0200
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>, Rob Herring <robh@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kbuild: add dtbs_prepare target
Message-ID: <YtxLpPj0djE31TF+@fjasle.eu>
References: <20220716093122.137494-1-masahiroy@kernel.org>
 <Ytp4PyBcCfRsVaG5@bergen.fjasle.eu>
 <CAK7LNASFLKfDaPgWRzq2dw0939eLbcn5Y4A-qtSEfZs9BDecRg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK7LNASFLKfDaPgWRzq2dw0939eLbcn5Y4A-qtSEfZs9BDecRg@mail.gmail.com>
X-Provags-ID: V03:K1:wR4IwQRS/1Mifo7X+NbINbAXF5HoSVGNQYQz0U29GcAYHmGu7nG
 tafFuOVWjGGfVcRwfI3aM3l4XC7MBBWRKjsfv/RcRHPPijng2ctuO9dbaVPmcSG/vE+dj1Q
 558tPWuW8hCEmlYjWaUKkKqKuEYDKxMqvKQ0SBMXZYmIHVt0kVxEr/AVCqFxG4KsZEgFrS2
 jntijyJeitSOVXi9ds5Ng==
X-UI-Out-Filterresults: notjunk:1;V03:K0:r7XI++cQT70=:T9sc2ikKwR00BAwnHqGh1i
 TR1zyVuyFPFcPJk2CVDVKKOrZY+Q8QuvIA3r0WlQDDrFuRDqVRCBsloqOthIifQ2g1t5dzAlR
 KJIWQyRR4enhOOOEGlucixRFpB7TvbSM6OyGV9yVjJiwbLOE/GGRG8s20KHxOlsT/FhweUEEh
 5cWxZ+a/rJXgkUaG2Ywe4gaB04Gnupot5t06GUqiDAdZa9eP2clZ1+RLBYVwMWaMYCIklJNTM
 9SxHS7ot42mOUrpdP6wrKYM3dLdVXe3Mdx9iEE6kGqk3bVlrQyfQY8+Tj3F21/KvhMU676ex5
 LKOVNd5gVVwB2i0+mpCgIjjwUK/lxamsbnth2QgpASNjr/ucgo2xKkyShQmSGJ6YhIlUyxHNM
 DF4yQvEqa/hVEvBH5p1VeZauy/ZegmXJOHc+c4+MLAYc9wGeqaM0LhmpJoqMr+ArDG/dWvlO0
 Qg/xSrmJ+mwLaK+gIEq0j6T8tFdmPsSmFTPu08InWktMEaxb0341So4grjjmDwEkXIrqgMqVG
 nERMN4zb4ySxXaWlyk0Cah+NYe1jI7aAZ8w6VhRAIkq5K14rE0AJIu331bUj063LccgVfHjkq
 412+X9ayQfZ6yc/4eW5ZzfNVCLubDEl/izS/6SfE/LO6Rc1Caqg5wzllM6qpzfqLw4jC4k0Gv
 Yqn3lbcl2G5hx2EEn6i2bU30KAP1WKJigtGxgzbXaP5Ayp+AHEAcLzRCtZDINO7pfaHFZrXIu
 9RZgcZqz9PPyyQdI4b/BeClgeYezRLO1VxW/jQ==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 23, 2022 at 09:33:03AM +0900, Masahiro Yamada wrote:
> On Fri, Jul 22, 2022 at 7:14 PM Nicolas Schier <nicolas@fjasle.eu> wrote:
> >
> > On Sat, 16 Jul 2022 18:31:22 +0900 Masahiro Yamada wrote:
> > > Factor out the common prerequisites for DT compilation into the new
> > > target, dtbs_prepare.
> > >
> > > Add comments in case you wonder why include/config/kernel.release is
> > > the prerequisite. Our policy is that installation targets must not
> > > (re)compile any build artifacts in the tree. If we make modules_install
> > > depend on include/config/kernel.release and it is executed under the
> > > root privilege, it may be owned by root.
> > >
> > > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > > ---
> > >
> > >  Makefile | 14 ++++++++++----
> > >  1 file changed, 10 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/Makefile b/Makefile
> > > index a9bd55edb75e..8aa4dbb8f878 100644
> > > --- a/Makefile
> > > +++ b/Makefile
> > > @@ -1367,16 +1367,22 @@ endif
> > >
> > >  ifneq ($(dtstree),)
> > >
> > > -%.dtb: include/config/kernel.release scripts_dtc
> > > +%.dtb: dtbs_prepare
> > >       $(Q)$(MAKE) $(build)=$(dtstree) $(dtstree)/$@
> > >
> > > -%.dtbo: include/config/kernel.release scripts_dtc
> > > +%.dtbo: dtbs_prepare
> > >       $(Q)$(MAKE) $(build)=$(dtstree) $(dtstree)/$@
> >
> > Is there a reason, why both rules are not unified?  I guess it is, but
> > I can't see it.
> 
> 
> 
> See the GNU Make manual:
> https://www.gnu.org/software/make/manual/html_node/Pattern-Examples.html
> 
> The last paragraph, "This pattern rule has two targets ..."
> 
> 
> 
> %.dtb %.dtbo: dtbs_prepare
>          ...
> 
> means foo.dtb and foo.dtbo are generated at the same
> time by the rule.  This is strange.

uh, I'm working with Makefile since years but I wasn't aware of that. Thanks a
lot for the pointer and explanation!

Kind regards,
Nicolas

> 
> >
> > >
> > > -PHONY += dtbs dtbs_install dtbs_check
> > > -dtbs: include/config/kernel.release scripts_dtc
> > > +PHONY += dtbs dtbs_prepare dtbs_install dtbs_check
> > > +dtbs: dtbs_prepare
> > >       $(Q)$(MAKE) $(build)=$(dtstree)
> > >
> > > +# include/config/kernel.release is not actually required for building DTBs,
> > > +# but for installing DTBs because INSTALL_DTBS_PATH contains $(KERNELRELEASE).
> > > +# We do not want to move it to dtbs_install. The policy is installation
> > > +# targets (, which may run as root) must not modify the tree.
> >
> > Is the comma after the opening parenthesis intended?
> 
> 
> I will rephrase the comment in v2.
> 
> 
> 
> 
> >
> > Kind regards,
> > Nicolas
> >
> > > +dtbs_prepare: include/config/kernel.release scripts_dtc
> > > +
> > >  ifneq ($(filter dtbs_check, $(MAKECMDGOALS)),)
> > >  export CHECK_DTBS=y
> > >  dtbs: dt_binding_check
> > > --
> > > 2.34.1
> 
> 
> 
> -- 
> Best Regards
> Masahiro Yamada

-- 
epost|xmpp: nicolas@fjasle.eu          irc://oftc.net/nsc
↳ gpg: 18ed 52db e34f 860e e9fb  c82b 7d97 0932 55a0 ce7f
     -- frykten for herren er opphav til kunnskap --
