Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8A454A4D0A
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 18:23:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380877AbiAaRXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 12:23:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243562AbiAaRXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 12:23:14 -0500
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B45C7C061714
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 09:23:13 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id k4so13435760qvt.6
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 09:23:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :content-language;
        bh=bPILK0yhACFpprVLxksCilL8cYY3PolxdleU68y4ooA=;
        b=FjFa+zrsc3qD881ulSSHXKU8UPvaUT0pCpq7bRxFVtb8dAVuCfYJDqD54f+ePCE8Me
         fheCqyCUDYfiDFOAkpQkovYZ7tjDE00l8K2iXLVM+WbJx3OFtEJxqF3MXibeN0ZldNHE
         Fhvmm2qfTKTq5QsgoelPS/kd5IoOOL1yBnSpV6jeIhTx9G3TQQqKfJjKUKmwMTOKSHgF
         uCBsi2Vr+rGVxX3oFGPBtxoNDpb16nnHIn3wYfp9YtUyrBrMpYOnPfys0Z0DPid6YuJA
         LmJ4RELwypJTcFFQem4okazyUa6eRpjvZw40N6vAE65vqcXUeIa3HkpuqGaVINH6Q5ZR
         FtlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:content-language;
        bh=bPILK0yhACFpprVLxksCilL8cYY3PolxdleU68y4ooA=;
        b=I3+9XREwAuxaHCqQpBtXXzuc9f7dHrqUN8hBTSIrJ0lKtQw5tHwm2DLpW8KSIdovsV
         lTdSY0Zu2qBA1+MB9YVWYoVbF5w36iH6NuV4wIYlkSyR1bJC/l0ejUtCgtPoUj7kv+uW
         EXAtmUuYa87dmM0EBh+SOU8Y9CUSt2JvStH/AdpcG/x774MDR6b92GWLZSvFeTcmlEtw
         0Gijx/U0oyQl/GzNWsON0G6SjljRlG5VRkJziXaNiIkboTSsOGGL1yxSJDGBcp1lHY01
         R52SFvHzGV3/XIK29dHmOugjiRtOCkh6YaShD4d98gkx1DBbW+CrKDrGp1+QglyhcvB3
         UyEQ==
X-Gm-Message-State: AOAM5309FFJGzEf2X8hRDkp02k0cTUARykE/J7qqBBk0/1BPHSm4ZxIy
        sM1g2nGpGMvnSiYJZ7s5fQc=
X-Google-Smtp-Source: ABdhPJy6vaDmp+y3fJCA7gGV2DLanRMhr8/9jPq+zq2/Xy49pzdQAaX3/i08PEqF7oW7dWBgRCy2Kw==
X-Received: by 2002:a05:6214:dad:: with SMTP id h13mr18954971qvh.74.1643649792751;
        Mon, 31 Jan 2022 09:23:12 -0800 (PST)
Received: from [10.139.255.254] ([89.187.171.240])
        by smtp.gmail.com with ESMTPSA id r3sm8735666qkm.56.2022.01.31.09.23.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jan 2022 09:23:12 -0800 (PST)
Message-ID: <f66c5a4e-2034-00b5-a635-6983bd999c07@gmail.com>
Date:   Mon, 31 Jan 2022 12:23:07 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
From:   Demi Marie Obenour <demiobenour@gmail.com>
Subject: [PATCH v2] Improve docs for IOCTL_GNTDEV_MAP_GRANT_REF
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>
Cc:     Demi Marie Obenour <demiobenour@gmail.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Content-Language: en-US
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------gFL06z6z0ZwGNw3LFs9KmkqE"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------gFL06z6z0ZwGNw3LFs9KmkqE
Content-Type: multipart/mixed; boundary="------------cKY3Ggs6VDUCSn4I6iN78sHA";
 protected-headers="v1"
From: Demi Marie Obenour <demiobenour@gmail.com>
To: Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>
Cc: Demi Marie Obenour <demiobenour@gmail.com>,
 xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Message-ID: <f66c5a4e-2034-00b5-a635-6983bd999c07@gmail.com>
Subject: [PATCH v2] Improve docs for IOCTL_GNTDEV_MAP_GRANT_REF

--------------cKY3Ggs6VDUCSn4I6iN78sHA
Content-Type: multipart/mixed; boundary="------------g0T69ASidFiPhh4eOY4XzIg1"

--------------g0T69ASidFiPhh4eOY4XzIg1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

The current implementation of gntdev guarantees that the first call to
IOCTL_GNTDEV_MAP_GRANT_REF will set @index to 0.  This is required to
use gntdev for Wayland, which is a future desire of Qubes OS.
Additionally, requesting zero grants results in an error, but this was
not documented either.  Document both of these.

Signed-off-by: Demi Marie Obenour <demiobenour@gmail.com>
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

--------------g0T69ASidFiPhh4eOY4XzIg1
Content-Type: application/pgp-keys; name="OpenPGP_0xB288B55FFF9C22C1.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB288B55FFF9C22C1.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
=3Dx+Ro
-----END PGP PUBLIC KEY BLOCK-----

--------------g0T69ASidFiPhh4eOY4XzIg1--

--------------cKY3Ggs6VDUCSn4I6iN78sHA--

--------------gFL06z6z0ZwGNw3LFs9KmkqE
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdodNnxM2uiJZBxxxsoi1X/+cIsEFAmH4Gv8ACgkQsoi1X/+c
IsFo6hAAh2feox5ZjJJXrlOFxBBeidmpzSI1HWJg4liZWRMSl+fdxdfPLJvOKF7u
kEGONFue24jz5IpEnkhHlwFCx+BWXpfXY3kKRZH5xWImphj6STBYIZhPC4+PCVy+
NAok5gBTYvFhpQLI+go7cKdPvZXhZnb9XZJU8cTBvfCH8kA/J2XJdP9DcOXxV35x
9FKp6RzIYBjMWPmf/KsHGrDr99JWogSwHQZNuEsdVitTEZjo0EP8/hYA2E5slmbY
pIGhmsYuzGYY6JUpKGuEn6VLj25M2gRJEYWVU+2lF5cRT6XOv1ZVUfudgfJs4fZj
LNYalHwdwZG2XMctYMK5YwBwECzsqPPsxVFGHXaoxlSCCJw9bta6xS1aWMMRG6o4
FT141XCMINEwjrsDDPGVUNxLhWpeqE+kAMrcILHVkIiAEkckDsQX0YJUVI9c2tvz
FVo2AY965RuEy2olMJjdmervcztWNMj4jIGWzTe2rjk1KAb12yIEMhrRw5HFakfX
X8knx6NtzD1gACXVDp7QUA7zHb3KYOdXsHLvVJBQIHvH115asb7NdLX0SkwyZeqC
kjNNWAOfZBg+f9NhzuP2Xgje3VH/JEUN+agrv4xuq2z9bLefkZ7cIzTQtsw4CAUe
kBNkazG/1oBySW/6okr67f69KIZSJiXm5XEU+sJCF4MvFBsyKcI=
=Di8c
-----END PGP SIGNATURE-----

--------------gFL06z6z0ZwGNw3LFs9KmkqE--
