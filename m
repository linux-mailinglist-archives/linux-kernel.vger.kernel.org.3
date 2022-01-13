Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F7D048DA34
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 15:56:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235816AbiAMO4X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 09:56:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232444AbiAMO4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 09:56:22 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD62EC06161C;
        Thu, 13 Jan 2022 06:56:21 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id u25so24089123edf.1;
        Thu, 13 Jan 2022 06:56:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kFk46LMUsbPXmYDjluK2WhJE06qBR7w0lhPTkMyBJXc=;
        b=JyRpTA8c52bH57ISx/V51sjYq8XK1zznYGqVySa+JYdvfBKzDfHsT0egHReWwXAicx
         g3IVg6DTOCBlivNAOoqoLSRbx3R4qW6Y9xQerBHwzFXEsUJfCfIxkgQb7KHK8b44GXsF
         SWAVM8WfS37RFsnGtnpiGqtwicakDUeXnKNp1wIjBdsMrOZ5qt8ssealLHKK3OksrtT5
         xQRN3A72dj9hQSws0BZlm81ecr6KT8+rY3HY8Cjgg9CruBFEff7RS2ABjrxkf1KgZJly
         NtM2tFcbtSXAACl1QJK5gLo7kfFKMT8SiQhxckEnfA05eYxDjChglnfKv8NOb+gthoX1
         /gxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kFk46LMUsbPXmYDjluK2WhJE06qBR7w0lhPTkMyBJXc=;
        b=rOBzu85aTaFC+gaeitd5Rano+idYU3S9LJJilpBkj6ZxoFQE0ENBeNgpcjDTSCY9lo
         O93Hu5NLsDkUyVKqznaZa4QiM42933JLCfVlSQd10bHN6KhdnH63cw80HrDm+qm50GMA
         cmtdLdAfyZ5LFRM57y8ugQIMMYT/GVKkf4qgcn5UoGH95pF++lU6gzbYrHlUrLHl55CE
         Qi7d090HXwo4mwN/1PcYPf23cI0fEwL+Yq9YBNZgg/nO/s7PQfPLhiX7QGDOKlNZwIAt
         nKTD4S1Ih3Y/YOcouIRzNbx+WpakYa27epLENDEzRmMBIYkypdRnFgS+Qig3PzZNenGg
         i5Bw==
X-Gm-Message-State: AOAM530Jb4+DdTsJtVvldfoNc0RuXMZsKqyfU/TPxTDTNQH+gEWLdogJ
        dXZYAs/nmTTBBKgO8eXI4b6SMP0BT5fI6FOICNobsY4bT2qSu+To
X-Google-Smtp-Source: ABdhPJxmhJBwsEUB9im91Ska6okmWvIz7U96owI2/BkkW+H1gz0RxU8A4v0KB6dFDtRLVDQb3SoSbNcA5qDDRRcexpk=
X-Received: by 2002:a50:ab1a:: with SMTP id s26mr4627668edc.182.1642085780451;
 Thu, 13 Jan 2022 06:56:20 -0800 (PST)
MIME-Version: 1.0
References: <1642003482-48935-1-git-send-email-wang.yong12@zte.com.cn> <CAMU9jJquKLfzLOjN3xTLHgPJFWONpeVgUDG-0vsf_8ia3r3ALQ@mail.gmail.com>
In-Reply-To: <CAMU9jJquKLfzLOjN3xTLHgPJFWONpeVgUDG-0vsf_8ia3r3ALQ@mail.gmail.com>
From:   yong w <yongw.pur@gmail.com>
Date:   Thu, 13 Jan 2022 22:56:09 +0800
Message-ID: <CAOH5QeBxnK-vOwVh9HNeu5PjMPJrHtWCyTK_y43iCbfzN+aoEg@mail.gmail.com>
Subject: Re: [PATCH] docs/zh_CN: Update zh_CN/accounting/delay-accounting.rst
To:     teng sterling <sterlingteng@gmail.com>
Cc:     Alex Shi <alexs@kernel.org>, Yanteng Si <siyanteng@loongson.cn>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, wang.yong12@zte.com.cn,
        yang.yang29@zte.com.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
teng sterling <sterlingteng@gmail.com> =E4=BA=8E2022=E5=B9=B41=E6=9C=8813=
=E6=97=A5=E5=91=A8=E5=9B=9B 10:11=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi Yong,
> <yongw.pur@gmail.com> =E4=BA=8E2022=E5=B9=B41=E6=9C=8813=E6=97=A5=E5=91=
=A8=E5=9B=9B 07:27=E5=86=99=E9=81=93=EF=BC=9A
> >
> > From: wangyong <wang.yong12@zte.com.cn>
> >
> > Update zh_CN/accounting/delay-accounting.rst.
> > The document modification has been merged which refers to the following=
 link:
> > https://lore.kernel.org/all/1639583021-92977-1-git-send-email-wang.yong=
12@zte.com.cn/
> The normal way to handle this is to add an appropriate Fixes tag.
>
> By the way, this patch should be submitted together as part of that
> patch series where you modified the original documentation. Also check
> out the documentation for other languages and send it in the same way.
> If you get stuck, simply --CC the maintainer is an elegant way to
> handle it. >_<
The previous patch has been merged into linux-next. There was no
Chinese translation when I submitted it.
At present, this document is only translated into Chinese, which was
translated not long ago.
So I update it in this patch.
>
> >
> > Signed-off-by: wangyong <wang.yong12@zte.com.cn>
> > Reviewed-by: Yang Yang <yang.yang29@zte.com.cn>
> This looks like the first version of the patch and doesn't seem to
> have been reviewed by anyone yet, so you can't sign it instead of
> someone else.
Yang Yang reviewed it offline.
>
> Thanks,
> Yanteng
Thanks for your reply.
