Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC5825197D8
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 09:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345231AbiEDHJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 03:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345224AbiEDHIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 03:08:47 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAE5924092;
        Wed,  4 May 2022 00:04:43 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id q23so706077wra.1;
        Wed, 04 May 2022 00:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hwnWHQrJtOET5MQj1pPppw1nYJRoSiyVm+kRApnh+UY=;
        b=NvvPxoGth3gCZQ/uVIR4uOd4733Wv2984GTPvpnzXlo2s1UwxlSAIsqrIIdIoeC6C9
         5GkX+f4sVeo844VtSmzDA95PjKK1jd8O6f+lt/d8I7cn0DRq6aUMcCMgvU55FLgnVMxz
         rYzbwI/5o6doxM1fFOvNXeLn5EgwQSY0FMFOnzzf3Z9OcnbIU6TXJOey3obrFnu0kW8k
         +foaHpws42fMArjhdQeBYHsjqJ47woOGdlFfrfVlgf5XmANfbt58psIH8pk5g6LDo7tb
         zjJ5A6p1NZA3/NTPpK36orF8aMOO15UWArInr0ho6O33sdQ9+VbtgD9BQ8GFFJxOAjed
         2pxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hwnWHQrJtOET5MQj1pPppw1nYJRoSiyVm+kRApnh+UY=;
        b=8KvIYRAGODd0sS3UFPcDAcle41lnk+mVAyyDazR2gi6Wm5f2l4/4AacGkQflPBXjsX
         pg3MPVnwZk3lp83XPFEv6Z00zL2KuL89FvgRukxdCrOXb1GKYQFi3fBw5IbUGyi91nxJ
         8t87OedPGKka2EGDoHgANUH8wegccbeT6grBZx0C3/UVJi+lC5nefKw43M+efoOzVVv5
         +//dMR47biX0SorizvG+B5+g3fdAND6dDjySqoyN8qXGdECuLAut8QjiFlHfU3gJIxJk
         H0HQH8By4GE4utnzSAH/++P18BQsJWAWef8DyEm0BdTUD5S9bkG+JZFfGeKKeZJ/CbXh
         0lpQ==
X-Gm-Message-State: AOAM5335jyC6138dkVlYkZ6ihxpf0SgiWPWiQIezC3IpR1DDrab1Pej5
        DHghVJnXMVIN5V5Wy/yi3lg=
X-Google-Smtp-Source: ABdhPJxEgsx5wSC/VpXT7/TrJwylLRNn5oTYH2sIhlsZGzhxr4P0pytGwa0vjfL02rpPGAIJzbVFPw==
X-Received: by 2002:a5d:5012:0:b0:20a:d9a9:44dc with SMTP id e18-20020a5d5012000000b0020ad9a944dcmr15278192wrt.627.1651647882175;
        Wed, 04 May 2022 00:04:42 -0700 (PDT)
Received: from orome ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id j7-20020a05600c190700b003944821105esm3536802wmq.2.2022.05.04.00.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 00:04:41 -0700 (PDT)
Date:   Wed, 4 May 2022 09:04:39 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Dipen Patel <dipenp@nvidia.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the hte tree
Message-ID: <YnIlh++OJDRrK9sz@orome>
References: <20220504165956.531c4b53@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yy3WkBucFs3BdxCk"
Content-Disposition: inline
In-Reply-To: <20220504165956.531c4b53@canb.auug.org.au>
User-Agent: Mutt/2.2.1 (c8109e14) (2022-02-19)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yy3WkBucFs3BdxCk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 04, 2022 at 04:59:56PM +1000, Stephen Rothwell wrote:
> Hi all,
>=20
> After merging the hte tree, today's linux-next build (arm
> multi_v7_defconfig) failed like this:
>=20
> drivers/gpio/gpiolib-cdev.c:572:8: error: unknown type name 'hte_return_t'
>   572 | static hte_return_t process_hw_ts_thread(void *p)
>       |        ^~~~~~~~~~~~
> drivers/gpio/gpiolib-cdev.c:623:8: error: unknown type name 'hte_return_t'
>   623 | static hte_return_t process_hw_ts(struct hte_ts_data *ts, void *p)
>       |        ^~~~~~~~~~~~
> drivers/gpio/gpiolib-cdev.c: In function 'hte_edge_setup':
> drivers/gpio/gpiolib-cdev.c:851:41: error: passing argument 2 of 'hte_req=
uest_ts_ns' from incompatible pointer type [-Werror=3Dincompatible-pointer-=
types]
>   851 |         return hte_request_ts_ns(hdesc, process_hw_ts,
>       |                                         ^~~~~~~~~~~~~
>       |                                         |
>       |                                         int (*)(struct hte_ts_dat=
a *, void *)
> In file included from drivers/gpio/gpiolib-cdev.c:27:
> include/linux/hte.h:234:75: note: expected 'hte_ts_cb_t' {aka 'enum hte_r=
eturn (*)(struct hte_ts_data *, void *)'} but argument is of type 'int (*)(=
struct hte_ts_data *, void *)'
>   234 | static inline int hte_request_ts_ns(struct hte_ts_desc *desc, hte=
_ts_cb_t cb,
>       |                                                               ~~~=
~~~~~~~~~^~
> drivers/gpio/gpiolib-cdev.c:852:34: error: passing argument 3 of 'hte_req=
uest_ts_ns' from incompatible pointer type [-Werror=3Dincompatible-pointer-=
types]
>   852 |                                  process_hw_ts_thread, line);
>       |                                  ^~~~~~~~~~~~~~~~~~~~
>       |                                  |
>       |                                  int (*)(void *)
> In file included from drivers/gpio/gpiolib-cdev.c:27:
> include/linux/hte.h:235:53: note: expected 'hte_ts_sec_cb_t' {aka 'enum h=
te_return (*)(void *)'} but argument is of type 'int (*)(void *)'
>   235 |                                     hte_ts_sec_cb_t tcb, void *da=
ta)
>       |                                     ~~~~~~~~~~~~~~~~^~~
> cc1: some warnings being treated as errors
>=20
> Something has been missed in the contruction of the git tree :-(
>=20
> I have dropped the hte tree for today.

Yeah, oddly I didn't catch that when I was doing the test build. Let me
recheck what went wrong there.

Sorry for the mess,
Thierry

--yy3WkBucFs3BdxCk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmJyJYcACgkQ3SOs138+
s6G8Qw//Rx/sm+z5HOp/4SyYnB2804YIZvXUJ4Z4U+54y7BpUcAaG3Nugezm1mPj
CT1BSAMxxUUCIPRw/evJMYVGbHn4qsick1dT2OluWYTZ/U+Ffjk5y/uNttUtv60/
1NdVEbedTMAsfheU84NTz22lD3TwA13PqE9H5L2qpwdT5sVqKC3Qo26mNDsEPe1U
8DhwPOMhZClfPd1hMFRhBaJl8jUtMu3R9JG67tgnoKSe6a59QujKWA6TBBv3XcGl
5GeE4JIe9AvYY68axDdolpSuRqpOurwTxsojry3gdvvMEoO4490ydY29cJV3Wbwc
4PuyJyYm8JKozwYL8VEwb7y+lXdpl0I799hB0r6f/ukZDu8ERtBj3ZT64odqlbQf
fInFJk59+j8LBIoBl0p1uB28NULZxjHCM6j/mraKcm9wkoUdW2jtzNE0q6yUG1N8
3u3x27YP/s76+bbeAbSjvqhXKMdYPMZiUyS86FgCl7dQlc4X/AZZUANtCKO8B989
916LDrOzj7CUWPm6ypH3mYxA6gT9ihaGxqWsPjB+twUOE1w7H4RZWZMU/5jXFm+c
kokRZNaTEoupyTXdElI7IUyhlVBXNuo1ae9DUUZa62X6PaPptJAf9/EfB0zD9HPO
b/mFD74H34fk9lV9y410dp68Qrzn4HnnFn4N3B4emqTYsjU9yYg=
=fvlN
-----END PGP SIGNATURE-----

--yy3WkBucFs3BdxCk--
