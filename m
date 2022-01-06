Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5761E4865EC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 15:18:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239963AbiAFOSw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 09:18:52 -0500
Received: from mout.gmx.net ([212.227.17.22]:51385 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239854AbiAFOSv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 09:18:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1641478726;
        bh=XmBQEQdpVKDeVaGl1xSjDSY3DfE3NwuYVyzERjAro34=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=JyoLx5WfKy3MC87Ifwo0qWe0jqdVhTuNU0FxVUR75DlVIIQLXjev0NYpBsHxDFe8T
         +l3mIpah3BHg16HiQvUk2ldSh0bzuCe8p1xrlrX+nWu2b9ptChMO5LnUeM41B5nXGq
         iM6kEQBy0bc5q+c3VUbd5Ahu2uQbZObnBEDM7bSQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.152.191]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MG9kC-1nAv853x9w-00GV4r; Thu, 06
 Jan 2022 15:18:45 +0100
Message-ID: <f95569dc-1d84-232d-b09f-6d531b1e6261@gmx.de>
Date:   Thu, 6 Jan 2022 15:17:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] parisc: pdc_stable: use default_groups in kobj_type
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        linux-parisc@vger.kernel.org
References: <20220106095117.3273204-1-gregkh@linuxfoundation.org>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <20220106095117.3273204-1-gregkh@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:speqiOUorjZaSnmJNZavu/FrKCGKY8pxcorJyyOJY2L2qrqxdXd
 CRRwW4KIlhoIvQ8sl00M0l3S4L5JDsyye9CSBss8UbbIkTsMX2fRgFRwIysE+68SVFbnno2
 Y+VinMncL1ne+czGSJ5Ju2eTa4mJVmbZLF5cl4X69JC8VoL7oe/X3F/qKZE291sOzj6GHpz
 s98ETKe4MHl9Bt0/R4sQA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:PRBHOqWiGec=:cbWXA6DvjhCG0W0e5qolGR
 chyXMlUwlIMVK36cxMBjXrov09FkWQYf78hIo/tIje5O+tR+e9Iin4rGLR0/7KpdPRKFNPruy
 NUTFaaQhQ4jUioVpCWUy9AmGw/n+OidWMvRT0qzrQf+khFc8aKNnJWPRvEWT08KvqxOrkYeTU
 +ulWHRmaIp7OL74Jdsl4C+tItC+7+psq2CpmjWDbpsBxySIkOXWXioc2PfjL7z4rBYlHTCFIO
 RPmfSzUwgY5ZHwYlUocyWpkZuaVkVeFLRvXwKYMDQTaGmgRDNcmTbWLq4u+cW1pATIMzDPgtR
 T66zSI+UOkvc3tx757qQXuns1MbOZumJta5mWWi7kGdP7x93J7P6l3lwnL+bgE7GHENARCCTW
 q3/ksvmJuj3kJsfZgOT0nAjnVwq6eIbwkDJizRMmz3+CSodIw/o4+hH/EVbuZvUDHxFfjSEHz
 oiXoZgoLT88nnYvDZugf4Ez/LjESe8Fxh85qlVQVJknDy4Bz4MVGU8AmNWVRBdNjIgkxBwaHf
 nZCGRSAdLy0QAIuihoYX4YcRfyjmtMFRC2dwBqUlAAyHvjxeZGft4ettiBxcw+XYl6c0dBpsR
 ddgEJvDHFNrv/6d3MfOrMHrGHlxnBz7IBd98D0ui3KkuI7tp38QGmMPOYkJRUd3DMQPcG1gdb
 51kl0vd7jCWJhZ2V/3jkL2deEvEteDR+MfAa8nBMOp/rFQ7LbX0XijNx7DMpRIte2nKKlGbmM
 O+t7UFpscut40SNdH8IiO8C55TQ+MnzhwJjVNPO/4uDJk44HETJvprl8m23L/5s6SxFgU61UK
 dBA6s8okg/vw2rSim2vOpp/y/2Ku799gwWQHxSDt8TWzgwjnZXaStcl/UW9yZZHs7BuOj8yzY
 tibZOjjeyec/tXuQO3W7LMpgMcX9tmbCZPqcaGbHqABCHY0urWTeC09UY12WTJ5sddJnVZkKy
 aBLc+lZ1FadruuIXXrXCxS/L+LUpM9cvzI0UdxIAYqBbR+5jK5TYdLVqDb8NhF8mRzBmwHq6F
 fre+jBPcah9C7eey9S4YNcJRIQObsTjpEIWLKwSaK9yxz91B7uhhHmgRCi7o9w9NpyHZRa/0U
 H0mWGVPBtJTw7k=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/6/22 10:51, Greg Kroah-Hartman wrote:
> There are currently 2 ways to create a set of sysfs files for a
> kobj_type, through the default_attrs field, and the default_groups
> field.  Move the parisc pdc_stable sysfs code to use default_groups
> field which has been the preferred way since aa30f47cf666 ("kobject: Add
> support for default attribute groups to kobj_type") so that we can soon
> get rid of the obsolete default_attrs field.
>
> Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
> Cc: Helge Deller <deller@gmx.de>
> Cc: linux-parisc@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Applied.

Thanks!
Helge

> ---
>  drivers/parisc/pdc_stable.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/parisc/pdc_stable.c b/drivers/parisc/pdc_stable.c
> index e090978518f1..9513c39719d1 100644
> --- a/drivers/parisc/pdc_stable.c
> +++ b/drivers/parisc/pdc_stable.c
> @@ -482,11 +482,12 @@ static struct attribute *paths_subsys_attrs[] =3D =
{
>  	&paths_attr_layer.attr,
>  	NULL,
>  };
> +ATTRIBUTE_GROUPS(paths_subsys);
>
>  /* Specific kobject type for our PDC paths */
>  static struct kobj_type ktype_pdcspath =3D {
>  	.sysfs_ops =3D &pdcspath_attr_ops,
> -	.default_attrs =3D paths_subsys_attrs,
> +	.default_groups =3D paths_subsys_groups,
>  };
>
>  /* We hard define the 4 types of path we expect to find */
>

