Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F3494711EA
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 06:28:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbhLKFbv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 00:31:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbhLKFbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 00:31:50 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DC5CC061714;
        Fri, 10 Dec 2021 21:28:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 126EBB82AD3;
        Sat, 11 Dec 2021 05:28:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 615C0C004DD;
        Sat, 11 Dec 2021 05:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639200491;
        bh=DmF69SAhs/bhKdwrdHs+5LvgKoaOu6JAimdnFR5ocro=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=WxZNmaWs7+mM9QuqbhLVtfI1yU4Mes/oBQ2285eK/bpdqmKAMgziF4I0NTeeaQOlz
         Sx9LteEDeZ/LDGHq1ujSCXZ2wtPLhED4moKs4iaoRhm5pShS9y9vYCvNbTwPLShnGI
         uAxPZ7ZnZqJVnPVusuNm1nbOZfGIeCswmWWawn9qgyln6FKVOMYRnAb65KY//fnea+
         UYgVqWaIgv/Co9BIpISfpYAJVVm91xsMjxF2fOmQaboV2av7XQfUaHrADoRKI24Alk
         4+DKtxMVOzdEeH3WRsF0WNbCQWXH3c55X+NDjVrFrUuN40HZLrLUWwVcTgCOJWPO9S
         nZcieBuoBoWFw==
Message-ID: <b6eeb67d3be33767a4d52d8e2009817a90d91224.camel@kernel.org>
Subject: Re: [PATCH 01/25] x86/sgx: Add shortlog descriptions to ENCLS
 wrappers
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     dave.hansen@linux.intel.com, tglx@linutronix.de, bp@alien8.de,
        luto@kernel.org, mingo@redhat.com, linux-sgx@vger.kernel.org,
        x86@kernel.org, seanjc@google.com, kai.huang@intel.com,
        cathy.zhang@intel.com, cedric.xing@intel.com,
        haitao.huang@intel.com, mark.shanahan@intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Date:   Sat, 11 Dec 2021 07:28:08 +0200
In-Reply-To: <b49ee68b-63c5-f8f8-ca2b-31663c3150f6@intel.com>
References: <cover.1638381245.git.reinette.chatre@intel.com>
         <fd9ab4d760a2ea7a42ab9e60b9e19b8620abe11d.1638381245.git.reinette.chatre@intel.com>
         <YauzxOEmmpeGF/K3@iki.fi> <b49ee68b-63c5-f8f8-ca2b-31663c3150f6@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.42.2 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-12-06 at 13:13 -0800, Reinette Chatre wrote:
> > * "Create an SECS page in the Enclave Page Cache (EPC)"
> > * "Add a Version Array (VA) page to the Enclave Page Cache (EPC)"
> >=20
> > They should have similar descriptions, e.g.
> >=20
> > * "Initialize an EPC page into SGX Enclave Control Structure (SECS) pag=
e."
> > * "Initialize an EPC page into Version Array (VA) page."
>=20
> Will do. Did you intentionally omit the articles or would you be ok if I=
=20
> change it to:
>=20
> "Initialize an EPC page into an SGX Enclave Control Structure (SECS) page=
."
> "Initialize an EPC page into a Version Array (VA) page."
>=20
> I also notice that you prefer the comments to end with a period and I=20
> will do so for all in the next version.

Looks fine to me.

> > > +/* Extend uninitialized enclave measurement */
> > >   static inline int __eextend(void *secs, void *addr)
> > >   {
> > >   	return __encls_2(EEXTEND, secs, addr);
> > >   }
> >=20
> > That description does not make __eextend any less cryptic.
> >=20
> > Something like this would be already more informative:
> >=20
> > /* Hash a 256 byte region of an enclave page to SECS:MRENCLAVE. */
>=20
> Thank you, I will use this description.
>=20
> >=20
> > This same remark applies to the rest of these comments. They should
> > provide a clue what the wrapper does rather than an English open coded
> > function name.
>=20
> Please see below for another attempt that includes your proposed changes=
=20
> so far. What do you think?
>=20
> __ecreate():
> /* Initialize an EPC page into an SGX Enclave Control Structure (SECS)=
=20
> page. */
>=20
> __eextend():
> /* Hash a 256 byte region of an enclave page to SECS:MRENCLAVE. */
>=20
> __eadd():
> /* Copy a source page from non-enclave memory into the EPC. */

Perhaps:

/*=C2=A0
 * Associate an EPC page to an enclave either as a REG or TCS page
 * populated with the provided data.
 */

This is more aligned with your description for __eremove().

>=20
> __einit():
> /* Finalize enclave build, initialize enclave for user code execution */
>=20
> __eremove():
> /* Disassociate EPC page from its enclave and mark it as unused. */
>=20
> __edbgwr():
> /* Copy data to an EPC page belonging to a debug enclave. */
>=20
> __edbgrd():
> /* Copy data from an EPC page belonging to a debug enclave. */
>=20
> __etrack():
> /* Track that software has completed the required TLB address clears. */
>=20
> __eldu():
> /* Load, verify, and unblock an Enclave Page Cache (EPC) page. */
>=20
> __eblock():
> /* Make EPC page inaccessible to enclave, ready to be written to memory. =
*/
>=20
> __epa():
> /* Initialize an EPC page into a Version Array (VA) page. */
>=20
> __ewb():
> /* Invalidate an EPC page and write it out to main memory. */
>=20
>=20
> Reinette

/Jarkko
