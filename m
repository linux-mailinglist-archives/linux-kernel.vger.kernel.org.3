Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4BB356A0E2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 13:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235330AbiGGLHP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 07:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235339AbiGGLHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 07:07:13 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B73857261;
        Thu,  7 Jul 2022 04:07:12 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id n4so12506373ejz.10;
        Thu, 07 Jul 2022 04:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to;
        bh=6ocG0Xck6UFoBCXVcbGriBvJ4wwbkS8brBEBVvGMITw=;
        b=Q2yYlLuje44TpclVgSV40km5glpOaMJdyo/383PQm3a9IBFllScYiQtCL7SSXU8Kyd
         SoonSUjN2nsr6pvWv5sR9dTISXyt8c5wrUDfXV9TVI/94QUYjDPsYkZQVuPqBiXLjQlA
         b3pxn0ZDOh86lp5bLj5AhZsZwDX74rqrij/V7ya5pc8i+s6Em0y5VoZ4i/GAskJ9o5ag
         ITAcZl+T/8N6Cojoh0l27LwY3A8S6IFRkUGkR5JvvTLhBJjPCt1vTFxoxbBN86jMejWy
         CQAvKG7J3Nps+X5HoYUVdDrhjU7/zocopakCohb7EaCJkNPeabxr51dUMII7PR3FeJsW
         w9Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=6ocG0Xck6UFoBCXVcbGriBvJ4wwbkS8brBEBVvGMITw=;
        b=V1fQ3CtP/e9cPQmYWoPibOzUhJC9DMxmJ6e4hV8ZQmZRGj7mrTNSZWLbRrR7n1LmPr
         vcf94+y5UfjFDA2niRCQPlWpIKramudbE4llCePkrvy/YfyfApAOXacxWKFFKk79h3Vp
         uzQoXvkChW0F66hLaNLrNP1VWRnqMXFjA1kCZmoFUN+IqOcZIvlHxgS4tOlP3tQMLu9E
         KJT4H7iYdv8PGwxepcjgzNb+6yklUpv50bgYo0ukZ25IXurB2nw1GMgd8sNXg7DnmY+v
         EBZRgI6Zoj85lt2CxEejAf0JEP4sUiJNf0cHHRegr0fI4JF8LruE0wgw2UIeeF7VFpuH
         uoSg==
X-Gm-Message-State: AJIora+xwGA5ddNFhGDizYSq0cHDC7XQhEnmxlRYroI0TmJSxSuly+5i
        ogJN7WA0v40Bos5UMePD9gKJKOCZi9A=
X-Google-Smtp-Source: AGRyM1u+zcwcFdgV64NNDm8xDWHGCRn3wAvvjYPPm/7cS6b3PQJu8+Hoee9dgWTuxyznISy6Q/Q4qA==
X-Received: by 2002:a17:907:75e1:b0:72a:ebee:5f61 with SMTP id jz1-20020a17090775e100b0072aebee5f61mr12017592ejc.171.1657192030969;
        Thu, 07 Jul 2022 04:07:10 -0700 (PDT)
Received: from Ansuel-xps. (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.gmail.com with ESMTPSA id g18-20020a17090604d200b006ff0b457cdasm647905eja.53.2022.07.07.04.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 04:07:10 -0700 (PDT)
Message-ID: <62c6be5e.1c69fb81.d194f.1258@mx.google.com>
X-Google-Original-Message-ID: <Ysa+XQPqiwJC7DIV@Ansuel-xps.>
Date:   Thu, 7 Jul 2022 13:07:09 +0200
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Baolin Wang <baolin.wang7@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        linux-arm-msm@vger.kernel.org,
        Devicetree List <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-remoteproc@vger.kernel.org
Subject: Re: [PATCH 1/3] hwspinlock: qcom: Add support for mmio usage to
 sfpb-mutex
References: <20220707013017.26654-1-ansuelsmth@gmail.com>
 <CADBw62o8HfH_MfbLP-=5qra9yjO34bUC__mZU1NDxqFALQZOmw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADBw62o8HfH_MfbLP-=5qra9yjO34bUC__mZU1NDxqFALQZOmw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 07, 2022 at 07:00:15PM +0800, Baolin Wang wrote:
> On Thu, Jul 7, 2022 at 9:30 AM Christian Marangi <ansuelsmth@gmail.com> wrote:
> >
> > Allow sfpb-mutex to use mmio in addition to syscon.
> >
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > ---
> >  drivers/hwspinlock/qcom_hwspinlock.c | 32 ++++++++++++++++++++++------
> >  1 file changed, 25 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/hwspinlock/qcom_hwspinlock.c b/drivers/hwspinlock/qcom_hwspinlock.c
> > index 364710966665..23c913095bd0 100644
> > --- a/drivers/hwspinlock/qcom_hwspinlock.c
> > +++ b/drivers/hwspinlock/qcom_hwspinlock.c
> > @@ -19,6 +19,11 @@
> >  #define QCOM_MUTEX_APPS_PROC_ID        1
> >  #define QCOM_MUTEX_NUM_LOCKS   32
> >
> > +struct qcom_hwspinlock_of_data {
> > +       u32 offset;
> > +       u32 stride;
> > +};
> > +
> >  static int qcom_hwspinlock_trylock(struct hwspinlock *lock)
> >  {
> >         struct regmap_field *field = lock->priv;
> > @@ -63,9 +68,20 @@ static const struct hwspinlock_ops qcom_hwspinlock_ops = {
> >         .unlock         = qcom_hwspinlock_unlock,
> >  };
> >
> > +static const struct qcom_hwspinlock_of_data of_sfpb_mutex = {
> > +       .offset = 0x4,
> > +       .stride = 0x4,
> > +};
> > +
> > +/* All modern platform has offset 0 and stride of 4k */
> > +static const struct qcom_hwspinlock_of_data of_tcsr_mutex = {
> > +       .offset = 0,
> > +       .stride = 0x1000,
> > +};
> > +
> >  static const struct of_device_id qcom_hwspinlock_of_match[] = {
> > -       { .compatible = "qcom,sfpb-mutex" },
> > -       { .compatible = "qcom,tcsr-mutex" },
> > +       { .compatible = "qcom,sfpb-mutex", .data = &of_sfpb_mutex },
> > +       { .compatible = "qcom,tcsr-mutex", .data = &of_tcsr_mutex },
> >         { }
> >  };
> >  MODULE_DEVICE_TABLE(of, qcom_hwspinlock_of_match);
> > @@ -101,7 +117,7 @@ static struct regmap *qcom_hwspinlock_probe_syscon(struct platform_device *pdev,
> >         return regmap;
> >  }
> >
> > -static const struct regmap_config tcsr_mutex_config = {
> > +static const struct regmap_config qcom_hwspinlock_mmio_config = {
> >         .reg_bits               = 32,
> >         .reg_stride             = 4,
> >         .val_bits               = 32,
> > @@ -112,18 +128,20 @@ static const struct regmap_config tcsr_mutex_config = {
> >  static struct regmap *qcom_hwspinlock_probe_mmio(struct platform_device *pdev,
> >                                                  u32 *offset, u32 *stride)
> >  {
> > +       const struct qcom_hwspinlock_of_data *data;
> >         struct device *dev = &pdev->dev;
> >         void __iomem *base;
> >
> > -       /* All modern platform has offset 0 and stride of 4k */
> > -       *offset = 0;
> > -       *stride = 0x1000;
> > +       data = of_device_get_match_data(dev);
> 
> Nit: better to validate the return value though this is a rare case.
> 
> if (!data)
>          return -ENODEV;
> 

Wonder if that can actually happen?

Looking at of_device_get_match_data() it can only return the data or
NULL if the match data is not defined but considering it should ALWAYS
be defined (or the driver can't work). But yhea should be a value to
check.

-- 
	Ansuel
