Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A68984C1305
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 13:43:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240533AbiBWMnx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 07:43:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237798AbiBWMnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 07:43:51 -0500
Received: from re-prd-fep-049.btinternet.com (mailomta17-re.btinternet.com [213.120.69.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38B36A41AE;
        Wed, 23 Feb 2022 04:43:21 -0800 (PST)
Received: from re-prd-rgout-004.btmx-prd.synchronoss.net ([10.2.54.7])
          by re-prd-fep-049.btinternet.com with ESMTP
          id <20220223124320.NRGT31284.re-prd-fep-049.btinternet.com@re-prd-rgout-004.btmx-prd.synchronoss.net>;
          Wed, 23 Feb 2022 12:43:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1645620200; 
        bh=ZUOrQYhFWoe+Vq5v/JYhlfLNQyVSymysY/xsNotSJGE=;
        h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:MIME-Version;
        b=Xnvwswcdh6dxuaV8DAfWxe859tCNKMgIlF07H7hNa3nzybp5EEyO/M01Q//YrJwqKW4GERi3JedZkf+/blWcN5xBGGa9VVu64FOMriC1FEtbkdzdabavA1uzaIXZq+WYzTYCuAPabtfxFJB/UNAwJk5A6L2HYJ4Ewdad1XAGRS6a9IsZsngymhPrgh+vrdVKKaWf1aMOx8qslVjvkEeNXsNQzEtMHhuSID+UsolaS1qalzfGP1R4YgXPUdROU9ZdKcoKz0rhGd7UwOijHMleK3IJVii/hZZ1tHxrxg1Lmj/jg0kYfJim/p4S8+hKYE17+fF1+KKgoGcfEHg62DaK3g==
Authentication-Results: btinternet.com;
    auth=pass (LOGIN) smtp.auth=richard_c_haines@btinternet.com;
    bimi=skipped
X-SNCR-Rigid: 613A901C15D9026E
X-Originating-IP: [109.150.61.96]
X-OWM-Source-IP: 109.150.61.96 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvvddrledtgdegvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkffuhffvffgjfhgtfggggfesthekredttderjeenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecuggftrfgrthhtvghrnhepjeevteffjeduleetfeeitdfhheekudeutddthfevtefgveelhfegheffheffieeknecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpfhhigidrshgvtghurhhithihnecukfhppedutdelrdduhedtrdeiuddrleeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplgduledvrdduieekrddurdduleekngdpihhnvghtpedutdelrdduhedtrdeiuddrleeipdhmrghilhhfrhhomheprhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhdpnhgspghrtghpthhtohepledprhgtphhtthhopeguvghmihhosggvnhhouhhrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepvghprghrihhssehprghrihhsphhlrggtvgdrohhrghdprhgtphhtthhopehjvghffhhvsehgohhoghhlvgdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhes
        vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehomhhoshhnrggtvgesrhgvughhrghtrdgtohhmpdhrtghpthhtohepphgruhhlsehprghulhdqmhhoohhrvgdrtghomhdprhgtphhtthhopehsvghlihhnuhigqdhrvghfphholhhitgihsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsthgvphhhvghnrdhsmhgrlhhlvgihrdifohhrkhesghhmrghilhdrtghomh
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from [192.168.1.198] (109.150.61.96) by re-prd-rgout-004.btmx-prd.synchronoss.net (5.8.716.04) (authenticated as richard_c_haines@btinternet.com)
        id 613A901C15D9026E; Wed, 23 Feb 2022 12:43:20 +0000
Message-ID: <2b45951fceea5f535550f8ab3f3d25c3ff12a8c5.camel@btinternet.com>
Subject: Re: [PATCH V2] security/selinux: Always allow FIOCLEX and FIONCLEX
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, demiobenour@gmail.com,
        SElinux list <selinux@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        selinux-refpolicy@vger.kernel.org,
        Jeff Vander Stoep <jeffv@google.com>
Date:   Wed, 23 Feb 2022 12:43:19 +0000
In-Reply-To: <CAFqZXNuf5J35Jb3nmQ6YRrc6C2f5rk-30U0rB4wTMd-+SBQhEQ@mail.gmail.com>
References: <20220221131533.74238-1-richard_c_haines@btinternet.com>
         <CAHC9VhQnRQFrM-mTzUQ3UsyVp2JYw1wUh=7yrdjH7-QmHKidAg@mail.gmail.com>
         <20396305e71619dbee4fa3c612925b57f4bb0a4b.camel@btinternet.com>
         <CAFqZXNuf5J35Jb3nmQ6YRrc6C2f5rk-30U0rB4wTMd-+SBQhEQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-02-23 at 13:12 +0100, Ondrej Mosnacek wrote:
> On Wed, Feb 23, 2022 at 12:58 PM Richard Haines
> <richard_c_haines@btinternet.com> wrote:
> > On Tue, 2022-02-22 at 18:28 -0500, Paul Moore wrote:
> > > On Mon, Feb 21, 2022 at 8:15 AM Richard Haines
> > > <richard_c_haines@btinternet.com> wrote:
> > > > 
> > > > These ioctls are equivalent to fcntl(fd, F_SETFD, flags), which
> > > > SELinux
> > > > always allows too.  Furthermore, a failed FIOCLEX could result
> > > > in a
> > > > file
> > > > descriptor being leaked to a process that should not have
> > > > access to
> > > > it.
> > > > 
> > > > As this patch removes access controls, a policy capability
> > > > needs to
> > > > be
> > > > enabled in policy to always allow these ioctls.
> > > > 
> > > > Based-on-patch-by: Demi Marie Obenour <demiobenour@gmail.com>
> > > > Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> > > > ---
> > > > V2 Change: Control via a policy capability. See this thread for
> > > > discussion:
> > > > https://lore.kernel.org/selinux/CAHC9VhQEPxYP_KU56gAGNHKQaxucY8gSsHiUB42PVgADBAccRQ@mail.gmail.com/T/#t
> > > > 
> > > > With this patch and the polcap enabled, the selinux-testsuite
> > > > will
> > > > fail:
> > > > ioctl/test at line 47 - Will need a fix.
> > > > 
> > > >  security/selinux/hooks.c                   | 7 +++++++
> > > >  security/selinux/include/policycap.h       | 1 +
> > > >  security/selinux/include/policycap_names.h | 3 ++-
> > > >  security/selinux/include/security.h        | 7 +++++++
> > > >  4 files changed, 17 insertions(+), 1 deletion(-)
> > > 
> > > Thanks Richard for putting together the v2 of this patch.
> > > 
> > > As far as the test is concerned, it seems like the quick-n-dirty
> > > fix
> > > is to simply remove the ioctl(FIOCLEX) test in test_noioctl.c; is
> > > everyone okay with that?  At least that is what I'm going to do
> > > with
> > > my local copy that I use to validate the kernel-secnext builds
> > > unless
> > > someone has a better patch :)
> > 
> > To fix this I was planning to submit a patch that would change the
> > ioctl(FIOCLEX) tests to ioctl(FS_IOC_GETFSLABEL) as that would
> > continue
> > to test the xperms.
> 
> That one seems to be implemented only by some filesystems. Is there
> any more generic one we could use?

What about  FS_IOC_GETFLAGS

> 
> > 
> > > 
> > > > diff --git a/security/selinux/hooks.c
> > > > b/security/selinux/hooks.c
> > > > index 5b6895e4f..030c41652 100644
> > > > --- a/security/selinux/hooks.c
> > > > +++ b/security/selinux/hooks.c
> > > > @@ -3745,6 +3745,13 @@ static int selinux_file_ioctl(struct
> > > > file
> > > > *file, unsigned int cmd,
> > > >                                             CAP_OPT_NONE,
> > > > true);
> > > >                 break;
> > > > 
> > > > +       case FIOCLEX:
> > > > +       case FIONCLEX:
> > > > +               /* Must always succeed if polcap set, else
> > > > default:
> > > > */
> > > > +               if (selinux_policycap_ioctl_skip_cloexec())
> > > > +                       break;
> > > > +               fallthrough;
> > > > +
> > > 
> > > The break/fallthrough looks like it might be a little more
> > > fragile
> > > than necessary, how about something like this:
> > > 
> > >   case FIOCLEX:
> > >   case FIONCLEX:
> > >     if (!selinux_policycap_ioctl_skip_cloexec())
> > >       error = ioctl_has_perm(cred, file, FILE__IOCTL, (u16) cmd);
> > >       break;
> > > 
> > > Yes, it does duplicate the default ioctl_has_perm() call, but
> > > since
> > > we
> > > are effectively deprecating this and locking the FIOCLEX/FIONCLEX
> > > behavior with this policy capability it seems okay to me (and
> > > preferable to relying on the fallthrough).
> > > 
> > > Thoughts?
> > 
> > Yes I did ponder this and in my first attempt I had this before the
> > switch():
> > 
> >         /* Must always succeed if polcap set */
> >         if (selinux_policycap_ioctl_skip_cloexec() &&
> >             (cmd == FIOCLEX || cmd == FIONCLEX))
> >                 return 0;
> > 
> >         switch (cmd) {
> >         case FIONREAD:
> >         case FIBMAP:
> > 
> > but changed to within the switch(), anyway I'm happy to resubmit a
> > patch either way.
> 
> I agree with Paul's suggestion. Better to duplicate the simple call
> than to complicate the code flow.

Okay will use Paul's.

> 

