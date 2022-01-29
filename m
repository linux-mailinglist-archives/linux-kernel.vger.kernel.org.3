Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6834E4A31FD
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 22:04:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353216AbiA2VEL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 16:04:11 -0500
Received: from mout.gmx.net ([212.227.17.20]:47215 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346309AbiA2VEK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 16:04:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1643490217;
        bh=XILC4jW/1N/QSXjzRyiWHVfUd+QOrX0IkAodGA2MHDY=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=PWqKZaWXRrWOHRK2xZdAAH894W3suxXG3vof+dax44fjX83R6xQGHujTKB+RcAOMM
         EpVH5q9Pv+wpd9NvJpCupowSXMrVeI7bl1j0O8dz4yLxZdlCJWv9URa1FxemDrkmWB
         wPzzbUhrD3ZmyCfH290Jt27H66Q69v0/TDG/Dt0E=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.194.160]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MTiTt-1moN8e2KPV-00TzQu; Sat, 29
 Jan 2022 22:03:37 +0100
Date:   Sat, 29 Jan 2022 22:03:34 +0100
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Theodore Ts'o <tytso@mit.edu>,
        LKML <linux-kernel@vger.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>, sultan@kerneltoast.com,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v2] random: remove batched entropy locking
Message-ID: <YfWrpoQIR9+NDGHl@latitude>
References: <CAHmME9pe2BEJV4WiZNHmDmH_XK621Qqr1JCBdgTNZmr4JGBA4w@mail.gmail.com>
 <20220128223548.97807-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="XiiH0S1pX/5KzGJO"
Content-Disposition: inline
In-Reply-To: <20220128223548.97807-1-Jason@zx2c4.com>
X-Provags-ID: V03:K1:Xne52OSI0Jra1T6IKCh3biJPpckFKEgyEutvUMND3WdDKXbzump
 uLwPM07/TRWrhJBld89gIIFGJq6SAWaO1xVilPw0bEuVU0+W2Q8aa4pvb+cuKk/2MFrLT3/
 023k5t1wv8yW+p/zuzg7acm9A7dJ0Y656Jv3+8PsLJ0ZbmOAmj2MfNQXJUFzWxf00j3Zkvi
 M4jGSmzAlOX52zQisWNLA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:V8bvcCW3y5o=:LWhKlL3mgYoDwtv50ITfXW
 P3m8cVsjszr6iedKRjCPIJgrZjJpiMayLXy70YhkrKu9WrAWLtjFrEzulFXfNxW/Jil5RoQXx
 IMRAhouiEfr8bdQWBgOvxqG6RCK8rbeRSEr+ysppfouGQ5+MtNfrrvJMfNbFT+/OPhkFY7h7H
 VdHD/H6Mky+Dz2lIrFNVm7V0JBWEQPCOqoIQnohH6AEF9zr14XfjA5KXvgjShVasIg+JjaCsm
 Lj896IrMLH1E0kqBwadG20dRxARcH9WpR+L4kW4jwYnb8G/jVYjiA7ojdhoBHPpB+zvO2dCjL
 VRqnKlxAUoJ+ZQrPnx289jsI71YPXfTXi9fQ9NlkJfzgw3fomT7ixmOp/BSTMTaCJ9yKlupIe
 xugkzTikZOKcn/gzv2r7p7MJ/+Tu8xSwqDSxXhd5bz29AXBhTcCZpw8KJXsz16ZTVkUAJoOsp
 iMum6EkjTx441bamAxOdJFNmxYiE5Su97CaScjlATZhYQBBaqWxgGxkV8EcKFC6VQOpnF6VLm
 OLe6Ckk0moR0PoJltwfOwz9HwhBto6xzfKbS/tleBmuytK64x+26nPi6+TPrZ0qqEdNTXb2iA
 fjpfyY5fiqrHQ0laVOFmMVIkU/fZbD2fZSGJgDgAtufK+PRBUDxOPYQwRZ0BboRUEYxND87F8
 7Hhb7JKKFRkVdOTAxccAroT4YR93X8P0pdWCE4cxrpR2ecZ59qf7OPBUrwfoEsDRqb+9WowZd
 UVlQM/kmfV40Zvy3RsdbmI5+31xAvovAYpB3Xvqqo+yWE7XrvRX/h1OkeKQRIo8QpY+sjiXVu
 4yuFCHbgBRcDt0bv/yUoMzQx34TRfvsgavFg9LJbqE0gmNpH7BTuYUisoEar8Np3B9meZhyiu
 X5iPNJx7F+bU1qXHOgMEUV4VWyBJ57ceXj1pNtzblhJvWDPLEW7UQhMOy/kVavF1kj8mdZW/k
 i5J61aZoKJxF+iy86PlZM4MUOfzYg0tYlVdXRrgi5TV1RgHjCQwaQV2z5IRtYmvr234ImpFwo
 79y3oHapRo4CTtciLKoQj3yCVbA5Qor0RtoeqleUKr0oRYpsrWQQFkTZYDDvLyGwiMkyqtFx+
 Su7hs2Y95DyAj0=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XiiH0S1pX/5KzGJO
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jason,

On Fri, Jan 28, 2022 at 11:35:48PM +0100, Jason A. Donenfeld wrote:
> Rather than use spinlocks to protect batched entropy, we can instead
> disable interrupts locally, since we're dealing with per-cpu data, and
> manage resets with a basic generation counter. This should fix up the
> below splat that Jonathan received with a PROVE_RAW_LOCK_NESTING=3Dy
> kernel.
>=20
> Note that Sebastian has pointed out a few other areas where
> using spinlock_t in an IRQ context is potentially problematic for
> PREEMPT_RT. This patch handles one of those cases, and we'll hopefully
> have additional patches for other cases.
>=20
> [    2.500000] [ BUG: Invalid wait context ]
[...]
>=20
> Reported-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
> Link: https://lore.kernel.org/lkml/YfMa0QgsjCVdRAvJ@latitude/
> Fixes: b7d5dc21072c ("random: add a spinlock_t to struct batched_entropy")
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
> Changes v1->v2:
> - We move from Andy's original patch, which was a bit racey, to using a
>   simple generation counter.
>=20
>  drivers/char/random.c | 58 ++++++++++++++++++++-----------------------
>  1 file changed, 27 insertions(+), 31 deletions(-)

This patch doesn't seem to apply properly on 5.17-rc1:

$ git am rand2.mbox
Applying: random: remove batched entropy locking
error: patch failed: drivers/char/random.c:2057
error: drivers/char/random.c: patch does not apply
Patch failed at 0001 random: remove batched entropy locking
hint: Use 'git am --show-current-patch=3Ddiff' to see the failed patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".

So I cherry-picked it from https://git.zx2c4.com/linux-rng jd/no-batch-lock.

The result looks alright (no splat during boot).

Tested-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
--


With both patches, I get the following about three minutes after boot, but
I guess it will be addressed by one of the other patchsets under discussion:

[  202.670000] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
[  202.670000] [ BUG: Invalid wait context ]
[  202.670000] 5.17.0-rc1-00001-g4e53c88bd88e #585 Not tainted
[  202.670000] -----------------------------
[  202.670000] swapper/0 is trying to lock:
[  202.670000] c0b0ff3c (random_write_wait.lock){....}-{3:3}, at: __wake_up=
_common_lock+0x54/0xb4
[  202.670000] other info that might help us debug this:
[  202.670000] context-{2:2}
[  202.670000] no locks held by swapper/0.
[  202.670000] stack backtrace:
[  202.670000] CPU: 0 PID: 0 Comm: swapper Not tainted 5.17.0-rc1-00001-g4e=
53c88bd88e #585
[  202.670000] Hardware name: WPCM450 chip
[  202.670000] [<c00100a8>] (unwind_backtrace) from [<c000db2c>] (show_stac=
k+0x10/0x14)
[  202.670000] [<c000db2c>] (show_stack) from [<c0054eec>] (__lock_acquire+=
0x3f0/0x189c)
[  202.670000] [<c0054eec>] (__lock_acquire) from [<c0054478>] (lock_acquir=
e+0x2b8/0x354)
[  202.670000] [<c0054478>] (lock_acquire) from [<c0568088>] (_raw_spin_loc=
k_irqsave+0x60/0x74)
[  202.670000] [<c0568088>] (_raw_spin_lock_irqsave) from [<c004c34c>] (__w=
ake_up_common_lock+0x54/0xb4)
[  202.670000] [<c004c34c>] (__wake_up_common_lock) from [<c004c3bc>] (__wa=
ke_up+0x10/0x18)
[  202.670000] [<c004c3bc>] (__wake_up) from [<c030d898>] (crng_reseed.cons=
tprop.0+0x240/0x338)
[  202.670000] [<c030d898>] (crng_reseed.constprop.0) from [<c0061b34>] (ha=
ndle_irq_event_percpu+0x18/0x38)
[  202.670000] [<c0061b34>] (handle_irq_event_percpu) from [<c0061b8c>] (ha=
ndle_irq_event+0x38/0x5c)
[  202.670000] [<c0061b8c>] (handle_irq_event) from [<c0065b28>] (handle_fa=
steoi_irq+0x9c/0x114)
[  202.670000] [<c0065b28>] (handle_fasteoi_irq) from [<c0061178>] (handle_=
irq_desc+0x24/0x34)
[  202.670000] [<c0061178>] (handle_irq_desc) from [<c05621ac>] (generic_ha=
ndle_arch_irq+0x28/0x3c)
[  202.670000] [<c05621ac>] (generic_handle_arch_irq) from [<c0008eb4>] (__=
irq_svc+0x54/0x80)
[  202.670000] Exception stack(0xc0931f20 to 0xc0931f68)
[  202.670000] 1f20: 00000000 0005317f 0005217f 60000013 00000000 00000000 =
c0930000 ffffffff
[  202.670000] 1f40: c0937ac0 00000000 00053177 00000000 600000d3 c0931f70 =
c000b0e8 c000b0e0
[  202.670000] 1f60: 60000013 ffffffff
[  202.670000] [<c0008eb4>] (__irq_svc) from [<c000b0e0>] (arch_cpu_idle+0x=
24/0x34)
[  202.670000] [<c000b0e0>] (arch_cpu_idle) from [<c0567e24>] (default_idle=
_call+0x40/0x80)
[  202.670000] [<c0567e24>] (default_idle_call) from [<c0046fbc>] (do_idle+=
0xd4/0x254)
[  202.670000] [<c0046fbc>] (do_idle) from [<c00474e4>] (cpu_startup_entry+=
0xc/0x10)
[  202.670000] [<c00474e4>] (cpu_startup_entry) from [<c07bdedc>] (start_ke=
rnel+0x5cc/0x6c0)
[  202.670000] random: crng init done

--XiiH0S1pX/5KzGJO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAmH1q4EACgkQCDBEmo7z
X9uYOg/+MiXtki+fcCeL1hqanjHz0TYuFNuw1NlQ3yoEg2TUbZIxdTU4IdXhHG2z
2KbiRl+dNhIQuY2iaZJeRk9KGrj/lVfB6TbXjxB0eSqTCZ3FJGPaLgb5qpFJxAME
8xiFLt0rnEJcy5A2Fs6Rv5KPiQT5q4QEIFUaVvnzmI+TrYPhuuoPIEh+niLtfIin
VIiVuF5XXsjmyCW5ozWozn8QI13omg7NrifR/4dwBthk8IXsGaCTWlCKC9zBEYi7
QDKypBQQjSHxZzJxg45PjiAAzKsyZD8zt7qN4XFe/f4EPK6NnPY0rI0O25+lkqkl
Ww9p5ZMzmDKV1P1kSgFCzH84v+XqhendLhG2EbWfX/qONoQIKMR+uMoQ6GMJmaAo
Y9G17hP7SWJJ2G2Z2JydVzpd8wMypIfMqn35T0ntxhIErBcr+gYRkJTKXKfPgKNT
UBNA0VGKmgAn5HTuWHqiuWMf/34615x0EukjQ9AvsJOPEpr7rbgNEfarIiFQp6vI
QPjSIMiJ/q299v4Y1RJKBbXttzUphTZElzNCuR0Rt1jQL3M7KaNy81aImh5/UL9F
kLYrqkiwI7oTEJZa1LxN9b60kfnblIoPYeRTteAl2drOxtMxRw6iT8YuC1hOaRtm
pYHvk9jtqxItQfb4DPyKfEOOtE0pXl2eVeV20yKh3jyI5KoE5GA=
=4MzG
-----END PGP SIGNATURE-----

--XiiH0S1pX/5KzGJO--
