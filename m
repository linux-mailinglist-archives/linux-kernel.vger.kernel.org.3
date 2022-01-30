Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81C8D4A3319
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 02:43:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353711AbiA3BnT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 20:43:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234657AbiA3BnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 20:43:09 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D327AC061714
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 17:43:08 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id k17so29808420ybk.6
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 17:43:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l4WivkdTm53Jw9l1J9ROUjCL84RYPC3TVleYiM5qsF8=;
        b=XUEW8qHU1uz45LsjpBiB2OtdsXRM3uS0slep4OE62Wgdo0fh87Jt7qZm078mNkVC06
         VbHLOljIs5JDsbc02chw8GA0e6bIciURxOFiajehMm2Q8oxEwNBtbzGrORyItKFWGI6H
         Ye1fL+MexX77wjLVdZ7lqUXnlCDt5SebBTes6Ins34GxE58D+p3qVYQu+tOLavM5VpQK
         rA7b/RipQFpGUC6/+Xqn6380ypXhHgPdO6NTvZErfpv0tstvxosanB61IbGwwBK0ZDTh
         nYvLLAFxuehucXzc48vgeBq7cr2+68i4yJNjLpdpChOCWFS3f0EqEDybWoxzc1cUPvdb
         Vtzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l4WivkdTm53Jw9l1J9ROUjCL84RYPC3TVleYiM5qsF8=;
        b=XQBcnsYDeH/87aCeLLr41Mkb36RNBfr6ksDCqiz6ersBz/bqSGSU9gE7YLAa6kp8fe
         N0OD0pb+O0C40uWOXElZ4KP0DRcr3j9Nvh3MWUbRhU56LH9HbzJDoNRQlmm96W8QK8ZL
         1fqbbmUJ6ci1wraZemwQk58H1jUlD/wqehUUJaMUspMEMp5uJd1gc5OoqqA7l1HcfWUu
         j0ZveXRs93wSCbRRM4VGB/bmc+QvOuPQx/kurvQ79gYanlvVHaWHK5TWIyb0mX/Cpu4y
         +hnsb+EkeKPH9IsFSl0TbOK4dau787OmWs0ubbG5TX0byMOzr76E2ao874Y/HzM23eRv
         zzsg==
X-Gm-Message-State: AOAM530g3IEr7OKq+Q3FHazn+tDxvCDOupQkYCX1ZRXaHez4H0iLJXZ9
        IOJ5GVfTmMTO+RRFcD2XBOv814BzCH19sKPNiBMrEw==
X-Google-Smtp-Source: ABdhPJwr7mIRo9eScUWXPNLILmR+M08O5ZXFiaTInfMDPkK1vK9GuO1CV/W55bipWFRtdTE5YMsvnDS2LnCQ+FgAbec=
X-Received: by 2002:a05:6902:124a:: with SMTP id t10mr20339897ybu.634.1643506988111;
 Sat, 29 Jan 2022 17:43:08 -0800 (PST)
MIME-Version: 1.0
References: <20220121060120.10683-1-guodong.liu@mediatek.com>
In-Reply-To: <20220121060120.10683-1-guodong.liu@mediatek.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 30 Jan 2022 02:42:57 +0100
Message-ID: <CACRpkdaL_cUj2rbQUSzVj+ViEuNWiQbsakChNkaj6FK+fE76FA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] pinctrl: mediatek: Support pinctrl driver on mt8186
To:     Guodong Liu <guodong.liu@mediatek.com>,
        Chen-Yu Tsai <wenst@chromium.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        Sean Wang <sean.wang@mediatek.com>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 21, 2022 at 7:01 AM Guodong Liu <guodong.liu@mediatek.com> wrote:

> changes since v1:
> - add default pinctrl config to consistent with other MTK pinctrl drivers
>
> Patch 1 add pinctrl file and binding document.
>
> Patch 2 add pinctrl chip driver on mt8186.
>
> Guodong Liu (2):
>   dt-bindings: pinctrl: mt8186: add pinctrl file and binding document
>   pinctrl: add pinctrl driver on mt8186

Looks good to me, just wanna loop this by Chen-Yu Tsai for a check that
it looks good to him too.

Yours,
Linus Walleij
