Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E642F4A3811
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 19:37:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354597AbiA3Sfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 13:35:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241414AbiA3Sfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 13:35:37 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 735EAC061714
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jan 2022 10:35:36 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id o12so10159029qke.5
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jan 2022 10:35:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :content-language;
        bh=2QZaKEKOX73FhHQGC0MdXbWrYGotSIe9lUIuwquuvdg=;
        b=VuuicGXcK7e3bhqkWRp1BZXQasNvelaoZavpbmazHxSNEkQnV465APqewQygLvnS5q
         yBfSt3/j7NNQlL/4IB3fK8ZiFtkqeCtF8axY+7uQszt/NGRjOA8Qb7ZjBy2RcfuIenYU
         bGlPA2Uoh/434oyQOHR31He3N+g0LMvtdpWSvjFxRkZeTOJUa6vemNUSehA9abMhW8Hx
         Zf3GY2ZnGacAJGHzqBKIjPgXRj8Sddj7odJV/vCd4cDfbcC7D4KxBnichq1obSiHCZ6D
         fzF4y9j5zRuaSPedvLzL18PTQpxlc9Zz5ZjBt6OWHhpr0YFnFslvppATM9oo+GL9DNHM
         k82A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:content-language;
        bh=2QZaKEKOX73FhHQGC0MdXbWrYGotSIe9lUIuwquuvdg=;
        b=1/xT9ZtM3i0oEBrI0Ve4WqHKnf8thJcekfq3LQxKtyaoDxNl7Tpfnedotyf5Y2su1w
         rObeoO2gNgHD1n3YFPZG/pYv/3DBf7i2VdKNCWX7hVZ5ONaNRnlPcVZKYrnp1QhiPq/V
         VT57FDeYF7GuD9ZHx+I//+q/yk2hEkJaLExPgAHsAqX7QLzXFVEY24eKkZJIedmIirc4
         vM6TOgB2ZzvswVXNcNV5ydyvdj3UnaD9/nRDNdgGXS28Bzz1fbCv/yILmtwASV0O4qjW
         hbtXwAFl5c/qu4kjDqI2zssun3jTxnQaLRenpZppseDXt2iQ/995M4+BQFeXxAJr+FZO
         3UpQ==
X-Gm-Message-State: AOAM531nDbCc5tZO+5AwpHp3ZnX/tcu3k10i0PH2QDWobgpfkQjtne8e
        hmU5ZR/lLOX0l2o3FDk/nfk=
X-Google-Smtp-Source: ABdhPJxCXOvShMpoTA2HOSQ8oL5vrMNvIQ/6Ci43XAxm7+RD+rnjlG+9iAEBypoDIALroEYvpyuiIQ==
X-Received: by 2002:a05:620a:849:: with SMTP id u9mr10850044qku.408.1643567735598;
        Sun, 30 Jan 2022 10:35:35 -0800 (PST)
Received: from [10.139.255.254] ([89.187.171.240])
        by smtp.gmail.com with ESMTPSA id w4sm7649260qko.123.2022.01.30.10.35.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Jan 2022 10:35:34 -0800 (PST)
Message-ID: <68f3303d-f035-ffdf-c786-9c826e66bd0b@gmail.com>
Date:   Sun, 30 Jan 2022 13:35:12 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
From:   Demi Marie Obenour <demiobenour@gmail.com>
Subject: [PATCH] Improve docs for IOCTL_GNTDEV_MAP_GRANT_REF
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>
Cc:     Demi Marie Obenour <demiobenour@gmail.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Content-Language: en-US
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------Bx4Iu0sxzRIO7AumyduLJADG"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------Bx4Iu0sxzRIO7AumyduLJADG
Content-Type: multipart/mixed; boundary="------------Svb035ThpoP0VwkRoIWu0Nkf";
 protected-headers="v1"
From: Demi Marie Obenour <demiobenour@gmail.com>
To: Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>
Cc: Demi Marie Obenour <demiobenour@gmail.com>,
 xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Message-ID: <68f3303d-f035-ffdf-c786-9c826e66bd0b@gmail.com>
Subject: [PATCH] Improve docs for IOCTL_GNTDEV_MAP_GRANT_REF

--------------Svb035ThpoP0VwkRoIWu0Nkf
Content-Type: multipart/mixed; boundary="------------PzX56KGQ0dWoGgjBEpLZHBZR"

--------------PzX56KGQ0dWoGgjBEpLZHBZR
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

The current implementation of gntdev guarantees that the first call to
IOCTL_GNTDEV_MAP_GRANT_REF will set @index to 0.  This is required to
use gntdev for Wayland, which is a future desire of Qubes OS.
Additionally, requesting zero grants results in an error, but this was
not documented either.  Document both of these.
---
 include/uapi/xen/gntdev.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/uapi/xen/gntdev.h b/include/uapi/xen/gntdev.h
index 9ac5515b9bc2..7a7145395c09 100644
--- a/include/uapi/xen/gntdev.h
+++ b/include/uapi/xen/gntdev.h
@@ -47,7 +47,13 @@ struct ioctl_gntdev_grant_ref {
 /*
  * Inserts the grant references into the mapping table of an instance
  * of gntdev. N.B. This does not perform the mapping, which is deferred
- * until mmap() is called with @index as the offset.
+ * until mmap() is called with @index as the offset. @index should be
+ * considered opaque to userspace, with one exception: if no grant
+ * references have ever been inserted into the mapping table of this
+ * instance, @index will be set to 0. This is necessary to use gntdev
+ * with userspace APIs that expect a file descriptor that can be
+ * mmap()'d at offset 0, such as Wayland. If @count is set to 0, this
+ * ioctl will fail.
  */
 #define IOCTL_GNTDEV_MAP_GRANT_REF \
 _IOC(_IOC_NONE, 'G', 0, sizeof(struct ioctl_gntdev_map_grant_ref))
--=20
Sincerely,
Demi Marie Obenour
she/her/hers
--------------PzX56KGQ0dWoGgjBEpLZHBZR
Content-Type: application/pgp-keys; name="OpenPGP_0xB288B55FFF9C22C1.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB288B55FFF9C22C1.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
=3Dx+Ro
-----END PGP PUBLIC KEY BLOCK-----

--------------PzX56KGQ0dWoGgjBEpLZHBZR--

--------------Svb035ThpoP0VwkRoIWu0Nkf--

--------------Bx4Iu0sxzRIO7AumyduLJADG
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdodNnxM2uiJZBxxxsoi1X/+cIsEFAmH22nQACgkQsoi1X/+c
IsGRyw/+IBzFvJPuAMi/kE7b4wFJfC57OlA6Zxg7YXMEY62oe2ONMdXYuE0oGntQ
scsntd7KHD8qt6gopW4I0uPTdSVeVrXPJderP/fyBZ2xT/VBon62vwh3wWuGVlgQ
FCK83b5NRJWu2gPYJbD5a+4qOjlACVjRFHXLYPHEyN5gE6vW5dxyOh2PmlbQZyLa
2+cZwaGDcKOpt3uu0gjjUdmMLqvJZJpwQqKlno9M2ZtvYNb7rFCgp6Phb2hzu39P
wvyyypw18JQI8edTlrmS/8xUaM1czPYC2i2nbCvPryxmO4n1RNJMIkl/uWobMXDS
AMffQKH/NjE+0LEuxoGQFSC4vkW/LTVFypiq2MJElJq/iXfA5StFfkmxvJkS+wpd
NCFPGUZyYNXEx+D6FvG1neMQbcAUDakSnLj5FfW/d1QZAFTZnqo4tvh6tYuOLWJk
m6tB5v8cG+baUzwZCVxkCEC1Mpc8tydbbz5z+suIU4DQeytNY/Eqk6WzfWETMk35
k/VEZgwgO5llAZVor9NdJciTpmQR+/FNyyqcohsH+/wxBzt29EFF6Fx1F/Yj7Mb8
3tucpcTn3vVLLYoYLLobm5vCyY1BeyXDP1C2GHUQGeaX2X1zMqaSyIlVYyS6HyPj
JydLWv4UkeVaVxuXC4LzyVxxQC83Mqq9GmG1f9Zk5a6zRccu7QE=
=JNNI
-----END PGP SIGNATURE-----

--------------Bx4Iu0sxzRIO7AumyduLJADG--
