Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAE5B5836D8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 04:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234650AbiG1C0w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 22:26:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232427AbiG1C0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 22:26:51 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82F9115713;
        Wed, 27 Jul 2022 19:26:49 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id a23so870256lfm.10;
        Wed, 27 Jul 2022 19:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lF4K9njh1CfE8adJZDA/xjNewn/fwTSHNz/x/3VXeQw=;
        b=XVSTyj7vzz7QwsIqoxOxW+ZgWu2IUtoVj2iGcz9DufSsKAqdcgfPdyxvQTvD7BVO/z
         qpHYvZ2LtkPo8QoSnUd5pJ9x/AR2II/+a8R6c/pKrLo/3N1CaTN42/4WVOBYZseyzQCZ
         7BVYNgJCPWsn+xPJ0O0WIyAsPC2e3J6IHr9+f6NelImngddAoda6FOoMPqH7eyaMeRtu
         67rykmv3DMo7aJzC3K8Telr3f83TzwT9rp0Qbi+0lA0XzbK/HE6DXpjQMt33yteYSW3T
         v9pX9wWvGMy81LNFsnCKpJizH5lRkfn4Pnb+1uX6JPfzI1qrS+3JBl+geYUamYOMXB1N
         MPXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lF4K9njh1CfE8adJZDA/xjNewn/fwTSHNz/x/3VXeQw=;
        b=s3DK4dmxloTOL0SuGQk3VCGaQ8Ji0svnuIx1LvneMISQ+0dFTkpgERp1UxD9q6jE+z
         asL2I74mMnK4EsNWLhAQ2s7/YH7d+uU62Rbwx+0qKMSzqwOiCNjsJ+oT/U4u8ykPNcSn
         yUIVLEY7MErQNTk7l/XSNuiN50z5+tGSQU6JrbJkdOoIktkiRI8tB0TGet02w55iIQEL
         Tt/Cxd0lU7qPlI4tO0cSatAkEbLrPHN3xukfaGOGXoLkQYKLUfVW0j72m7EZ1sQsAohO
         QRIDxEAxfkiXIFkMGhihnvyQQsgTzGc5MCHAuDOf9AwsvVomD1F/qAH2tdyvS3wcO7Ll
         R2Rw==
X-Gm-Message-State: AJIora/xIDWDE94DdcdCN5ylu6HNWb5J79ihbVRIIpm6rgH8ntJmxPw2
        VQvzaEhnsLyd13bDTOGgvHTfIYoCkTeE9OjBqg==
X-Google-Smtp-Source: AGRyM1tS57mHO/4ewowr7uHmS2gxY8q8rgApDI1ve1jS/0Y+B4OisEaiylmJYKS4KcGoiSBGXLKiU+wxqiVBp+TA7UU=
X-Received: by 2002:a05:6512:2288:b0:48a:87c4:a8eb with SMTP id
 f8-20020a056512228800b0048a87c4a8ebmr7255274lfu.328.1658975207414; Wed, 27
 Jul 2022 19:26:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220727034454.31892-1-stanley.chu@mediatek.com>
 <20220727034454.31892-3-stanley.chu@mediatek.com> <fa60e605-a881-79aa-b9ed-9c8bdf06778f@acm.org>
In-Reply-To: <fa60e605-a881-79aa-b9ed-9c8bdf06778f@acm.org>
From:   Stanley Chu <chu.stanley@gmail.com>
Date:   Thu, 28 Jul 2022 10:26:35 +0800
Message-ID: <CAGaU9a8vyk7PKwNPCJJokUWp5jSrr3X8PQbmzgMjfLSRmVwLYw@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] scsi: ufs: ufs-mediatek: Provide detailed
 description for UIC errors
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Stanley Chu <stanley.chu@mediatek.com>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Avri Altman <avri.altman@wdc.com>, alim.akhtar@samsung.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        peter.wang@mediatek.com, Chun-Hung Wu <chun-hung.wu@mediatek.com>,
        alice.chao@mediatek.com, powen.kao@mediatek.com,
        mason.zhang@mediatek.com, qilin.tan@mediatek.com,
        lin.gui@mediatek.com, eddie.huang@mediatek.com,
        tun-yu.yu@mediatek.com, cc.chou@mediatek.com,
        chaotian.jing@mediatek.com, jiajie.hao@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bart,

On Thu, Jul 28, 2022 at 3:04 AM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 7/26/22 20:44, Stanley Chu wrote:
> > diff --git a/drivers/ufs/host/ufs-mediatek.h b/drivers/ufs/host/ufs-med=
iatek.h
> > index aa26d415527b..9017ab8f9867 100644
> > --- a/drivers/ufs/host/ufs-mediatek.h
> > +++ b/drivers/ufs/host/ufs-mediatek.h
> > @@ -26,6 +26,44 @@
> >   #define REG_UFS_DEBUG_SEL_B2        0x22D8
> >   #define REG_UFS_DEBUG_SEL_B3        0x22DC
> >
> > +/*
> > + * Details of UIC Errors
> > + */
> > +static const u8 *ufs_uic_err_str[] =3D {
> > +     "PHY Adapter Layer",
> > +     "Data Link Layer",
> > +     "Network Link Layer",
> > +     "Transport Link Layer",
> > +     "DME"
> > +};
>
> Why type u8 for strings instead of char?

Will use char instead in the next version.

>
> Please define arrays in .c files. Otherwise one copy of the array will
> be included in each source file this header file is included in.

Will move them to .c in the next version.

Thanks, Stanley



--=20
Yours truly,

=E6=9C=B1=E5=8E=9F=E9=99=9E (Stanley Chu)
