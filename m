Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 389E051F787
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 11:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237636AbiEII7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 04:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237750AbiEIIrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 04:47:45 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D5191D8B72;
        Mon,  9 May 2022 01:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1652085824;
        bh=S9Y7+ltJPNDfDjv0EbiDnYCt9f7uMciPO9hctM/+Pk0=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=HQrX+gXBarVJHgo5GZlnGQPUW0BL5Z/kFl/j3wXNu3Ms0pE1T7Dg7I2F2faqW5Tg5
         +wUn+11hI84/L2gEnN0pP/0wCowThj9EMENu9c/HQg1kSe374LzcjC6mfcsg3L9vXn
         34JoxlzViAZOobO/zJSoR120iMa7N1bDkZwOO4+c=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.155.173]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MWAOW-1nHUgv4C5q-00XZp3; Mon, 09
 May 2022 10:43:44 +0200
Message-ID: <6f1d8ce6-4ad1-e07e-d864-46f374282539@gmx.de>
Date:   Mon, 9 May 2022 10:43:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] parisc: fix typos in comments
Content-Language: en-US
To:     Julia Lawall <Julia.Lawall@inria.fr>
Cc:     kernel-janitors@vger.kernel.org,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220430190718.8046-1-Julia.Lawall@inria.fr>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <20220430190718.8046-1-Julia.Lawall@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KupA7zcW0QKMS/XEPJyyMug2Fq0P+WnD96vvpnor4HRFkaXghYY
 3RoocBN0lAd6qH2FNpFaXn1XPl+3t7H/Tcuc17TJm5HGwxqpSw2Va5711ISnDJNITpmZIXz
 Xo6ZuSGGxy4kjNx7ST5pShw6nlo+lt5TOgXyjUCsBZpZVNltvKQQIzbI2QoD3H9cIwEJCm8
 vcpvoacb4b66paeJxiMwA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7tT3/gYg15U=:MigBqemwFIOJ4QRsfYY6hQ
 Cwtj3BZLpOMZkeqH66z9Hnc9e9GXKncbO/5mTNZe1vlBQivobHJ+YzJFFWW5wVtSTeJ7LdXqf
 qwELzuos18gnLMrWgFmxKSVyjXgZMZ3g/jbbrkuujiy+DmeoeFEeHEvKOF1VF/sNpkMRvErlG
 YtxJkVkUm3/i90E7JFaFy0GWBDBmlQB1K822XhRLiUu1WLMbSd4HTLMu931XxibHfvV63EV7C
 eMkDHSoLqXx1shUkJ0xOeSFurVuEbXrK+Eoj9e/nRf9DbSnzPELE5aWh22QPeQrkqdeDqsZz1
 T566yy57IVpXXsfMtLqO44KsOO7EgQOIAG27KkvvgvRYtzFsnvKQ7zYwM9g9itxyEiC8iq9Ms
 JRPd2V+tEVz0490QTqzCey0ndyDWct39M667BSiC2dnXESoEt4PntQcDgmutpBLCIPZXf7lnp
 vcnSRsNEts286+48jcJCPNYzKw6KmAdYtYcI3WiVviQa15nJiPRaQBGqveJWtCVBYV69cxWBJ
 Gn/C7KgKd0S+8xNa9fclnPMJ/hlAVGw8niNUypcoAeByNGT/4Lk11cvZhaZOzIxNleCEcHlcg
 yaWnJQoSpeui7BGiuzor5Q9g5grYaDTLKb7i7wekvAjlk5i7Qm5khXxuHUbEFZ6/Yn2oD/ksb
 1vGgn8/jCzGA3OOaM3TEknKt4BgnLl+yrfR/uS/H0Iames8XAwSMVYJv6i16D8JXNi09GS06V
 juYyvXzeSjhnBwxc4NrJagkjUeW+htekDipxMhD5eCeOlVkt6OzG/KK8cASTI8uarcULZRV4o
 d1SdA/tFO58GyXQysusYs3891PBTfgD+e70mV1GdJE7/lnSUFShqTHuJwrjgKNfOwnBclKV8q
 ePiJcIapFhR9KFplJBrIzk44z3XBaVO0zth5HiBpF5xWwSV5PvAJIGhSH4xI0PuYqUsPC6/R4
 sc1wp5Vdf8/40fuR1B+y+o01TuJ9nPaVkPWPWEo7pH75LcZGYJsTnt9uykOYWy/vP853/ASu7
 JPo9D10c7xMT7o4uZQNsTpxhyjwNMr1pPq9zZNI4Fr0q9QmIL+gS3DB/FftTTA+OFCeiDOYfQ
 zHQuGGz/6YFVms=
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/30/22 21:07, Julia Lawall wrote:
> Various spelling mistakes in comments.
> Detected with the help of Coccinelle.
>
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

applied.

Thanks!
Helge

>
> ---
>  arch/parisc/kernel/kprobes.c |    2 +-
>  arch/parisc/kernel/time.c    |    2 +-
>  arch/parisc/kernel/traps.c   |    2 +-
>  arch/parisc/math-emu/dfadd.c |    2 +-
>  arch/parisc/math-emu/dfsub.c |    2 +-
>  arch/parisc/math-emu/sfadd.c |    2 +-
>  arch/parisc/math-emu/sfsub.c |    2 +-
>  7 files changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/arch/parisc/kernel/kprobes.c b/arch/parisc/kernel/kprobes.c
> index 3343d2fb7889..6e0b86652f30 100644
> --- a/arch/parisc/kernel/kprobes.c
> +++ b/arch/parisc/kernel/kprobes.c
> @@ -152,7 +152,7 @@ int __kprobes parisc_kprobe_ss_handler(struct pt_reg=
s *regs)
>  	/* for absolute branch instructions we can copy iaoq_b. for relative
>  	 * branch instructions we need to calculate the new address based on t=
he
>  	 * difference between iaoq_f and iaoq_b. We cannot use iaoq_b without
> -	 * modificationt because it's based on our ainsn.insn address.
> +	 * modifications because it's based on our ainsn.insn address.
>  	 */
>
>  	if (p->post_handler)
> diff --git a/arch/parisc/kernel/time.c b/arch/parisc/kernel/time.c
> index bb27dfeeddfc..cafd3ad20272 100644
> --- a/arch/parisc/kernel/time.c
> +++ b/arch/parisc/kernel/time.c
> @@ -251,7 +251,7 @@ void __init time_init(void)
>  static int __init init_cr16_clocksource(void)
>  {
>  	/*
> -	 * The cr16 interval timers are not syncronized across CPUs, even if
> +	 * The cr16 interval timers are not synchronized across CPUs, even if
>  	 * they share the same socket.
>  	 */
>  	if (num_online_cpus() > 1 && !running_on_qemu) {
> diff --git a/arch/parisc/kernel/traps.c b/arch/parisc/kernel/traps.c
> index a6e61cf2cad0..b78f1b9d45c1 100644
> --- a/arch/parisc/kernel/traps.c
> +++ b/arch/parisc/kernel/traps.c
> @@ -469,7 +469,7 @@ void parisc_terminate(char *msg, struct pt_regs *reg=
s, int code, unsigned long o
>  	 * panic notifiers, and we should call panic
>  	 * directly from the location that we wish.
>  	 * e.g. We should not call panic from
> -	 * parisc_terminate, but rather the oter way around.
> +	 * parisc_terminate, but rather the other way around.
>  	 * This hack works, prints the panic message twice,
>  	 * and it enables reboot timers!
>  	 */
> diff --git a/arch/parisc/math-emu/dfadd.c b/arch/parisc/math-emu/dfadd.c
> index ec487e07f004..00e561d4aa55 100644
> --- a/arch/parisc/math-emu/dfadd.c
> +++ b/arch/parisc/math-emu/dfadd.c
> @@ -253,7 +253,7 @@ dbl_fadd(
>  	    return(NOEXCEPTION);
>  	    }
>  	right_exponent =3D 1;	/* Set exponent to reflect different bias
> -				 * with denomalized numbers. */
> +				 * with denormalized numbers. */
>  	}
>      else
>  	{
> diff --git a/arch/parisc/math-emu/dfsub.c b/arch/parisc/math-emu/dfsub.c
> index c4f30acf2d48..4f03782284bd 100644
> --- a/arch/parisc/math-emu/dfsub.c
> +++ b/arch/parisc/math-emu/dfsub.c
> @@ -256,7 +256,7 @@ dbl_fsub(
>  	    return(NOEXCEPTION);
>  	    }
>  	right_exponent =3D 1;	/* Set exponent to reflect different bias
> -				 * with denomalized numbers. */
> +				 * with denormalized numbers. */
>  	}
>      else
>  	{
> diff --git a/arch/parisc/math-emu/sfadd.c b/arch/parisc/math-emu/sfadd.c
> index 838758279d5b..9b98c874dfac 100644
> --- a/arch/parisc/math-emu/sfadd.c
> +++ b/arch/parisc/math-emu/sfadd.c
> @@ -249,7 +249,7 @@ sgl_fadd(
>  	    return(NOEXCEPTION);
>  	    }
>  	right_exponent =3D 1;	/* Set exponent to reflect different bias
> -				 * with denomalized numbers. */
> +				 * with denormalized numbers. */
>  	}
>      else
>  	{
> diff --git a/arch/parisc/math-emu/sfsub.c b/arch/parisc/math-emu/sfsub.c
> index 583d3ace4634..29d9eed09d12 100644
> --- a/arch/parisc/math-emu/sfsub.c
> +++ b/arch/parisc/math-emu/sfsub.c
> @@ -252,7 +252,7 @@ sgl_fsub(
>  	    return(NOEXCEPTION);
>  	    }
>  	right_exponent =3D 1;	/* Set exponent to reflect different bias
> -				 * with denomalized numbers. */
> +				 * with denormalized numbers. */
>  	}
>      else
>  	{
>

