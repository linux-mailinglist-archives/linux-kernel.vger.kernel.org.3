Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0484E4B9467
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 00:18:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238124AbiBPXSY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 18:18:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237894AbiBPXSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 18:18:22 -0500
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C37011FFF7A;
        Wed, 16 Feb 2022 15:18:09 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 618F537D;
        Wed, 16 Feb 2022 23:18:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 618F537D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1645053489; bh=V8K8xqB6GvWibTfMknLArVeDK2cu5lHKcq4ov4877bs=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=sgWiM+neEJ/Q6RDdyZglrjbiLRQBXww03crnSzmh3ua//HltnBL9MOkvCwyxn9KUP
         jJXssINRrbHrtEc2lpaCaEYjCGgCrT3XWFmTxasHRNBaey6Alr8KdFi66sjdzpQi3i
         hB3SCaNVpm67hkUalOl2wU9MCexgAks8ahJVMf/D1AaBHvXort7XRp6I9MscSHyHfJ
         m/BRadT3g9JHKsHRE0gJG1YYTXVgbynXvCm16M4q/I9exsbOvzOx6jm1cbZDWpXkMD
         7KWE1nhudXe/v4FZmzltjlM/mA8sJxdZdz5ffXnHi85NofThutblIrmTWVIZYox3pw
         dKumSu9ZKM8Xg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Tomasz =?utf-8?B?V2FybmllxYLFgm8=?= <tomasz.warniello@gmail.com>
Cc:     Tomasz =?utf-8?B?V2FybmllxYLFgm8=?= <tomasz.warniello@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 01/15] scripts: kernel-doc: Add the NAME section
In-Reply-To: <20220104015946.529524-2-tomasz.warniello@gmail.com>
References: <20220104015946.529524-1-tomasz.warniello@gmail.com>
 <20220104015946.529524-2-tomasz.warniello@gmail.com>
Date:   Wed, 16 Feb 2022 16:18:08 -0700
Message-ID: <87wnhu2yfj.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

My first comment is that the changelogs need work.  A changelog on a
patch should say what *that patch* is doing and, more importantly, why.=20=
=20
Neither of those are present here.

Tomasz Warnie=C5=82=C5=82o <tomasz.warniello@gmail.com> writes:

This information, to the extent that it's needed, should be a part of
the series description in part 0.

> You can see the POD with:
>
> $ perldoc scripts/kernel-doc
>
> * Transform documentation into POD (1/15)
> =3D Series explanation =3D
>
> This series transforms the free-form general comments - mainly the usage
> instructions and the meta information - into the standard Perl
> documentation format. Some of the original text is reduced out.
>
> The transformation includes language, paragraphing and editorial
> corrections.
>
> The only change in the script execution flow is the replacement of the
> 'usage' function with the native core Perl 'pod2usage'.
>
> The TODO suggestion to write POD found in the script is ancient, thus
> I can't address its author with a "Suggested-by" tag.
>
> The process consists of 15 steps.
>
> 1) Add the NAME section
> 2) Add the SYNOPSIS section
> 3) Relink argument parsing error handling to pod2usage
>
> The following subseries is disfunctional before its last part.
>
> 4) Translate the DESCRIPTION section
> 5) Translate the "Output format selection" subsection of OPTIONS
> 6) Translate the "Output format selection modifier" subsection of OPTIONS
> 7) Translate the "Output selection" subsection of OPTIONS
> 8) Translate the "Output selection modifiers" subsection of OPTIONS
> 9) Translate the "Other parameters" subsection of OPTIONS
> 10) Replace the usage function
>
> Here the DESCRIPTION and OPTIONS subseries is finished. The -h and -help
> parameters are handled by POD now.
>
> 11) Remove the "format of comments" comment block
> 12) Archive the pre-git museum
> 13) License cleanup
> 14) Refresh the copyright lines
> 15) Move the TODOs
>
> Signed-off-by: Tomasz Warnie=C5=82=C5=82o <tomasz.warniello@gmail.com>
> ---
>  scripts/kernel-doc | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/scripts/kernel-doc b/scripts/kernel-doc
> index 3106b7536b89..46d3e779bf5d 100755
> --- a/scripts/kernel-doc
> +++ b/scripts/kernel-doc
> @@ -16,6 +16,12 @@ use strict;
>  ## This software falls under the GNU General Public License.     ##
>  ## Please read the COPYING file for more information             ##
>=20=20
> +=3Dhead1 NAME
> +
> +kernel-doc - Print formatted kernel documentation to stdout
> +
> +=3Dcut
> +

So, we do like patches to be granular and do only one thing, but this
may be taking it a bit too far.  It could well be combined with patch 2,
for example, which is just adding another section.

Meanwhile, I'd describe its role is something like "extract and format
documentation from the kernel source".

Thanks,

jon
