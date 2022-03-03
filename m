Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3217B4CB890
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 09:18:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231238AbiCCITh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 03:19:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbiCCITf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 03:19:35 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 089A11712B5
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 00:18:50 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id j15so7037286lfe.11
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 00:18:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=on4cm3w97gy7RevnM2fAc8kCbBYemQ93B0MGug+f2Sw=;
        b=HbmOUBeULRAj4VjhmZVI3EKmNdxqiWcxb0dr+4Kpd3Uum3VcFHkK4pe8+KHgkMhEwG
         XEhHYFpvjPm4aiqP904xnKALwPNGd2RH8l59cDmlnI68h8iSOcWWegi1H5Ir8tSZAbFc
         m61+tI1InDj0JEM9IXyUtSFpJN7s4yoRuKDdc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=on4cm3w97gy7RevnM2fAc8kCbBYemQ93B0MGug+f2Sw=;
        b=d8LH1qcLwNAGLIehQbnwpLDF2zOajsRUCG2ya9oNC8ykm1bJ/7sfnu5LbiV25MEqtP
         MdNcukRKlYJIFNbxZWgjjFBD2lXsvA9gA90ZMqY9eJv0qxZQM21bdP56kLuMznqDQS+g
         OeHjv+EZu9hYVppI4BfihCA/Tw1MCkAFOJ40FrPnwZaGGPhTFrE6qcnbV/ra7jegWhCE
         0LgwGrGnA47l4PRSvMDoiV3UHGmV99pG1S9d6EI63ENdJNxEY5L6iRyNXc6uJqU59EPo
         ti4lRo42R0dgxQy3yC/Wd0+WXC1z815UBxi1rxQzyp+9kkIQLWnQi/HxZ91tNIRYHrI/
         KKAw==
X-Gm-Message-State: AOAM532pjJ5UqcUuBchnzzmHJXKiJ5RL/G8mZA05rwNMvnSR/nJ6doQX
        ZmQMZNQd98d2EsL3wt9VpNfZs3b925W6YWnX76jpE5gE2Ap8/WMG
X-Google-Smtp-Source: ABdhPJz7qOkcs9NrVpx+qNqlVj4sTQvZ7OlQDyiM5QuV1qHK2lks0edta7sb7odh4BSvah8kBcAyY+1/w97q+jW/l1Q=
X-Received: by 2002:ac2:5fc2:0:b0:443:82cf:9603 with SMTP id
 q2-20020ac25fc2000000b0044382cf9603mr20717684lfg.142.1646295528442; Thu, 03
 Mar 2022 00:18:48 -0800 (PST)
MIME-Version: 1.0
References: <20220106065407.16036-1-johnson.wang@mediatek.com>
 <20220106065407.16036-5-johnson.wang@mediatek.com> <Yd4yy2emxSSh80UW@robh.at.kernel.org>
In-Reply-To: <Yd4yy2emxSSh80UW@robh.at.kernel.org>
From:   Fei Shao <fshao@chromium.org>
Date:   Thu, 3 Mar 2022 16:18:12 +0800
Message-ID: <CAJ66y9F67VNRWE3JsCqnX4AFzd+R9Y9WJHoxnk_t7u2rHhuimg@mail.gmail.com>
Subject: Re: [PATCH 4/4] dt-bindings: regulator: Add MT6358 regulators
To:     Rob Herring <robh@kernel.org>
Cc:     Johnson Wang <johnson.wang@mediatek.com>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        broonie@kernel.org, linux-kernel <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jan 2022 19:45:47 -0600, Rob Herring <robh@kernel.org> wrote:
>
> On Thu, 06 Jan 2022 14:54:07 +0800, Johnson Wang wrote:
> > Add buck_vcore_sshub and ldo_vsram_others_sshub
> > regulators to binding document for MT6358 and MT6366.
> >
> > Signed-off-by: Johnson Wang <johnson.wang@mediatek.com>
> > ---
> >  .../bindings/regulator/mt6358-regulator.txt   | 22 ++++++++++++++-----
> >  1 file changed, 17 insertions(+), 5 deletions(-)
> >
>
> Reviewed-by: Rob Herring <robh@kernel.org>

Just a gentle ping on this - I assume there's no actionable item on
Johnson's end? (or better to rebase & resend?)
