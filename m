Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77EEE5272C9
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 18:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234099AbiENQGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 12:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbiENQGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 12:06:34 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2825E1EECB
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 09:06:32 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id CF39E5C00E7;
        Sat, 14 May 2022 12:06:29 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Sat, 14 May 2022 12:06:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1652544389; x=1652630789; bh=dl1KQYoQor
        7dFAFhpdtNa+47JnMIBmQHVAoY4PnaKqo=; b=WnlthM3QMFEj+Xq1OpWQEBjXhn
        Zt9iXKJXoLPTs78znRUeUZuvpieT3yiMv+PxzvZm51zjeFyuFH3+ddcMkaRKXttE
        keBOGVqhJDhH/jkpT9dWyOL5/B+PVdXYL065XT/xW/QzXYkPNFceXa6YoBqLn+UU
        /NjBicpatJFwFsd22aozATMNCbRiIdzNXfR2joBb2sz+E8HAMC0AuYaDcKIdws5b
        8m4Xj4cLXwJYEBjQPcr6W2T8eqWeapQx6YK+w1mvcAWLzLdOMgqAC4blFmobjTuo
        HLQsEbfKHObprXjc8XoHqIegtoZt32Tq4gM9svo6Hx3DMqYBlro4I/bYtZZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1652544389; x=1652630789; bh=dl1KQYoQor7dF
        AFhpdtNa+47JnMIBmQHVAoY4PnaKqo=; b=JFVIQTw60eGO61Ai9EOiGrGqPkes0
        WzDU0eDlZK2DRQGqt/UZJg+hHrpIW59ZPU2XqAgKEyK4z3mOxfLTiovRQ5TLmiQW
        1DD4LdLtSA4ki09d2uBqkBJxLhbb+lXrpr7IYdnRxtJcjTM+QNcvJDn2bwT+atkL
        Kb39ege6Ta0USh0tZkSqPaB1YHIpG7QAWxrlirYrp0OJ/Z6iTgvhMLF22Djc1OrH
        PO3pa67ygpqtdBzzE9blGGJ19ajMUfYOS161NGrxUEiJFuMdtink6SVUIc+1+zbb
        /XBH5EnQF1pMigQnDb5CSC5GCBTWj98raQeSgqDiHItYoc1xpr/ZIxeUA==
X-ME-Sender: <xms:hdN_Yg_jOMJvpHjDH4XrahOAe4g-5Tv-xUzVOBhdyxKyudaHxq4wAg>
    <xme:hdN_YotDAmov4IBUnTsYLdzweccadZlwmCpCcMEoeDhFpDC4nn-usHF-xwRlrmPTi
    gmTmimUeBrtiOg>
X-ME-Received: <xmr:hdN_YmD8KfF0XYpRXnKAqBcNioNbR5ppKwgpJ9QoMLSxVAaBtunsuK83klSP>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrhedugdelhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfggtggusehgtderredttdejnecuhfhrohhmpeffvghmihcuofgr
    rhhivgcuqfgsvghnohhurhcuoeguvghmihesihhnvhhishhisghlvghthhhinhhgshhlrg
    gsrdgtohhmqeenucggtffrrghtthgvrhhnpeevieefgeeuhefhjedutdejuefhudetveeg
    geeitddujeelteekgeeigedtteekgeenucffohhmrghinhepghhithhhuhgsrdgtohhmne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepuggvmhhi
    sehinhhvihhsihgslhgvthhhihhnghhslhgrsgdrtghomh
X-ME-Proxy: <xmx:hdN_YgchApXzjgp4u1QsrCKUld8MY_ZwwfCkJrfInHQDBXXYamDn_A>
    <xmx:hdN_YlMeTBzqXb54izPnzT8QH7o50dmBbgKmh09u0DxqiYlhxR_lPg>
    <xmx:hdN_YqkXEt8EOyXWVRbzu1wvxogLY1pwP9kWbUhc_4sFzASS523e7g>
    <xmx:hdN_YuaCb5j33xfz42cxAu5H1w4B-7JOB6c7hmO_kOJkgKw9BtVaQA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 14 May 2022 12:06:29 -0400 (EDT)
Date:   Sat, 14 May 2022 11:55:39 -0400
From:   Demi Marie Obenour <demi@invisiblethingslab.com>
To:     Xen developer discussion <xen-devel@lists.xenproject.org>
Cc:     Juergen Gross <jgross@suse.com>,
        Boris Ostrovski <boris.ostrovsky@oracle.com>,
        Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>, linux-kernel@vger.kernel.org
Subject: Hang in 5.17.4+ that appears to be due to Xen
Message-ID: <Yn/Tgj1Ehs/BdpHp@itl-email>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="TNAwTdkDEjbbq6M1"
Content-Disposition: inline
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--TNAwTdkDEjbbq6M1
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 May 2022 11:55:39 -0400
From: Demi Marie Obenour <demi@invisiblethingslab.com>
To: Xen developer discussion <xen-devel@lists.xenproject.org>
Cc: Juergen Gross <jgross@suse.com>,
	Boris Ostrovski <boris.ostrovsky@oracle.com>,
	Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>,
	linux-kernel@vger.kernel.org
Subject: Hang in 5.17.4+ that appears to be due to Xen

In https://github.com/QubesOS/qubes-issues/issues/7481, a user reported
that Xorg locked up when resizing a VM window.  While I do not have the
same hardware the user does and thus cannot reproduce the bug, the stack
trace seems to indicate a deadlock between xen_gntdev and i915.  It
appears that gnttab_unmap_refs_sync() is waiting for i915 to free the
pages, while i915 is waiting for the MMU notifier that called
gnttab_unmap_refs_sync() to return.  Result: deadlock.

The problem appears to be that a mapped grant in PV mode will stay in
the =E2=80=9Cinvalidating=E2=80=9D state until it is freed.  While MMU noti=
fiers are
allowed to sleep, it appears that they cannot wait for the page to be
freed, as is happening here.  That said, I am not very familiar with
this code, so my diagnosis might be incorrect.
--=20
Sincerely,
Demi Marie Obenour (she/her/hers)
Invisible Things Lab

--TNAwTdkDEjbbq6M1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdodNnxM2uiJZBxxxsoi1X/+cIsEFAmJ/04MACgkQsoi1X/+c
IsGi2hAArO7G1fAnno/7xTzDfqxcNnOEuHFwZcn55O1E0JJ6qjGj9Uc98Td3TAcw
M2i9U0fDpAB3L9naiD86fZHTgbKhEHAJ3d8D7RzA8wLOCdYD5Swh2rib2smYgZHP
7Lsl9IhcMhc0JkgwJ0Acr7qnA/2bar8uz3q4hX/aEiHJo+nD/PvrLnhXYNrfSUHK
zP4ceuHJ2DYMBMEE66kdcolWYB2md5oOJXf1ff8MIiGAfxlaAqfBpCTInD6Fx060
SM8JBnDkoDkp8lyMpoklyN0wwtParAdYpQ4au70NctQ0ImQtcEtx8YKQI1qkyCUy
oXDX8LwVb4YNpu1/wtfKwM4M2q4zKqvPLRjGA2TVKPOv4fPBw2+3GyhmOPwQDn19
LSbwnBo0mFb05bjQFKHf7sEhFmKZ63Gr2RlU+91tjVaquRQILd5CFW/0wCaNvDhq
6+t28vOl/loFBoQo0OCXL1KMgKQjtPcj+Kd8OflFuOceuD+4L7KzZ2EpUHOTD+V5
q+qchLFuJ9ic0Ohy+m4J1aU0t2Hjk5iyD//lrlA1iWhSM15F0PEPzRbeO02DT0Js
bTKbIx62lTo5NHrB6AcHWYUsX9wN51+Kb7/ca/vNVD1gQJPgFaooNnNv2fK0z0ND
jGcmREAkW9MAGOovIwBHEU68Ibr0bvwgf5jrcJWERKtOPQXVHs4=
=i937
-----END PGP SIGNATURE-----

--TNAwTdkDEjbbq6M1--
