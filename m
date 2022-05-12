Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC878524A79
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 12:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352737AbiELKjZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 06:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350808AbiELKjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 06:39:24 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3105D5F8DE;
        Thu, 12 May 2022 03:39:23 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id x12so4219037pgj.7;
        Thu, 12 May 2022 03:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:content-transfer-encoding:date:message-id:from:to:cc
         :subject:references:in-reply-to;
        bh=QBcRVDUCAstZXZUhMrwdnOjMM/nNbvz+rqF7+qVRK/c=;
        b=WONYvkUlw3zVmgJJHku6BS1QH+bE/rAN9PylmVGoAdnUxM+ugZPKsTOCwgerpN0LdL
         etjkrmInEuPBwAKn7DzTWY8tAp/KzGtnjdPXHL4QaGoAVgrPyKzHIPvaFUFKGXrvSvFn
         J9bMPlYctKUwU0y0C1ZlT6mOj0/NqqdTBKlWtneqm/gK0GTE+YTBPKsF/YiYegFh6UJz
         wExZ7Q3jTgaS+jSbQH8Yzz/z2LUoVcKqeFHWEl9u7rT+otBig8+DOCy+O5ITV6WSWiHh
         galLjXiSNimGyRwTx31D1y6nSe2JAnvgmFeFzCdLSPTXD5TdJz3tLGX6g0sZMr/zM6B8
         eD0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:content-transfer-encoding:date
         :message-id:from:to:cc:subject:references:in-reply-to;
        bh=QBcRVDUCAstZXZUhMrwdnOjMM/nNbvz+rqF7+qVRK/c=;
        b=3ym2CBji7gKMHRgKJ3h7FtHDfZADK7bfoTIVqqp+mRQmTsxqqVu4JM8aMZjzNjVwMM
         SHIwZWjn1E1D97lVcEhcizqjIP1ndqtnktWcjlXh0FXr0rojBrlji4FjYmxGOS19D3pC
         ge9ZUK4B+68c3HWUi4kP/FdpuNZT6owLCw+mRouP1zuA7Q0s/Oa6o0LTdox3oRdiyVfX
         OY2Wp6SMgagFDTBlnWvK6vsK5X47SYyypL7nDtwPBP9TgP8x70d6htv94KIdGLBKI2BL
         Qc5y4A1WaUciE3tf8dirH3lOZZA4s96GG9An0AZO7OOAaWDg6UZ4VY0if2bcRcizXmUt
         bsLA==
X-Gm-Message-State: AOAM533i401J8zpCJOyflYWBn0270vmrofb6jnmAgIvx9Xvhb6/tqGqz
        425CWXNYm7/hr+NA2eOdKWg=
X-Google-Smtp-Source: ABdhPJxllMVvT2PI5ufTrBa28hri8fUM2Bc7cHcATgs3iVPN254oIsuU7aTeIbYUaviJCCqE0VCHBQ==
X-Received: by 2002:a65:43cc:0:b0:3c2:6d65:f1f0 with SMTP id n12-20020a6543cc000000b003c26d65f1f0mr24302902pgp.0.1652351962564;
        Thu, 12 May 2022 03:39:22 -0700 (PDT)
Received: from localhost ([49.204.239.218])
        by smtp.gmail.com with ESMTPSA id i2-20020aa796e2000000b0050dc76281fasm3436315pfq.212.2022.05.12.03.39.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 May 2022 03:39:22 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 12 May 2022 16:09:17 +0530
Message-Id: <CJXPVU06SN65.296G7A6NC7PTG@skynet-linux>
From:   "Sireesh Kodali" <sireeshkodali1@gmail.com>
To:     "Dmitry Baryshkov" <dmitry.baryshkov@linaro.org>,
        <linux-remoteproc@vger.kernel.org>
Cc:     <linux-arm-msm@vger.kernel.org>,
        <~postmarketos/upstreaming@lists.sr.ht>,
        <bjorn.andersson@linaro.org>, <devicetree@vger.kernel.org>,
        <phone-devel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Andy Gross" <agross@kernel.org>,
        "Mathieu Poirier" <mathieu.poirier@linaro.org>
Subject: Re: [PATCH 1/9] remoteproc: qcom: pas: Add MSM8953 ADSP PIL support
X-Mailer: aerc 0.9.0
References: <20220511161602.117772-1-sireeshkodali1@gmail.com>
 <20220511161602.117772-2-sireeshkodali1@gmail.com>
 <b86b5ba5-91ab-592a-5b4b-10dc738116ca@linaro.org>
In-Reply-To: <b86b5ba5-91ab-592a-5b4b-10dc738116ca@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed May 11, 2022 at 10:21 PM IST, Dmitry Baryshkov wrote:
> On 11/05/2022 19:15, Sireesh Kodali wrote:
> > Add support for the Audio DSP PIL found on the Qualcomm MSM8953
> > platform. The same configuration is used on all SoCs based on the
> > MSM8953 platform (SDM450, SDA450, SDM625, SDM632, APQ8053).
> >=20
> > Signed-off-by: Sireesh Kodali <sireeshkodali1@gmail.com>
> > ---
> >   drivers/remoteproc/qcom_q6v5_pas.c | 31 +++++++++++++++++++++++++++++=
+
> >   1 file changed, 31 insertions(+)
> >=20
> > diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qc=
om_q6v5_pas.c
> > index 1ae47cc153e5..4dcb714a1468 100644
> > --- a/drivers/remoteproc/qcom_q6v5_pas.c
> > +++ b/drivers/remoteproc/qcom_q6v5_pas.c
> > @@ -617,7 +617,37 @@ static const struct adsp_data sm8350_adsp_resource=
 =3D {
> >   	.ssctl_id =3D 0x14,
> >   };
> >  =20
> > +static const struct adsp_data msm8953_adsp_resource =3D {
> > +	.crash_reason_smem =3D 423,
> > +	.firmware_name =3D "adsp.mdt",
> > +	.pas_id =3D 1,
> > +	.has_aggre2_clk =3D false,
> > +	.auto_boot =3D true,
> > +	.proxy_pd_names =3D (char*[]){
> > +		"cx",
> > +		NULL,
> > +	},
> > +	.ssr_name =3D "lpass",
> > +	.sysmon_name =3D "adsp",
> > +	.ssctl_id =3D 0x14,
> > +};
> > +
>
> Also it looks like this item is identical to msm8996_adsp_resources. So=
=20
> you can existing structure instead.
>


Yes, the msm8953 item is identical to the msm8996_adsp_resource. I
wasn't aware that we could re-use structs like this, I will do that in
v2 of this patch

> >   static const struct adsp_data msm8996_adsp_resource =3D {
> > +	.crash_reason_smem =3D 423,
> > +	.firmware_name =3D "adsp.mdt",
> > +	.pas_id =3D 1,
> > +	.has_aggre2_clk =3D false,
> > +	.auto_boot =3D true,
> > +	.proxy_pd_names =3D (char*[]){
> > +		"cx",
> > +		NULL,
> > +	},
> > +	.ssr_name =3D "lpass",
> > +	.sysmon_name =3D "adsp",
> > +	.ssctl_id =3D 0x14,
> > +};
> > +
> > +static const struct adsp_data msm8998_adsp_resource =3D {
> >   		.crash_reason_smem =3D 423,
> >   		.firmware_name =3D "adsp.mdt",
> >   		.pas_id =3D 1,
> > @@ -850,6 +880,7 @@ static const struct adsp_data sdx55_mpss_resource =
=3D {
> >   static const struct of_device_id adsp_of_match[] =3D {
> >   	{ .compatible =3D "qcom,msm8974-adsp-pil", .data =3D &adsp_resource_=
init},
> >   	{ .compatible =3D "qcom,msm8996-adsp-pil", .data =3D &msm8996_adsp_r=
esource},
> > +	{ .compatible =3D "qcom,msm8953-adsp-pil", .data =3D &msm8953_adsp_re=
source},
> >   	{ .compatible =3D "qcom,msm8996-slpi-pil", .data =3D &slpi_resource_=
init},
> >   	{ .compatible =3D "qcom,msm8998-adsp-pas", .data =3D &msm8996_adsp_r=
esource},
> >   	{ .compatible =3D "qcom,msm8998-slpi-pas", .data =3D &slpi_resource_=
init},
>
>
> --=20
> With best wishes
> Dmitry

Thanks,
Sireesh
