Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42D5247A48C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 06:28:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232674AbhLTFZs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 00:25:48 -0500
Received: from mga12.intel.com ([192.55.52.136]:5449 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229437AbhLTFZr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 00:25:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639977947; x=1671513947;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to;
  bh=WaCj4I0I+WwyOPXN0+A1kdFe3+zRp+ZwLrddyJ8x4z0=;
  b=Xq6puuuFkQcl5kkxU4LoD/wd/H4MvKiIGAGLFOH4rtCy0m0JuGsaF4NP
   1CkQznWXuPprc9Nq8ogMEx1C0ySWKLy/Lhsb++yw4vszEu3M3cK9JexCR
   jj24SiA8UsqNEAznsy/QeW7UpJq22k3ytAz7h8ivTlVQIpxSHGj9ruk59
   JOfzSIU5P6HdACSZSzYqNzUeCAKhfxhmuN+MDZHpjBfzXoIjrZHz4VTMF
   O3jBnxr/OBvKGmcLpo/ybMeg+VxD/AY7V1jSqg5yjf6OO/VhP3EYrxqS7
   0/cPhoG2ymKevvGcY57VBe1P78pdIfbJr0OBTndILBX6IU4UPE6ax0Xx+
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10203"; a="220112307"
X-IronPort-AV: E=Sophos;i="5.88,219,1635231600"; 
   d="diff'?scan'208";a="220112307"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2021 21:25:47 -0800
X-IronPort-AV: E=Sophos;i="5.88,219,1635231600"; 
   d="diff'?scan'208";a="467266382"
Received: from cgbowman-mobl.amr.corp.intel.com (HELO [10.212.217.43]) ([10.212.217.43])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2021 21:25:46 -0800
Subject: Re: [GIT PULL] core/urgent for v5.16-rc6
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Borislav Petkov <bp@suse.de>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
References: <Yb82O5i2DVcK9nAJ@zn.tnic>
 <CAHk-=wiNMghi=nZc432_Sj4QwG+BtxGUtovnpVQk-LpDj8r3ZA@mail.gmail.com>
From:   Dave Hansen <dave.hansen@intel.com>
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
 z5cecg==
Message-ID: <15b1a9af-f8ff-c3e2-ba3e-cdbd29ae38db@intel.com>
Date:   Sun, 19 Dec 2021 21:25:44 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wiNMghi=nZc432_Sj4QwG+BtxGUtovnpVQk-LpDj8r3ZA@mail.gmail.com>
Content-Type: multipart/mixed;
 boundary="------------EC110B288E76E6B251D7FC51"
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------EC110B288E76E6B251D7FC51
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

On 12/19/21 12:14 PM, Linus Torvalds wrote:
...
> The SS_DISABLE case shouldn't take the lock at all.
> 
> And the actual modification of the values shouldn't need any locking
> at all, since it's all thread-local.

The modification is definitely thread-local, but the implications are
wider after the dynamic xfeature and sigframe support went in.  Now,
(x86-only) no thread is allowed to enable dynamic features unless the
entire _process's_ altstacks pass validate_sigaltstack().

> I'm not convinced even the limit checking needs the lock, but
> whatever. I think it could maybe just use "read_once()" or something.
> 
> I think the attached patch is an improvement, but I did *not* test
> this, and I'm just throwing this out as a "maybe something like this".

The patch definitely makes the code easier to read.  But, it looks like
we need to invert the sigaltstack_size_valid() condition from the patch:

> +               if (unlikely(ss_size < min_ss_size) ||
> +                   unlikely(sigaltstack_size_valid(ss_size))) {
			       ^^^^^
> +                       sigaltstack_unlock();
> +                       return -ENOMEM;
>                 }

That should be !sigaltstack_size_valid(ss_size).

Also, the sigaltstack_lock() lock really is needed over the assignments
like this:

>                 t->sas_ss_sp = (unsigned long) ss_sp;
>                 t->sas_ss_size = ss_size;
>                 t->sas_ss_flags = ss_flags;
to prevent races with validate_sigaltstack().  We desperately need a
comment in there, but we probably shouldn't reference
validate_sigaltstack() itself since it's deeply x86-only.  I've got a
shot at a comment in the attached patch.

As for the the:

>                 if (ss_mode == SS_DISABLE) {
>                         t->sas_ss_sp = 0;
>                         t->sas_ss_size = 0;
>                         t->sas_ss_flags = ss_flags;
>                         return 0;
>                 }

hunk, I think it's OK.  Shrinking t->sas_ss_size without the lock is
safe-ish because it will never cause validate_sigaltstack() to fail.  I
need to think about that bit more, though.

Another blatantly untested patch is attached.  I'll try to give it a go
on some real hardware tomorrow.

--------------EC110B288E76E6B251D7FC51
Content-Type: text/x-patch; charset=UTF-8;
 name="patch2.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="patch2.diff"


 1 file changed, 19 insertions(+), 17 deletions(-)

index dfcee3888b00..f58f1d574931 100644

---

 b/kernel/signal.c |   41 ++++++++++++++++++++++++-----------------
 1 file changed, 24 insertions(+), 17 deletions(-)

diff -puN kernel/signal.c~linux-sigaltstack kernel/signal.c
--- a/kernel/signal.c~linux-sigaltstack	2021-12-19 16:50:41.411762535 -08=
00
+++ b/kernel/signal.c	2021-12-19 21:14:14.605399136 -0800
@@ -4161,7 +4161,6 @@ do_sigaltstack (const stack_t *ss, stack
 		size_t min_ss_size)
 {
 	struct task_struct *t =3D current;
-	int ret =3D 0;
=20
 	if (oss) {
 		memset(oss, 0, sizeof(stack_t));
@@ -4181,8 +4180,15 @@ do_sigaltstack (const stack_t *ss, stack
 			return -EPERM;
=20
 		ss_mode =3D ss_flags & ~SS_FLAG_BITS;
-		if (unlikely(ss_mode !=3D SS_DISABLE && ss_mode !=3D SS_ONSTACK &&
-				ss_mode !=3D 0))
+
+		if (ss_mode =3D=3D SS_DISABLE) {
+			t->sas_ss_sp =3D 0;
+			t->sas_ss_size =3D 0;
+			t->sas_ss_flags =3D ss_flags;
+			return 0;
+		}
+
+		if (unlikely(ss_mode !=3D SS_ONSTACK && ss_mode !=3D 0))
 			return -EINVAL;
=20
 		/*
@@ -4194,24 +4200,25 @@ do_sigaltstack (const stack_t *ss, stack
 		    t->sas_ss_flags =3D=3D ss_flags)
 			return 0;
=20
+		/*
+		 * Lock out any changes to sigaltstack_size_valid()
+		 * until the t->sas_ss_* changes are complete:
+		 */
 		sigaltstack_lock();
-		if (ss_mode =3D=3D SS_DISABLE) {
-			ss_size =3D 0;
-			ss_sp =3D NULL;
-		} else {
-			if (unlikely(ss_size < min_ss_size))
-				ret =3D -ENOMEM;
-			if (!sigaltstack_size_valid(ss_size))
-				ret =3D -ENOMEM;
-		}
-		if (!ret) {
-			t->sas_ss_sp =3D (unsigned long) ss_sp;
-			t->sas_ss_size =3D ss_size;
-			t->sas_ss_flags =3D ss_flags;
+
+		if (unlikely(ss_size < min_ss_size) ||
+		    unlikely(!sigaltstack_size_valid(ss_size))) {
+			sigaltstack_unlock();
+			return -ENOMEM;
 		}
+
+		t->sas_ss_sp =3D (unsigned long) ss_sp;
+		t->sas_ss_size =3D ss_size;
+		t->sas_ss_flags =3D ss_flags;
+
 		sigaltstack_unlock();
 	}
-	return ret;
+	return 0;
 }
=20
 SYSCALL_DEFINE2(sigaltstack,const stack_t __user *,uss, stack_t __user *=
,uoss)
_

--------------EC110B288E76E6B251D7FC51--
