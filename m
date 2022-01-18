Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4658D4925D1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 13:39:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236418AbiARMiv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 07:38:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232927AbiARMit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 07:38:49 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 273D3C061574;
        Tue, 18 Jan 2022 04:38:49 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id cx27so5331268edb.1;
        Tue, 18 Jan 2022 04:38:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=giqSwPUWjiHUPnyssgYdEuVWMZ2dXDJUtAKotE6rGaM=;
        b=fciRrSY/1qXsi3cijprTseE5sDv/N1k7x0b6GBLyBVEfR+3OXnmtDReSPI4CloyuAE
         79p3ELAAbMmebrFsiPZSVb78V8crUa5NlEZ557+2PK+JeVPpY/cR1+Ol59pRsBIUXdnT
         zGEMblbQbaQ483/tXNB0+beRlqNESPOGfLsIc8LherNvX55PqIxcforSlcRVsAmI/hw5
         Ykip3pGVME71LtZq5G6jBKBbTB3r3j8vQMZOwrzgRMeEb9hJ7CYyCfpLQZ9HlSwAVryC
         u7TLD/sZ0WbEt/4i6o5SKIMn90EkXdfKHXIQEqvmbayQWfrlgzNiWyry7rs44DL6ZDQ/
         JyaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=giqSwPUWjiHUPnyssgYdEuVWMZ2dXDJUtAKotE6rGaM=;
        b=4tN/H1M3C8FxY6uOOvnawH5GewMrh+jPw7WLED/vm5jGB60M1h8FnFZIVK7qVSbLe/
         C7EtHn2NmNifGodjcyJEm300tShduqttjunfvXnh+5jWSIQb2tJV858XPdYZtSiB8fSh
         Q9AatzkQuCn/M5nldREOwfwtMXxpSm++tilTDXQL2XVhvnSnmg5jfgAecgTxHbLe7w2k
         Jm+aFkonudeeZXwCtNa7yiZXmqqbHHIVtcHQ1i+DlLeRIsZB32trKx8Tdeg/rKx4/9sd
         i6V6NBKZs4JecFaguj2jO7WmTaVtz5KOoxOe84fiJA15MU0uJtacAOBrTt4C+YWiXdO6
         AQlw==
X-Gm-Message-State: AOAM530wAN/QyoFLYWWS/N/fFwoTebQdiilH+8ZmciRF4yeEuIkd+XtA
        VPx2WTQnPDk7sRvCK56BCpQH8Me1EH6G+FESHbM=
X-Google-Smtp-Source: ABdhPJwqVDIgIjz4XFyGfH2mOQXWMGKutp0EPGmRa3pyLpBvDKfrXt2ayucK2GzX9mri6O79EyqLaURuG9fu3AgkVBU=
X-Received: by 2002:a17:906:f2c8:: with SMTP id gz8mr19495096ejb.220.1642509527757;
 Tue, 18 Jan 2022 04:38:47 -0800 (PST)
MIME-Version: 1.0
References: <1642003482-48935-1-git-send-email-wang.yong12@zte.com.cn>
 <CAMU9jJquKLfzLOjN3xTLHgPJFWONpeVgUDG-0vsf_8ia3r3ALQ@mail.gmail.com> <CAOH5QeBxnK-vOwVh9HNeu5PjMPJrHtWCyTK_y43iCbfzN+aoEg@mail.gmail.com>
In-Reply-To: <CAOH5QeBxnK-vOwVh9HNeu5PjMPJrHtWCyTK_y43iCbfzN+aoEg@mail.gmail.com>
From:   yong w <yongw.pur@gmail.com>
Date:   Tue, 18 Jan 2022 20:38:30 +0800
Message-ID: <CAOH5QeAka4QsLCOHaNK8NBp1BUFsu3HqEqiOhWOewabA58fVqw@mail.gmail.com>
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
Is this patch OK?

yong w <yongw.pur@gmail.com> =E4=BA=8E2022=E5=B9=B41=E6=9C=8813=E6=97=A5=E5=
=91=A8=E5=9B=9B 22:56=E5=86=99=E9=81=93=EF=BC=9A
>
> Hello,
> teng sterling <sterlingteng@gmail.com> =E4=BA=8E2022=E5=B9=B41=E6=9C=8813=
=E6=97=A5=E5=91=A8=E5=9B=9B 10:11=E5=86=99=E9=81=93=EF=BC=9A
> >
> > Hi Yong,
> > <yongw.pur@gmail.com> =E4=BA=8E2022=E5=B9=B41=E6=9C=8813=E6=97=A5=E5=91=
=A8=E5=9B=9B 07:27=E5=86=99=E9=81=93=EF=BC=9A
> > >
> > > From: wangyong <wang.yong12@zte.com.cn>
> > >
> > > Update zh_CN/accounting/delay-accounting.rst.
> > > The document modification has been merged which refers to the followi=
ng link:
> > > https://lore.kernel.org/all/1639583021-92977-1-git-send-email-wang.yo=
ng12@zte.com.cn/
> > The normal way to handle this is to add an appropriate Fixes tag.
> >
> > By the way, this patch should be submitted together as part of that
> > patch series where you modified the original documentation. Also check
> > out the documentation for other languages and send it in the same way.
> > If you get stuck, simply --CC the maintainer is an elegant way to
> > handle it. >_<
> The previous patch has been merged into linux-next. There was no
> Chinese translation when I submitted it.
> At present, this document is only translated into Chinese, which was
> translated not long ago.
> So I update it in this patch.
> >
> > >
> > > Signed-off-by: wangyong <wang.yong12@zte.com.cn>
> > > Reviewed-by: Yang Yang <yang.yang29@zte.com.cn>
> > This looks like the first version of the patch and doesn't seem to
> > have been reviewed by anyone yet, so you can't sign it instead of
> > someone else.
> Yang Yang reviewed it offline.
> >
> > Thanks,
> > Yanteng
> Thanks for your reply.
