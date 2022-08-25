Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 295565A1A92
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 22:51:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241200AbiHYUvD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 16:51:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbiHYUvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 16:51:00 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79DC26110E
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 13:50:59 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id u5so18244107wrt.11
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 13:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=ycn3CsR1iWHNGED1GDVpfA/87x3QqwpXsbLUpADdraQ=;
        b=bol+gBDkBo1VMcISuBNdzLclSLVqvh573NNoMjLdlmP1yyj8f3MJeT6AboKjeaiSGI
         0/daGmDLQG/9OA1SJMF0LsBovpJE9BAgUAef48cuzfISAD1S1aTihSF7JGeM/7OO7DQD
         495EdzxTgDFvKHDf88ckMc/sjafE7lrIbmzTjE6jIQ3+rBeiYo6RrCGXeWUdi9zhs6G+
         eb5nBvRRaCKnmB5NC1JUyulCkN+kIiK1VRIXYV4J6ZF8hFNL5s1Ydlm2G23LHlf4+Pwc
         xfK74m0plG+MNfq+AWuQxeh7OpVObn5S+rIY9DHRS+sIHPa2mhubXcvBVfJcbWlQLSH3
         PZXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=ycn3CsR1iWHNGED1GDVpfA/87x3QqwpXsbLUpADdraQ=;
        b=HsupJQL5QVg2yK/JM0wJ9xF5LoKaU5fXqhwGtXknIIPZFEPi+k+MTrSg0ZaJRn0JQ7
         ul+SSdzIOpVhHYwSU2rNXbphT0o9FrtKhBJNrQkVA88othvK3dQ2fab6d1vV9txm20Vn
         XRkK+ceZpFSc25PabKCMcnvnCPVrlJVd9W/Y/vRCTxbTSwnpPfrPcDs0USItaCRcfrVh
         Rwm3Ynkb4Q6BQ9UIQ6zNSq5Dt5Jg8aEfjtqgK7lO3uGSmUIFMqMPyv7W0avMHQcI9UKJ
         Una8EyHpjVj6rMDkOmXnHjiV/wrnZV+68tuXn7dKy/Hb6c9sMsqGIgPbFlkNOLYrRSrR
         EBow==
X-Gm-Message-State: ACgBeo14S+66hvNltALRlbxg9gFgXQSwJaV555NLAyXbTVvvwesRnW5a
        PBzBE8QCsG1oHXme0/mot2WFEDwLs6mmWg==
X-Google-Smtp-Source: AA6agR6zAtMnvY10hfD6sffzNF0D5ClJkG/OeP4X0NXPmQeTBXTYIB0Lw/Fj0n9D5VwM2LHQte9fWA==
X-Received: by 2002:a05:6000:144c:b0:222:c5db:6caa with SMTP id v12-20020a056000144c00b00222c5db6caamr3190372wrx.421.1661460658024;
        Thu, 25 Aug 2022 13:50:58 -0700 (PDT)
Received: from kista.localnet (82-149-1-172.dynamic.telemach.net. [82.149.1.172])
        by smtp.gmail.com with ESMTPSA id n4-20020a05600c3b8400b003a608d69a64sm6356134wms.21.2022.08.25.13.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 13:50:57 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     yong.deng@magewell.com, mchehab@kernel.org, wens@csie.org,
        samuel@sholland.org, wangjianli <wangjianli@cdjrlc.com>
Cc:     linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        wangjianli <wangjianli@cdjrlc.com>
Subject: Re: [PATCH] sunxi/sun6i-csi: fix repeated words in comments
Date:   Thu, 25 Aug 2022 22:50:56 +0200
Message-ID: <3184312.aeNJFYEL58@kista>
In-Reply-To: <20220823143820.29860-1-wangjianli@cdjrlc.com>
References: <20220823143820.29860-1-wangjianli@cdjrlc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne torek, 23. avgust 2022 ob 16:38:20 CEST je wangjianli napisal(a):
> Delete the redundant word 'the'.
>=20
> Signed-off-by: wangjianli <wangjianli@cdjrlc.com>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
>  drivers/media/platform/sunxi/sun6i-csi/sun6i_video.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_video.c
> b/drivers/media/platform/sunxi/sun6i-csi/sun6i_video.c index
> 682c26536034..fac004389b6b 100644
> --- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_video.c
> +++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_video.c
> @@ -177,7 +177,7 @@ static int sun6i_video_start_streaming(struct vb2_que=
ue
> *vq, unsigned int count)
>=20
>  	/*
>  	 * CSI will lookup the next dma buffer for next frame before the
> -	 * the current frame done IRQ triggered. This is not documented
> +	 * current frame done IRQ triggered. This is not documented
>  	 * but reported by Ond=C5=99ej Jirman.
>  	 * The BSP code has workaround for this too. It skip to mark the
>  	 * first buffer as frame done for VB2 and pass the second buffer
> --
> 2.36.1


