Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E01EE494215
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 21:48:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240077AbiASUsf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 15:48:35 -0500
Received: from mout.gmx.net ([212.227.15.19]:36407 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234427AbiASUse (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 15:48:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1642625308;
        bh=Wq2wCMvJMRTznzWEUm9j4pZ5kEAN28YbqyR5A4QCv6o=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=SJJJl1aE8E5GXCpxnAKjgSjZpwbLJmRwxdvOvlIkO+JWixMLtB93WpTQTDFoLMvQo
         P8pQepW+xDWU2GsHxYTzYk4VElamAyJQezzhAtPFnlBfPXI0pT4SVcwxPT7Fl3MZHd
         wINXNIp9CbOcFO3y+zaMyS5Zw2sLVO4wRIFwY06w=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.191.218.185]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MWASe-1mmVpm2K0w-00XeiY; Wed, 19
 Jan 2022 21:48:28 +0100
Message-ID: <145440f77810f8091ff0621a0b7d0f08cc43f8d3.camel@gmx.de>
Subject: Re: regression: LTP isofs testcase failure - bisection fingers
 "loop: make autoclear operation asynchronous"
From:   Mike Galbraith <efault@gmx.de>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     lkml <linux-kernel@vger.kernel.org>
Date:   Wed, 19 Jan 2022 21:48:27 +0100
In-Reply-To: <dd6c1f86-9a4b-bc1d-8d9e-835e64a00638@I-love.SAKURA.ne.jp>
References: <4eb771d2b48ee94ba2e3aa8706bce8117d398e80.camel@gmx.de>
         <c53285e4-cbd4-5fd0-cbc9-93e2e3d3d88d@I-love.SAKURA.ne.jp>
         <0a1c1464e40e4c60687bc715c0b78c9124e456f8.camel@gmx.de>
         <dd6c1f86-9a4b-bc1d-8d9e-835e64a00638@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.2 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WzWk5d7w6HARwCZs3WD8YMCBYHZruxC4slaqLynZlYdBAFi6Cek
 biYgMsKVTy3wEUMdtbh61QHXNUrAo1edAouuLIfY778005bOfOs4ljdh9S6TpeMyBn5YtAf
 VMzE6ZOwSBhKKYbB6t0YEZ3H3eP2bojcCfaT62e68CqndZvvVIBLUDu+MtZVRHvhioxLSRt
 dnYIl2QLYlzHVUfL+F/TA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Ql/g2bDtDMg=:Fp5X/2uOrweWx4R95xGTzA
 L9lbT4FI1cMTmdQ3z9Drm5nMYjIUjn48x6gUc3mssDimE0spVxof9FHbywRISnGDgvSE0UVH4
 Kp3l9Hem4/kbBGT8TzfVDMW9ZlS96jfQKBQEu9DSZNTUtzzPmRIo6G3S6ZzClrxD6Br4+6DRs
 wrtj0WgIjTjZJl1tdc9N5639jgQVI33EUu5n5G5io4a2nWB3rhMnYO2Nrr4eJc/NC4l5230Xf
 /QlE60SUtXPHJfQ2sl+a0ESLlROsXlN4/N6nxqC3Scz0Sz+mzNr/SixY6SU9zBVbKDs7pcoSv
 Ci7eO+ctmQFvy7V6JCcOOFKpQZoRz5uLgVoV6anbPKrz3camaumOaCsD3wjCDBSTntIpzzuhg
 Ntz3qTqv7Hqhc2fpDHDkwa7wdgVonM9ixMbVwhAg6a+dePwU2FbHopyPUp+gHZJUVN2DebyG5
 HYW0hiMhjNX9Kw+SWalq5v3kJzTAASne3p7uYE/3e/4glgh9xpUXbRH60WtgY6r3c/P6y65Eb
 aHHW9iwgEc30r5b1u71JCzZU6iLuN5WbdewxFeZsz+OVYJVMCKq2E07nE+S2CP6ENHgeWlOz7
 /lHGIFf/MujeNuFg1fvJSuHIbTo9VHFTV4zV87OoKDwfLa2XmJtF0/hdrMPtgAc6MQg2AYYI3
 mI/SKjRMVshegTc44deYTkH45QABKc8j8lQu3jA+5tLaZUii8Qx5rn/0ZrKRNKG/FqQBVrDh3
 rOpo6sBkWxIoDq3rULptyDQZrV5WNNiHJBFGciPMrk6avU1mYRhRBT1oEiMUr5Kp/D652AOKk
 RdUVaPndNWw7ZZ5+r4EZTIntvRCYom4tJD4HFzzo7L6N6luAUuzbhRa5oOCDvnJcnOo7E7jb0
 Tr8LBmazZeO0aKd8gsaCJ/r+Zos7hZdpAxQuYcCT3bhzInuoL2bCFIMC39XY0VxmscdkWt5YH
 FqnKUMloJcNhDIVDHdJybixSxfsGa1M/HL9M7XU3/ZufnhkLDXS3hi+CsuJ3tvRHqGzbqHZVH
 u858eiREMwTxqNeyz9U7juGbAJRbuGTV2kYjHy6T4oGOT5504NGX9BrdVH+VrLFlf2JN3mYzf
 ojaHMoOmgPDrUU=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-01-18 at 15:19 +0900, Tetsuo Handa wrote:
> On 2022/01/18 12:21, Mike Galbraith wrote:
> > On Tue, 2022-01-18 at 06:57 +0900, Tetsuo Handa wrote:
> > > On 2022/01/18 0:34, Mike Galbraith wrote:
> > > > Greetings,
> > > >
> > > > LTP's isofs testcase began failing this cycle, and bisected as bel=
ow,
> > > > which a revert then confirmed.=C2=A0 Full testcase output attached=
.
> > > >
> > >
> > > Thanks for reporting.
> > > Discussion is continued at https://lkml.kernel.org/r/cdaf1346-2885-f=
0da-8878-12264bd48348@I-love.SAKURA.ne.jp=C2=A0.
> >
> > FWIW, simply immediately flushing that shiny new rundown_work turned
> > LTP's thumb back to upward pointing.
>
> Unfortunately, that reintroduces the circular locking dependency problem
> which my patch tried to solve.

Hm, lockdep was green (and is, just double checked out of curiosity)
with the LTP testcase (shrug).

Happily, and as previously noted, both patch options at the link you
provided restored the LTP testcase's happy camper status.

	-Mike
