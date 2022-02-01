Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 461804A5C0B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 13:17:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236275AbiBAMRu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 07:17:50 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:49847 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237962AbiBAMRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 07:17:48 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 8F65D32021A3;
        Tue,  1 Feb 2022 07:17:47 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 01 Feb 2022 07:17:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alyssa.is; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; bh=NwpNAO3jsQ2s8tfKumaXN6R+gbFuZ2OaHhV6Lb
        yW8bo=; b=QoprNxq1BWVwwPL7y3cxQvPRF3S5rNa6+9yTAo/Ks4f+AslOlgTU5N
        NEq33xioEvMUjTROWccysIodRzA2OF1BsqwGN3GC6b8IdnVpuZT3uD9I4EYqRy9+
        4yrEJDPI5j51SUO75D+xtoc+EIbVkw4b8c+N6u2VqClmdfK4PTTd8p+vIIvuq00J
        ADV0+MazXDa0EYpv3sn/p1s/ZffB8q+mubjuST2D5rZVweNeZpw42FK7Y+qsMScr
        m/3Z/xZX18et2tsNtAlxa//cyo9wikxXYFTjaIF2ukhaf/x4kBbpg8KMnpZbynP1
        R0HVrST3zaLZP4Tz/kWmQynbmepsLmZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=NwpNAO3jsQ2s8tfKu
        maXN6R+gbFuZ2OaHhV6LbyW8bo=; b=A6CyP1T5B1gZepWRttvl/KBBp8GUGfyTu
        cCdtSW9d8vZ/7Db6i8essvdSk+1hwnOKvtGWbFevNXsDB1IuK2QmYKqhl2Ip2r/2
        nfiAqxbZJQx2S/TDTkDuZsY8MlctZbNxLt2hwGejlyO1rEYcdJrroCdKuSoprn4f
        vLm3EY7gTLuhxmg1kQ+liYxJre+SN8/Hak9v1bygpi1N//I36ni6G9PNyHV+b90A
        MBo4ZTswu1HTqd2DvqWVxi3rSTO/03L9J2eRweuRpmzdpuyJsPjENXjyfSD9WDT9
        OwSl28Yg5cXw917BM9Xo/j8qwGNy0rV6G4E5XsvuY7jM+xjtaSe/Q==
X-ME-Sender: <xms:6iT5YcNlJV4nCTansnK-sVkP-TT4gsTeylLAif2wYQj0I9JBLWIPyQ>
    <xme:6iT5YS-iE-Fx--laY3Pa0lfoMejA0m5R7BW0m2w437l8KhPY29B2W0HLDDrTV3fIV
    GrZeXjw_LJ99Pqd6Q>
X-ME-Received: <xmr:6iT5YTSgxrVX9h3f3mkoVigIbIvJSjx3yBh5VjmKwSIKXk3jlHskfbWOAyuQzvEYEEyhqV-VOd5eDZjMgquGXJieMBer6cIK>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrgeefgdefkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtjeenucfhrhhomheptehlhihsshgr
    ucftohhsshcuoehhihesrghlhihsshgrrdhisheqnecuggftrfgrthhtvghrnhepgefgje
    fhudehhfevgfduledtuedtleefgeeutdehtddtgfeffedtjeehveduvedtnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepqhihlhhishhssegvvh
    gvrdhqhihlihhsshdrnhgvth
X-ME-Proxy: <xmx:6iT5YUtaVObbcat8mBnXc12hcwUGznlojG0jH4n9AYPk5YJFcJJC6g>
    <xmx:6iT5YUeYcV7xkupfu2lxeKpPhICLq7vKPKHfwVawbzYxRWOiyhPVJA>
    <xmx:6iT5YY08iLnyq27bpWJUNm_a-x1Ey1iEYTzT9z7Uf6Tp-MmMyEaXpw>
    <xmx:6yT5YcTBExqz--oWaos4rcY6AZKU85zBOnQBCKWXJWHg8UerBuTcLw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Feb 2022 07:17:46 -0500 (EST)
Received: by eve.qyliss.net (Postfix, from userid 1000)
        id 6596E8090; Tue,  1 Feb 2022 12:17:45 +0000 (UTC)
Date:   Tue, 1 Feb 2022 12:17:45 +0000
From:   Alyssa Ross <hi@alyssa.is>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Tzung-Bi Shih <tzungbi@google.com>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        chrome-platform@lists.linux.dev
Subject: Re: [PATCH v2] platform/chrome: cros_ec_typec: Check for EC device
Message-ID: <20220201121745.r4dbilp3fpqhjuty@eve>
References: <20220126190219.3095419-1-pmalani@chromium.org>
 <20220126230411.nn2illij4wbpdm4q@eve>
 <YfHUXtJPU77wtCPb@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gounvrkiin7nkkhy"
Content-Disposition: inline
In-Reply-To: <YfHUXtJPU77wtCPb@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gounvrkiin7nkkhy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Prashant,

On Wed, Jan 26, 2022 at 11:08:14PM +0000, Prashant Malani wrote:
> Hi Alyssa,
>
> On Jan 26 23:04, Alyssa Ross wrote:
> > On Wed, Jan 26, 2022 at 07:02:20PM +0000, Prashant Malani wrote:
> > > The Type C ACPI device on older Chromebooks is not generated correctly
> > > (since their EC firmware doesn't support the new commands required). =
In
> > > such cases, the crafted ACPI device doesn't have an EC parent, and it=
 is
> > > therefore not useful (it shouldn't be generated in the first place si=
nce
> > > the EC firmware doesn't support any of the Type C commands).
> > >
> > > To handle devices which use these older firmware revisions, check for
> > > the parent EC device handle, and fail the probe if it's not found.
> > >
> > > Fixes: fdc6b21e2444 ("platform/chrome: Add Type C connector class dri=
ver")
> > > Reported-by: Alyssa Ross <hi@alyssa.is>
> > > Reviewed-by: Tzung-Bi Shih <tzungbi@google.com>
> > > Signed-off-by: Prashant Malani <pmalani@chromium.org>
> > > ---
> > > Hi Alyssa, could you kindly test this with your existing setup? Thank=
s!
> >
> > Hi Prashant, I'm happy to test, but I'm on vacation until the end of the
> > week so probably won't get a chance before Monday.
>
> No worries, whenever you get the chance is fine.
>
> >
> > I'm guessing I should be testing with latest upstream coreboot (now that
> > your fix there has been applied)?
>
> You should use the coreboot with which you discovered the crash, so the
> one which *doesn't* contain the fix.

I applied this patch to Linux 5.17-rc2 and tested with the
coreboot_tiano-eve-mrchromebox-20210806.rom firmware.

The Oops has been replaced with
"cros-ec-typec: GOOG0014:00: couldn't find parent EC device".
My laptop now reboots correctly =E2=80=94 the hang on reboot is gone.

The cros_ec_typec driver ends up being loaded, but no devices are bound
to it.  This differs from the behaviour with upstream coreboot
(cabf9e33a7), where cros_ec_typec does not end up being loaded.

Assuming all that's the intended behaviour:

Reviewed-by: Alyssa Ross <hi@alyssa.is>
Tested-by: Alyssa Ross <hi@alyssa.is>

BTW: if you need anything else tested on an eve running upstream Linux
and Coreboot in future, I'm happy to be CCed. :)

> Thanks again!
>
> -Prashant

--gounvrkiin7nkkhy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEH9wgcxqlHM/ARR3h+dvtSFmyccAFAmH5JOIACgkQ+dvtSFmy
ccBxVw//fEzb3zR8P3ov4Hhq21CxINWY7CYP/+iHTAMNIJaTQrU+1QgTnSXv2Lam
5wGg4OFaqVKOffT738eub9MSxdeTfueAno4gHd3FmhAAAbU2wjj2dPaju+lZdH08
teCmPmnGPyc5pkW+vctvjiafPuvr99sz5mkgZ51jywWGcoYBIjvtkiQVtDisMNoh
aY80WujZRx7UIqw9cMjb3fcSEvLXL9yDQXYNmEULFI72uUiMFqf5DrzYW43hJCF6
pNZwnTE1w8rvs0cGKqp1RsqjCyS4sjcPMbq3JAbQfqwrB040x7SQqB6fMjEonPns
E93ycWrEqWzOPTkM0d9kHtU69OuiX82aY/1LvZsmRmFGx/T3lq9iXswjstodAg9A
eZJCaLauSbUEApyOuJ+VlX+YfYBAtGMrZ7tPOYukMAkR6PSrLfqz2ntrL1K3rtcH
QHcCLd7/LAhGNEzwFBw4Ob85UCD3eti8X3KTCmbrklIZNNTAqTsuDtX4HgEeuuqU
X0AQAvJ13FFQFWflR+yrtl6m1fJk2sjGYflGJkjCT615fW3x3SyTVDdwPX3Nbs5N
VUWDJjbYzjubONyYitSoyrBRzKCihTOaTp06Zu0q/ubb0N5z6d8UZ0gWAu+N6XRE
yBjWy4BObHcioQzipFTAHsA5wVbmUdFLXWF7d32P2lBIgRnNRfg=
=Cjxi
-----END PGP SIGNATURE-----

--gounvrkiin7nkkhy--
