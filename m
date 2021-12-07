Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04D2146BB99
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 13:47:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236618AbhLGMu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 07:50:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235539AbhLGMu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 07:50:27 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F38D0C061574
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 04:46:56 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id y13so56394509edd.13
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 04:46:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x/xq6H3+Gju35XXL9JxKNpaAa8BNxCgs3E1gWrMLGFY=;
        b=lbM1p/y1iMGtUPc/ZRGftnmNQ4xf7kzFNEXCCH5czc3tsImvVr4O549nFcX0I6xBl5
         WNhRZRK+RvejAwQnsBEbSNq6Yfwz1m0IPgZOds3Mj9Po9Zb2KwrszL1YdGjOhTm7S24U
         n5FGaXYDCuzT94MVSl0GFK17PPVJqE6XPD1+Y8CyytOCq7tf//hsFck2aam+DiANtTwx
         aAft+fBSp43+Wh57XGr2cs8f1JbhdJ2s+/3ty5Bo0i/tGvUUBZUYUVOeWgLPMVKYTqjR
         oOs/E7lV7d4050nMGuCfMc78sC67r9MPeUSNiCfKetb/3uGQdHPwVX4pbVOPgHui+oDh
         kUNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x/xq6H3+Gju35XXL9JxKNpaAa8BNxCgs3E1gWrMLGFY=;
        b=BJ9epCgWBFLor4kwZNEBLHOyUNj0rjaACkOr8I5eoYgqFf2V5kCSqLoLcZBao2xQXh
         41PpOlqwUjyYd64WQlYo1u0wDTTY2m+0B2a+uaewp7T5o343oxiuEcq6uqOpaQAePqQA
         3ys9pBFkIE2cEXk/i8oXq+QQ4nzxsZzzNiID4/xhUfLjmFNdbahKlJVIPbkPCa8Wjpsm
         OVbGyHnH2xe/RKJhTANeI65HD87jTfIrwSDnUpYxsEP+/nUW92dG2L7zIVLmgLMIbKev
         NyybnD9IkEyZW2Ck16IisPreeJAvRSaBIWSp3WBcgTqVnXiKxOV6AEB4YC+e0AxulUPh
         PXUQ==
X-Gm-Message-State: AOAM530s//j9vfSVVB2bcTVo1Y+bKjj7at7R64wEjjEWErtwN+keGYaZ
        i0K/N0faThk5YwSfcYWgeMiiTF61Z958Ca7zy57C3w==
X-Google-Smtp-Source: ABdhPJw03qJnubMJy1q++3pwo7aYIWoOdaeknS4l22gDeU0RBVT4dOMGDF0SN4xhH5Q0iALJ5Y62jw6SC7JtlLqBeM4=
X-Received: by 2002:a17:906:3b84:: with SMTP id u4mr51654598ejf.310.1638881215471;
 Tue, 07 Dec 2021 04:46:55 -0800 (PST)
MIME-Version: 1.0
References: <20210825063323.3607738-1-eizan@chromium.org> <20210825163247.v7.2.Ie6d1e6e39cf9b5d6b2108ae1096af34c3d55880b@changeid>
 <CAAEAJfDNDXdJFfB-bHhFcqnnKZ0TY--d_wLGddKRymQOLQY4TQ@mail.gmail.com>
 <fc309940c9e59f80397b90c8b11424fea344e1b5.camel@mediatek.com> <a0b3a10d-9313-7ac5-692c-822aeff50858@xs4all.nl>
In-Reply-To: <a0b3a10d-9313-7ac5-692c-822aeff50858@xs4all.nl>
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Date:   Tue, 7 Dec 2021 09:46:44 -0300
Message-ID: <CAAEAJfDOU+tCjm=B8Mg0esZf=e99MM1cv+8SUN6sCBKq0hVvZw@mail.gmail.com>
Subject: Re: [PATCH v7 2/7] mtk-mdp: add driver to probe mdp components
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     houlong wei <houlong.wei@mediatek.com>,
        Eizan Miyamoto <eizan@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        =?UTF-8?B?WW9uZyBXdSAo5ZC05YuHKQ==?= <Yong.Wu@mediatek.com>,
        "wenst@chromium.org" <wenst@chromium.org>,
        =?UTF-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        =?UTF-8?B?WW9uZ3FpYW5nIE5pdSAo54mb5rC45by6KQ==?= 
        <yongqiang.niu@mediatek.com>,
        =?UTF-8?B?QW5kcmV3LUNUIENoZW4gKOmZs+aZuui/qik=?= 
        <Andrew-CT.Chen@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        =?UTF-8?B?TWluZ2hzaXUgVHNhaSAo6JSh5piO5L+uKQ==?= 
        <Minghsiu.Tsai@mediatek.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-media <linux-media@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

On Tue, 7 Dec 2021 at 09:37, Hans Verkuil <hverkuil@xs4all.nl> wrote:
>
> On 9/5/21 6:23 PM, houlong wei wrote:
> > Hi Ezequiel,
> >
> > Thank you for your attention to this series of patches. I answer partial of your questions below.
> > Regards,
> > Houlong
> >
> > On Sat, 2021-09-04 at 20:34 +0800, Ezequiel Garcia wrote:
> >> Hi Eizan,
> >>
> >> Sorry for seeing this series so late.
> >>
> >> On Wed, 25 Aug 2021 at 03:35, Eizan Miyamoto <eizan@chromium.org>
> >> wrote:
> >>>
> >>> Broadly, this patch (1) adds a driver for various MTK MDP
> >>> components to
> >>> go alongside the main MTK MDP driver, and (2) hooks them all
> >>> together
> >>> using the component framework.
> >>>
> >>> (1) Up until now, the MTK MDP driver controls 8 devices in the
> >>> device
> >>> tree on its own. When running tests for the hardware video decoder,
> >>> we
> >>> found that the iommus and LARBs were not being properly configured.
> >>
> >> Why were not being properly configured? What was the problem?
> >> Why not fixing that instead?
> >>
> >> Does this mean the driver is currently broken and unusable?
> >
> > This series of patches are supplements to another series, please refer
> > to
> > https://patchwork.kernel.org/project/linux-mediatek/list/?series=515129c
> > , which add device link between the mtk-iommu consumer and the mtk-larb
> > devices. Without that series of patches, the mtk-mdp driver can work
> > well so far.
> > But with that series, it seems the device link only can be established
> > for the device which is registered as a platform driver. That's why
> > Eizan adds this series of patches to make all mdp components to be
> > registered as platform drivers.
>
> Hold on, so this means that if that iommu device-link series is merged,
> then the mtk-mdp driver breaks? I posted a PR for that iommu series, but
> I've just withdrawn that PR until this issue is clarified.
>
> Is it only mtk-mdp that is affected by this iommu device-link series, or
> others as well?
>

Like I said before, I think it's a mistake to introduce the component
framework in V4L2. This whole idea looks like a hack to me.

If we merge this, then we validate using the component framework
as a way to avoid fixing things properly.

Regards,
Ezequiel
