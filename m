Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE2AA482F33
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 10:05:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232285AbiACJFA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 04:05:00 -0500
Received: from mga04.intel.com ([192.55.52.120]:42695 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232278AbiACJE7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 04:04:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641200699; x=1672736699;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=7MtfJB0ux1ftlT1RGKEJ22bg25hObeMn+1zfkq2OVPg=;
  b=DUSe0nbj0lsZ6VbuBIYCwtuwaai5+Vr1fnKSevkxgIWNiAVC1uY9WXvW
   mPN8vrKtrcsL4bCjtsm3b2t1sLabxoDDChNtU84aMEPG8z6va6Z+15Ayp
   J7FccV1p2zaPmNx5+kjOKa5TT4aNjwpbKN4oJvY1wY6clwTB+iru32kbc
   48SWr/M+hbq8ZorIWzF5khJk9/Rrz5v9z74p4B4n1/ekwJ4hr7b4+mQ+F
   YjXMZrOdsma2idTBhuzd1JzuTxLFUk7vO6w9unzDA6ng4GDKqJ8l/R5fO
   6q9KN1o6nmi15g1iXSf6T1MyZV3i6kyZL0EVrfWZCZ3Raj79DYYtN37XE
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10215"; a="240856652"
X-IronPort-AV: E=Sophos;i="5.88,257,1635231600"; 
   d="scan'208";a="240856652"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2022 01:04:58 -0800
X-IronPort-AV: E=Sophos;i="5.88,257,1635231600"; 
   d="scan'208";a="511971963"
Received: from kmorriss-mobl2.ger.corp.intel.com (HELO localhost) ([10.252.24.237])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2022 01:04:56 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Tomasz =?utf-8?B?V2FybmllxYLFgm8=?= <tomasz.warniello@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scripts: kernel-doc: transform documentation into POD
In-Reply-To: <0796a780-f5ee-0b6c-e7ef-544ba5f6a429@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20211209225549.69010-1-tomasz.warniello@gmail.com>
 <87h7b8cfg0.fsf@meer.lwn.net>
 <0796a780-f5ee-0b6c-e7ef-544ba5f6a429@gmail.com>
Date:   Mon, 03 Jan 2022 11:04:53 +0200
Message-ID: <87pmp9tcju.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 03 Jan 2022, Tomasz Warnie=C5=82=C5=82o <tomasz.warniello@gmail.com=
> wrote:
> On 17/12/2021 00:12, Jonathan Corbet wrote:
>>>  my $kernelversion;
>>> @@ -468,7 +306,7 @@ while ($ARGV[0] =3D~ m/^--?(.*)/) {
>>>      } elsif ($cmd eq "Werror") {
>>>  	$Werror =3D 1;
>>>      } elsif (($cmd eq "h") || ($cmd eq "help")) {
>>> -	usage();
>>> +			pod2usage(-exitval =3D> 0, -verbose =3D> 2);
>>=20
>> Why the strange indentation here?  This file is far from pretty, but
>> that makes it worse.  (Other places too).
>
> Sometimes beauty requires cooperation. You can help it in your pager.
> If it's less, then try `-x 2`, `-x 4`, etc.

In kernel, tabs are 8 characters.

See Documentation/process/coding-style.rst


BR,
Jani.


--=20
Jani Nikula, Intel Open Source Graphics Center
