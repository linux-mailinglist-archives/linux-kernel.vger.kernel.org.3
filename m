Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9738D4883BD
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 14:20:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234321AbiAHNUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 08:20:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232663AbiAHNUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 08:20:10 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 252A6C061574;
        Sat,  8 Jan 2022 05:20:10 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id y17so8507326qtx.9;
        Sat, 08 Jan 2022 05:20:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3HthMCsPfkm3D+hK+w8i9XluI2ffJu/FapjeqvptUDQ=;
        b=DYmYsl60KfGzH+6NoHO2TMGRrW7UuJB1FTtVmuGk1UWgDMFBPt7Uqh37us7fHDPBBR
         5w3y4SxcTTx/uBUopJIo1EHE80hynyXlyM8x9MupmvGJM+RVOf1FXEj0PRoLigq52e1J
         57kpmgDhiR8/q9h44pNtl70zrwgLgbP9VUiBsY7AV0/Hyk6dRzPKvd14dvqRwb2zSh0G
         gCFYdzcYe9GwJ1nFgf6nXXyxPssg1SkjwaQRjfXPehqpKmlkiH3cX9wTD3VNkgoi92Se
         j8iW4Ib8XkvTgNqcrc4ktzvB4xGGDhtX8ON9weGFFQczPsK0q9nj+mhtwGMSlP6AxO5b
         AC7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3HthMCsPfkm3D+hK+w8i9XluI2ffJu/FapjeqvptUDQ=;
        b=MCySfMYviH3oEAlsiJ39BU11PbnnmMacLz0KaDEvapzadj87uCowJJCjJ5b6fD5jYB
         e0wLWiVQZczLzuzr+fbUzaGf4O+6um009YoVJ0HUtrpCWCl8dFLr3Mexq82ClZso9tYq
         y3yRFDbhcJ1T/K1BIInEH4KL+U8kEtZ67vMRBezfuy8/z3DDQvfa1C5cwlUbcwpzQAO+
         Vby/uc0GWvJjZuYewoauGE1qmtLYr37CZeSm8kR5A9/5y1ILK85vjyy+k7ZXTWDAHqsZ
         eNjREIw3anu5j6YLRjY2piJuGXXLI4m9fHpVQh0jEgypcGWlevs3DIzli5qIeGJDJe3v
         t+fA==
X-Gm-Message-State: AOAM531RkXh8xKroF0hT5KPeYCRisFcPS68Flpx70naYoq27l07w4EPj
        baGNhdkLIaWIY3U5VJTxUWM=
X-Google-Smtp-Source: ABdhPJwioTNVKTIrfAj6ShEKx75QzL0MhQveklvkKUzU/02IT1QJyXQnDTMjwVTCTzTONFje8GiUdQ==
X-Received: by 2002:a05:622a:1206:: with SMTP id y6mr59734519qtx.356.1641648009181;
        Sat, 08 Jan 2022 05:20:09 -0800 (PST)
Received: from errol.ini.cmu.edu (pool-108-39-235-221.pitbpa.fios.verizon.net. [108.39.235.221])
        by smtp.gmail.com with ESMTPSA id u10sm1028717qtx.3.2022.01.08.05.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jan 2022 05:20:08 -0800 (PST)
Date:   Sat, 8 Jan 2022 08:20:06 -0500
From:   "Gabriel L. Somlo" <gsomlo@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "kgugala@antmicro.com" <kgugala@antmicro.com>,
        "mholenko@antmicro.com" <mholenko@antmicro.com>,
        "krakoczy@antmicro.com" <krakoczy@antmicro.com>,
        "mdudek@internships.antmicro.com" <mdudek@internships.antmicro.com>,
        "paulus@ozlabs.org" <paulus@ozlabs.org>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "shorne@gmail.com" <shorne@gmail.com>,
        "geert@linux-m68k.org" <geert@linux-m68k.org>,
        "david.abdurachmanov@sifive.com" <david.abdurachmanov@sifive.com>,
        "florent@enjoy-digital.fr" <florent@enjoy-digital.fr>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>
Subject: Re: [PATCH v8 3/3] mmc: Add driver for LiteX's LiteSDCard interface
Message-ID: <YdmPho2GpVcvWUgU@errol.ini.cmu.edu>
References: <20220107233458.2326512-1-gsomlo@gmail.com>
 <20220107233458.2326512-4-gsomlo@gmail.com>
 <CAHp75VcHnHpX1=ojmFnujqkf55aS1ePiVW4kKydTJQe=dXbwbQ@mail.gmail.com>
 <YdjvlA7rqQoZe44F@errol.ini.cmu.edu>
 <CAHp75Vf7o1g0FTAd+Zo6TMzDN3C2nGLhbDo0OJ9Cmwcxm=Kc8Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75Vf7o1g0FTAd+Zo6TMzDN3C2nGLhbDo0OJ9Cmwcxm=Kc8Q@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 08, 2022 at 01:26:08PM +0200, Andy Shevchenko wrote:
> On Sat, Jan 8, 2022 at 3:57 AM Gabriel L. Somlo <gsomlo@gmail.com> wrote:
> > On Sat, Jan 08, 2022 at 01:54:07AM +0200, Andy Shevchenko wrote:
> > > On Saturday, January 8, 2022, Gabriel Somlo <gsomlo@gmail.com> wrote:
> 
> > >     +       u32 div;
> > >     +
> > >     +       div = freq ? host->ref_clk / freq : 256U;
> > >
> > >     +       div = roundup_pow_of_two(div);
> > >     +       div = clamp(div, 2U, 256U);
> > >
> > > Logically seems to me that you may join these two together, because clamped
> > > range is power-of-2 one.
> >
> > `div` needs to be a power-of-2 when written to the LITEX_PHY_CLOCKERDIV
> > register (below). And clamp() will just enforce a min/max range, so if
> > (div = ref_clk / freq) ends up e.g., 5, I need both roundup_pow_of_two()
> > to bump it to 8, and clamp() to enforce that it's between 2 and 256.
> >
> > Unless you mean I should simply write it like:
> >
> >         div = clamp(roundup_pow_of_two(div), 2U, 256U);
> >
> > ... as a single line?
> 
> Yes, that's what I meant.

Turns out, clamp really hates being passed roundup_pow_of_two()
directly (see below). I think it's probably better if we leave
them as-is, to avoid going the explicit cast route which Geert
recommended against.

I'll send out v9 later today with everything else, including
devm_add_action_or_reset().

Thanks,
--Gabriel

drivers/mmc/host/litex_mmc.c: In function 'litex_mmc_setclk':
./include/linux/minmax.h:20:35: warning: comparison of distinct pointer types lacks a cast
   20 |         (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
      |                                   ^~
./include/linux/minmax.h:26:18: note: in expansion of macro '__typecheck'
   26 |                 (__typecheck(x, y) && __no_side_effects(x, y))
      |                  ^~~~~~~~~~~
./include/linux/minmax.h:36:31: note: in expansion of macro '__safe_cmp'
   36 |         __builtin_choose_expr(__safe_cmp(x, y), \
      |                               ^~~~~~~~~~
./include/linux/minmax.h:45:25: note: in expansion of macro '__careful_cmp'
   45 | #define min(x, y)       __careful_cmp(x, y, <)
      |                         ^~~~~~~~~~~~~
./include/linux/minmax.h:89:28: note: in expansion of macro 'min'
   89 | #define clamp(val, lo, hi) min((typeof(val))max(val, lo), hi)
      |                            ^~~
./include/linux/minmax.h:26:18: note: in expansion of macro '__typecheck'
   26 |                 (__typecheck(x, y) && __no_side_effects(x, y))
      |                  ^~~~~~~~~~~
./include/linux/minmax.h:36:31: note: in expansion of macro '__safe_cmp'
   36 |         __builtin_choose_expr(__safe_cmp(x, y), \
      |                               ^~~~~~~~~~
./include/linux/minmax.h:52:25: note: in expansion of macro '__careful_cmp'
   52 | #define max(x, y)       __careful_cmp(x, y, >)
      |                         ^~~~~~~~~~~~~
./include/linux/minmax.h:89:45: note: in expansion of macro 'max'
   89 | #define clamp(val, lo, hi) min((typeof(val))max(val, lo), hi)
      |                                             ^~~
drivers/mmc/host/litex_mmc.c:448:15: note: in expansion of macro 'clamp'
  448 |         div = clamp(roundup_pow_of_two(div), 2U, 256U);
      |               ^~~~~
./include/linux/minmax.h:20:35: warning: comparison of distinct pointer types lacks a cast
   20 |         (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
      |                                   ^~
./include/linux/minmax.h:26:18: note: in expansion of macro '__typecheck'
   26 |                 (__typecheck(x, y) && __no_side_effects(x, y))
      |                  ^~~~~~~~~~~
./include/linux/minmax.h:36:31: note: in expansion of macro '__safe_cmp'
   36 |         __builtin_choose_expr(__safe_cmp(x, y), \
      |                               ^~~~~~~~~~
./include/linux/minmax.h:45:25: note: in expansion of macro '__careful_cmp'
   45 | #define min(x, y)       __careful_cmp(x, y, <)
      |                         ^~~~~~~~~~~~~
./include/linux/minmax.h:89:28: note: in expansion of macro 'min'
   89 | #define clamp(val, lo, hi) min((typeof(val))max(val, lo), hi)
      |                            ^~~
drivers/mmc/host/litex_mmc.c:448:15: note: in expansion of macro 'clamp'
  448 |         div = clamp(roundup_pow_of_two(div), 2U, 256U);
      |               ^~~~~
In file included from ./include/linux/bits.h:5,
                 from drivers/mmc/host/litex_mmc.c:12:
./include/linux/minmax.h:20:35: warning: comparison of distinct pointer types lacks a cast
   20 |         (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
      |                                   ^~
./include/linux/const.h:12:55: note: in definition of macro '__is_constexpr'
   12 |         (sizeof(int) == sizeof(*(8 ? ((void *)((long)(x) * 0l)) : (int *)8)))
      |                                                       ^
./include/linux/minmax.h:26:39: note: in expansion of macro '__no_side_effects'
   26 |                 (__typecheck(x, y) && __no_side_effects(x, y))
      |                                       ^~~~~~~~~~~~~~~~~
./include/linux/minmax.h:36:31: note: in expansion of macro '__safe_cmp'
   36 |         __builtin_choose_expr(__safe_cmp(x, y), \
      |                               ^~~~~~~~~~
./include/linux/minmax.h:45:25: note: in expansion of macro '__careful_cmp'
   45 | #define min(x, y)       __careful_cmp(x, y, <)
      |                         ^~~~~~~~~~~~~
./include/linux/minmax.h:89:28: note: in expansion of macro 'min'
   89 | #define clamp(val, lo, hi) min((typeof(val))max(val, lo), hi)
      |                            ^~~
./include/linux/minmax.h:26:18: note: in expansion of macro '__typecheck'
   26 |                 (__typecheck(x, y) && __no_side_effects(x, y))
      |                  ^~~~~~~~~~~
./include/linux/minmax.h:36:31: note: in expansion of macro '__safe_cmp'
   36 |         __builtin_choose_expr(__safe_cmp(x, y), \
      |                               ^~~~~~~~~~
./include/linux/minmax.h:52:25: note: in expansion of macro '__careful_cmp'
   52 | #define max(x, y)       __careful_cmp(x, y, >)
      |                         ^~~~~~~~~~~~~
./include/linux/minmax.h:89:45: note: in expansion of macro 'max'
   89 | #define clamp(val, lo, hi) min((typeof(val))max(val, lo), hi)
      |                                             ^~~
drivers/mmc/host/litex_mmc.c:448:15: note: in expansion of macro 'clamp'
  448 |         div = clamp(roundup_pow_of_two(div), 2U, 256U);
      |               ^~~~~
In file included from ./include/linux/kernel.h:17,
                 from ./include/linux/clk.h:13,
                 from drivers/mmc/host/litex_mmc.c:13:
./include/linux/minmax.h:20:35: warning: comparison of distinct pointer types lacks a cast
   20 |         (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
      |                                   ^~
./include/linux/minmax.h:28:27: note: in definition of macro '__cmp'
   28 | #define __cmp(x, y, op) ((x) op (y) ? (x) : (y))
      |                           ^
./include/linux/minmax.h:45:25: note: in expansion of macro '__careful_cmp'
   45 | #define min(x, y)       __careful_cmp(x, y, <)
      |                         ^~~~~~~~~~~~~
./include/linux/minmax.h:89:28: note: in expansion of macro 'min'
   89 | #define clamp(val, lo, hi) min((typeof(val))max(val, lo), hi)
      |                            ^~~
./include/linux/minmax.h:26:18: note: in expansion of macro '__typecheck'
   26 |                 (__typecheck(x, y) && __no_side_effects(x, y))
      |                  ^~~~~~~~~~~
./include/linux/minmax.h:36:31: note: in expansion of macro '__safe_cmp'
   36 |         __builtin_choose_expr(__safe_cmp(x, y), \
      |                               ^~~~~~~~~~
./include/linux/minmax.h:52:25: note: in expansion of macro '__careful_cmp'
   52 | #define max(x, y)       __careful_cmp(x, y, >)
      |                         ^~~~~~~~~~~~~
./include/linux/minmax.h:89:45: note: in expansion of macro 'max'
   89 | #define clamp(val, lo, hi) min((typeof(val))max(val, lo), hi)
      |                                             ^~~
drivers/mmc/host/litex_mmc.c:448:15: note: in expansion of macro 'clamp'
  448 |         div = clamp(roundup_pow_of_two(div), 2U, 256U);
      |               ^~~~~
./include/linux/minmax.h:20:35: warning: comparison of distinct pointer types lacks a cast
   20 |         (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
      |                                   ^~
./include/linux/minmax.h:28:40: note: in definition of macro '__cmp'
   28 | #define __cmp(x, y, op) ((x) op (y) ? (x) : (y))
      |                                        ^
./include/linux/minmax.h:45:25: note: in expansion of macro '__careful_cmp'
   45 | #define min(x, y)       __careful_cmp(x, y, <)
      |                         ^~~~~~~~~~~~~
./include/linux/minmax.h:89:28: note: in expansion of macro 'min'
   89 | #define clamp(val, lo, hi) min((typeof(val))max(val, lo), hi)
      |                            ^~~
./include/linux/minmax.h:26:18: note: in expansion of macro '__typecheck'
   26 |                 (__typecheck(x, y) && __no_side_effects(x, y))
      |                  ^~~~~~~~~~~
./include/linux/minmax.h:36:31: note: in expansion of macro '__safe_cmp'
   36 |         __builtin_choose_expr(__safe_cmp(x, y), \
      |                               ^~~~~~~~~~
./include/linux/minmax.h:52:25: note: in expansion of macro '__careful_cmp'
   52 | #define max(x, y)       __careful_cmp(x, y, >)
      |                         ^~~~~~~~~~~~~
./include/linux/minmax.h:89:45: note: in expansion of macro 'max'
   89 | #define clamp(val, lo, hi) min((typeof(val))max(val, lo), hi)
      |                                             ^~~
drivers/mmc/host/litex_mmc.c:448:15: note: in expansion of macro 'clamp'
  448 |         div = clamp(roundup_pow_of_two(div), 2U, 256U);
      |               ^~~~~
./include/linux/minmax.h:20:35: warning: comparison of distinct pointer types lacks a cast
   20 |         (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
      |                                   ^~
./include/linux/minmax.h:31:24: note: in definition of macro '__cmp_once'
   31 |                 typeof(x) unique_x = (x);               \
      |                        ^
./include/linux/minmax.h:45:25: note: in expansion of macro '__careful_cmp'
   45 | #define min(x, y)       __careful_cmp(x, y, <)
      |                         ^~~~~~~~~~~~~
./include/linux/minmax.h:89:28: note: in expansion of macro 'min'
   89 | #define clamp(val, lo, hi) min((typeof(val))max(val, lo), hi)
      |                            ^~~
./include/linux/minmax.h:26:18: note: in expansion of macro '__typecheck'
   26 |                 (__typecheck(x, y) && __no_side_effects(x, y))
      |                  ^~~~~~~~~~~
./include/linux/minmax.h:36:31: note: in expansion of macro '__safe_cmp'
   36 |         __builtin_choose_expr(__safe_cmp(x, y), \
      |                               ^~~~~~~~~~
./include/linux/minmax.h:52:25: note: in expansion of macro '__careful_cmp'
   52 | #define max(x, y)       __careful_cmp(x, y, >)
      |                         ^~~~~~~~~~~~~
./include/linux/minmax.h:89:45: note: in expansion of macro 'max'
   89 | #define clamp(val, lo, hi) min((typeof(val))max(val, lo), hi)
      |                                             ^~~
drivers/mmc/host/litex_mmc.c:448:15: note: in expansion of macro 'clamp'
  448 |         div = clamp(roundup_pow_of_two(div), 2U, 256U);
      |               ^~~~~
./include/linux/minmax.h:20:35: warning: comparison of distinct pointer types lacks a cast
   20 |         (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
      |                                   ^~
./include/linux/minmax.h:31:39: note: in definition of macro '__cmp_once'
   31 |                 typeof(x) unique_x = (x);               \
      |                                       ^
./include/linux/minmax.h:45:25: note: in expansion of macro '__careful_cmp'
   45 | #define min(x, y)       __careful_cmp(x, y, <)
      |                         ^~~~~~~~~~~~~
./include/linux/minmax.h:89:28: note: in expansion of macro 'min'
   89 | #define clamp(val, lo, hi) min((typeof(val))max(val, lo), hi)
      |                            ^~~
./include/linux/minmax.h:26:18: note: in expansion of macro '__typecheck'
   26 |                 (__typecheck(x, y) && __no_side_effects(x, y))
      |                  ^~~~~~~~~~~
./include/linux/minmax.h:36:31: note: in expansion of macro '__safe_cmp'
   36 |         __builtin_choose_expr(__safe_cmp(x, y), \
      |                               ^~~~~~~~~~
./include/linux/minmax.h:52:25: note: in expansion of macro '__careful_cmp'
   52 | #define max(x, y)       __careful_cmp(x, y, >)
      |                         ^~~~~~~~~~~~~
./include/linux/minmax.h:89:45: note: in expansion of macro 'max'
   89 | #define clamp(val, lo, hi) min((typeof(val))max(val, lo), hi)
      |                                             ^~~
drivers/mmc/host/litex_mmc.c:448:15: note: in expansion of macro 'clamp'
  448 |         div = clamp(roundup_pow_of_two(div), 2U, 256U);
      |               ^~~~~

