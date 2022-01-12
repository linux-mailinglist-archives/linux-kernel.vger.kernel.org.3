Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE23248C3D5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 13:16:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353111AbiALMQK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 07:16:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238443AbiALMQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 07:16:02 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98035C06173F;
        Wed, 12 Jan 2022 04:16:02 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id p14so3913401plf.3;
        Wed, 12 Jan 2022 04:16:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OetVYdoEDfRxVlip52WuP6tWKcL+6dy2sed+JMBIiBk=;
        b=ZWXGsjLbAFwqvn7GtrJY3pcDSdFuakijB+JCmJa/2cDte5Zeg096x45VHsicpGGOAA
         iDGS3V+snRgALx51yKCEqU1UEBBQt6//tqsi+FDuSnfFtupai34e6A5wE+05jq3gmFp7
         +sS8r4UCpaGY4zuvJhvQE5vxelcy6a+/+8CfmDIMONVNeiyLtTaJxJpSjNYSafuplz/G
         WTXfbnUgcKcGkZ8lPplt1P2LC4kjBMDxEtdPCLukEcqdFxvdjq3guzFeo/X3WGD8qsAh
         3/HSVKmvR2Hz+9ZAwqCdeU9pd7Qh6I4h6D2QuXMY+Ft3khmCTNtKaRh2vxP40M4GRWBD
         RUAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OetVYdoEDfRxVlip52WuP6tWKcL+6dy2sed+JMBIiBk=;
        b=pXWcmg13sYB2cCg1YEy2TqSTFym203tRlXsusSiQa5MagsNOOC77OmmBieTz21jjdW
         X1+5+Tyy+bQBXdl4Pscbb5asTUm0JNlVq/S/LVSkyVf4Vq7KGxKsSxD2yFHPgadHvsGX
         CVUhDQhOOqEsfhZ9Ztq1471IQVYRO9fu/KIfOrQ7IXuU1q0mCf1U9ewHd7e8CUMNKgNy
         3+NNkGbrgln8WKBlnkZJf9gucN5+UAz8rkGmiL48BgvC20yLbOxRQ1YaXpPCdAwWZz/u
         3AzcrW9fxXnQU8wiyvApoCpFYBYYA08qdLs/U6zyI/PvIHuAd/XkiKkfwtL9gJEXIBI2
         dUdw==
X-Gm-Message-State: AOAM530juV5YgXVOW4dE40NSu5ICH7/dqVKmSMcxT1RaEYKb1P5LzrwN
        zwBN24Yt9zXCcRPoB8mk2E2ElPFkV0rdxFbCiQ8GVVnhrPhyww==
X-Google-Smtp-Source: ABdhPJzaPbYqA32TIPuPfLam9UQeH3lT61cZvJEVycC7KM9gCgsi6Pd07Pp6+j/8GX0pPTxfat4o1eAiooZBoeKIkVk=
X-Received: by 2002:a17:903:24d:b0:14a:677d:843a with SMTP id
 j13-20020a170903024d00b0014a677d843amr3202024plh.129.1641989761504; Wed, 12
 Jan 2022 04:16:01 -0800 (PST)
MIME-Version: 1.0
References: <20220110122929.647573-1-xu.xin16@zte.com.cn> <20220110123256.647748-1-xu.xin16@zte.com.cn>
In-Reply-To: <20220110123256.647748-1-xu.xin16@zte.com.cn>
From:   teng sterling <sterlingteng@gmail.com>
Date:   Wed, 12 Jan 2022 20:15:40 +0800
Message-ID: <CAMU9jJp=DUzKCGkJyWaefiSBqcHR2rtA3Wc0KYnSvfq9bw2RCg@mail.gmail.com>
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

<cgel.zte@gmail.com> =E4=BA=8E2022=E5=B9=B41=E6=9C=8811=E6=97=A5=E5=91=A8=
=E4=BA=8C 11:07=E5=86=99=E9=81=93=EF=BC=9A
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

Thank you for the translation. Here's a patch for the same that has
been reviewed
<https://lore.kernel.org/linux-doc/60c579b34792c4c76194c4843a695263a982b37d=
.1641866889.git.siyanteng@loongson.cn/T/#u>

Here are some of my suggestions=EF=BC=9A
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
These signatures are recommended to refer to other documents that have
already been translated, too many different formats will make a mess
of the Chinese document.
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
In the document, we are no longer using this reference, simply write
in parentheses to refer to the path of the document can be.
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
Compile pass is only one of the basis for checking through, we also
have to check the html for any problems, as far as I know, the above
treatment is very ugly, in the html will be like this=EF=BC=9A

active_mmarch_pgtable_helpersbalance damon/index.........

Let's handle it simply like this=EF=BC=9A

.. toctree::
   :maxdepth: 1

   active_mm
   balance
   damon/index

TODOLIST:
* arch_pgtable_helpers
* free_page_reporting
* frontswap
* highmem
* hmm
* hwpoison
* hugetlbfs_reserv
* ksm
* memory-model
* mmu_notifier
* numa
* overcommit-accounting
* page_migration
* page_frags
* page_owner
* page_table_check
* remap_file_pages
* slub
* split_page_table_lock
* transhuge
* unevictable-lru
* vmalloced-kernel-stacks
* z3fold
* zsmalloc

Finally, welcome to join us!

Thanks,
Yanteng

> --
> 2.15.2
>
>
