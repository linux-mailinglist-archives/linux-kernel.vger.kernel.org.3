Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE2A581A6E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 21:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239551AbiGZTop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 15:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbiGZTon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 15:44:43 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D923122B
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 12:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=TGq8QP1oBJLa4d9eMw2KLoD7AcNO8P4iv3iIuufPVq4=; b=DoPmG1X4azqFAa9TxUU9xSoQO4
        PtjPwk2cEf59HghYi6McmmrULab2qwjdhs8xG2upOd4P/QQDDFZsZfvM1Vye8fVqAFmsfXpKwPSCt
        A7HH24z8qsPdm/WEI/1S14aw2cQKaV9yQUNI7GTtpv0LbHdAnIOPj1lwjEzczETDanFiIJ3Olzhrg
        u+HvoSF4Dw/bulkDWQ90cLky6Pjfh7faZaj51p23r/xRXMqcbbRi4fVygESlq1h6v1ZlMiahLrfhI
        FVhZeEb+JeR9p8nGfPm/gbSmwYuJmDr2biZphi4DDy2FSpkkeQv/m2Jqlcj6wae2cH2quNuqwOfk2
        jYAUJ0hA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:33578)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1oGQTt-0004YI-Cr; Tue, 26 Jul 2022 20:44:37 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1oGQTq-0001UV-AR; Tue, 26 Jul 2022 20:44:34 +0100
Date:   Tue, 26 Jul 2022 20:44:34 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Yury Norov <yury.norov@gmail.com>, Dennis Zhou <dennis@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org
Subject: Re: Linux 5.19-rc8
Message-ID: <YuBEIiLL1xZVyEFl@shell.armlinux.org.uk>
References: <CAHk-=wiWwDYxNhnStS0e+p-NTFAQSHvab=2-8LwxunCVuY5-2A@mail.gmail.com>
 <20220725161141.GA1306881@roeck-us.net>
 <CAHk-=whtGUwJwHUSNsXd4g7cok=n0Zwje7nACp8skh1fa2NtJA@mail.gmail.com>
 <YuAm5h1B6bsrR/9q@fedora>
 <CAHk-=wgYpJTMMxmfbpqc=JVtSK0Zj4b15G=AvEYk6vPNySDSsA@mail.gmail.com>
 <YuAv+lV324G7pmlk@yury-laptop>
 <CAHk-=wg2-j8zocUjurAeg_bimNz7C5h5HDEXKK6PxDmR+DaHRg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wg2-j8zocUjurAeg_bimNz7C5h5HDEXKK6PxDmR+DaHRg@mail.gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 26, 2022 at 11:36:21AM -0700, Linus Torvalds wrote:
> On Tue, Jul 26, 2022 at 11:18 AM Yury Norov <yury.norov@gmail.com> wrote:
> >
> > We have find_bit_benchmark to check how it works in practice. Would
> > be great if someone with access to the hardware can share numbers.
> 
> Honestly, I doubt benchmarking find_bit in a loop is all that sensible.

Yes, that's what I was thinking - I've never seen it crop up in any of
the perf traces I've seen.

Nevertheless, here's some numbers from a single run of the
find_bit_benchmark module, kernel built with:
arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 20210110

Current native implementation:

[   46.184565]
               Start testing find_bit() with random-filled bitmap
[   46.195127] find_next_bit:                 2440833 ns, 163112 iterations
[   46.204226] find_next_zero_bit:            2372128 ns, 164569 iterations
[   46.213152] find_last_bit:                 2199779 ns, 163112 iterations
[   46.299398] find_first_bit:               79526013 ns,  16234 iterations
[   46.684026] find_first_and_bit:          377912990 ns,  32617 iterations
[   46.692020] find_next_and_bit:             1269071 ns,  73562 iterations
[   46.698745]
               Start testing find_bit() with sparse bitmap
[   46.705711] find_next_bit:                  118652 ns,    656 iterations
[   46.716621] find_next_zero_bit:            4183472 ns, 327025 iterations
[   46.723395] find_last_bit:                   50448 ns,    656 iterations
[   46.762308] find_first_bit:               32190802 ns,    656 iterations
[   46.769093] find_first_and_bit:              52129 ns,      1 iterations
[   46.775882] find_next_and_bit:               62522 ns,      1 iterations

Generic implementation:

[   25.149238]
               Start testing find_bit() with random-filled bitmap
[   25.160002] find_next_bit:                 2640943 ns, 163537 iterations
[   25.169567] find_next_zero_bit:            2838485 ns, 164144 iterations
[   25.178595] find_last_bit:                 2302372 ns, 163538 iterations
[   25.204016] find_first_bit:               18697630 ns,  16373 iterations
[   25.602571] find_first_and_bit:          391841480 ns,  32555 iterations
[   25.610563] find_next_and_bit:             1260306 ns,  73587 iterations
[   25.617295]
               Start testing find_bit() with sparse bitmap
[   25.624222] find_next_bit:                   70289 ns,    656 iterations
[   25.636478] find_next_zero_bit:            5527050 ns, 327025 iterations
[   25.643253] find_last_bit:                   52147 ns,    656 iterations
[   25.657304] find_first_bit:                7328573 ns,    656 iterations
[   25.664087] find_first_and_bit:              48518 ns,      1 iterations
[   25.670871] find_next_and_bit:               59750 ns,      1 iterations

Overall, I would say it's pretty similar (some generic perform
marginally better, some native perform marginally better) with the
exception of find_first_bit() being much better with the generic
implementation, but find_next_zero_bit() being noticably worse.

So, pretty much nothing of any relevance between them, which may
come as a surprise given the byte vs word access differences between
the two implementations.

I suspect the reason behind that may be because the native
implementation code is smaller than the generic implementation,
outweighing the effects of the by-byte rather than by-word. I would
also suspect that, because of the smaller implementation, the native
version performs better in a I$-cool situation than the generic. Lastly,
I would suspect if we fixed the bug in the native version, and converted
it to use word loads, it would probably be better than the generic
version. I haven't anything to base that on other than gut feeling at
the moment, but I can make the changes to the native implementation and
see what effect that has, possibly tomorrow.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
