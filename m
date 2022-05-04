Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3312651A377
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 17:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352021AbiEDPR4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 11:17:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352059AbiEDPRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 11:17:36 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D971B433BE
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 08:13:23 -0700 (PDT)
Received: from leknes.fjasle.eu ([46.142.49.211]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MMG6Y-1nVIKn0MnG-00JI3R; Wed, 04 May 2022 17:13:19 +0200
Received: by leknes.fjasle.eu (Postfix, from userid 1000)
        id 166813C09D; Wed,  4 May 2022 17:13:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fjasle.eu; s=mail;
        t=1651677197; bh=Zv48oCzX9aTpHMu1wZ0vo7qNppWpmqFd71bIQLuKUTE=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=nZ4IohC1j17rhy6Ts2/HAz8kewnFrVPlqY/zMG6gxsMlsi9tYrPp4FweddQMMEAGo
         SeedqXYq/W8Sz1WbzV8AskHEAXgokNqPlV1cWkNAJnk0PjH2bcNu9SpF7lmZfzumFi
         OMrzVCoWVh+shHeat6OvTo2WcV0i6zTL5YQWFSYg=
Date:   Wed, 4 May 2022 17:13:16 +0200
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     David Howells <dhowells@redhat.com>, linux-cachefs@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [RESEND] fscache: re-match MODULE_PARM_DESC() calls to
 module parameters
Message-ID: <YnKYDC+HfPwRn7HK@fjasle.eu>
References: <YTX02eiVawkpTquX@fjasle.eu>
 <YaCRLx0/CvrxqlZM@lillesand.fjasle.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YaCRLx0/CvrxqlZM@lillesand.fjasle.eu>
X-Provags-ID: V03:K1:wPd6Jf8Xp9Zv/e8vFx7zpmOSZJrBclPeRnq6itMigLx2L/JLUYY
 uThv0mv+ELkdLDsZAUjSH9H9EkVgnRco45PrbkoQ6L3ER4ePAzpuiaBX5AftD/f+qsnpJHV
 XoZ6o7uRh/ZHd6laazvxyRi4JXXS13rMYqHSwyCDC06b83IrjE2d7G5LxBMRXw5+miagL9x
 dyL1sLWc2sMVIzgNuo5HA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xC8m4VFD3n4=:6SzFYO5oAHhVVFjM/AWN2O
 HFz9rGR6PrXnRWK2NxPCUXvJUwF9Leousc3AnkgzGEIm6lkSl710rrpipIZuV0B9KzhG8Qnhn
 k0S5vqSVYumoIugKQwxpnFTUaETaAGWadgcsaz8RgmI8urDUQNkBkNDjGcDOQHh1zgFKUhkxr
 V0t2m8BJTF20DDdVB79kKyc1a7y+Z4cySlJwdoVaT4kdKCeKV2jPlMASrBKLg76IixOR0ALNf
 UvlnuVasBAlkYKeQ2SjaIwVnVBCMND84vOk4nTvYDBwyvYg4pkOY/OOsk8IEYO+IsSSZ5ymZ4
 eyEgyK7B97VNak3NVD1w+bPaZe937MuuNiM2LkFhs3lNYAYogIDbsVSxyzpT7JcBmwdvJkCUo
 eUva3ezZ52jXr9JiYaXI/fYitVd5nnpoTr9tzq1uKmSdYaHIuex2BW/dRrma1BKG6LvjydH4Y
 hnETsjzz6xF+5X+li4b1sg6LHiH/Ky4Xd930pacfsl8Gp+ztI9ptcJ4IhfisCCKQ64DA56n9k
 oFVCuQnB5n+Nqt2mohUuQw15X4g/KEYTEMG7LN4gNHvSZTkyqon//eSy2VIeWayk8FP1coZli
 8eFbgde/wfzCP4k42Dxh3QoRAtWJkzhksd9/a1kQ72gK88TT632+bmpb6uOBW+GBmEWVBTeqK
 xqnpTWaMaEcsYsDuQyVNstVsQVDTCyIOjzGkNEqA3ZtFsGuuwjEq8vkwrBLeXYICiyv8=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 26, 2021 at 08:47:59AM +0100 Nicolas Schier wrote:
> On Mon Sep  6 13:00:41 2021 Nicolas Schier wrote:
> > Fix calls of MODULE_PARM_DESC() such that the first argument matches 
> > the
> > actual module parameter name.  This changes the 'parm' section in the
> > output of `modinfo fscache` from:
> > 
> >     parm: defer_lookup:uint
> >     parm: fscache_defer_lookup:Defer cookie lookup to background thread
> >     parm: defer_create:uint
> >     parm: fscache_defer_create:Defer cookie creation to background thread
> >     parm: debug:uint
> >     parm: fscache_debug:FS-Cache debugging mask
> > 
> > into:
> > 
> >     parm: defer_lookup:Defer cookie lookup to background thread (uint)
> >     parm: defer_create:Defer cookie creation to background thread (uint)
> >     parm: debug:FS-Cache debugging mask (uint)
> > .
> > 
> > Signed-off-by: Nicolas Schier <nicolas@fjasle.eu>
> > ---
> >  fs/fscache/main.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > --
> > Resend unmodified as list approval for linux-cachefs@r.c timed out.
> > 
> > diff --git a/fs/fscache/main.c b/fs/fscache/main.c
> > index c1e6cc9091aa..ccb06dc0a6e9 100644
> > --- a/fs/fscache/main.c
> > +++ b/fs/fscache/main.c
> > @@ -22,19 +22,19 @@ MODULE_LICENSE("GPL");
> >  unsigned fscache_defer_lookup = 1;
> >  module_param_named(defer_lookup, fscache_defer_lookup, uint,
> >  		   S_IWUSR | S_IRUGO);
> > -MODULE_PARM_DESC(fscache_defer_lookup,
> > +MODULE_PARM_DESC(defer_lookup,
> >  		 "Defer cookie lookup to background thread");
> >  
> >  unsigned fscache_defer_create = 1;
> >  module_param_named(defer_create, fscache_defer_create, uint,
> >  		   S_IWUSR | S_IRUGO);
> > -MODULE_PARM_DESC(fscache_defer_create,
> > +MODULE_PARM_DESC(defer_create,
> >  		 "Defer cookie creation to background thread");
> >  
> >  unsigned fscache_debug;
> >  module_param_named(debug, fscache_debug, uint,
> >  		   S_IWUSR | S_IRUGO);
> > -MODULE_PARM_DESC(fscache_debug,
> > +MODULE_PARM_DESC(debug,
> >  		 "FS-Cache debugging mask");
> >  
> >  struct kobject *fscache_root;
> > -- 
> > 2.30.1
> 
> David,  I got no feedback on this here, yet.  Shall I fix something or 
> is there anything wrong with the patch?  
> 
> Kind regards,
> Nicolas

ping.

Looking forward for any reply.

Kind regards,
Nicolas
