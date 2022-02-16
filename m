Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C55BE4B9479
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 00:26:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238386AbiBPX1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 18:27:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231585AbiBPX06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 18:26:58 -0500
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 081F49EBAD;
        Wed, 16 Feb 2022 15:26:44 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 3ACEA37D;
        Wed, 16 Feb 2022 23:26:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 3ACEA37D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1645054004; bh=PZQSP6R+jY8fblyRlqUqjGpfYN7XjpKYkpL8H3cbVEY=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Kb2Sk70S8EhNPCcM5MR29SWBTGG4A1pIza/Ns+2ynTVGdgwtbAkwuPW5QqQVaPmvs
         H8IDDVrYHbyKohWgYAxa0lTmEiwtRQmpsghSUYC5UHX8sR4RyemEAuaUZNTtn6RWe4
         W58ckP4FpkbtlgdM7R93im1/qjf4pl5XCRWp4PUnf9cA87LKmuJUGGhkZIf0rODibA
         KAEys2kzND8XkAcm81U6D6k8ihjyXfZQqdINnvLyIGZTTZ1wwWEWJmiYNqm6+wGcVS
         60DeZwcq7R6sVfuudaM5nFS9PyK71/lY3OFf73mqFMT4LY39pRZ3sX5kr9nOlcXj65
         YxfaX6VIdOcJw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Tomasz =?utf-8?B?V2FybmllxYLFgm8=?= <tomasz.warniello@gmail.com>
Cc:     Tomasz =?utf-8?B?V2FybmllxYLFgm8=?= <tomasz.warniello@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jani Nikula <jani.nikula@linux.intel.com>
Subject: Re: [PATCH v3 11/15] scripts: kernel-doc: Remove the "format of
 comments" comment block
In-Reply-To: <20220104015946.529524-12-tomasz.warniello@gmail.com>
References: <20220104015946.529524-1-tomasz.warniello@gmail.com>
 <20220104015946.529524-12-tomasz.warniello@gmail.com>
Date:   Wed, 16 Feb 2022 16:26:43 -0700
Message-ID: <87k0du2y18.fsf@meer.lwn.net>
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

Tomasz Warnie=C5=82=C5=82o <tomasz.warniello@gmail.com> writes:

> As suggested by Jani Nikula in a reply to my first version of this
> transformation, Documentation/doc-guide/kernel-doc.rst can serve as the
> information hub for comment formatting. The section DESCRIPTION already
> points there, so the original comment block can just be removed.

This is a relatively good *why* section - the sort of text all of the
patches should have.

> * Transform documentation into POD (11/15)
> See step 1 for the series details.
>
> =3D Meta note =3D
>
> I guess, I should use the Suggested-by tag for credits.
> Maintainers, please correct this if I'm doing this wrong.

"meta notes" can appear below the "---" line, that way the maintainer
doesn't have to edit them out when the patch is applied.

> Suggested-by: Jani Nikula <jani.nikula@linux.intel.com>
> Signed-off-by: Tomasz Warnie=C5=82=C5=82o <tomasz.warniello@gmail.com>
> ---
>  scripts/kernel-doc | 115 ---------------------------------------------
>  1 file changed, 115 deletions(-)

Thanks,

jon
