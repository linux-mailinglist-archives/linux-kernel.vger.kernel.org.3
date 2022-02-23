Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B38E34C120E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 12:58:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240226AbiBWL6y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 06:58:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235992AbiBWL6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 06:58:51 -0500
Received: from re-prd-fep-044.btinternet.com (mailomta28-re.btinternet.com [213.120.69.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D872449682;
        Wed, 23 Feb 2022 03:58:21 -0800 (PST)
Received: from re-prd-rgout-005.btmx-prd.synchronoss.net ([10.2.54.8])
          by re-prd-fep-044.btinternet.com with ESMTP
          id <20220223115819.YGRE28912.re-prd-fep-044.btinternet.com@re-prd-rgout-005.btmx-prd.synchronoss.net>;
          Wed, 23 Feb 2022 11:58:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1645617499; 
        bh=xH2HDukqbX5dvbmogMeWYVzR/wGRlgNjqzbmhBv/HvQ=;
        h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:MIME-Version;
        b=g2uncVR7olpMgOcyVdKW+/fiTVuoRP/9wbW9bcCzILHBGB7XmsBZg+Som/v8JeulKZIVZ93XdeC4fLZBZ09KT9ycMLFhLIul4h0z+GAqzNap62eqP2XZj0JXN6Lq9hKCOc53oqpzL0vXaTdfLk+5mWPwM+AqYkm/BPoaO1dfulICc6BTdSxixKZw8bbAcJXp0f+5t6dxjhaTt9KqWgJhr77iwR3hfa4reADj7eMAjRr3qgpUi7JOCnj+skWWzK8GMJ0QJCJbpaK4OX+yOdCOnCa9wj/SYdvaJyHPaLqcHY0bFSlLl2CgoyDOgs/hfeazC4sqEQKZVih2faafNIsLtw==
Authentication-Results: btinternet.com;
    auth=pass (LOGIN) smtp.auth=richard_c_haines@btinternet.com;
    bimi=skipped
X-SNCR-Rigid: 613A912415D7956E
X-Originating-IP: [109.150.61.96]
X-OWM-Source-IP: 109.150.61.96 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvvddrledtgdeffecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkffuhffvffgjfhgtfggggfesthekredttderjeenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecuggftrfgrthhtvghrnhepjeevteffjeduleetfeeitdfhheekudeutddthfevtefgveelhfegheffheffieeknecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpfhhigidrshgvtghurhhithihnecukfhppedutdelrdduhedtrdeiuddrleeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplgduledvrdduieekrddurdduleekngdpihhnvghtpedutdelrdduhedtrdeiuddrleeipdhmrghilhhfrhhomheprhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhdpnhgspghrtghpthhtohepkedprhgtphhtthhopeguvghmihhosggvnhhouhhrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepvghprghrihhssehprghrihhsphhlrggtvgdrohhrghdprhgtphhtthhopehjvghffhhvsehgohhoghhlvgdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhes
        vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehprghulhesphgruhhlqdhmohhorhgvrdgtohhmpdhrtghpthhtohepshgvlhhinhhugidqrhgvfhhpohhlihgthiesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsvghlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhtvghphhgvnhdrshhmrghllhgvhidrfihorhhksehgmhgrihhlrdgtohhm
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from [192.168.1.198] (109.150.61.96) by re-prd-rgout-005.btmx-prd.synchronoss.net (5.8.716.04) (authenticated as richard_c_haines@btinternet.com)
        id 613A912415D7956E; Wed, 23 Feb 2022 11:58:19 +0000
Message-ID: <20396305e71619dbee4fa3c612925b57f4bb0a4b.camel@btinternet.com>
Subject: Re: [PATCH V2] security/selinux: Always allow FIOCLEX and FIONCLEX
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     stephen.smalley.work@gmail.com, eparis@parisplace.org,
        demiobenour@gmail.com, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, selinux-refpolicy@vger.kernel.org,
        jeffv@google.com
Date:   Wed, 23 Feb 2022 11:58:19 +0000
In-Reply-To: <CAHC9VhQnRQFrM-mTzUQ3UsyVp2JYw1wUh=7yrdjH7-QmHKidAg@mail.gmail.com>
References: <20220221131533.74238-1-richard_c_haines@btinternet.com>
         <CAHC9VhQnRQFrM-mTzUQ3UsyVp2JYw1wUh=7yrdjH7-QmHKidAg@mail.gmail.com>
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

On Tue, 2022-02-22 at 18:28 -0500, Paul Moore wrote:
> On Mon, Feb 21, 2022 at 8:15 AM Richard Haines
> <richard_c_haines@btinternet.com> wrote:
> > 
> > These ioctls are equivalent to fcntl(fd, F_SETFD, flags), which
> > SELinux
> > always allows too.  Furthermore, a failed FIOCLEX could result in a
> > file
> > descriptor being leaked to a process that should not have access to
> > it.
> > 
> > As this patch removes access controls, a policy capability needs to
> > be
> > enabled in policy to always allow these ioctls.
> > 
> > Based-on-patch-by: Demi Marie Obenour <demiobenour@gmail.com>
> > Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> > ---
> > V2 Change: Control via a policy capability. See this thread for
> > discussion:
> > https://lore.kernel.org/selinux/CAHC9VhQEPxYP_KU56gAGNHKQaxucY8gSsHiUB42PVgADBAccRQ@mail.gmail.com/T/#t
> > 
> > With this patch and the polcap enabled, the selinux-testsuite will
> > fail:
> > ioctl/test at line 47 - Will need a fix.
> > 
> >  security/selinux/hooks.c                   | 7 +++++++
> >  security/selinux/include/policycap.h       | 1 +
> >  security/selinux/include/policycap_names.h | 3 ++-
> >  security/selinux/include/security.h        | 7 +++++++
> >  4 files changed, 17 insertions(+), 1 deletion(-)
> 
> Thanks Richard for putting together the v2 of this patch.
> 
> As far as the test is concerned, it seems like the quick-n-dirty fix
> is to simply remove the ioctl(FIOCLEX) test in test_noioctl.c; is
> everyone okay with that?  At least that is what I'm going to do with
> my local copy that I use to validate the kernel-secnext builds unless
> someone has a better patch :)

To fix this I was planning to submit a patch that would change the
ioctl(FIOCLEX) tests to ioctl(FS_IOC_GETFSLABEL) as that would continue
to test the xperms.

> 
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index 5b6895e4f..030c41652 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -3745,6 +3745,13 @@ static int selinux_file_ioctl(struct file
> > *file, unsigned int cmd,
> >                                             CAP_OPT_NONE, true);
> >                 break;
> > 
> > +       case FIOCLEX:
> > +       case FIONCLEX:
> > +               /* Must always succeed if polcap set, else default:
> > */
> > +               if (selinux_policycap_ioctl_skip_cloexec())
> > +                       break;
> > +               fallthrough;
> > +
> 
> The break/fallthrough looks like it might be a little more fragile
> than necessary, how about something like this:
> 
>   case FIOCLEX:
>   case FIONCLEX:
>     if (!selinux_policycap_ioctl_skip_cloexec())
>       error = ioctl_has_perm(cred, file, FILE__IOCTL, (u16) cmd);
>       break;
> 
> Yes, it does duplicate the default ioctl_has_perm() call, but since
> we
> are effectively deprecating this and locking the FIOCLEX/FIONCLEX
> behavior with this policy capability it seems okay to me (and
> preferable to relying on the fallthrough).
> 
> Thoughts?

Yes I did ponder this and in my first attempt I had this before the
switch():

	/* Must always succeed if polcap set */
	if (selinux_policycap_ioctl_skip_cloexec() &&
	    (cmd == FIOCLEX || cmd == FIONCLEX))
		return 0;

 	switch (cmd) {
 	case FIONREAD:
 	case FIBMAP:

but changed to within the switch(), anyway I'm happy to resubmit a
patch either way.

> 

