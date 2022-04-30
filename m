Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A12B1515F01
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 18:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243218AbiD3QTn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 12:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243050AbiD3QTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 12:19:42 -0400
X-Greylist: delayed 495 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 30 Apr 2022 09:16:19 PDT
Received: from komekko.fuwafuwatime.moe (unknown [IPv6:2a01:4f9:6a:1712::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7DFC34BB6;
        Sat, 30 Apr 2022 09:16:19 -0700 (PDT)
Received: from megumin.fuwafuwatime.moe (c-174-50-122-55.hsd1.ga.comcast.net [174.50.122.55])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by komekko.fuwafuwatime.moe (Postfix) with ESMTPSA id 87E981A7B66;
        Sat, 30 Apr 2022 19:07:59 +0300 (EEST)
Received: from localhost (bubbles.localdomain [192.168.1.101])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by megumin.fuwafuwatime.moe (Postfix) with ESMTPSA id 64665BB6B5B;
        Sat, 30 Apr 2022 12:07:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=concord.sh; s=dkim;
        t=1651334876;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=skqVWzMwophoEkJSS/d4zaggvs9O9ypBAst/OCvrWUI=;
        b=lDrp0a+eCJopgMZ+28H/ix2OqjLXZk3TXlRvSA7ljsSXD9/gu8sFJHdKcyoEs7xdTFfwSH
        nSiyknf+iWj6UuyRGNtR+0ew8GuX9EAkqwCgDy/F5kQqmzI852WHf6b4AF2ddtArV9e+YD
        LRaj+Zf9lFzFU6hhEeYY9yRwhqfNPywMsiSKHhJCI1hA9Zbi5HjoUWvu/Em92UwVXKsFyn
        9KU73ucJiekuZPlsqcnb60Q7EajBR6Jm9MFbCs/ZxRjmZ00kBr19mJB/ZMsuOSomuZSfva
        OsNe0ws9BpRW+WjCoYG8sLxdQut407naJI4iSJV/XAJTf15VxvmU5c8FwumpPw==
Date:   Sat, 30 Apr 2022 12:07:50 -0400
From:   Kenton Groombridge <me@concord.sh>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev
Subject: Re: [RFC PATCH 00/21] KCFI support
Message-ID: <20220430160750.ov7ddsq2vzibwrju@bubbles>
Mail-Followup-To: Sami Tolvanen <samitolvanen@google.com>,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev
References: <20220429203644.2868448-1-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zpbpn5imnhuprfsc"
Content-Disposition: inline
In-Reply-To: <20220429203644.2868448-1-samitolvanen@google.com>
Authentication-Results: ORIGINATING;
        auth=pass smtp.auth=me@concord.sh smtp.mailfrom=me@concord.sh
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zpbpn5imnhuprfsc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 22/04/29 01:36PM, Sami Tolvanen wrote:
> KCFI is a proposed forward-edge control-flow integrity scheme for
> Clang, which is more suitable for kernel use than the existing CFI
> scheme used by CONFIG_CFI_CLANG. KCFI doesn't require LTO, doesn't
> alter function references to point to a jump table, and won't break
> function address equality. The latest LLVM patches are here:
>=20
>   https://reviews.llvm.org/D119296
>   https://reviews.llvm.org/D124211

Many thanks for continuing to work on this! As a user who has been
following the evolution of this patch series for a while now, I have a
couple of burning questions:

1) The LLVM patch says that kCFI is not compatible with execute-only
memory. Is there a plan ahead for kCFI if and when execute-only memory
is implemented?

2) kCFI only checks indirect calls while Clang's traditional CFI has
more schemes like bad cast checking and so on. Are there any major
security tradeoffs as a result of this?

V/R

Kenton Groombridge

--zpbpn5imnhuprfsc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQKTBAABCgB9FiEEP+u3AkfbrORB/inCFt7v5V9Ft54FAmJtXtFfFIAAAAAALgAo
aXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5maWZ0aGhvcnNlbWFuLm5ldDNG
RUJCNzAyNDdEQkFDRTQ0MUZFMjlDMjE2REVFRkU1NUY0NUI3OUUACgkQFt7v5V9F
t544Dg//ZWfCVPSPbS6jIItV88Z+1j0B2V2ovBXyACDNw9+gb0nK3wdofNteeb+v
4/U/TIG66RKItrpzntuNJH6aaNvwXFnZX4Zoen+l9z/Y2bppPWk3j/FELtnPTopQ
Sze0C34gdGZnnHyzQwTl8QVmRJsON+FN0PmZfCQp4+5NRjWJRF3aI3fGBBYPS9sd
JkiG1k8/pQBRI5IcjYogXNshK/LPV/HpwUhkKdrG+f+Qbs+ItENMS3nO5c80yvd+
dVSzRf+5pCQHAu6JmcUWTejYG13oI5VasRTruh4US3ITaHB1uIPX1Qkhkejl9RMJ
hKhEbpKkEqZDBEU9eA5Zvjz2miSEnYBIBKdP8HloN4dhBAznKoiC9Q0hVMmR+kPD
oXnGs6YqgIP2n6tp8nq50nL/sieaBetzjnVb7qwnUHcmEsfFBa7enprmuwVgi/5g
sxgO7wup05JlE85rF5JOAXVcWC3zb8au+yMQknDx1p/hGvlMFWK+w0OqecK2dbos
crliqCbiL+2iL98O1ocYt40HT0AV3uuw8kSbMwjcJJepNvpTzrjf2q90ydCvCoDa
crAjD2xs16YHG7On/4P19fhh6Pirn/FlMYquKuOqInAU7qSDiu5vnqsXFn2UiuUc
wDqcwxC0qupYuI+Gm8PAb/QIcEY177T5OHOcu+qMppIasNsnCcI=
=jtla
-----END PGP SIGNATURE-----

--zpbpn5imnhuprfsc--
