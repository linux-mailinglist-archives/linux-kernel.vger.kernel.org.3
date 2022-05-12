Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3AC5244C1
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 07:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349494AbiELFQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 01:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349915AbiELFQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 01:16:24 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E8F21F62F;
        Wed, 11 May 2022 22:16:22 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id i17so3834230pla.10;
        Wed, 11 May 2022 22:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:content-transfer-encoding:date:message-id:cc:subject
         :from:to:references:in-reply-to;
        bh=o5r8j5DfRtmLS+iVKuwr6JvqFgR9CxOqwnqwvrWJx9w=;
        b=m/daO8WF7cexoTd4geHDhaMezghvuSRaTFPrdGvTuluSIepdWjVnfvL/TZbJUr3GDz
         /q8/JGjqwkqG/wowpueFJ2DRpwX8YcRFuiHrGc7ngDMHyK687V4hFwdWRbjCWrzNwJ/q
         +WrGgNv27agaVgQDMct1extVZfjV8Nxus4ZsaVOd8S042zqulV4dkwgSaRkStbjO4BkV
         hQZzensKfcpL78/LzZwFu2BItNJEmcgCqFqkcveJLrEKxR92CPxDhY5sILeM/ExvhNhk
         4lMRN9tQ3/JsBxw7U5COI+806D8fSFzLhphMpZPGatrrWYbzdaPsoVBwKQ9EhC9NUiHk
         qVIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:content-transfer-encoding:date
         :message-id:cc:subject:from:to:references:in-reply-to;
        bh=o5r8j5DfRtmLS+iVKuwr6JvqFgR9CxOqwnqwvrWJx9w=;
        b=snuWjQVaG13p8tE/eCUT+dmABVJ3T8kZQ6zvCGzwV55o/jc3vlUAHyatYz8rApR70o
         842SorkJFZX7llfJkrOxQ0/vf6L5oALNrRJlSgCcCh+oUYdVmvLZCWt301CbLgIwncum
         yG2DufstTkQnaH6okFXR75pRZl7lpX9aZkiudBW6AcMGte2c/rQHOUGBoBoP+4DorcyS
         bZMGnvortrNmH2k7v0Uw50Ls2xCyLhzF8x3wMM6Fdo4g+ckuxqAUsSVrkff3250xVbF9
         ByEgi2PjTqsLLiTstayrW35BKibT7MfggS4J0HbCBTLQPb4ncSIL9KXCI/CHAaFR3yIe
         /70Q==
X-Gm-Message-State: AOAM531R8bQwlLDsYeJf+J8t9gZTFTjA95egSfkPOQ6zQkYXbBGFN6ZG
        8vYSy5URo0KsUzRInCf7hG0=
X-Google-Smtp-Source: ABdhPJxsuLKd57Hz6gAd6v6A/NHHFlJvHr99DoDw5/Hx2C3VmQhaVRkb6NQsrtVOgQZ3fe5U5dGiOg==
X-Received: by 2002:a17:902:d2c9:b0:15e:a266:6472 with SMTP id n9-20020a170902d2c900b0015ea2666472mr28171958plc.45.1652332581734;
        Wed, 11 May 2022 22:16:21 -0700 (PDT)
Received: from localhost ([49.204.239.218])
        by smtp.gmail.com with ESMTPSA id t16-20020a170902e85000b0015e8d4eb2e1sm2857810plg.299.2022.05.11.22.16.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 May 2022 22:16:21 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 12 May 2022 10:46:16 +0530
Message-Id: <CJXJ0IIGOKN4.7V6UQ9ZFIX8I@skynet-linux>
Cc:     <linux-arm-msm@vger.kernel.org>,
        <~postmarketos/upstreaming@lists.sr.ht>,
        <bjorn.andersson@linaro.org>, <devicetree@vger.kernel.org>,
        <phone-devel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Andy Gross" <agross@kernel.org>,
        "Mathieu Poirier" <mathieu.poirier@linaro.org>
Subject: Re: [PATCH 2/9] remoteproc: qcom: q6v5-mss: Add modem support on
 MSM8953
From:   "Sireesh Kodali" <sireeshkodali1@gmail.com>
To:     "Dmitry Baryshkov" <dmitry.baryshkov@linaro.org>,
        <linux-remoteproc@vger.kernel.org>
X-Mailer: aerc 0.9.0
References: <20220511161602.117772-1-sireeshkodali1@gmail.com>
 <20220511161602.117772-3-sireeshkodali1@gmail.com>
 <1d43e1fa-30b2-dbf0-bfaf-f9cfaf987efb@linaro.org>
In-Reply-To: <1d43e1fa-30b2-dbf0-bfaf-f9cfaf987efb@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed May 11, 2022 at 10:24 PM IST, Dmitry Baryshkov wrote:
> On 11/05/2022 19:15, Sireesh Kodali wrote:
> > The modem on the MSM8953 platform is similar to the modem on the MSM899=
6
> > platform in terms of set up. It differs primarily in the way it needs S=
CM
> > to bless the MPSS firmware region.
> >=20
> > Signed-off-by: Sireesh Kodali <sireeshkodali1@gmail.com>
> > ---
> >   drivers/remoteproc/qcom_q6v5_mss.c | 64 +++++++++++++++++++++++++++--=
-
> >   1 file changed, 58 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/drivers/remoteproc/qcom_q6v5_mss.c b/drivers/remoteproc/qc=
om_q6v5_mss.c
> > index af217de75e4d..a73fdcddeda4 100644
> > --- a/drivers/remoteproc/qcom_q6v5_mss.c
> > +++ b/drivers/remoteproc/qcom_q6v5_mss.c
> > @@ -234,6 +234,7 @@ struct q6v5 {
> >  =20
> >   enum {
> >   	MSS_MSM8916,
> > +	MSS_MSM8953,
> >   	MSS_MSM8974,
> >   	MSS_MSM8996,
> >   	MSS_MSM8998,
> > @@ -687,12 +688,14 @@ static int q6v5proc_reset(struct q6v5 *qproc)
> >   		}
> >   		goto pbl_wait;
> >   	} else if (qproc->version =3D=3D MSS_MSM8996 ||
> > -		   qproc->version =3D=3D MSS_MSM8998) {
> > +		   qproc->version =3D=3D MSS_MSM8998 ||
> > +		   qproc->version =3D=3D MSS_MSM8953) {
> >   		int mem_pwr_ctl;
> >  =20
> >   		/* Override the ACC value if required */
> > -		writel(QDSP6SS_ACC_OVERRIDE_VAL,
> > -		       qproc->reg_base + QDSP6SS_STRAP_ACC);
> > +		if (qproc->version !=3D MSS_MSM8953)
> > +			writel(QDSP6SS_ACC_OVERRIDE_VAL,
> > +					qproc->reg_base + QDSP6SS_STRAP_ACC);
> >  =20
> >   		/* Assert resets, stop core */
> >   		val =3D readl(qproc->reg_base + QDSP6SS_RESET_REG);
> > @@ -734,7 +737,8 @@ static int q6v5proc_reset(struct q6v5 *qproc)
> >   		writel(val, qproc->reg_base + QDSP6SS_PWR_CTL_REG);
> >  =20
> >   		/* Turn on L1, L2, ETB and JU memories 1 at a time */
> > -		if (qproc->version =3D=3D MSS_MSM8996) {
> > +		if (qproc->version =3D=3D MSS_MSM8996 ||
> > +			qproc->version =3D=3D MSS_MSM8953) {
> >   			mem_pwr_ctl =3D QDSP6SS_MEM_PWR_CTL;
> >   			i =3D 19;
> >   		} else {
> > @@ -1314,7 +1318,16 @@ static int q6v5_mpss_load(struct q6v5 *qproc)
> >   			max_addr =3D ALIGN(phdr->p_paddr + phdr->p_memsz, SZ_4K);
> >   	}
> >  =20
> > -	/*
> > +	if (qproc->version =3D=3D MSS_MSM8953) {
> > +		ret =3D qcom_scm_pas_mem_setup(5, qproc->mpss_phys, qproc->mpss_size=
);
> > +		if (ret) {
> > +			dev_err(qproc->dev,
> > +					"setting up mpss memory failed: %d\n", ret);
> > +			goto release_firmware;
> > +		}
> > +	}
> > +
> > +	/**
>
> Single star please
>
> >   	 * In case of a modem subsystem restart on secure devices, the modem
> >   	 * memory can be reclaimed only after MBA is loaded.
> >   	 */
> > @@ -1413,7 +1426,6 @@ static int q6v5_mpss_load(struct q6v5 *qproc)
> >   			writel(RMB_CMD_LOAD_READY, qproc->rmb_base + RMB_MBA_COMMAND_REG);
> >   		}
> >   		writel(size, qproc->rmb_base + RMB_PMI_CODE_LENGTH_REG);
> > -
> >   		ret =3D readl(qproc->rmb_base + RMB_MBA_STATUS_REG);
> >   		if (ret < 0) {
> >   			dev_err(qproc->dev, "MPSS authentication failed: %d\n",
> > @@ -1422,6 +1434,7 @@ static int q6v5_mpss_load(struct q6v5 *qproc)
> >   		}
> >   	}
> >  =20
> > +
>
> Unnecessary
>

oops

> >   	/* Transfer ownership of modem ddr region to q6 */
> >   	ret =3D q6v5_xfer_mem_ownership(qproc, &qproc->mpss_perm, false, tru=
e,
> >   				      qproc->mpss_phys, qproc->mpss_size);
> > @@ -2198,6 +2211,44 @@ static const struct rproc_hexagon_res msm8996_ms=
s =3D {
> >   	.version =3D MSS_MSM8996,
> >   };
> >  =20
> > +static const struct rproc_hexagon_res msm8953_mss =3D {
> > +	.hexagon_mba_image =3D "mba.mbn",
> > +	.proxy_supply =3D (struct qcom_mss_reg_res[]) {
> > +		{
> > +			.supply =3D "pll",
> > +			.uA =3D 100000,
> > +		},
> > +		{}
> > +	},
> > +	.proxy_pd_names =3D (char*[]) {
> > +			"cx",
> > +			"mx",
> > +			NULL
> > +	},
> > +	.active_supply =3D (struct qcom_mss_reg_res[]) {
> > +		{
> > +			.supply =3D "mss",
> > +			.uV =3D 1050000,
> > +			.uA =3D 100000,
> > +		},
> > +		{}
> > +	},
> > +	.proxy_clk_names =3D (char*[]){
> > +			"xo",
> > +			NULL
> > +	},
> > +	.active_clk_names =3D (char*[]){
> > +			"iface",
> > +			"bus",
> > +			"mem",
> > +			NULL
> > +	},
> > +	.need_mem_protection =3D false,
> > +	.has_alt_reset =3D false,
> > +	.has_spare_reg =3D false,
>
>
> Please follow the custom  and define the rest of fields here.
>

I missed these in the rebase, I'll add them in v2

> > +	.version =3D MSS_MSM8953,
> > +};
> > +
> >   static const struct rproc_hexagon_res msm8916_mss =3D {
> >   	.hexagon_mba_image =3D "mba.mbn",
> >   	.proxy_supply =3D (struct qcom_mss_reg_res[]) {
> > @@ -2301,6 +2352,7 @@ static const struct of_device_id q6v5_of_match[] =
=3D {
> >   	{ .compatible =3D "qcom,msm8916-mss-pil", .data =3D &msm8916_mss},
> >   	{ .compatible =3D "qcom,msm8974-mss-pil", .data =3D &msm8974_mss},
> >   	{ .compatible =3D "qcom,msm8996-mss-pil", .data =3D &msm8996_mss},
> > +	{ .compatible =3D "qcom,msm8953-mss-pil", .data =3D &msm8953_mss},
> >   	{ .compatible =3D "qcom,msm8998-mss-pil", .data =3D &msm8998_mss},
> >   	{ .compatible =3D "qcom,sc7180-mss-pil", .data =3D &sc7180_mss},
> >   	{ .compatible =3D "qcom,sc7280-mss-pil", .data =3D &sc7280_mss},
>
>
> --=20
> With best wishes
> Dmitry

Thank you for the review, I'll make the changes in v2 of this patch.

Thanks,
Sireesh
