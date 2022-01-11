Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B64E948ADED
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 13:52:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240049AbiAKMwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 07:52:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238734AbiAKMwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 07:52:03 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3ADCC06173F;
        Tue, 11 Jan 2022 04:52:02 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id w22so11711749iov.3;
        Tue, 11 Jan 2022 04:52:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=L07VkrmeA+z0Dq25akT1C/42p2m2KsG0KFfXsB65F+E=;
        b=KVbAxv4hk7g44+wTW1FXgIN0jc3529uBPErLALVFTHJd/01uNK378q2TjZEr3L7q4x
         hZF675Rd2Y2LYGZoNTyV1m0y9LAtsTq7J7BzCqkmSaf4vN8Hz72D6m3Rskhp31itYOpq
         EFWya65EHqwjV8rzEOCceEiTvQuOTQc9Z1Rxpmg32LlMv0Wm8rWuGifeD/Ji+f2DYYvb
         CYJT2T2GQvZXKoLcB7wnoXRd8FTaE9DKgRj8sGZybYwdlDk07L7oBO0j5KtEW0+dMMDT
         sJ35kKjDxqP1BURI/2bjfINynG3WOVC2dQ61glqr/F+C4SiTJ6p60Rf0IewAZgLr9EEs
         mJwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=L07VkrmeA+z0Dq25akT1C/42p2m2KsG0KFfXsB65F+E=;
        b=p1Y7H8d3HQJUs3xqQAv8qShgqV5/1o8M9+M39JHKlMbDOVsJ/oN0aWjKqYh87aMrKR
         rqfictauQEScc/pyWxbshFpZ5QTWPZOUMrpvk85FtMzcKXMs0gm50R3pkhB4LeOCuxtJ
         4RGYZIpkpYsnVMloJCpeiBqOnvXqHflutL6IRju48MIB0EnHQhBQNeNJC7/G7akvYMM4
         SMG0vg63Ih00fCI1jYTNjTU9PQ1hMD26nGxy3iLEZdrxwGyvpp3IhjxI3v0Z7Gr+nKVS
         ZTx5pfV2HHSrCxziXgWlQgHR39mYaxPcV0IPeVRXiqVLNqLJO1u6NA2OfvaMdYBsr66E
         jrXA==
X-Gm-Message-State: AOAM532XiE7+Dli3O1RUIkuCZOMCKms+1P5iZWMDN2nsMp1rr92NHpRj
        PgQzgpxsjNx25wTTm2pX7VFF0nzfUeqgj2nuoYI=
X-Google-Smtp-Source: ABdhPJyxJfS2OANCnsOmhmWWIrzth6lFpAQfsgqnKXaXvlO0z7E1fpSrYnFTKTqgzVZmFvHTUGHckB3nRHSsYj2XP04=
X-Received: by 2002:a5d:9496:: with SMTP id v22mr2066056ioj.36.1641905522150;
 Tue, 11 Jan 2022 04:52:02 -0800 (PST)
MIME-Version: 1.0
References: <20220110122929.647573-1-xu.xin16@zte.com.cn> <20220110123256.647748-1-xu.xin16@zte.com.cn>
In-Reply-To: <20220110123256.647748-1-xu.xin16@zte.com.cn>
From:   Alex Shi <seakeel@gmail.com>
Date:   Tue, 11 Jan 2022 20:51:26 +0800
Message-ID: <CAJy-AmmhXGTctT050aqV4hvyx33pFb+sAMXRbm+wXxgv-XR5CQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] docs/zh_CN: Add zh_CN/vm/index.rst
To:     CGEL <cgel.zte@gmail.com>
Cc:     Alex Shi <alexs@kernel.org>, xu.xin16@zte.com.cn,
        Jonathan Corbet <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Zeal Robot <zealci@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2022 at 8:33 PM <cgel.zte@gmail.com> wrote:
>
> From: xu xin <xu.xin16@zte.com.cn>
>
> This patch adds zh_CN/vm/index.rst.
>
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: xu xin <xu.xin16@zte.com.cn>
> ---
>  Documentation/translations/zh_CN/vm/index.rst | 49 +++++++++++++++++++++=
++++++
>  1 file changed, 49 insertions(+)
>  create mode 100644 Documentation/translations/zh_CN/vm/index.rst
>
> diff --git a/Documentation/translations/zh_CN/vm/index.rst b/Documentatio=
n/translations/zh_CN/vm/index.rst
> new file mode 100644
> index 0000000..27f8405
> --- /dev/null
> +++ b/Documentation/translations/zh_CN/vm/index.rst
> @@ -0,0 +1,49 @@
> +.. include:: ../disclaimer-zh_CN.rst
> +
> +:=E5=8E=9F=E6=96=87Original:    Documentation/vm/index.rst
> +
> +:=E8=AF=91=E8=80=85Translator:  =E5=BE=90=E9=91=AB xu xin <xu.xin16@zte.=
com.cn>
> +
> +:=E6=A0=A1=E8=AF=91Proofreader: =E6=9D=A8=E6=B4=8B Yang Yang <yang.yang2=
9@zte.com.cn>
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Linux=E5=86=85=E5=AD=98=E7=AE=A1=E7=90=86=E7=9A=84=E6=96=87=E6=A1=A3
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +=E8=BF=99=E6=98=AF=E4=B8=80=E4=B8=AA=E5=85=B3=E4=BA=8ELinux=E5=86=85=E5=
=AD=98=E7=AE=A1=E7=90=86=EF=BC=88mm=EF=BC=89=E5=AD=90=E7=B3=BB=E7=BB=9F=E7=
=9A=84=E6=96=87=E6=A1=A3=E9=9B=86=E5=90=88=EF=BC=8C=E5=85=B6=E5=86=85=E9=83=
=A8=E5=85=B7=E6=9C=89=E4=B8=8D=E5=90=8C=E5=B1=82=E7=BA=A7=E7=9A=84=E8=AF=A6=
=E7=BB=86=E4=BF=A1=E6=81=AF=EF=BC=8C
> +=E5=8C=85=E6=8B=AC=E6=B3=A8=E9=87=8A=E5=92=8C=E9=82=AE=E4=BB=B6=E5=88=97=
=E8=A1=A8=EF=BC=8C=E7=94=A8=E4=BA=8E=E8=AF=A6=E7=BB=86=E6=8F=8F=E8=BF=B0=E6=
=95=B0=E6=8D=AE=E7=BB=93=E6=9E=84=E5=92=8C=E7=AE=97=E6=B3=95=E3=80=82=E5=A6=
=82=E6=9E=9C=E6=82=A8=E6=AD=A3=E5=9C=A8=E5=AF=BB=E6=89=BE=E6=9C=89=E5=85=B3=
=E7=AE=80=E5=8D=95=E5=86=85=E5=AD=98=E5=88=86
> +=E9=85=8D=E7=9A=84=E5=BB=BA=E8=AE=AE=EF=BC=8C=E8=AF=B7=E5=8F=82=E9=98=85=
:ref:`memory_allocation` =E3=80=82=E6=9C=89=E5=85=B3=E6=8E=A7=E5=88=B6=E5=
=92=8C=E8=B0=83=E6=95=B4=E6=8C=87=E5=8D=97=EF=BC=8C=E8=AF=B7=E5=8F=82=E9=98=
=85
> +:doc: `admin guide <../admin-guide/mm/index>` =E3=80=82

You have a Chinese version mm/index, link to it. :)

Thanks
Alex

> +
> +.. toctree::
> +   :maxdepth: 1
> +
> +   ksm
> +
> +Todolist:
> +   active_mm
> +   arch_pgtable_helpers
> +   balance
> +   damon/index
> +   free_page_reporting
> +   frontswap
> +   highmem
> +   hmm
> +   hwpoison
> +   hugetlbfs_reserv
> +   memory-model
> +   mmu_notifier
> +   numa
> +   overcommit-accounting
> +   page_migration
> +   page_frags
> +   page_owner
> +   page_table_check
> +   remap_file_pages
> +   slub
> +   split_page_table_lock
> +   transhuge
> +   unevictable-lru
> +   vmalloced-kernel-stacks
> +   z3fold
> +   zsmalloc
> --
> 2.15.2
>
>
