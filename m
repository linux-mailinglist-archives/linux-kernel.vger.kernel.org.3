Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D237047129C
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 08:53:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbhLKHxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 02:53:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbhLKHxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 02:53:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FAC4C061714;
        Fri, 10 Dec 2021 23:53:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 44FFCB80763;
        Sat, 11 Dec 2021 07:53:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91437C004DD;
        Sat, 11 Dec 2021 07:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639209201;
        bh=Ve28Nl70KS1HeXPGI4mklOyPjtN/kIinh54UncEWRU8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=fzmPUVwUilAcIW7BdrmqqJ+dKmzFVOAKCNlJHmGock0g94ZNhSeyubXpMajSiL//+
         hMMR0KjLYmio2g7DW34gBXeF5GJN9rVsHul1IxnhD7E0RrDv21sO0Fe4gpeit367vZ
         OYMO0a03i5/r/sHOzbJ3Pny83UsmnzR8Nhu92xl8wRhsW16uPQ2dylN7oOqPHmRgnI
         8MkX9jjxZu5RQmGlS7TfVt+YI4PgyXq7TbkjCaVpMFEYw4dDvZ7ag1ahfIq3jkF41w
         7nivfXqZ4+lHmPN0LV/8r/EosROH9Aoq74vPJ1NniD9gUrNfWbZHy/3QLpaPvYn8DI
         wfsLAOfbzjHIQ==
Message-ID: <f04bc4ba7ed1d8a1dc62b89d4fc0de6e794126f2.camel@kernel.org>
Subject: Re: [PATCH 08/25] x86/sgx: Make SGX IPI callback available
 internally
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     dave.hansen@linux.intel.com, tglx@linutronix.de, bp@alien8.de,
        luto@kernel.org, mingo@redhat.com, linux-sgx@vger.kernel.org,
        x86@kernel.org, seanjc@google.com, kai.huang@intel.com,
        cathy.zhang@intel.com, cedric.xing@intel.com,
        haitao.huang@intel.com, mark.shanahan@intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Date:   Sat, 11 Dec 2021 09:53:17 +0200
In-Reply-To: <bda9f351-6820-5978-44c5-0ca48fe7f31a@intel.com>
References: <cover.1638381245.git.reinette.chatre@intel.com>
         <d4c030fd6bc8d5a618204abaea4b97489f137cc9.1638381245.git.reinette.chatre@intel.com>
         <YavzKF3LooOmj3Un@iki.fi> <bda9f351-6820-5978-44c5-0ca48fe7f31a@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.42.2 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-12-06 at 13:36 -0800, Reinette Chatre wrote:
> Hi Jarkko,
>=20
> On 12/4/2021 3:00 PM, Jarkko Sakkinen wrote:
> > On Wed, Dec 01, 2021 at 11:23:06AM -0800, Reinette Chatre wrote:
> > > The ETRACK instruction followed by an IPI to all CPUs within an encla=
ve
> > > is a common pattern with more frequent use in support of SGX2.
> > >=20
> > > Make the (empty) IPI callback function available internally in
> > > preparation for more usages.
> >=20
> > Please, just describe the usages that this is needed for so that
> > there is zero guesswork required.
>=20
> The reader is not required to guess. The first paragraph states that=20
> SGX2 also uses the ETRACK flow that relies on this function. What if I=
=20
> replace "for more usages" by "for usage by SGX2"?

I think that'd be good enough.

/Jarkko
