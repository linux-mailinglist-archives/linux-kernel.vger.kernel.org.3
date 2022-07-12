Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3DDE571B61
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 15:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232808AbiGLNeR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 09:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233054AbiGLNeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 09:34:11 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F20375723B
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 06:34:09 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id nd6so2538323qvb.6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 06:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20210112.gappssmtp.com; s=20210112;
        h=message-id:subject:from:to:date:in-reply-to:references
         :content-transfer-encoding:user-agent:mime-version;
        bh=ACcVEjWAl0l8BCPeGNEBMR96Vi6sSgqEYdNkLpYgsf0=;
        b=xb8y8B0q4vFneb5wFxkhbTICKHFpaId6bsu7EZunPzwvjN9/LBwV+lPsydD5Eup8/h
         Dc5K0R2CZA/NVLTSUrnTQ0Qkpj61Q+aZvVZsI3RRq/d7o1EOS4w8mqlWpqv4N6+1RO43
         JziY3aVKbKZsF90XTDGFL1B3gyi07L3sYO2jzy04MbLdYtB3m08o1ZU9HCTYVS8DvGS5
         ljgMNkIuxbJWs6lvwRx5NWv6vKsZY+B8D7LxuZZNLgTbCl7Li3YO8QHcXkXC9k5Yzc2Q
         JUWu5eXkMFyraSVFKSQQ8DApGZlPNiqOq9iePUdnCCca3csa69dzwRDQF03OzC11abb5
         sjiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=ACcVEjWAl0l8BCPeGNEBMR96Vi6sSgqEYdNkLpYgsf0=;
        b=5AouMoJeR+QYeeLj6kDffF4CY7TxLnegbCW+ah2QgeX5zq/vhKrR7uPI6PGPKrgDuC
         UvVNbB42aRiu7TEJaY7PpYM9PT9mJyoCEIL1VxOavMxONSOju7qfDXnY4oKb/uBuJAvH
         QyJcb02PASnLFdOHM4KJOjIIChykE2llF00rbo0mkAjD7KkywW+L6lZhR8SgxnI8H1ni
         eBBrjXI3ly6gsYVThCqVUc4j1RDF9NCzNfqL4+hi43Ju3VfZjJr4e2cU2dENwuWgEzPg
         X8+Fi6rqHBwzxFqQV/UgvTPlZ2Q+LMytMWNippcy/jdc4tIxV9EsOqd/u1Wl3oHKsZuC
         nFqw==
X-Gm-Message-State: AJIora8cZnWIGkfIOVPMgTqsRDatrgvKlUe6Vz3wAWZEkiP9pIOlqJBo
        wxlnyMgE7GWXmD8Q8En936eM1A==
X-Google-Smtp-Source: AGRyM1tR9QQjMICvEvriS3rUrQeRvEnCkxrSDR9p9b3QC/NKJyXkOuzupjLq2xmjuWFbvpwWCe4AvA==
X-Received: by 2002:a0c:f3ce:0:b0:473:3c5:d378 with SMTP id f14-20020a0cf3ce000000b0047303c5d378mr17519526qvm.48.1657632848339;
        Tue, 12 Jul 2022 06:34:08 -0700 (PDT)
Received: from nicolas-tpx395.localdomain (192-222-136-102.qc.cable.ebox.net. [192.222.136.102])
        by smtp.gmail.com with ESMTPSA id g7-20020a05620a40c700b006b1490619cdsm9354056qko.99.2022.07.12.06.34.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 06:34:07 -0700 (PDT)
Message-ID: <b06c71d090ae7eaa3cd047bb0067f566371bac3a.camel@ndufresne.ca>
Subject: Re: [PATCH 1/7] venus : Add default values for the control
 V4L2_CID_COLORIMETRY_HDR10_MASTERING_DISPLAY
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Viswanath Boma <quic_vboma@quicinc.com>,
        video.upstream.external@qti.qualcomm.com,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 12 Jul 2022 09:34:06 -0400
In-Reply-To: <20220712122347.6781-1-quic_vboma@quicinc.com>
References: <20220712122347.6781-1-quic_vboma@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.2 (3.44.2-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mardi 12 juillet 2022 =C3=A0 17:53 +0530, Viswanath Boma a =C3=A9crit=C2=
=A0:
> From: Stanimir Varbanov <stanimir.varbanov@linaro.org>
>=20
>  V4l2 encoder compliance expecting default values of colormetry for the c=
ontrol.

nit: colormetry -> colorimetry

>=20
> Change-Id: I1db0d4940b54e033d646ce39d60dc488afba8d58
> Signed-off-by: Viswanath Boma <quic_vboma@quicinc.com>
> ---
>  drivers/media/platform/qcom/venus/venc_ctrls.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/media/platform/qcom/venus/venc_ctrls.c b/drivers/med=
ia/platform/qcom/venus/venc_ctrls.c
> index ea5805e71c143..37ba7d97f99b2 100644
> --- a/drivers/media/platform/qcom/venus/venc_ctrls.c
> +++ b/drivers/media/platform/qcom/venus/venc_ctrls.c
> @@ -352,6 +352,8 @@ static const struct v4l2_ctrl_ops venc_ctrl_ops =3D {
>  int venc_ctrl_init(struct venus_inst *inst)
>  {
>  	int ret;
> +	struct v4l2_ctrl_hdr10_mastering_display p_hdr10_mastering =3D { {34000=
, 13250, 7500 },
> +	{ 16000, 34500, 3000 }, 15635,	16450, 10000000, 500 };

What is the origin of these values ? Should this be done in the control
framework instead ?

> =20
>  	ret =3D v4l2_ctrl_handler_init(&inst->ctrl_handler, 58);
>  	if (ret)
> @@ -580,7 +582,7 @@ int venc_ctrl_init(struct venus_inst *inst)
> =20
>  	v4l2_ctrl_new_std_compound(&inst->ctrl_handler, &venc_ctrl_ops,
>  				   V4L2_CID_COLORIMETRY_HDR10_MASTERING_DISPLAY,
> -				   v4l2_ctrl_ptr_create(NULL));
> +				   v4l2_ctrl_ptr_create((void *)&p_hdr10_mastering));
> =20
>  	v4l2_ctrl_new_std(&inst->ctrl_handler, &venc_ctrl_ops,
>  			  V4L2_CID_MPEG_VIDEO_INTRA_REFRESH_PERIOD, 0,

