Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0332949E7E8
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 17:45:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234585AbiA0QpH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 11:45:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234423AbiA0QpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 11:45:05 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81612C061714
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 08:45:05 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id s2-20020a17090ad48200b001b501977b23so8070198pju.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 08:45:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :in-reply-to;
        bh=WiG8e4rFhf3TAlPr7MXRtjgD0oBCA9X+CmBmQI1Z8BM=;
        b=tcEHUtmXrDWlHm/yOPUWB6afp5YSifkZAJgM5UKd5Rdb7+ZSPfQjkD1UjsQAYkmnIE
         R98PAnasU0HP7DZkcc7LcoNOyAYVrHdARTqqMvy9zdnYnId42F1NgZCWdPCJJaZhpy4V
         Zp+TcIsKQVgT6qH4C0Ki8VfXgkx8+rUbfbqJG7VflEIRZ0svGs1lAnYDUlh6Xnipbmwm
         /0OMmUVlXnZksA0KRtPIMgSLu/A/1QHWGzXxc7Krk4aIxQrfkx/5WjP9DlWuo6swJbId
         PuJ0Pm4whgoT4LNR9DqZqzvD0DHmPIoEOJ4fSPx78kXhgIqMia3yLR/xtjRBhAXrowIE
         xmfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:in-reply-to;
        bh=WiG8e4rFhf3TAlPr7MXRtjgD0oBCA9X+CmBmQI1Z8BM=;
        b=nF1Bj39ptyRWKECPn5OoU8lLfodTmYOPTctLTagWObDscKg7BidfBXtHZbO9GkNJAk
         h8/v/+6EZyWhk+eSSAe6DvTdlhtVxONLLQnAwxcUiBZ6NUrBu2HvLak/NtyWSJL0zKLv
         YTRtnZLbWpgqvUvD4wV9JT1uYtl70Kcsu21QpTrmYtEB4WVJTnt9ZiiELN21JGIHcTNg
         Y9ql7KWFhIGTzAcTwPBERvcp7SG6hpD//TC5wr990mico3+Xg9Mazg6UYIorwAguYbBs
         7COZwzskyILOs81IQOtOcq5kz5XBhp1S7UZ9tp6N0NyI+6trs61rxScWXGI6yLFrmn4A
         ywtQ==
X-Gm-Message-State: AOAM532IzdacJa8qimceNFMPKY5ekWCJ0gXN62ka2Uku0V3jy3B21ENm
        SBekrNGjDsHAyPQ+WbPqq471Hw==
X-Google-Smtp-Source: ABdhPJwnt99Hy7hFh3oGiEC1FitCeWH1wk49aL6d8IF8AcSgbFZnUmnNqnIhVhbrTa/m8kAPTHcT7A==
X-Received: by 2002:a17:90a:9908:: with SMTP id b8mr14638416pjp.125.1643301904503;
        Thu, 27 Jan 2022 08:45:04 -0800 (PST)
Received: from google.com ([2620:15c:202:201:7713:237d:48f3:f690])
        by smtp.gmail.com with ESMTPSA id mn2sm3178870pjb.38.2022.01.27.08.45.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 08:45:03 -0800 (PST)
Date:   Thu, 27 Jan 2022 08:44:57 -0800
From:   Benson Leung <bleung@google.com>
To:     Benson Leung <bleung@chromium.org>, chrome-platform@lists.linux.dev
Cc:     bleung@google.com, pmalani@chromium.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: platform-chrome: Add new
 chrome-platform@lists.linux.dev list
Message-ID: <164330181439.2996990.7235316022532021501.b4-ty@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="E1Fh8DIqhPrTlsFd"
Content-Disposition: inline
In-Reply-To: <20220126222233.2852280-1-bleung@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--E1Fh8DIqhPrTlsFd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 26 Jan 2022 14:22:33 -0800, Benson Leung wrote:
>=20


Applied to for-next.

[1/1] MAINTAINERS: platform-chrome: Add new chrome-platform@lists.linux.dev=
 list
      commit: 664de6a26b7f17eebca896c3e18201b15d5c7b19


--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--E1Fh8DIqhPrTlsFd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCYfLMCQAKCRBzbaomhzOw
wmhTAQCIRyO9gXLKbcChHnl054jF5HaMDq61VMVJilowCGIEPAEA6HbrVq6aKYel
2kCSQn/+iWgT5f2Gy1ZjYlNE2xk1DwU=
=pIDh
-----END PGP SIGNATURE-----

--E1Fh8DIqhPrTlsFd--
