Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 783B6536775
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 21:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354396AbiE0T0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 15:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354117AbiE0T0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 15:26:18 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AAD710B
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 12:26:16 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id 135so5659535qkm.4
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 12:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20210112.gappssmtp.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-transfer-encoding:user-agent:mime-version;
        bh=G6b4VHTAM4bhr1qeJfjgThR4MDcHb/Fb1ERdo5Xb9Ik=;
        b=W/HrPyjahMm4XKGZc9+7n1p03LftQMndyai4tDNxJxUutyLiTpXLxyMSO6hx3+MYx8
         Z9v73UVhkR8hBRDiepUIqsS7dIEwk2GTJhGeA29+MBoSTLQ20wtDZbUANS5mfe1juPfW
         3zBG1z++lCTMMTND6Hv0I0dg8fD+nUSH0C7OS3T3CAst542iDFd6Ahx47MngBwRQlHC4
         20HynURDTifrwmB3aTLx5xG6oeOJL9tGq8EjWUNO4XfO/Z1TmS6AHh06Lj0xcRR+FeRe
         7Uo8PQ3Tg9xsES9SZpyiL4HLNiZscxh+x7Mfrae8BAWoux9oI3408osPV6YryvKQAnEr
         U0CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=G6b4VHTAM4bhr1qeJfjgThR4MDcHb/Fb1ERdo5Xb9Ik=;
        b=cAWPuFYJIqI5z5VPhlEwPTd9I1jwVAThOV2vVaATBHdeEjVlxVi3GybvL5DZMtvnlN
         hUUouPoZLstrPsuEUGRzPg0KdF51yyQ03Kh4Q0FHFzXNGWpzbQyA79MoX2T22IimFfLc
         3Fl/NYP35oup6VHJjSe+hHQaa4rHzWOdrmrE0Y6Sdan0dTM3Vvol8eTlGjG3ZDEAT5u0
         twfap+AXLYJrRNC6tUkAKFDKcDm3c7kXgP8HM4oq+Jb8q/L9pgDHkVFLm4lCPLlbvJt4
         KEkjorowhVm81+CZ/R9o2gaMvcHOp1E2uvJWAzk5MBBc2McrecaAoq5tXIO9MADfV0dg
         tMpA==
X-Gm-Message-State: AOAM5326UP+9Fe7zVDBvSWnhl8FpSanxGXsfKzeikuCri6a+EwRPwMP7
        lPJl/C6h3/2oiDis0beaF9DSEw==
X-Google-Smtp-Source: ABdhPJyAI5R9wYvBWLNcvQNrBosxG7C54X4ReS6SL/cc8NYsDgCPP/4vLmzo8r/gjN3XtNdTk/a1UQ==
X-Received: by 2002:a37:8a43:0:b0:699:fac5:224d with SMTP id m64-20020a378a43000000b00699fac5224dmr29317291qkd.599.1653679575602;
        Fri, 27 May 2022 12:26:15 -0700 (PDT)
Received: from nicolas-tpx395.localdomain (192-222-136-102.qc.cable.ebox.net. [192.222.136.102])
        by smtp.gmail.com with ESMTPSA id bq44-20020a05620a46ac00b006a33bee9a47sm3479852qkb.63.2022.05.27.12.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 May 2022 12:26:15 -0700 (PDT)
Message-ID: <02cbaf49474cbba446b6bdae77d5da950cce3e00.camel@ndufresne.ca>
Subject: Re: [EXT] Re: [PATCH v2] media: imx-jpeg: Leave a blank space
 before the configuration data
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Ming Qian <ming.qian@nxp.com>, Fabio Estevam <festevam@gmail.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Mirela Rabulea (OSS)" <mirela.rabulea@oss.nxp.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        linux-media <linux-media@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Date:   Fri, 27 May 2022 15:26:13 -0400
In-Reply-To: <AM6PR04MB6341CB4019E4F7077D3DCD54E7D89@AM6PR04MB6341.eurprd04.prod.outlook.com>
References: <20220527102444.19683-1-ming.qian@nxp.com>
         <CAOMZO5D-gUdoTx3hLmZE2EeYfun-g2xLx6J4tNTSZd-yKCLgXA@mail.gmail.com>
         <AM6PR04MB6341CB4019E4F7077D3DCD54E7D89@AM6PR04MB6341.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1 (3.44.1-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le vendredi 27 mai 2022 =C3=A0 11:33 +0000, Ming Qian a =C3=A9crit=C2=A0:
> > From: Fabio Estevam <festevam@gmail.com>
> > Sent: 2022=E5=B9=B45=E6=9C=8827=E6=97=A5 19:12
> > To: Ming Qian <ming.qian@nxp.com>
> > Cc: Mauro Carvalho Chehab <mchehab@kernel.org>; Mirela Rabulea (OSS)
> > <mirela.rabulea@oss.nxp.com>; Hans Verkuil <hverkuil-cisco@xs4all.nl>;
> > Shawn Guo <shawnguo@kernel.org>; Sascha Hauer <s.hauer@pengutronix.de>;
> > Sascha Hauer <kernel@pengutronix.de>; dl-linux-imx <linux-imx@nxp.com>;
> > linux-media <linux-media@vger.kernel.org>; linux-kernel
> > <linux-kernel@vger.kernel.org>; open list:OPEN FIRMWARE AND FLATTENED
> > DEVICE TREE BINDINGS <devicetree@vger.kernel.org>; moderated
> > list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE
> > <linux-arm-kernel@lists.infradead.org>
> > Subject: [EXT] Re: [PATCH v2] media: imx-jpeg: Leave a blank space befo=
re
> > the
> > configuration data
> >=20
> > Caution: EXT Email
> >=20
> > Hi Ming,
> >=20
> > On Fri, May 27, 2022 at 7:25 AM Ming Qian <ming.qian@nxp.com> wrote:
> > >=20
> > > There is a hardware bug that it will load the first 128 bytes of
> > > configuration data twice, it will led to some configure error.
> > > so shift the configuration data 128 bytes, and make the first 128
> > > bytes all zero, then hardware will load the 128 zero twice, and ignor=
e
> > > them as garbage.
> > > then the configuration data can be loaded correctly
> > >=20
> > > Signed-off-by: Ming Qian <ming.qian@nxp.com>
> > > Reviewed-by: Mirela Rabulea <mirela.rabulea@nxp.com>
> > > Reviewed-by: Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
> >=20
> > Fixes tag?
>=20
> Hi Fabio,
> =C2=A0=C2=A0=C2=A0=C2=A0It's a hardware issue, so I'm not sure is it a dr=
iver issue that I fix it.
> =C2=A0=C2=A0=C2=A0=C2=A0Or I just check which patch includes the code I c=
hanged, and add the fix
> tag?

You can use Fixes tag even though there was no software bug. The point of t=
he
tag is to help locate how far we can backport this patch in order to let st=
able
kernel users benefit.

regards,
Nicolas

>=20
> Ming

