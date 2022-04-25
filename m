Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0604B50D775
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 05:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240586AbiDYDXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 23:23:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240592AbiDYDWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 23:22:33 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0886C20197;
        Sun, 24 Apr 2022 20:19:30 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id v25so2984708ybd.8;
        Sun, 24 Apr 2022 20:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QAunaVT1jcyoQModTE6mBAO7CfddjaWEj8RHhYf/ZM0=;
        b=W5ZdxqEJpcFSowY9QYhfBMhfCTBd0OclvVfDyTmZdMCCqTgebng3/ptSEH5ALHZVLw
         1kwcUC/P22kVb/bPhwkPhj6X0LffxfXCCdaaMZT4JQqtVvw89Ccpy0AH07tj+q0DEUzz
         7W2Ija68fHWuP05Y0YPIaYK0CXGS3+jzV7p3oKT5n0xCFTHm+L6Oh6TyfmGnoRc7bXZV
         5Dcifp/bc1EXietsKFFWwApGMPl+Gvv5vQhnf7takf+8dPSagTNjgmFtNRjWt38l7Cbr
         gcKcO7fsFZhvuGsvaALcMhZ0JB0c6pzirPmjIUDW0dRILCmNFKzANKQ3ugkMg/Qo5loE
         zhmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QAunaVT1jcyoQModTE6mBAO7CfddjaWEj8RHhYf/ZM0=;
        b=zo1W18gbeTpEvOOha8ttpQOjHWC5TthKxMMQxgHa+xuya//WIXZ2LrSS40QJaoG+Li
         9X8AWrdlhARfAXNnPl2AMd3+kLVnvqHUkPPXlwn9OnG+gG3EAlcIqJabkZlorofNZONH
         GnhyYeoi/3V9EVtgYli7UUd0gpQfL1Oae3WsvVy4FVxd6KB5egzqIlL9ifPIdPs33LlG
         +gx6b24CrRGZO0/NhX+rOyfwk4Yk86uotqdcDI2sRTEsDC9RI5L7lM2TFLJ7CcQXXE27
         aOA6hIVd5u/9mtPRFs0ZtHe0WTXZ3TQynpV7lhgUi4C211KvGg3scR/SJ/P5d3SoYBIu
         CzTg==
X-Gm-Message-State: AOAM532MtxI0K85EBuDhw8YKMrxuLuvBE91XcsqELqXgEAnJcXhABQlI
        oOpwM/j2+Ql+9uDo+FHh2IQQEaYjxriMtgTUeLJm9DpB2X26Vgm4
X-Google-Smtp-Source: ABdhPJxoU5GLqrUvuWhvTkTslCk2tbyx7Aak5KOgpM9DKpWjMCsJpmpMMNHRTuPAmmZkPFXwlPC4Qm3TCfVjZJC4qSc=
X-Received: by 2002:a5b:690:0:b0:645:d493:36c9 with SMTP id
 j16-20020a5b0690000000b00645d49336c9mr11829962ybq.641.1650856769257; Sun, 24
 Apr 2022 20:19:29 -0700 (PDT)
MIME-Version: 1.0
References: <CAEensMzuQ0uAw8_5Xb7u1n685au=DpaJyPevGCT8GCG7xS42ow@mail.gmail.com>
 <1650424016-7225-1-git-send-email-baihaowen@meizu.com> <1650424016-7225-2-git-send-email-baihaowen@meizu.com>
 <30d2f96e-99e1-2976-a294-8e112166afff@gmail.com> <049ccac8-c394-0cdc-c2ed-4ea91cab6439@meizu.com>
 <c498b2a7-8f0e-4f6d-10ba-49c4c7794ff9@gmail.com> <0be9fe6a-b01e-b355-9283-6ad8372932d6@meizu.com>
In-Reply-To: <0be9fe6a-b01e-b355-9283-6ad8372932d6@meizu.com>
From:   yanteng si <siyanteng01@gmail.com>
Date:   Mon, 25 Apr 2022 11:19:16 +0800
Message-ID: <CAEensMzgJ6LmGiJajqwgE3cQCR-pcgr1o35Qf=n1K215BwHLhA@mail.gmail.com>
Subject: Re: [PATCH 1/2] docs/zh_CN: sync with original text Documentation/vm/page_owner.rst
To:     baihaowen <baihaowen@meizu.com>
Cc:     Alex Shi <seakeel@gmail.com>, Alex Shi <alexs@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Yanteng Si <siyanteng@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_20,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

baihaowen <baihaowen@meizu.com> =E4=BA=8E2022=E5=B9=B44=E6=9C=8825=E6=97=A5=
=E5=91=A8=E4=B8=80 09:17=E5=86=99=E9=81=93=EF=BC=9A
>
> =E5=9C=A8 4/24/22 11:16 AM, Alex Shi =E5=86=99=E9=81=93:
> >
> > On 4/24/22 10:56, baihaowen wrote:
> >>>> +        =3D=3D=3D=3D=3D=3D          =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =
     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> hi, Alex
> >> I can apply local.
> >> =E2=9E=9C  linux-next git:(heads/next-20220421) =E2=9C=97 git am doc_p=
ageonwer_patches/0001-docs-zh_CN-sync-with-original-text-Documentation-vm-.=
patch
> >> =E5=BA=94=E7=94=A8=EF=BC=9Adocs/zh_CN: sync with original text Documen=
tation/vm/page_owner.rst
> >> =E2=9E=9C  linux-next git:(heads/next-20220421) =E2=9C=97 git am doc_p=
ageonwer_patches/0002-doc-vm-page_owner.rst-Fix-table-display-confusion.pat=
ch
> >> =E5=BA=94=E7=94=A8=EF=BC=9Adoc/vm/page_owner.rst: Fix table display co=
nfusion
> >>
> >> I think git send-email will change format by my select. I'll try to re=
send.
> > Send to yourself only then get it from your email client and try applyi=
ng.
> >
> > Thanks
> > Alex
> Hi Alex
>
> Could you tell me how do you do when you get a patch from email ?
$: git clone git://git.kernel.org/pub/scm/utils/b4/b4.git
$: b4/b4.sh am <message-id>
###=E5=9C=A8=E4=BD=A0=E7=9A=84=E9=82=AE=E7=AE=B1=E9=87=8C=E6=9F=A5=E7=9C=8B=
=E5=8E=9F=E5=A7=8B=E6=9C=89=E9=82=AE=E4=BB=B6=EF=BC=8C=E7=84=B6=E5=90=8E=E6=
=89=BE=E5=88=B0message-id=EF=BC=8C=E8=B4=B4=E8=BF=87=E6=9D=A5=E5=B0=B1=E8=
=A1=8C=EF=BC=8C=E5=89=8D=E6=8F=90=E6=98=AF=E4=BD=A0=E7=9A=84=E8=A1=A5=E4=B8=
=81=E7=B3=BB=E5=88=97=E5=9C=A8lore=E9=87=8C=E6=98=AF=E6=8C=89=E7=85=A7=E5=
=89=8D=E5=87=A0=E5=A4=A9=E6=88=91=E8=AF=B4=E7=9A=84=E9=82=A3=E4=B9=88=E5=BC=
=84=E3=80=82
$: vim xxxx.mbx   ### [modify your patch]
$: git am  xxxx.mbx


Thanks,
Yanteng

>
> I get my patch from email and then copy-patse to a new file, then git am =
xx.patch.
> It will notice =E8=A1=A5=E4=B8=81=E6=A0=BC=E5=BC=8F=E6=A3=80=E6=B5=8B=E5=
=A4=B1=E8=B4=A5=E3=80=82
>
> --
> Haowen Bai
>
