Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 854014711A9
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 06:17:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbhLKFU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 00:20:57 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:40108 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbhLKFU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 00:20:56 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 7EE5BCE2F24;
        Sat, 11 Dec 2021 05:17:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B93AC004DD;
        Sat, 11 Dec 2021 05:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639199837;
        bh=qJhikgXWzaoyJDcutq52oBBNAeenNWQANF7cPpNbU0M=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=n+zj0+bE7v6iDCAcZSsr1U5X0CDJ1DktplwqX0bxON+sDN/w86rNaeR4a9q+2g4uj
         tFIc6iNtwXFfLEyrKrOKFY66maabggwaQHmJogN/UjJ4pXRRq+9UiHJoGQY0hNJC2Q
         fqasI0pf67J1jNIu6Qb8Gjz/N5oo1Q8jRXQRsd2oZuJaX1Fw3lF/7PtCJiyKYavux4
         9Ayja/XQH0tdpDIoeyRwB6cftKoiEa/CSoleWKxZ8BHNfRPsqSr/cTXWrdE//aTvKk
         1NoTIKf2VXUQS3LfL4IA+3T9QzQNCIX9XfhrhjiInXPb6Zq/tc2WaCtouY2U8vU6iw
         8hTmHl6MB3I4A==
Message-ID: <dc1db094f94e2b4db58f5f3dce384f6967dd4168.camel@kernel.org>
Subject: Re: [PATCH 10/25] x86/sgx: Support enclave page permission changes
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Dave Hansen <dave.hansen@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>
Cc:     dave.hansen@linux.intel.com, tglx@linutronix.de, bp@alien8.de,
        luto@kernel.org, mingo@redhat.com, linux-sgx@vger.kernel.org,
        x86@kernel.org, seanjc@google.com, kai.huang@intel.com,
        cathy.zhang@intel.com, cedric.xing@intel.com,
        haitao.huang@intel.com, mark.shanahan@intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Date:   Sat, 11 Dec 2021 07:17:13 +0200
In-Reply-To: <925629af-8cb3-c3c7-35ca-52d30beb984d@intel.com>
References: <cover.1638381245.git.reinette.chatre@intel.com>
         <44fe170cfd855760857660b9f56cae8c4747cc15.1638381245.git.reinette.chatre@intel.com>
         <Yav0/3jeJsuT3yEq@iki.fi> <925629af-8cb3-c3c7-35ca-52d30beb984d@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.42.2 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-12-06 at 12:19 -0800, Dave Hansen wrote:
> On 12/4/21 3:08 PM, Jarkko Sakkinen wrote:
> > > Enclave page permission changes need to be approached with care and
> > > for this reason this initial support is to allow enclave page
> > > permission changes _only_ if the new permissions are the same or
> > > more restrictive that the permissions originally vetted at the time t=
he
> > > pages were added to the enclave. Support for extending enclave page
> > > permissions beyond what was originally vetted is deferred.
> > This paragraph is out-of-scope for a commit message. You could have
> > this in the cover letter but not here. I would just remove it.
>=20
> This does convey valuable information, though.  It tells the reader that
> this is a sub-optimal implementation.  It also acknowledges that there
> is further work to do.  Maybe saying that it is "deferred" is not quite
> the verbiage I would use, but the concept is fine.

BTW, should we consistently speak about protection bits instead of
permissions?

/Jarkko
