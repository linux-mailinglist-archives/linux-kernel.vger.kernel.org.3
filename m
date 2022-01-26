Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E00B549CE23
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 16:26:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242736AbiAZP0D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 10:26:03 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:57453 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236024AbiAZP0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 10:26:02 -0500
Received: from mail-wr1-f43.google.com ([209.85.221.43]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MYcy3-1mi8eh3hOF-00Vd9t for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022
 16:26:00 +0100
Received: by mail-wr1-f43.google.com with SMTP id u15so26421356wrt.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 07:26:00 -0800 (PST)
X-Gm-Message-State: AOAM530JUO6xrFtZH2LCBG3j7eKpolHXDvV9mSmmDRVf7to8HXulLHkn
        G7P3ZUc1olFxedTJ42t4UoKvdAOUr49VMYtjUeQ=
X-Google-Smtp-Source: ABdhPJxQ1+Uxsa4pQiGTAyglo4nzvh1RMAmtkfmM9sB7VDNZHiCEUOdvF/ucNQAz9aiP5ind2pRCKzRlvPRgzr7Xh78=
X-Received: by 2002:adf:fd05:: with SMTP id e5mr22814967wrr.192.1643210760533;
 Wed, 26 Jan 2022 07:26:00 -0800 (PST)
MIME-Version: 1.0
References: <20220125073137.1.83124@7e6451f583e7> <CAMuHMdVYhwpP0vSK4LT+50ZqB9opD8gcm-2aor8wAc49=GR+-w@mail.gmail.com>
 <CAAH8bW93TUpyn8GaZfB83pu8Kvrsz9PHPCBHcG3+UStU7v=s=A@mail.gmail.com>
 <31219CC3-CEE4-4CFA-A416-B98F2115A527@chromium.org> <CAMuHMdUwd=2KGk9JkZPSZsvAWG4wddxZFxd5bFfbrtZi3JynQA@mail.gmail.com>
 <CAK8P3a0bLTWc-UG4eX14CQ=hiXms+wHx2VvaovXA-ZUQYAA1fA@mail.gmail.com> <CAMuHMdVA5M3J5dxWWVQV+GPLQU9xU=qFm6fO6NXXS+thYYqnKQ@mail.gmail.com>
In-Reply-To: <CAMuHMdVA5M3J5dxWWVQV+GPLQU9xU=qFm6fO6NXXS+thYYqnKQ@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 26 Jan 2022 16:25:44 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2uM=vVx7WwZDi_H7dZPxBtr5-EeS5ETQVoah1Cek0W2A@mail.gmail.com>
Message-ID: <CAK8P3a2uM=vVx7WwZDi_H7dZPxBtr5-EeS5ETQVoah1Cek0W2A@mail.gmail.com>
Subject: Re: kisskb: FAILED linux-next/m68k-allmodconfig/m68k-gcc8 Tue Jan 25, 18:24
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>,
        Yury Norov <yury.norov@gmail.com>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:WDxcEDmGDFw1/HERbmsQLkCAKL5iAviVcHLi0iNVog7KKr/8PM9
 DUEa+DPcN/TeTPZ/ENITkYBUYJzksD35qoCqurhY6ay9I4RYfNWIp9SC1cBOcT0gZakVT94
 bYR3nx9GjTrLw3/pQUVSm2FtIlM7FoMi9FjDtgslLBAZ0kRxpdnHwXB5lrXoKaWOiLByMmh
 WLk8bukR6ZeFc9Xd6h52Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:tzYoSVwjQF8=:dfTglNrtROSVkwMkZmg0EL
 +S0do6/NkzsV5jHXEQr9nExWHFrqUNk5brD6kzyDOzsK1OCdhBEKyqCrO+6KVAQynb2NTVVoz
 yRIvLDKkyjtU8iVOhRE6fEy0f7dFD5DDvQr/Y8LDw+7OAhY6F+XEAbZWLpi7IEsOxhziCj1TR
 C3WABz+eKkua3XpVy+HvhNEjgW7LWTHniqL1oWeD1KOHckA6wGo4iFCawabTnLvTXKrgUNtBC
 3ny+Rut/LX0V4QcaGlJ4V12JXTJXXiZuVyv0s5fArp7Qq548zQCQTOOjGlDXYVDEFt+8CLqg4
 83iRGBopCbewtAwTd9tYuT40HYalxgJk10fH+ElbuZob4ZEJHfLLQa/occGTXVpPCM41tuHDQ
 iOuWPqcpbx7Tml3uPUiRYucQnZUVlLWSnV2SPyvhLfsZRW1kRI2zxQse/nAmEzT54VNDQycZx
 ovhi9NfaK2SvaLe1InFAVPSi3HDGvrHprV7MkNSCvhF0xedFYg9Z+wFcv7fgqUj4Lt43ZWE5D
 l3wbZUKp81y9IvR9LEb5zpJwtAn1hs6B6zr3X1L8PrTe8kuWWaclAjnD8eB65wqCTZ6gFt7pV
 hekQTcSn5CV/g2uG3flnHpNm5P3gs3LMa+ZcLVq+rRXDjzqSGx0Anqk1kqE2UB1VpyJmvAsbE
 9ppX50dHiiKcOuij+hXfwhpPxbnjuY1rMKFSLvelJ3O7kVzmOQBxSiJsu0ymqllCafbM=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2022 at 1:37 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Wed, Jan 26, 2022 at 1:26 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > I ran the preprocessed code through cvise[1], bisecting for a reduced
> > test case that fails on gcc-8 but succeeds on gcc-9. The reduced
> > case is still fairly complex, and it appears to only happen in the
> > presence of an inline asm. Narrowing down the compiler versions shows
> > that anything after gcc-9.2 does not warn, but 9.1 and earlier versions do,
> > which is further indication that  it was probably a false-positive that got
> > fixed in gcc.
>
> Thanks for investigating! So let's ignore this.
>
> FTR, my gcc-9 is 9.4.0, i.e. >= 9.2.

Ok, if it comes up again, I suppose we can make the warning conditional on
the compiler warning.

         Arnd
