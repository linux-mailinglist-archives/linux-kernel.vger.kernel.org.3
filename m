Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 188AA552B75
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 09:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346555AbiFUHEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 03:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346495AbiFUHEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 03:04:44 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C06121812
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 00:04:42 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id b7so14335545ljr.6
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 00:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=wVYB/K8/OVezz2UHsT3wbngGrmChXY79wPo0J5TmhcI=;
        b=eyDpeal1G1PXk06VrT2MX7uD2bK/bG4M8qS3gyd5fnI6xjvzAOJwjj0oXa7eRRGR/o
         TAdzcIhhbjO3ATorN1GKJiqwnahMCAXEZttL6GvSu2qeXZQS7BsQ9nAqKUQhl/rJO8pQ
         /mOnW3qVWYVe5HfQNTZgzcfYTUmtAuzoYZKfA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=wVYB/K8/OVezz2UHsT3wbngGrmChXY79wPo0J5TmhcI=;
        b=7zekhjAL0e6cjQ5SU/tYksUcRw6RmLvih5iXo6ifmKt9BCeXow6M9f+wRgnZRbkvf6
         F9Kl9gG1ssfi7WFk3DMpZA8f7KzDC2JZmfjASaIZWRLS080acOX0JUK47uMI15FATMvI
         XdV3QDdiiuQHcVWj+Rz8uVWYe4KaoCrE+r+MFU21kM/KCCXnPbl6dIeEy95yBa5QbIkU
         g9f4NBdgxmO4a1CBh5SJUTsMuae2TBmHz3H+MW40N489+ksc5eAB/zKxVRUlvy1M7RpZ
         RyZ94Llcn9vObQ6So1eXlgMuJ4PHqB7ayvWBRVdOMeFAhBKcjLIsRNDQjDiCoRGY3UyZ
         C2GQ==
X-Gm-Message-State: AJIora+uKh63PSGQPCuEfGi4gxQWVqTmFrg2pgTOxkDxF5rQbs/ERSUN
        oqXYO/a6HeMdxt/eInd1anZAqg==
X-Google-Smtp-Source: AGRyM1u1aN8rZ1fsfGwJqrfdtcZd+MyUX3sE7LbWw0O+Bqp0ZabGsGGqStRRfg+ByhCDYArgOjq21Q==
X-Received: by 2002:a2e:b5b1:0:b0:25a:7552:6bd7 with SMTP id f17-20020a2eb5b1000000b0025a75526bd7mr1748210ljn.386.1655795080507;
        Tue, 21 Jun 2022 00:04:40 -0700 (PDT)
Received: from [172.16.11.74] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id g22-20020ac24d96000000b0047f71cd1d4csm628207lfe.132.2022.06.21.00.04.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jun 2022 00:04:39 -0700 (PDT)
Message-ID: <f9224687-ce0c-b41b-f158-1b679a70c2d5@rasmusvillemoes.dk>
Date:   Tue, 21 Jun 2022 09:04:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v4 05/34] vsprintf: %pf(%p)
Content-Language: en-US
To:     Kent Overstreet <kent.overstreet@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, pmladek@suse.com
Cc:     rostedt@goodmis.org, enozhatsky@chromium.org, willy@infradead.org
References: <20220620004233.3805-1-kent.overstreet@gmail.com>
 <20220620004233.3805-6-kent.overstreet@gmail.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
In-Reply-To: <20220620004233.3805-6-kent.overstreet@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/06/2022 02.42, Kent Overstreet wrote:
> This implements two new format strings: both do the same thing, one more
> compatible with current gcc format string checking, the other that we'd
> like to standardize:
> 
>  %pf(%p) - more compatible
>  %(%p)  - more prettier

No.

> diff --git a/Documentation/core-api/printk-formats.rst b/Documentation/core-api/printk-formats.rst
> index 5e89497ba3..8fc0b62af1 100644
> --- a/Documentation/core-api/printk-formats.rst
> +++ b/Documentation/core-api/printk-formats.rst
> @@ -625,6 +625,28 @@ Examples::
>  	%p4cc	Y10  little-endian (0x20303159)
>  	%p4cc	NV12 big-endian (0xb231564e)
>  
> +Calling a pretty printer function
> +---------------------------------
> +
> +::
> +
> +        %pf(%p)     pretty printer function taking one argument
> +        %pf(%p,%p)  pretty printer function taking two arguments
> +
> +For calling generic pretty printers. A pretty printer is a function that takes
> +as its first argument a pointer to a printbuf, and then zero or more additional
> +pointer arguments. For example:
> +
> +        void foo_to_text(struct printbuf *out, struct foo *foo)
> +        {
> +                pr_buf(out, "bar=%u baz=%u", foo->bar, foo->baz);
> +        }
> +
> +        printf("%pf(%p)", foo_to_text, foo);
> +
> +Note that a pretty-printer may not sleep, if called from printk(). If called
> +from pr_buf() or sprintf() there are no such restrictions.

I know what you're trying to say, but if the sprintf() call itself is
from a non-sleepable context this is obviously not true. So please just
make the rule "A pretty-printer must not sleep.". That's much simpler
and less error-prone. Otherwise I guarantee you that somebody is going
to add a sleeping pretty-printer for their own need, use it in a couple
of safe places, and then somebody wants to add a printk() in that driver
and sees "hey, I can get all this state dumped very easily with this
pretty-printer".

> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> index 7b24714674..5afa74dda5 100644
> --- a/lib/vsprintf.c
> +++ b/lib/vsprintf.c
> @@ -436,7 +436,8 @@ enum format_type {
>  	FORMAT_TYPE_UINT,
>  	FORMAT_TYPE_INT,
>  	FORMAT_TYPE_SIZE_T,
> -	FORMAT_TYPE_PTRDIFF
> +	FORMAT_TYPE_PTRDIFF,
> +	FORMAT_TYPE_FN,
>  };
>  
>  struct printf_spec {
> @@ -2520,7 +2521,16 @@ int format_decode(const char *fmt, struct printf_spec *spec)
>  		return ++fmt - start;
>  
>  	case 'p':
> -		spec->type = FORMAT_TYPE_PTR;
> +		fmt++;
> +		if (fmt[0] == 'f' &&
> +		    fmt[1] == '(') {
> +			fmt += 2;
> +			spec->type = FORMAT_TYPE_FN;
> +		} else
> +			spec->type = FORMAT_TYPE_PTR;
> +		return fmt - start;
> +	case '(':
> +		spec->type = FORMAT_TYPE_FN;
>  		return ++fmt - start;

NAK. Don't implement something that will never be tested nor used.
There's not a snowball's chance in hell that we'll ever build the kernel
without -Wformat.

>  
> +static void call_prt_fn(struct printbuf *out, void *fn, void **fn_args, unsigned nr_args)
> +{
> +	typedef void (*printf_fn_0)(struct printbuf *);
> +	typedef void (*printf_fn_1)(struct printbuf *, void *);
> +	typedef void (*printf_fn_2)(struct printbuf *, void *, void *);
> +	typedef void (*printf_fn_3)(struct printbuf *, void *, void *, void *);
> +	typedef void (*printf_fn_4)(struct printbuf *, void *, void *, void *, void *);
> +	typedef void (*printf_fn_5)(struct printbuf *, void *, void *, void *, void *, void *);
> +	typedef void (*printf_fn_6)(struct printbuf *, void *, void *, void *, void *, void *, void *);
> +	typedef void (*printf_fn_7)(struct printbuf *, void *, void *, void *, void *, void *, void *, void *);
> +	typedef void (*printf_fn_8)(struct printbuf *, void *, void *, void *, void *, void *, void *, void *, void *);

Sorry, but this is way too ugly, and the prospect of at some point in
the future invoking libffi to do something even naster... eww. We do not
need more functions with completely generic prototypes with no
typechecking and making it extremely hard to teach one of our static
analyzers (smatch has some %pX checking) to do that typechecking.

There are at least two ways you can achieve this passing of a variable
number of arguments with proper types.

(1) Each pretty-printer comes with a struct wrapping up its real
arguments and a macro for creating a compound literal passing those
arguments.

struct foo_pp {
  void (*func)(struct printbuf *pb, void *ctx); /* always first */
  int x;
  long y;
};
void foo_pp(struct printbuf *pb, void *ctx)
{
  struct foo_pp *f = ctx;
  pr_printf(pb, "%d %ld", f->x, f->y);
}

#define FOO_PP(_x, _y) (struct foo_pp){.func = foo_pp, .x = (_x), .y = (_y)}

printk("bla bla %pf\n", &FOO_PP(aa, bb));

(2) Let the pretty-printer itself extract the varargs it expects. To
portably pass around a va_list by reference it needs to be wrapped, so
this would be

struct wva { va_list ap; };

void foo_pp(struct printbuf *pb, struct wva *w)
{
  int x = va_arg(w->ap, int);
  long y = va_arg(w->ap, long);
  pr_printf(pb, "%d %ld", x, y);
}

printk("bla bla %pf(%d, %ld)\n", foo_pp, aa, bb)

with the core printf implementation internally using such a wrapped
va_list, and after a %pf( relying on the pretty-printer having consumed
the arguments up until the closing ). It would probably be a good idea
to give the pretty-printer a pointer to that opening '(' or one-past-it
as well so it could do a sanity check.

So the "core" implementation would be (or the printbuf version of the same)

wsnprintf(char *buf, size_t len, const char *fmt, struct wva *w)
{ ... }

while e.g. snprintf and vsnprintf would be

snprintf(char *buf, size_t len, const char *fmt, ...)
{
  struct wva w;
  int ret;
  va_start(w.ap, fmt);
  ret = wsnprintf(buf, len, fmt, &w);
  va_end(w.ap);
  return ret;
}
vsnprintf(char *buf, size_t len, const char *fmt, struct va_list ap)
{
  struct wva w;
  int ret;
  va_copy(w.ap, ap);
  ret = wsnprintf(buf, len, fmt, &w);
  va_end(w.ap);
  return ret;
}

[snprintf could as usual be implemented in terms of vsnprintf, but the
above would eliminate the state copying].

Rasmus
