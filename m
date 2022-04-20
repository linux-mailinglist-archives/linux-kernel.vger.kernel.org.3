Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71B0C508A64
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 16:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379428AbiDTONr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 10:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379523AbiDTOLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 10:11:41 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F31F4477D
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 07:07:40 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id k23so3824601ejd.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 07:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=axtU0b8TtpVbp0s/mbZjWqvA94Dr9I508ZNrAg+bBn0=;
        b=h3ip9pqn1Te/4FB3H+4SHiAbA6baF/wjith2bzY2njubpPrbXH4SFJAnu8cJNj6/UK
         9HFHH3DpzxOPKbG+JhKptMmqnimupMF5acHMST/auHETQ7IXtI8oLiXzopiADk6Xvj+G
         C+uMkITomXf82mlJjY28A1Qwx4BudvCvgJ1RrHhCiHyBwvdNwBsktj2N82QxuHlJ2qY6
         A5ppVf0HcXwng/AJ50Z3JkMX+BIyeJSclRVNNIxSeuhV0kmicV+m33kBimktN/XAZHu0
         lnksAl27sz/nFPLLWRtLinxEZQwto3wwwhH8Z8jHyQEWM7nZtP1hdljsDO9Keod1r5az
         5AEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=axtU0b8TtpVbp0s/mbZjWqvA94Dr9I508ZNrAg+bBn0=;
        b=1m7myiO/meB/kbuAdCXPmQ0YlxyUg5NWGw9PdeLcldnlN55V6HSsIkDt3W4RNW/PpC
         nUn1l1J17R/U9tGBSnRA6A4ttKc6JQT+5C4kxeTsXDyzSOqV/h/eeHvUcCJz+53oRYpy
         70KSvmTY8VSxpg6/h1idFTk5NNS2uVgsbywj1yEIpA80XG/re6VBP/Jkr3l8n7roN2Lc
         kWfSlC0XVUYr3gxAX/UN27SnZy3f6clydtQbDHzQHGb8H3/OJSENCgmwzHiEHdXVlXV3
         4wgZrwjwbaiHSo4I8OBe+csFZ2s4IB/IAhm/qIAhZYl0g3r4czVlqHFLNs4zbhWIntBZ
         Ec5Q==
X-Gm-Message-State: AOAM53102UCYBdJ9uD0pRRSLHvCLPlslF+JwN86F1fTVNmSMt+CZY+YU
        U0XPW3ZIE/U3qjeDWgLSM8Q=
X-Google-Smtp-Source: ABdhPJzx++INwh/binOtJF6UHoLInnaW20QfquRf+Me/PgiY/eme4g+R8VUQweTxq86X6SxppLyFcQ==
X-Received: by 2002:a17:906:2e8d:b0:6e4:b5fc:e8e6 with SMTP id o13-20020a1709062e8d00b006e4b5fce8e6mr6678249eji.215.1650463658445;
        Wed, 20 Apr 2022 07:07:38 -0700 (PDT)
Received: from leap.localnet (host-79-50-86-254.retail.telecomitalia.it. [79.50.86.254])
        by smtp.gmail.com with ESMTPSA id au9-20020a170907092900b006e8985cc68asm6703151ejc.1.2022.04.20.07.07.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 07:07:37 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Julia Lawall <julia.lawall@inria.fr>, ira.weiny@intel.com,
        Alaa Mohamed <eng.alaamohamedsoliman.am@gmail.com>,
        outreachy@lists.linux.dev, boris.ostrovsky@oracle.com,
        jgross@suse.com, sstabellini@kernel.org,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] xen:  Convert kmap() to kmap_local_page()
Date:   Wed, 20 Apr 2022 16:07:36 +0200
Message-ID: <2538961.9Mp67QZiUf@leap>
In-Reply-To: <alpine.DEB.2.22.394.2204201556330.2937@hadrien>
References: <20220419234328.10346-1-eng.alaamohamedsoliman.am@gmail.com> <3990312.6PsWsQAL7t@leap> <alpine.DEB.2.22.394.2204201556330.2937@hadrien>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On mercoled=C3=AC 20 aprile 2022 15:57:14 CEST Julia Lawall wrote:
>=20
> On Wed, 20 Apr 2022, Fabio M. De Francesco wrote:
>=20
> > On mercoled=C3=AC 20 aprile 2022 15:40:10 CEST Julia Lawall wrote:
> > >
> > > On Wed, 20 Apr 2022, Fabio M. De Francesco wrote:
> > >
> > > > On mercoled=C3=AC 20 aprile 2022 08:03:05 CEST Julia Lawall wrote:
> > > > >
> > > > > On Wed, 20 Apr 2022, Alaa Mohamed wrote:
> > > > >
> > > > > > kmap() is being deprecated and these usages are all local to=20
the
> > thread
> > > > > > so there is no reason kmap_local_page() can't be used.
> > > > > >
> > > > > > Replace kmap() calls with kmap_local_page().
> > > > >
> > > > > OK, so from a Coccinelle point of view, could we do
> > > > >
> > > > > @@
> > > > > expression e1,e2,x,f;
> > > > > @@
> > > > >
> > > > > e1 =3D
> > > > > - kmap
> > > > > + kmap_local_page
> > > > >     (e2)
> > > > > ... when !=3D x =3D e1 // not stored in any location and not pass=
ed=20
to
> > > > another function
> > > > >     when !=3D f(...,e1,...)
> > > > >     when !=3D x =3D e2
> > > > >     when !=3D f(...,e2,...)
> > > > > -kunmap(e2)
> > > > > +kunmap_local(e1)
> > > > >
> > > > > julia
> > > > >
> > > >
> > > > I've never spent sufficient time to understand properly the syntax=
=20
and
> > > > semantics of expressions of Coccinelle. However, thanks Julia, this
> > code
> > > > looks good and can be very helpful.
> > > >
> > > > Only a minor objection... it doesn't tell when 'e2' has been=20
allocated
> > > > within the same function where the kmap() call is.
> > > >
> > > > In the particular case that I cite above, I'd prefer to remove the
> > > > allocation of the page (say with alloc_page()) and convert kmap() /
> > kunmap()
> > > > to use kmalloc() / kfree().
> > > >
> > > > Fox example, this is done in the following patch:
> > > >
> > > > commit 633b0616cfe0 ("x86/sgx: Remove unnecessary kmap() from
> > > > sgx_ioc_enclave_init()") from Ira Weiny.
> > > >
> > > > Can Coccinelle catch also those special cases where a page that is
> > passed
> > > > to kmap() is allocated within that same function (vs. being passed=
=20
as
> > > > argument to this function) and, if so, propose a replacement with
> > > > kmalloc()?
> > >
> > > It looks complex in this case, because the allocation is in another
> > > function, and it is passed to another function.
> >
> > This is not the special case I was talking about. In this case your=20
code
> > for Coccinelle tells the right proposal and it is exactly what Alaa did=
=20
in
> > her patch (which is good!).
> >
> > I'm talking about other special cases like the one I pointed to with=20
the
> > link I provided. I'm sorry if my bad English made you think that Alaa's
> > patch was one of those cases where the page is allocated within the=20
same
> > function where kmap() is.
> >
> > I hope that now I've been clearer :)
>=20
> Ah, sorry for the misunderstanding.  If you have an example, I can take a
> look and propose something for this special case.
>=20
> julia

Yes, I have the example that you are asking for. It's that commit=20
633b0616cfe0 from Ira Weiny.

Let me copy and paste it here for your convenience...

diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/
ioctl.c
index 90a5caf76939..2e10367ea66c 100644
=2D-- a/arch/x86/kernel/cpu/sgx/ioctl.c
+++ b/arch/x86/kernel/cpu/sgx/ioctl.c
@@ -604,7 +604,6 @@ static long sgx_ioc_enclave_init(struct sgx_encl *encl,=
=20
void __user *arg)
 {
        struct sgx_sigstruct *sigstruct;
        struct sgx_enclave_init init_arg;
=2D       struct page *initp_page;
        void *token;
        int ret;
=20
@@ -615,11 +614,15 @@ static long sgx_ioc_enclave_init(struct sgx_encl=20
*encl, void __user *arg)
        if (copy_from_user(&init_arg, arg, sizeof(init_arg)))
                return -EFAULT;
=20
=2D       initp_page =3D alloc_page(GFP_KERNEL);
=2D       if (!initp_page)
+       /*
+        * 'sigstruct' must be on a page boundary and 'token' on a 512 byte
+        * boundary.  kmalloc() will give this alignment when allocating
+        * PAGE_SIZE bytes.
+        */
+       sigstruct =3D kmalloc(PAGE_SIZE, GFP_KERNEL);
+       if (!sigstruct)
                return -ENOMEM;
=20
=2D       sigstruct =3D kmap(initp_page);
        token =3D (void *)((unsigned long)sigstruct + PAGE_SIZE / 2);
        memset(token, 0, SGX_LAUNCH_TOKEN_SIZE);
=20
@@ -645,8 +648,7 @@ static long sgx_ioc_enclave_init(struct sgx_encl *encl,=
=20
void __user *arg)
        ret =3D sgx_encl_init(encl, sigstruct, token);
=20
 out:
=2D       kunmap(initp_page);
=2D       __free_page(initp_page);
+       kfree(sigstruct);
        return ret;
 }

I think that Coccinelle might understand that "initp_page" is allocated in=
=20
the same function where later it is kmap()'ed. But I'm not able to write a=
=20
Coccinelle check to find out these kinds of special cases. In these cases=20
the correct solution is not to use kmap_local_page(). Instead delete the=20
alloc_page() and use kmalloc().

Thanks,

=46abio



