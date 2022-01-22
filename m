Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04F65496A55
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 06:34:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233057AbiAVFeb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 00:34:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiAVFeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 00:34:31 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB8C4C06173B
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 21:34:30 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id s6so5918280qvv.11
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 21:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mail-followup-to:mime-version
         :content-disposition;
        bh=t1waumud45JHU9T1eQXEfohgllNa0U2gK96zGS4HhMY=;
        b=gog+qI5ALhtnagrux2TFFyR3NElPzn+glSY7RlS1tyh0zeYQDvaGchixkMDWEpsdRp
         VgqZOh7EAned/hyraOOpjyvEj0sIvr8VjI0uJD4kTzKpUbKktIw2U8imujJ7ndRJ7lu7
         5H5+VddArcKgonAl0efQwqr5o0zahqnaHGy4sI6b/akYcrn+RASFpTdl6hctBTFHbIvk
         Bo1Q2cnus4HNs95Cnetu8XPO+vZ3QpwV0UV5aRAF9SYmivF2woVqq5zWUlU++D+5GZyu
         NxPsJkotjjgt1sdrU5rh/TU/71G5mMkPWdFgGozAA0ownsG7nNmtleKf9V+QTeLR3oy1
         +AYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:mime-version:content-disposition;
        bh=t1waumud45JHU9T1eQXEfohgllNa0U2gK96zGS4HhMY=;
        b=byl1SmUiSM2NwQoAgZugOh2qV9od6vb3Wqbd3gnuB2K/iWdzYSxmwVNcc5boet9TNU
         wx5WZ59vs/aqSBHgbfn0uW5x52ktFr006Q8/SAM462TVxgDuepk6I4fvUrgFVgoCVhTq
         Nw26BmZiXt6bRc3K3Ujob8CBXwn3uwLqwU5wCUPrA5qk47YsCULhvg+Asj3uhe3N1QuD
         LvUW0ZihWsjz1i66TeL3268HYLG2DlAaD2ZGtwHINZOI0t5xD4A+9chgIDjHko1wnNwi
         8IZuFf57iBKcC9zMQtg9Z37nAW+Tod0Mtj8ko0KCDTxkQcYfybo+kM+aFPIDs9CjbWxl
         UGeg==
X-Gm-Message-State: AOAM532/kitfv6HHxI93Pybbvj4Wsqy8b67ux64KTfmuD+Eq3TDmM2mF
        1HiKIV/ff2xqNm3M/Mu5YyMkdVx7btkpJg==
X-Google-Smtp-Source: ABdhPJz8UlGedzRgHq16Gdu5R/4kysU7JOp27TXW/79XPtksk1GG2M1xh5hiDfZLDZ11a+uK8CZ4nw==
X-Received: by 2002:a05:6214:29c9:: with SMTP id gh9mr395873qvb.75.1642829669923;
        Fri, 21 Jan 2022 21:34:29 -0800 (PST)
Received: from Gentoo ([37.19.198.230])
        by smtp.gmail.com with ESMTPSA id v18sm4304955qtw.14.2022.01.21.21.34.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 21:34:29 -0800 (PST)
Date:   Sat, 22 Jan 2022 11:04:15 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     LinuxKernel <linux-kernel@vger.kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>
Subject: lore certificate error in browsers for past 2 days
Message-ID: <YeuXV0Qv0NUZ0l84@Gentoo>
Mail-Followup-To: Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        LinuxKernel <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="JJCndYZQbEtEaxJZ"
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--JJCndYZQbEtEaxJZ
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

  Hey,

  Not sure who needs to fix the damn thing ...but I am seeing the certificate
  expiration on various browsers ....namely, Firefox, Vimb, Nyxt


  Can someone kindly look in?

  ~Bhaskar


--JJCndYZQbEtEaxJZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAmHrl1YACgkQsjqdtxFL
KRVG+Qf/f4FoaQCbu9N1+H/uXc96ECudVvXzXbEJU6Gc8MN6oiFzUjj/7wY1jglS
tpI0q2Ms5jfkJRz0sweuFpoYSnPpcgM0RjNHm2ucqBVEc1APjnfHDFoFmSlRqK4D
YUeRBdyReIzdhb5oO6VsMG0RabwRPZMbDPn62aQV4tDi/tcP/ku5wrrpxQTuKTAB
VWJkK7/iarJo+/gdUDTzNvOT5ENPDbv9bDAF8aANysFTKa6zmhBzXnYBjfIw58l8
fO3HOw4gvvh0L93N2bSeC0y8zaMGly0ddm5yB1/oUyHpQyS3pT5REnZhnEoPYRvB
7+8O2CcrYo1lWSqhgOvl2v8bCk2z5A==
=BDhD
-----END PGP SIGNATURE-----

--JJCndYZQbEtEaxJZ--
