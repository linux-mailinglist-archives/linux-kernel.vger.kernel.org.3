Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1B68584377
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 17:47:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbiG1Pr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 11:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiG1Pr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 11:47:26 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2779683F0;
        Thu, 28 Jul 2022 08:47:25 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 7F3896E2;
        Thu, 28 Jul 2022 15:47:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 7F3896E2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1659023245; bh=WPWb6jFvYHnp035wflsqDUw6T4C3asd++u8JRPqJZtc=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=EoIXXCwINM+f9Mj90XoejMDuPwaYBPdUcv647F9dfCEHfppP+cFVfr1mIR8MS9mu3
         zEP20G6u2BCWGN7k3yEi96u4AdcdeVSHdriWW77lYPB3RfDrvkgTlBOIHCitY1Mc+H
         t7TQbeZM+7bQymtQBL3gaqGjaeBzQneqviq4uqZNZjzRjhHbkY5kb9TNIObXKHDfAO
         7k0jDRcPEfC3WSHvaSppyHaxb+NhjDeJSd/kh0w1o7IVBONWwidBlV+Z8dWkkHfK7U
         Jcj3rgc1sLOCTTne0MJ9vaMPfkLBSffV48KGq9Oj2E4TXpeai3cvo8FxWHtdKsJLwS
         yEUwsU4NwjYpQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Bagas Sanjaya <bagasdotme@gmail.com>, linux-doc@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Hannu Hartikainen <hannu@hrtk.in>,
        Jiri Kosina <jkosina@suse.cz>, Miguel Ojeda <ojeda@kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH] MAINTAINERS: remove outdated patch submission guidelines
In-Reply-To: <20220723075525.210510-1-bagasdotme@gmail.com>
References: <20220723075525.210510-1-bagasdotme@gmail.com>
Date:   Thu, 28 Jul 2022 09:47:24 -0600
Message-ID: <87h731b5o3.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> The patch submission guidelines in MAINTAINERS are redundant, since
> submitting-patches does the job and more up-to-date to current kernel
> development process.
>
> Remove the guidelines, while also move trivial patch suggestion to
> submitting-patches.
>
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>  Documentation/process/submitting-patches.rst |  4 +-
>  MAINTAINERS                                  | 78 +-------------------
>  2 files changed, 6 insertions(+), 76 deletions(-)

So I'm generally in favor of this change, but ...

> diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
> index a1cb6280fbcf4e..bb720c057de7d7 100644
> --- a/Documentation/process/submitting-patches.rst
> +++ b/Documentation/process/submitting-patches.rst
> @@ -15,7 +15,9 @@ Documentation/process/submit-checklist.rst
>  for a list of items to check before submitting code.  If you are submitting
>  a driver, also read Documentation/process/submitting-drivers.rst; for device
>  tree binding patches, read

This won't apply - submitting-drivers.rst is gone.

> -Documentation/devicetree/bindings/submitting-patches.rst.
> +Documentation/devicetree/bindings/submitting-patches.rst. Not all suggestions
> +presented here matter on every patch (including trivial ones), so apply
> +some common sense.
>  
>  This documentation assumes that you're using ``git`` to prepare your patches.
>  If you're unfamiliar with ``git``, you would be well-advised to learn how to
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 64379c699903bc..8d668a0ec903e4 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1,81 +1,9 @@
>  List of maintainers and how to submit kernel changes
>  ====================================================
>  
> -Please try to follow the guidelines below.  This will make things
> -easier on the maintainers.  Not all of these guidelines matter for every
> -trivial patch so apply some common sense.
> -
> -Tips for patch submitters
> --------------------------
> -
> -1.	Always *test* your changes, however small, on at least 4 or
> -	5 people, preferably many more.
> -
> -2.	Try to release a few ALPHA test versions to the net. Announce
> -	them onto the kernel channel and await results. This is especially
> -	important for device drivers, because often that's the only way
> -	you will find things like the fact version 3 firmware needs
> -	a magic fix you didn't know about, or some clown changed the
> -	chips on a board and not its name.  (Don't laugh!  Look at the
> -	SMC etherpower for that.)
> -
> -3.	Make sure your changes compile correctly in multiple
> -	configurations. In particular check that changes work both as a
> -	module and built into the kernel.
> -
> -4.	When you are happy with a change make it generally available for
> -	testing and await feedback.
> -
> -5.	Make a patch available to the relevant maintainer in the list. Use
> -	``diff -u`` to make the patch easy to merge. Be prepared to get your
> -	changes sent back with seemingly silly requests about formatting
> -	and variable names.  These aren't as silly as they seem. One
> -	job the maintainers (and especially Linus) do is to keep things
> -	looking the same. Sometimes this means that the clever hack in
> -	your driver to get around a problem actually needs to become a
> -	generalized kernel feature ready for next time.
> -
> -	PLEASE check your patch with the automated style checker
> -	(scripts/checkpatch.pl) to catch trivial style violations.
> -	See Documentation/process/coding-style.rst for guidance here.
> -
> -	PLEASE CC: the maintainers and mailing lists that are generated
> -	by ``scripts/get_maintainer.pl.`` The results returned by the
> -	script will be best if you have git installed and are making
> -	your changes in a branch derived from Linus' latest git tree.
> -	See Documentation/process/submitting-patches.rst for details.
> -
> -	PLEASE try to include any credit lines you want added with the
> -	patch. It avoids people being missed off by mistake and makes
> -	it easier to know who wants adding and who doesn't.
> -
> -	PLEASE document known bugs. If it doesn't work for everything
> -	or does something very odd once a month document it.
> -
> -	PLEASE remember that submissions must be made under the terms
> -	of the Linux Foundation certificate of contribution and should
> -	include a Signed-off-by: line.  The current version of this
> -	"Developer's Certificate of Origin" (DCO) is listed in the file
> -	Documentation/process/submitting-patches.rst.
> -
> -6.	Make sure you have the right to send any changes you make. If you
> -	do changes at work you may find your employer owns the patch
> -	not you.
> -
> -7.	When sending security related changes or reports to a maintainer
> -	please Cc: security@kernel.org, especially if the maintainer
> -	does not respond. Please keep in mind that the security team is
> -	a small set of people who can be efficient only when working on
> -	verified bugs. Please only Cc: this list when you have identified
> -	that the bug would present a short-term risk to other users if it
> -	were publicly disclosed. For example, reports of address leaks do
> -	not represent an immediate threat and are better handled publicly,
> -	and ideally, should come with a patch proposal. Please do not send
> -	automated reports to this list either. Such bugs will be handled
> -	better and faster in the usual public places. See
> -	Documentation/admin-guide/security-bugs.rst for details.
> -
> -8.	Happy hacking.
> +If you'd like to submit kernel changes (patches), refer to
> +:ref:`submittingpatches` for the guidelines, and
> +:ref:`development_process_main` for detailed guide on development process.

Let's not put RST directives into MAINTAINERS, which isn't an RST file.
Just mention Documentation/whatever and all will be good.

Thanks,

jon
