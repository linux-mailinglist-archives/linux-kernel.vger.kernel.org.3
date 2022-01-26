Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3453349D5E2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 00:04:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231251AbiAZXEQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 18:04:16 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:36831 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230323AbiAZXEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 18:04:14 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id C823A5C019A;
        Wed, 26 Jan 2022 18:04:13 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 26 Jan 2022 18:04:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alyssa.is; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; bh=Dq0lGCTgUY2foRXLONiN7fj2MSnnKOwhTtj7tX
        YQbuY=; b=sPJwG+/l4BN6FTBVtxVfYxsPju2Ns/HwtT0yiiSHvlFUm06XlY6q9k
        sxXL2Pz/engdK/L2+l+7qluMsH7nuaVE8+g3PoEym3kDYYpULYMMn/TZTtNpxXOB
        ce62W5g03F2WsQ/Cu38BkEVeCm0+8T3jk194ZEenSOPnBdsfSzz37BDuywk6RrAh
        BeFD3syR4Nl7sQ+aVMMPiI/+MrKbWfP2unGleh9MNHzhY0z8AivQQFQBUwtrKt7u
        71KCPOiJ0NKDvkP9Wjwc45/ZixlflosxDGIulikRYer14cPHZDFXw0n38ugRjISK
        b5vaDxwj4OLQZBYPgpWpHFzUbMetDSEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=Dq0lGCTgUY2foRXLO
        NiN7fj2MSnnKOwhTtj7tXYQbuY=; b=HdaQuQLkKRApqU/ZV/XVdOEqLFPXzcsyg
        1g7xuP9KdOFjv1+msp+1Dblf5zQSpeySU7HOp/S+DXp0GvmtIt7ctU9wh/t5IkS0
        6Is5WOJ7QI8XA4lEJre5nmYCr3cxhTQze/uV8ann/G+VFuPvk21U9BPeDmxcpRIy
        9ZMGcEqYrXD8K5Y/cmzqSR1hm7fqyFOXMtn93wpDtgoR6KfiLzPEUSGM0hRyB/rN
        FDKG6S50Hbb2vMRMquJdA7vzsq8ju3f4cg1oTpn4n7Tl1Rxdf/C+9LK+Q5Bvibw4
        p9hJsiVrEyTJC8diEyhVy6Rngwte+eMMEp2z2xSk/ZfGpQ9XfSYkQ==
X-ME-Sender: <xms:bdPxYTJYaF9xK2W2Jcd8hx2t7b9Wq3hdlYMTS2p0Q1MGPXNukN1hDw>
    <xme:bdPxYXKVuFB1J4wJaGmqKmoU3lT9eqybs9QPlk1JNH6Ja458Bze3l4pKb3t6IwMD8
    OmdZHvQpEVc2SJd-A>
X-ME-Received: <xmr:bdPxYbtlVM17QtyQMbhST9DdQcWgc-B4BQN9Er3-ViKReib2-EBCwhEKhew3Anh0qIK4a6829xpiU7760gI06LX7Pb9V02iT>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrfedvgddthecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomheptehlhihsshgr
    ucftohhsshcuoehhihesrghlhihsshgrrdhisheqnecuggftrfgrthhtvghrnhepteejhe
    ekjeevhfehveeuieejfeejtefgvefhudetudeludevjeejgeefieekhfehnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepqhihlhhishhssegvvh
    gvrdhqhihlihhsshdrnhgvth
X-ME-Proxy: <xmx:bdPxYca-nHcBzy95EmOvV5MgxYi1_hlsOxDNoIlXBKEaKHA_8AG_Kw>
    <xmx:bdPxYabi7o8mxT_W5J02IfAItPGwJ5V4VKbaFiw2VoNBfpcrQYVjcg>
    <xmx:bdPxYQBBRk6AhfKa8SBgJFEh8IziHeAoLZmVBzwpjkNzD9wx5GBY5w>
    <xmx:bdPxYRzV6EQ4_KCwNZrIjpLkQWScoh7x95FlFJw2e89ebSihuxnFRw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Jan 2022 18:04:12 -0500 (EST)
Received: by eve.qyliss.net (Postfix, from userid 1000)
        id 359808116; Wed, 26 Jan 2022 23:04:11 +0000 (UTC)
Date:   Wed, 26 Jan 2022 23:04:11 +0000
From:   Alyssa Ross <hi@alyssa.is>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Tzung-Bi Shih <tzungbi@google.com>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH v2] platform/chrome: cros_ec_typec: Check for EC device
Message-ID: <20220126230411.nn2illij4wbpdm4q@eve>
References: <20220126190219.3095419-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ydvev7hvnx7cp4p2"
Content-Disposition: inline
In-Reply-To: <20220126190219.3095419-1-pmalani@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ydvev7hvnx7cp4p2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 26, 2022 at 07:02:20PM +0000, Prashant Malani wrote:
> The Type C ACPI device on older Chromebooks is not generated correctly
> (since their EC firmware doesn't support the new commands required). In
> such cases, the crafted ACPI device doesn't have an EC parent, and it is
> therefore not useful (it shouldn't be generated in the first place since
> the EC firmware doesn't support any of the Type C commands).
>
> To handle devices which use these older firmware revisions, check for
> the parent EC device handle, and fail the probe if it's not found.
>
> Fixes: fdc6b21e2444 ("platform/chrome: Add Type C connector class driver")
> Reported-by: Alyssa Ross <hi@alyssa.is>
> Reviewed-by: Tzung-Bi Shih <tzungbi@google.com>
> Signed-off-by: Prashant Malani <pmalani@chromium.org>
> ---
> Hi Alyssa, could you kindly test this with your existing setup? Thanks!

Hi Prashant, I'm happy to test, but I'm on vacation until the end of the
week so probably won't get a chance before Monday.

I'm guessing I should be testing with latest upstream coreboot (now that
your fix there has been applied)?

> Changes in v2:
> - Added newlines as suggested by reviewers.
> - Added Reviewed-by tag from Tzung-Bi.
>
>  drivers/platform/chrome/cros_ec_typec.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
> index 5de0bfb0bc4d..952c1756f59e 100644
> --- a/drivers/platform/chrome/cros_ec_typec.c
> +++ b/drivers/platform/chrome/cros_ec_typec.c
> @@ -1075,7 +1075,13 @@ static int cros_typec_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>
>  	typec->dev = dev;
> +
>  	typec->ec = dev_get_drvdata(pdev->dev.parent);
> +	if (!typec->ec) {
> +		dev_err(dev, "couldn't find parent EC device\n");
> +		return -ENODEV;
> +	}
> +
>  	platform_set_drvdata(pdev, typec);
>
>  	ret = cros_typec_get_cmd_version(typec);
> --
> 2.35.0.rc0.227.g00780c9af4-goog
>

--ydvev7hvnx7cp4p2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEH9wgcxqlHM/ARR3h+dvtSFmyccAFAmHx02kACgkQ+dvtSFmy
ccDSeA//dgOrQ7iuPijev7cFEVYZlPvXEcMtI1kWwZzcx1zCsGi6FS63Gqg9uJVR
Q9zet2csAlgeXmgUA0NTY2WwjhRiXYraRil5TXiV0hop1lvRifGsJjISBanIPIO2
XTibAtqKniaB9Bgar0n/D4r9Bn7yHEQTIIwpuYnwr5MgYzX7DrZDi3zkTj5fGj/6
cqEoeKBhc0/StN/bskEQhmHFBgK0IL/RY6STrvlM6hdyu3rVXYwhy63bHARLj/EH
NGUXPiWH/YFj9U73PuS6XLu2rrr+rRBLuV2XWowWzP/Wpso2Ch1bBv7TMbvVbGVD
6kBalhbfmGryHUbNTrJEUe7gn7t4ZkF3Ni/+69JaLndjx8yhfJNKWihqET99CuJG
17tyRQ0bE4Rw7fGDTkRJMB19skZsDnpt2BVrrQ0mvSsGsyLcBlUMy2X7xt2Ewef/
hcV3CuCqcqFShfW4gnQpNtnqFzZ8S/IbSXjXMtXpCBB3o2HjBAIPAuruwUKJnvgk
ijv1OX0CBex6g1MkyQKKAvFSLD1QcBVzqSPw/WapqtzLog58ZmDbGNbQIlU6ydmu
g+3o+KQlYvRSHh0Ivbx/ARSUfw7W2Z7QOkT1gD9y9zVXWWzxy37jnUG9bHjZyNvg
HQ2cCj4/G1wRaPIwyi4fgNsWsVneS3j9yNmUqmtG68I56JOFm2c=
=cqF1
-----END PGP SIGNATURE-----

--ydvev7hvnx7cp4p2--
