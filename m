Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F404146B9D3
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 12:10:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235605AbhLGLNn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 06:13:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230496AbhLGLNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 06:13:42 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80E2BC061574;
        Tue,  7 Dec 2021 03:10:12 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id i5-20020a05683033e500b0057a369ac614so17570632otu.10;
        Tue, 07 Dec 2021 03:10:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8SWjF/mvYUi96YW/yOYz6zpmbfKxdf4QHUyiOXcjlos=;
        b=kb7KrexBhhpj/qI91b9j0cz8UR21yiE0Pi4E/oW4PnaRAygMAqGN6k0932ze0Kx+y1
         rbrK8yWDf8hlakNmXLDrvHWvQ61BShN83pVxuYVk59jT/64/AA44RkOl0TXYdIUtw4jW
         txQCeyPSYWQ9IoJVTJzYLcJgNQPLCpLOyDE0nnaCat/I9V368n1gC//XJsHIRLEb57UX
         QsaBxTiigmvT2DM/9EUMFujg2XbwjtSThfP95pwLCN34z/kjpSubee7HhjhIGbLMk+5P
         1sxUgUZwvkg6XWq7rhWohb0rvD8vs7AMCyi49OnKpmgVSpacIY8Oa6Z8Js6YN7MgP6cW
         oIzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8SWjF/mvYUi96YW/yOYz6zpmbfKxdf4QHUyiOXcjlos=;
        b=OFenA4iAfdU2HmWpOnO5VRJXwlUgIsY2TUEBGRNuoHukZiDOR8I+mWTGOPujHvlgv/
         egq4T3teYSBUGOeq8GTX6+8TSJQS7a5Eom/6pOwj/bShKvJHTWVSyY5kypyQO397A7zl
         KFlYCcIE/3oi8BRoTGz00D9+mK8aUHxgJnwMCbosaYtdMxY1n/1VrN21vyoQF4cHiSUS
         0LP0P+bgWTvltVcCiToRjeKZR20CmdvFOgzRY3OIKS4kb4Ov1szl7VO6fDlb3GvfKp9c
         FzhHv+1Z4kJTSeaB24CMNf/x/4m9bswoE2TwltuN1x/Ve1XtqdzhYyEBaAyP2ucxkfcg
         9G/A==
X-Gm-Message-State: AOAM532cJ9HSPlrIyuc+ilDPS770nWy9CfShYIl2BnCYWTD0mxypiRe2
        9K2cj+ZCfru+PyPF12wtN7oh/iExuvEiEwahk0KIklpWWvm9vr9T3qk=
X-Google-Smtp-Source: ABdhPJwWDhc8eCX1v5p+Mwb0dVGvvKvjNkUFLyoptJyzJwQTf/6PU0lOjh0PWm0v10cjeNzJHb93rfG6h46dMXehGs0=
X-Received: by 2002:a05:6830:22f1:: with SMTP id t17mr34798633otc.39.1638875411810;
 Tue, 07 Dec 2021 03:10:11 -0800 (PST)
MIME-Version: 1.0
References: <20211205131503.4122955-1-siyanteng@loongson.cn> <Ya4PBDWwnZ89/xqO@sirena.org.uk>
In-Reply-To: <Ya4PBDWwnZ89/xqO@sirena.org.uk>
From:   yanteng si <siyanteng01@gmail.com>
Date:   Tue, 7 Dec 2021 19:10:00 +0800
Message-ID: <CAEensMyMf=x7xv4AiOf+NQWF5e4BVQ5+1-0dufm+vnKNx4XW2A@mail.gmail.com>
Subject: Re: [PATCH] regulato: remove unnecessary indentation from driver.h's comments
To:     Mark Brown <broonie@kernel.org>
Cc:     lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Huacai Chen <chenhuacai@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Brown <broonie@kernel.org> =E4=BA=8E2021=E5=B9=B412=E6=9C=886=E6=97=A5=
=E5=91=A8=E4=B8=80 21:24=E5=86=99=E9=81=93=EF=BC=9A
>
> On Sun, Dec 05, 2021 at 09:15:03PM +0800, Yanteng Si wrote:
>
> >   *   REGULATOR_SEVERITY_PROT should automatically shut down the regula=
tor(s).
> >   *   REGULATOR_SEVERITY_ERR should indicate that over-current situatio=
n is
> > - *           caused by an unrecoverable error but HW does not perform
> > - *           automatic shut down.
> > - *   REGULATOR_SEVERITY_WARN should indicate situation where hardware =
is
> > - *           still believed to not be damaged but that a board sepcifi=
c
> > - *           recovery action is needed. If lim_uA is 0 the limit shoul=
d not
> > - *           be changed but the detection should just be enabled/disab=
led as
> > - *           is requested.
> > + *   caused by an unrecoverable error but HW does not perform automati=
c shut
> > + *   down.
> > + *   REGULATOR_SEVERITY_WARN should indicate situation where hardware =
is still
>
> This is obviously making things worse - it's creating inconsistent
> indentation within the list.
Sorry, I will try to fix it in the right way=E3=80=82

Thanks,
Yanteng
