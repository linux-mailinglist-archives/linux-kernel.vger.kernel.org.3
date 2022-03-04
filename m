Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3032D4CCE14
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 07:48:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238559AbiCDGsu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 01:48:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236380AbiCDGsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 01:48:47 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 903F74DF5C;
        Thu,  3 Mar 2022 22:47:51 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id d19so8560028ioc.8;
        Thu, 03 Mar 2022 22:47:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=j23UEdgmoD3PT7cpFQAiB9cWyyGiVLaUvaBGU1GyBnM=;
        b=O4anCBKrsFyHyGzL2RF8B7cVoEGN7VorjGDN2lWfWk7InIipFAsHECPDsdOCfaRbpB
         2Kt82y1BnVO5YHOf3TxW7h/ybyzM3bT9MqjlwgrpF2WtQIymp3JrcV5QOJEJ8rNAIy4a
         PLCK58ysJgdl6mAUW1D1vHWF/bPt2T/nCsKva5+pRKypjda9JkxpjO555iUWjqjtp6yX
         zHOy96yoFqH9Ox7QiF69+hVa9y7GMf1LfN3bnbRccWkQk1lRwTQ5rw3V4NJLJHSc6e0c
         VwIf3JuNMtpCudUkuFthPr30ar6Xx9zkMXFuboIjXHL3QE+cBaOVO72cXXKQ0MYLNUUC
         qmAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=j23UEdgmoD3PT7cpFQAiB9cWyyGiVLaUvaBGU1GyBnM=;
        b=EIWJKxLuaZjNPU0LmcF8cDkwAq9ngR+mdK8bsVpJCGcbFbjpMPcLDvzWHYpAn9yq47
         Icd443w3TnxHlDHSPJxGJEWejQaeQ8MUUNzCfKYbOxSR71OgZ3U/Y3bxo0RKb6orkhCM
         WLRC5ME66XoaWdf8woMGmJexguOVua8cULNdOU1dSI/TQ9yz75sKn1qq8z8eOxZWfwl0
         Esmaz7Tu7i6oZBYCmF15YWMAJTn5kqMBdJEH0KjgLmRfAosgOq8vpPCIKGH+O/o0No2L
         dlDWx/hEGVDmoyHKAVtl8iwhpIt91Jt+HHHh+E/w5Ru/BZG75HBw+3+JvFBaDZqwOyb0
         ukZw==
X-Gm-Message-State: AOAM530QWvkRdgD7Nl6oOSuSxW7IAvy26KMZXE/uLE4LLVfu10TPlUpO
        FLi+ws4Jt91Kni9DdMlxbnFK7iTvlofHV2tlHwU=
X-Google-Smtp-Source: ABdhPJxjDfv6jFJYN4fxfZbOXWdF3sJLBJrEkBPrcaNpWv3Ngca5sjQyQ48mqksXjVECGHbzT/Tk6PN8pi5cV3tELNU=
X-Received: by 2002:a05:6638:a9b:b0:317:12d1:5a46 with SMTP id
 27-20020a0566380a9b00b0031712d15a46mr15095078jas.306.1646376471271; Thu, 03
 Mar 2022 22:47:51 -0800 (PST)
MIME-Version: 1.0
References: <20220301145233.3689119-1-arnd@kernel.org> <20220301145233.3689119-3-arnd@kernel.org>
 <CA+icZUWCTuVeohWvePhxYY3WC9xAYSy9nP1xQQf=tFH_mWDCNQ@mail.gmail.com>
 <CAKwvOdn04aoWO_384k5HQodwA1-DCFwU50iRXQXh_BQk5pyz7w@mail.gmail.com>
 <CA+icZUWD_O1WTKNDTj7f+EUxx5Pf=zC53mfOBNgtj1JQwjZVAQ@mail.gmail.com> <YiD86pay2ENCebkR@dev-arch.thelio-3990X>
In-Reply-To: <YiD86pay2ENCebkR@dev-arch.thelio-3990X>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Fri, 4 Mar 2022 07:47:14 +0100
Message-ID: <CA+icZUXDBe5MF6G_2v4XoV0SFVkTZ96M5i-VGSvHsP1pFJ+nAg@mail.gmail.com>
Subject: Re: [PATCH 3/3] Kbuild: use -std=gnu11 for KBUILD_USERCFLAGS
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Marco Elver <elver@google.com>,
        Jani Nikula <jani.nikula@intel.com>,
        David Sterba <dsterba@suse.com>, Alex Shi <alexs@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kbuild@vger.kernel.org, llvm@lists.linux.dev,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        WEIRD_PORT autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 3, 2022 at 6:37 PM Nathan Chancellor <nathan@kernel.org> wrote:
>
> Hi Sedat,
>
> On Thu, Mar 03, 2022 at 07:26:05AM +0100, Sedat Dilek wrote:
> > Hey Nick!
> >
> > This only applies 1/3.
> >
> > $ b4 --version
> > 0.8.0
> >
> > $ b4 am https://lore.kernel.org/lkml/20220301145233.3689119-1-arnd@kern=
el.org/
> > -o - | git am -3
> > Analyzing 14 messages in the thread
> > Will use the latest revision: v3
> > You can pick other revisions using the -vN flag
> > Checking attestation on all messages, may take a moment...
> > ---
> >  =E2=9C=93 [PATCH v3 1/3] Kbuild: move to -std=3Dgnu11
> >    =E2=9C=93 Signed: DKIM/kernel.org
> >    + Reviewed-by: Nathan Chancellor <nathan@kernel.org> (=E2=9C=93 DKIM=
/kernel.org)
> >  ERROR: missing [2/3]!
> >  ERROR: missing [3/3]!
> >  ---
> >  NOTE: install patatt for end-to-end signature verification
> > ---
> > Total patches: 1
> > ---
> > WARNING: Thread incomplete!
> > Link: https://lore.kernel.org/r/20220301145233.3689119-1-arnd@kernel.or=
g
> > Base: not specified
> > Wende an: Kbuild: move to -std=3Dgnu11
>
> It looks like the threading somehow got broken, likely due to the [v3]
> on the first patch and not the second or third:
>
> This worked for me on v5.17-rc6:
>
> $ for i in $(seq 1 3); do b4 shazam -P _ 20220301145233.3689119-"$i"-arnd=
@kernel.org; done
>
> "b4 shazam" is the equivalent of "b4 am -o - ... | git am" and the
> "-P _" tells b4 to only fetch that exact message ID, not the whole
> thread.
>

Hmm, the universe is not good to me...

$ for i in $(seq 1 3); do b4 shazam -P _
20220301145233.3689119-"$i"-arnd@kernel.org; done
usage: b4 [-h] [--version] [-d] [-q] {mbox,am,attest,pr,ty,diff,kr} ...
b4: error: argument subcmd: invalid choice: 'shazam' (choose from
'mbox', 'am', 'attest', 'pr', 'ty', 'diff', 'kr')
usage: b4 [-h] [--version] [-d] [-q] {mbox,am,attest,pr,ty,diff,kr} ...
b4: error: argument subcmd: invalid choice: 'shazam' (choose from
'mbox', 'am', 'attest', 'pr', 'ty', 'diff', 'kr')
usage: b4 [-h] [--version] [-d] [-q] {mbox,am,attest,pr,ty,diff,kr} ...
b4: error: argument subcmd: invalid choice: 'shazam' (choose from
'mbox', 'am', 'attest', 'pr', 'ty', 'diff', 'kr')

Do I need a higher version of b4 (here: v0.8.0)?

Check myself... b4.git:

commit 7c1d044ff1d5235e598d4c777c4abfe60e0a09a8
("shazam: change default behaviour to be "apply-here"")

...is post-v0.8.0.

Lemme see if I can apply this patch...

# cd /usr/lib/python3/dist-packages

# LC_ALL=3DC git apply --check --verbose /root/b4-shazam.patch
Checking patch b4/command.py...
error: while searching for:
   sp.add_argument('-M', '--save-as-maildir', dest=3D'maildir',
action=3D'store_true', default=3DFalse,
                   help=3D'Save as maildir (avoids mbox format ambiguities)=
')

def cmd_am_common_opts(sp):
   sp.add_argument('-v', '--use-version', dest=3D'wantver', type=3Dint,
default=3DNone,
                   help=3D'Get a specific version of the patch/series')

error: patch failed: b4/command.py:35
error: b4/command.py: patch does not apply
Checking patch b4/mbox.py...
error: while searching for:
       ifh =3D io.StringIO()
       b4.save_git_am_mbox(am_msgs, ifh)
       ambytes =3D ifh.getvalue().encode()
       if cmdargs.applyhere:
           amflags =3D config.get('git-am-flags', '')
           sp =3D shlex.shlex(amflags, posix=3DTrue)
           sp.whitespace_split =3D True

error: patch failed: b4/mbox.py:262
error: b4/mbox.py: patch does not apply

Nope.
Dunno if I am willing to do that manually or build-from-git.

Anyway, can you add this b4 shazam tipp/trick to our wiki, please?

Last question:

LLVM/Clang-14...
Do I need any patches to Linux v5.17-rc6 or upstream Git?
Dependent/Independent of "std-gnu-11"?

I can see on my Debian/unstable AMD64 system:

# LC_ALL=3DC apt-cache policy clang-14
clang-14:
 Installed: (none)
 Candidate: 1:14.0.0~++20220301114802+19149538e9a9-1~exp1~20220301234814.85
 Version table:
    1:14.0.0~++20220301114802+19149538e9a9-1~exp1~20220301234814.85 99
        99 https://apt.llvm.org/unstable llvm-toolchain-14/main amd64 Packa=
ges
    1:14.0.0~+rc1-1 99
        99 https://ftp.debian.org/debian unstable/main amd64 Packages
        99 https://deb.debian.org/debian unstable/main amd64 Packages

The one from apt.llvm.org I guess is LLVM/Clang v14.0.0-rc2?

Maybe, I wait until Masahiroy has the triple in his kbuild Git tree...

Thanks.

Have a nice Friday,
- sed@ -

[1] https://git.kernel.org/pub/scm/utils/b4/b4.git/tag/?h=3Dv0.8.0
[2] https://git.kernel.org/pub/scm/utils/b4/b4.git/commit/?id=3D7c1d044ff1d=
5235e598d4c777c4abfe60e0a09a8
[3] https://github.com/ClangBuiltLinux/linux/wiki/Command-line-tips-and-tri=
cks
