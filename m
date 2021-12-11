Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 659814712AF
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 09:02:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbhLKICK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 03:02:10 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:33192 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbhLKICJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 03:02:09 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C77D7CE2903;
        Sat, 11 Dec 2021 08:02:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CEA4C004DD;
        Sat, 11 Dec 2021 08:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639209726;
        bh=ZoQp9huheWPnqZX3HAaei7T8AQ0sKAofAVbgyNmp1Zs=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=c06WDonmvd5IlsI6bc0Z2zd4Wf/8eo+qBkKQdBzPDkuAOZpaAhfbJWJWZBjLsCz88
         Ad+ekCA5vAE/YncqavtAtA+rYZAp/KG1x6z7LtYoQrjp8SnwG5Uspx7vYAYGRltxUB
         LUSYIB8PnjZIsow3iujWBiK3hXqXkeQOD5PZNVbSSTugR4sxYwuOIluVuwv3Sb5lPe
         z62vbRR2DBa/klOuf/OS2uG1mUmzbzFEAeUZvmYHJE+3K6RQ2hCxuRZkf4PHY54z/1
         DKV7oR/BrwjWEp/3iFbLWQSs9xDhKBdedIpA81BV+V3d0eWUdm+5Jg3UFmM2PEUYe1
         NICLQ8qYnp3OA==
Message-ID: <2a269a4dde2976f7aaf17de9c4a7fca3552e9c7a.camel@kernel.org>
Subject: Re: [PATCH 16/25] x86/sgx: Support modifying SGX page type
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     dave.hansen@linux.intel.com, tglx@linutronix.de, bp@alien8.de,
        luto@kernel.org, mingo@redhat.com, linux-sgx@vger.kernel.org,
        x86@kernel.org, seanjc@google.com, kai.huang@intel.com,
        cathy.zhang@intel.com, cedric.xing@intel.com,
        haitao.huang@intel.com, mark.shanahan@intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Date:   Sat, 11 Dec 2021 10:02:02 +0200
In-Reply-To: <dc74a876-54fe-5caa-6602-8887cfe34315@intel.com>
References: <cover.1638381245.git.reinette.chatre@intel.com>
         <c0f04a8f7e1afd9e9319bb9f283db9a3187f7abc.1638381245.git.reinette.chatre@intel.com>
         <Yav9g4+L8zg48DRf@iki.fi> <dc74a876-54fe-5caa-6602-8887cfe34315@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.42.2 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-12-06 at 13:48 -0800, Reinette Chatre wrote:
> > I'd suggest to change this as SGX_IOC_ENCLAVE_MODIFY_TYPE.
>=20
> How about SGX_IOC_ENCLAVE_MOD_TYPE to be consistent with your earlier=20
> suggestion of SGX_IOC_ENCLAVE_MOD_PROTECTIONS ?

I think it would be best to introduce only one new ioctl that would
be capable of doing either operation (and use secinfo as a vessel
for additional data).

/Jarkko
