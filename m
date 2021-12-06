Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6324346902D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 06:27:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232755AbhLFF03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 00:26:29 -0500
Received: from mail-4317.proton.ch ([185.70.43.17]:25762 "EHLO
        mail-4317.proton.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbhLFF03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 00:26:29 -0500
Date:   Mon, 06 Dec 2021 05:22:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alshehhi.io;
        s=protonmail2; t=1638768178;
        bh=QedFli8Yjca5xzsZm84nVRMgPS3fIfLF/WnRhgd85yU=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:From:To:Cc;
        b=dqL7BZXNK7ujbDb2/lGz6uH8LVTqW7ULpFoB54uE7Jm7jYezxQvh/BFrruvVdxX6t
         KiUMVaDPrJsYnvcTbJHm5Z1I6GPam56PiXLs9fYo+Y8jiq1D20R3RBQOaXdKSYQGav
         HB9HXv3HSZeLoef2EOQSm/uT+xLJWK0o91pAtCADP6VukLXX0cWBfV+sQ8Dd65SOxA
         hbfckZ3lGvaxpBqNl2beJBV8XaQ47Uo0LjDVDg2gqk5da4dOcgCBj5S5aBWC2B0AAd
         d5wEGV1NAXm9G/qQq3dUBRzRNF8QU994+LZU9J+4TCa11WbfjGL96Llhzd5DgbQOI3
         sXWLQeuDUWbJA==
To:     masahiroy@kernel.org
From:   Alshehhi Family <family@alshehhi.io>
Cc:     linux-kernel@vger.kernel.org, trivial@kernel.org,
        Husain Alshehhi <husain@alshehhi.io>
Reply-To: Alshehhi Family <family@alshehhi.io>
Subject: Re: [PATCH] Fix styling issues reported by checkpatch in usr/gen_init_cpio.c
Message-ID: <87y24y1f4p.fsf@alshehhi.io>
In-Reply-To: <20211206032840.531625-1-husain@alshehhi.io>
References: <20211206032840.531625-1-husain@alshehhi.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This is my first Patch to the linux kernel. I am not sure whether
details on how this patch is tested should be included in the commit
message or not. Nevertheless, here are the details.

Original:

    /home/husain/src/linux/scripts/checkpatch.pl --file --terse --emacs /ho=
me/husain/src/linux/usr/gen_init_cpio.c
    /home/husain/src/linux/usr/gen_init_cpio.c:42: WARNING: space prohibite=
d between function name and open parenthesis '('
    /home/husain/src/linux/usr/gen_init_cpio.c:76: WARNING: const array sho=
uld probably be static const
    /home/husain/src/linux/usr/gen_init_cpio.c:79: WARNING: quoted string s=
plit across lines
    /home/husain/src/linux/usr/gen_init_cpio.c:83: WARNING: Unnecessary typ=
ecast of c90 int constant - '(long) 0' could be '0L'
    /home/husain/src/linux/usr/gen_init_cpio.c:84: WARNING: Unnecessary typ=
ecast of c90 int constant - '(long) 0' could be '0L'
    /home/husain/src/linux/usr/gen_init_cpio.c:86: WARNING: Unnecessary typ=
ecast of c90 int constant - '(long) 0' could be '0L'
    /home/husain/src/linux/usr/gen_init_cpio.c:92: WARNING: Prefer 'unsigne=
d int' to bare use of 'unsigned'
    /home/husain/src/linux/usr/gen_init_cpio.c:110: ERROR: space required a=
fter that ',' (ctx:VxV)
    /home/husain/src/linux/usr/gen_init_cpio.c:111: WARNING: quoted string =
split across lines
    /home/husain/src/linux/usr/gen_init_cpio.c:119: WARNING: Prefer 'unsign=
ed int' to bare use of 'unsigned'
    /home/husain/src/linux/usr/gen_init_cpio.c:124: WARNING: Prefer 'unsign=
ed int' to bare use of 'unsigned'
    /home/husain/src/linux/usr/gen_init_cpio.c:143: WARNING: Comparisons sh=
ould place the constant on the right side of the test
    /home/husain/src/linux/usr/gen_init_cpio.c:159: ERROR: space required a=
fter that ',' (ctx:VxV)
    /home/husain/src/linux/usr/gen_init_cpio.c:160: WARNING: quoted string =
split across lines
    /home/husain/src/linux/usr/gen_init_cpio.c:173: WARNING: Prefer 'unsign=
ed int' to bare use of 'unsigned'
    /home/husain/src/linux/usr/gen_init_cpio.c:214: WARNING: Comparisons sh=
ould place the constant on the right side of the test
    /home/husain/src/linux/usr/gen_init_cpio.c:253: ERROR: space required a=
fter that ',' (ctx:VxV)
    /home/husain/src/linux/usr/gen_init_cpio.c:254: WARNING: quoted string =
split across lines
    /home/husain/src/linux/usr/gen_init_cpio.c:267: WARNING: Prefer 'unsign=
ed int' to bare use of 'unsigned'
    /home/husain/src/linux/usr/gen_init_cpio.c:285: WARNING: Comparisons sh=
ould place the constant on the right side of the test
    /home/husain/src/linux/usr/gen_init_cpio.c:311: WARNING: space prohibit=
ed between function name and open parenthesis '('
    /home/husain/src/linux/usr/gen_init_cpio.c:313: WARNING: space prohibit=
ed between function name and open parenthesis '('
    /home/husain/src/linux/usr/gen_init_cpio.c:331: WARNING: space prohibit=
ed between function name and open parenthesis '('
    /home/husain/src/linux/usr/gen_init_cpio.c:335: WARNING: space prohibit=
ed between function name and open parenthesis '('
    /home/husain/src/linux/usr/gen_init_cpio.c:337: WARNING: space prohibit=
ed between function name and open parenthesis '('
    /home/husain/src/linux/usr/gen_init_cpio.c:344: ERROR: trailing stateme=
nts should be on next line
    /home/husain/src/linux/usr/gen_init_cpio.c:349: ERROR: space required a=
fter that ',' (ctx:VxV)
    /home/husain/src/linux/usr/gen_init_cpio.c:350: WARNING: quoted string =
split across lines
    /home/husain/src/linux/usr/gen_init_cpio.c:382: ERROR: trailing whitesp=
ace
    /home/husain/src/linux/usr/gen_init_cpio.c:384: ERROR: trailing stateme=
nts should be on next line
    /home/husain/src/linux/usr/gen_init_cpio.c:385: ERROR: trailing stateme=
nts should be on next line
    /home/husain/src/linux/usr/gen_init_cpio.c:398: WARNING: sizeof expande=
d should be sizeof(expanded)
    /home/husain/src/linux/usr/gen_init_cpio.c:418: WARNING: Comparisons sh=
ould place the constant on the right side of the test
    /home/husain/src/linux/usr/gen_init_cpio.c:430: WARNING: space prohibit=
ed between function name and open parenthesis '('
    /home/husain/src/linux/usr/gen_init_cpio.c:452: ERROR: code indent shou=
ld use tabs where possible
    /home/husain/src/linux/usr/gen_init_cpio.c:454: ERROR: trailing stateme=
nts should be on next line
    /home/husain/src/linux/usr/gen_init_cpio.c:527: WARNING: space prohibit=
ed between function name and open parenthesis '('
    /home/husain/src/linux/usr/gen_init_cpio.c:577: ERROR: do not use assig=
nment in if condition
    /home/husain/src/linux/usr/gen_init_cpio.c:595: ERROR: space prohibited=
 after that '!' (ctx:BxW)
    /home/husain/src/linux/usr/gen_init_cpio.c:595: ERROR: do not use assig=
nment in if condition
    /home/husain/src/linux/usr/gen_init_cpio.c:613: ERROR: space prohibited=
 after that '!' (ctx:BxW)
    /home/husain/src/linux/usr/gen_init_cpio.c:613: ERROR: do not use assig=
nment in if condition
    /home/husain/src/linux/usr/gen_init_cpio.c:622: WARNING: Missing a blan=
k line after declarations
    /home/husain/src/linux/usr/gen_init_cpio.c:622: ERROR: space prohibited=
 after that '!' (ctx:BxW)
    /home/husain/src/linux/usr/gen_init_cpio.c:623: ERROR: do not use assig=
nment in if condition
    /home/husain/src/linux/usr/gen_init_cpio.c:631: WARNING: Comparisons sh=
ould place the constant on the right side of the test
    total: 17 errors, 29 warnings, 640 lines checked

After applying the change:

    /home/husain/src/linux/scripts/checkpatch.pl --file --terse --emacs /ho=
me/husain/src/linux/usr/gen_init_cpio.c
    /home/husain/src/linux/usr/gen_init_cpio.c:76: WARNING: const array sho=
uld probably be static const
    /home/husain/src/linux/usr/gen_init_cpio.c:79: WARNING: quoted string s=
plit across lines
    /home/husain/src/linux/usr/gen_init_cpio.c:111: WARNING: quoted string =
split across lines
    /home/husain/src/linux/usr/gen_init_cpio.c:160: WARNING: quoted string =
split across lines
    /home/husain/src/linux/usr/gen_init_cpio.c:254: WARNING: quoted string =
split across lines
    /home/husain/src/linux/usr/gen_init_cpio.c:351: WARNING: quoted string =
split across lines
    /home/husain/src/linux/usr/gen_init_cpio.c:581: ERROR: do not use assig=
nment in if condition
    /home/husain/src/linux/usr/gen_init_cpio.c:599: ERROR: do not use assig=
nment in if condition
    /home/husain/src/linux/usr/gen_init_cpio.c:617: ERROR: do not use assig=
nment in if condition
    /home/husain/src/linux/usr/gen_init_cpio.c:628: ERROR: do not use assig=
nment in if condition
    total: 4 errors, 6 warnings, 645 lines checked

