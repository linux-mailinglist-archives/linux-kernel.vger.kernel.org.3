Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABC2A4A6324
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 19:04:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241758AbiBASEr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 13:04:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233813AbiBASEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 13:04:44 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21671C061714
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 10:04:44 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id z131so15989485pgz.12
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 10:04:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :in-reply-to;
        bh=PA0fRujC3w3wngjo09wHj38K9eI3YOrwyDmfNHXPKOQ=;
        b=nKB/AG5qcMntUPf1Mn9uYxFmMwQX6d57f2HvaAn0gZlmYpvqiAnazvzQiMYytrUBfl
         s9Sf2kefF7ATZVi8d0eqm7Ut8KT+ugjXNMjef6HJhMUbMzdT2woUMlVIf6fHgSlwqQuT
         aSmDPfSzTkYLiFDkTDtpjjYnlvjwjHhcbbG8p+jg9OHacAAbeVkCHiJzyFKPsqGKFxtW
         V4XcDt2WjHsJhIMx+VqtTj9MmP7Ln9ZNONp7+2F/Jdb+JlcXT6RlOkNw3Mv8TaizhKRy
         3XZovhHOsKBdhpDW5jQ/E4elnG3dk9M/fj8amBMq6W5oaZ229+HbHE7UnNFeZxYRwvTA
         UrVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:in-reply-to;
        bh=PA0fRujC3w3wngjo09wHj38K9eI3YOrwyDmfNHXPKOQ=;
        b=Q+Vi983DjItJvQGbpcarcO3xCZ9aqDjP9eMikHZz4jBaYtnjYX7PRKAL8e8a0TGCZE
         kX94JLr0DCy+z9VGoZqwHLo9fscxcEzMUWAk9iVDzsQmEtm9gkK0lkpQDTRJm7lMhSLy
         uVRiP3p/L7PbAURuXW7NbD9r2L2V9m/aa5nmCJ/p3ECx3idl7WCxdFM3Oz51OLQghYo8
         IIllp7dCDrfg7lEjx2Zo+/p8n2uNPKwgAwE67xOh+SUtKtpb4KG15CscE5ooIVdUtzHI
         04AWk+KekS9TLjfFBotXrHHVmFD5F1rZzs3f7C7jFjv6popwws/jl5e+rjdnjDQvUorp
         U4TQ==
X-Gm-Message-State: AOAM532f6GmcFYuKrz0OqctDEDJRBxFXi+BdxIrrZK9LiK/APxeCU9nt
        hv4BZHI4Fii2tG8gbfwTWMqL6j7XGOLfzQ==
X-Google-Smtp-Source: ABdhPJzOdP7aj6KeGNtqEk4gsmUeRNia4ntW1vOKb7tjOfisVZZ+cio4a1eVaqD84m56qdPcJDGHuQ==
X-Received: by 2002:a63:3285:: with SMTP id y127mr21758025pgy.32.1643738682861;
        Tue, 01 Feb 2022 10:04:42 -0800 (PST)
Received: from google.com ([2620:15c:202:201:ca6:9749:7316:531a])
        by smtp.gmail.com with ESMTPSA id l26sm31878255pgm.73.2022.02.01.10.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 10:04:41 -0800 (PST)
Date:   Tue, 1 Feb 2022 10:04:35 -0800
From:   Benson Leung <bleung@google.com>
To:     linux-kernel@vger.kernel.org,
        Prashant Malani <pmalani@chromium.org>,
        chrome-platform@lists.linux.dev
Cc:     Guenter Roeck <groeck@chromium.org>, Alyssa Ross <hi@alyssa.is>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Tzung-Bi Shih <tzungbi@google.com>, bleung@chromium.org
Subject: Re: [PATCH v2] platform/chrome: cros_ec_typec: Check for EC device
Message-ID: <164373850836.3544522.16027166265181689567.b4-ty@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oODRVVzWBO06e+4n"
Content-Disposition: inline
In-Reply-To: <20220126190219.3095419-1-pmalani@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oODRVVzWBO06e+4n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 26 Jan 2022 19:02:20 +0000, Prashant Malani wrote:
> The Type C ACPI device on older Chromebooks is not generated correctly
> (since their EC firmware doesn't support the new commands required). In
> such cases, the crafted ACPI device doesn't have an EC parent, and it is
> therefore not useful (it shouldn't be generated in the first place since
> the EC firmware doesn't support any of the Type C commands).
>=20
> To handle devices which use these older firmware revisions, check for
> the parent EC device handle, and fail the probe if it's not found.

Applied, thanks!

[1/1] platform/chrome: cros_ec_typec: Check for EC device
      commit: ffebd90532728086007038986900426544e3df4e

Best regards,
--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--oODRVVzWBO06e+4n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCYfl2MwAKCRBzbaomhzOw
wrOZAP4gPkKd5dYI30xkDbEsgdlYovSEQfOhfSdEitv1g6mM1wD+LH5SF6np/5n3
LjSaW7b5/D+95IWhz557i94GvzlycAI=
=J6JR
-----END PGP SIGNATURE-----

--oODRVVzWBO06e+4n--
