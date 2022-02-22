Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E26E4BFEFC
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 17:39:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234222AbiBVQjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 11:39:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232671AbiBVQjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 11:39:36 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E16B160412
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 08:39:11 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id p12-20020a05683019cc00b005af1442c9e9so6191496otp.13
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 08:39:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HUDPBUCCyZ+r0/t1fOspP5japV7Qp4b2ztEVMD6jnZQ=;
        b=bPO+4Uv2v8uNdCOhqot+RlJnrcS31qSjx9SM8Jtf53qMdfsGwEZcXdPmOQrCQ3Q8E1
         UrBGUZAFtzScTxO1X8CTsvH+RcH/PldVUq7pLfgX1KM85gw15RMlGZhF+D7tjhHBBr2Y
         wLrmWpBRNREY91sYWNwiECXwJU8+pGntyPa8fvHXd1xMQBX0KZUTBPKuPaAuA1eDtw5m
         RYCFMGmRDERWj0Xvg5nkxfvTQ3dyEkL/zjrB3NfUseWGOtJCAABcyTzJfPivRVOwlxA0
         C63VEQR5h9lJbLgmTx/6Bqud/ajcS03+UpiP0T0rruoCCRDomoETRsspg7ZNdMDqvsV0
         lxwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HUDPBUCCyZ+r0/t1fOspP5japV7Qp4b2ztEVMD6jnZQ=;
        b=inphBwvQY7To79L1+wbeJJBEr3rOL5t8NqjurwWkXvFWTm/d3XA+VaR1QdXZVtfLwm
         pIVAuX4njNu+lixfzPZoIua0ZpWCZjjAsvPYyAxxdl643ZPvrq2BLnBk9qbG3fOswXUi
         gkmROR3QnBofVQh1uvymghm+wvGIUYOK08wOWlY1Ezr1gZIuY2ij5AnOVCt/lq4krKX+
         NZFKisHtRZNtHisEyA/L05aWiWPusAafryhBhmwbZT9zJUe1aE05aAw0Te5LcWXPDLmt
         NrqhrcXPTfCc85JrG1vlcOn1j9oh23H7dKlj8j1g7LzwW8rwDq2MFEeinRBWQbNBG0Qx
         ZMRQ==
X-Gm-Message-State: AOAM5334egYQvBd2cl3IC7O2ydYeevsPwcPYlU5Un9gcr0wqRzRCoTYT
        goOcFi6BERc73HLFI7mf+W0+6zkVbOkK0iOKAPI=
X-Google-Smtp-Source: ABdhPJy48t44vEi7/215bq21/ShouYaMou6wewiEwkT80+ZUXpPpncs9g6wGqbMIp8lqU20r71y8DU04IFc9zAcU21o=
X-Received: by 2002:a9d:4a8:0:b0:5ad:35f8:31a6 with SMTP id
 37-20020a9d04a8000000b005ad35f831a6mr6847722otm.200.1645547950284; Tue, 22
 Feb 2022 08:39:10 -0800 (PST)
MIME-Version: 1.0
References: <20220222131701.356117-1-maira.canal@usp.br> <20220222131701.356117-8-maira.canal@usp.br>
In-Reply-To: <20220222131701.356117-8-maira.canal@usp.br>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 22 Feb 2022 11:38:59 -0500
Message-ID: <CADnq5_Nuc8UbGGqrWW=TDJh-3QzPQ7Ho5FCcuAHVz-qPpfbf4g@mail.gmail.com>
Subject: Re: [PATCH 07/10] drm/amd/display: Remove unused dmub_outbox_irq_info_funcs
 variable
To:     =?UTF-8?B?TWHDrXJhIENhbmFs?= <maira.canal@usp.br>
Cc:     "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        xinhui pan <Xinhui.Pan@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        John Clements <john.clements@amd.com>,
        Tao Zhou <tao.zhou1@amd.com>,
        "Chai, Thomas" <YiPeng.Chai@amd.com>,
        "Tuikov, Luben" <luben.tuikov@amd.com>,
        "Stanley.Yang" <Stanley.Yang@amd.com>,
        Dennis Li <Dennis.Li@amd.com>,
        "Joshi, Mukul" <mukul.joshi@amd.com>,
        "Wentland, Harry" <harry.wentland@amd.com>,
        "Leo (Sunpeng) Li" <sunpeng.li@amd.com>,
        "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
        Anthony Koo <Anthony.Koo@amd.com>,
        Magali Lemes <magalilemes00@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, mwen@igalia.com,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Isabella Basso <isabbasso@riseup.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Tue, Feb 22, 2022 at 8:18 AM Ma=C3=ADra Canal <maira.canal@usp.br> wrote=
:
>
> Remove the unused struct irq_source_info_funcs
> dmub_outbox_irq_info_funcs from the file, which was declared but never
> hooked up.
>
> This was pointed by clang with the following warning:
>
> drivers/gpu/drm/amd/amdgpu/../display/dc/irq/dcn201/irq_service_dcn201.c:=
141:43:
> warning: unused variable 'dmub_outbox_irq_info_funcs'
> [-Wunused-const-variable]
> static const struct irq_source_info_funcs dmub_outbox_irq_info_funcs =3D =
{
>                                           ^
>
> Signed-off-by: Ma=C3=ADra Canal <maira.canal@usp.br>
> ---
>  .../gpu/drm/amd/display/dc/irq/dcn201/irq_service_dcn201.c   | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn201/irq_service_dcn201=
.c b/drivers/gpu/drm/amd/display/dc/irq/dcn201/irq_service_dcn201.c
> index aa708b61142f..45f99351a0ab 100644
> --- a/drivers/gpu/drm/amd/display/dc/irq/dcn201/irq_service_dcn201.c
> +++ b/drivers/gpu/drm/amd/display/dc/irq/dcn201/irq_service_dcn201.c
> @@ -138,11 +138,6 @@ static const struct irq_source_info_funcs vupdate_no=
_lock_irq_info_funcs =3D {
>         .ack =3D NULL
>  };
>
> -static const struct irq_source_info_funcs dmub_outbox_irq_info_funcs =3D=
 {
> -       .set =3D NULL,
> -       .ack =3D NULL
> -};
> -
>  #undef BASE_INNER
>  #define BASE_INNER(seg) DMU_BASE__INST0_SEG ## seg
>
> --
> 2.35.1
>
