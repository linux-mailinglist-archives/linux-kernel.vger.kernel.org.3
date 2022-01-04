Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE598484398
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 15:42:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234320AbiADOmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 09:42:24 -0500
Received: from ms.lwn.net ([45.79.88.28]:51072 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234262AbiADOmX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 09:42:23 -0500
X-Greylist: delayed 57045 seconds by postgrey-1.27 at vger.kernel.org; Tue, 04 Jan 2022 09:42:23 EST
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id A0E98299;
        Tue,  4 Jan 2022 14:42:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net A0E98299
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1641307342; bh=7ZuSoVaDF7HUoIoMH3MxtcdCVL8e7GEbds8CGOaH7J8=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Ce3gG6PQqzJuD6DW9fVFlZQlpw/QAIHkVkBKU5OczEF3viysxzKjLuTih/4qCkXAT
         D0mmtuXeBn6m6SJ0UCy5/Ywn9RhQtUn8Vp9GHIW43UK46D/A93SsGXZmoeS8gPPlxI
         7FfzhZYEmV6RsGsE5uxB4vgwpfvwbfiLrtjwFwB6AgVIO3lAZbKoGAZOuQTRW6pnPP
         015hCR2ZU/AEQFfentrtfTI6fZeuq7Yipn1iYTwJ5py3cpWu85VPedOFhg1ntGhgfN
         sPyLUnbKq7NkZ1jWnllq/PpDIxEwHig+KV9J7Rl2SBcTLCKV1x1dpSQ+wI3of1DKn5
         Z7rPBW3RMitcw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Thorsten Leemhuis <linux@leemhuis.info>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        workflows@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [RFC PATCH v1 2/2] docs: regressions.rst: rules of thumb for
 handling regressions
In-Reply-To: <ed8ffc6c-19cd-6558-7f7e-d7bdde4ecdb9@leemhuis.info>
References: <cover.1641203216.git.linux@leemhuis.info>
 <9a68f2fcb5fe599b76e278a61928e23eb950cd83.1641203216.git.linux@leemhuis.info>
 <CAKXUXMx_J-enVGQtX6ZqKKRZ7SwZe203tLnQoJ=VLPz3tUhK+Q@mail.gmail.com>
 <ed8ffc6c-19cd-6558-7f7e-d7bdde4ecdb9@leemhuis.info>
Date:   Tue, 04 Jan 2022 07:42:26 -0700
Message-ID: <87sfu3woj1.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thorsten Leemhuis <linux@leemhuis.info> writes:

> On 04.01.22 13:16, Lukas Bulwahn wrote:
>> On Mon, Jan 3, 2022 at 3:23 PM Thorsten Leemhuis <linux@leemhuis.info> wrote:
>>> +Try to fix regressions quickly once the culprit got identified. Fixes for most
>> 
>> s/got/gets/ --- at least, that is what the gmail grammar spelling suggests :)
>
> Hmm, LanguageTool didn't complain. Not totally sure, maybe both
> approaches are okay. But the variant suggested by the gmail checker
> might be the better one.

So we're deeply into nit territory, but "gets" would be the correct
tense there.  Even better, though, is to avoid using "to get" in this
way at all.  I'm informed that "to get" is one of the hardest verbs for
non-native speakers, well, to get, so I try to avoid it in my own
writing.  "once the culprit is identified" or "has been identified"
would both be good here.

>> financial support) for such further
>> documentation on the development process, please reach out to me and I
>> will see what I can do.

Financial support for documentation work?  Now there's a nice idea...:)

(back to real work now)

jon
