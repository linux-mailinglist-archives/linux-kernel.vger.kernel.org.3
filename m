Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83530504F89
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 13:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237212AbiDRLtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 07:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236879AbiDRLs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 07:48:57 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F15564D7;
        Mon, 18 Apr 2022 04:46:19 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-2eafabbc80aso136282027b3.11;
        Mon, 18 Apr 2022 04:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R+k5R+6Tf+kVP5/jwUVVJcqexRzi8y2ZOUAjpeAiUi4=;
        b=Ce5lUboHlt/gmpUKC++rrBFPSCnQ9wxILvj8LVkvjt0FOXtEEJUt8jEE2p/+9xEXrX
         AGEhhymndfCana7cViuokWV7Um9RmFBZjENGfgzG7eyBVYy62vB6s4ilKjGc+rfJXTQe
         pAqrR9cf3zEDv/Y0t39vAsx6ptucgIysTn7d0pEIcrOk4xjwsuyDMAt47QfQ5aaBQoug
         a7y+fNQYoNbUHae8C9QBgSzxRYnafMZjkFX1M7iI5OimZch5nzLHI8nJ7czhhtbBsmRJ
         0ppqCtGxFQHePbG1lMZToT2EfPEmBK6/TNedmw9WpRxcnxYpYQa6xqqeAj+2jcoMTrdX
         AfuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R+k5R+6Tf+kVP5/jwUVVJcqexRzi8y2ZOUAjpeAiUi4=;
        b=UKkpuM2cWrYTVHxM260/vuOkB4Ra5dzhD/iZzhplBAV3m1wfDi3mODpJh1/ork5+jD
         oSBHwOQQTNOednqjsegzoC8fKRDupZxNw8Xrtz/b80ZvRga2wEst8vdGnrfvpvgDgKzv
         vk/amL4VUxXsH2vytfSDJZwtlJA+8lSEDie+ZIJrAyfrA09xF/pyzkuYpfqwl2i9Beix
         eEszwtAw6BQYpvy6seWRRMkC6V3iQIcE2w3bu5W+g0TSOyajNXExnW7v7lK40zaoic2X
         RAc255am8R+KRRwH8/KMRbQaxBL7N0xJ0e0zROvdht76hlut349b/vCxOklqweqjitkX
         qT+g==
X-Gm-Message-State: AOAM5308aVQIwcX9zRyoavOMoxDgi7AQ0g7k0YwuzxdEDx+voQEq7tUd
        QJGWPUgyrGynML27hNVhab8ZcAF4LENTehIRGJrj1h1i1ztJJw==
X-Google-Smtp-Source: ABdhPJye5yqT98SnUYRLXzqx8takuFC8eq2pX1Rbb4eUcIiR85AzHfMDt6Qbgw4uG0I1YL+4XsFc6rnW3OecwaE1v5A=
X-Received: by 2002:a81:5904:0:b0:2eb:f900:882e with SMTP id
 n4-20020a815904000000b002ebf900882emr9347609ywb.281.1650282378263; Mon, 18
 Apr 2022 04:46:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220329094446.415219-1-tobetter@gmail.com> <CAMdYzYrCZtfDiB6O20Jtp56YQhHj3jMVhCt9aCYNLbD_xwFc3g@mail.gmail.com>
 <ff0135dc-da30-18b5-f5f4-cefdb0455c6b@kernel.org> <12089439.O9o76ZdvQC@phil> <d3cb233a-1962-af6b-2663-c057e7823a2b@kernel.org>
In-Reply-To: <d3cb233a-1962-af6b-2663-c057e7823a2b@kernel.org>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Mon, 18 Apr 2022 07:46:07 -0400
Message-ID: <CAMdYzYr6ONFiuA7dhYEdjTXHAN90=NBCEGK3gOY=BBLzf7P-4A@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: rockchip: Add Hardkernel ODROID-M1 board
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Heiko Stuebner <heiko@sntech.de>, Dongjin Kim <tobetter@gmail.com>,
        devicetree <devicetree@vger.kernel.org>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Mon, Apr 18, 2022 at 7:21 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On 17/04/2022 22:55, Heiko Stuebner wrote:
> >> Usually adding - in subsequent DTS files - means increasing the numbers
> >> so if you have regulator-[012] then just use regulator-[345] in other
> >> files. I see potential mess when you combine several DTSI files, each
> >> defining regulators, so in such case "some-name-regulator" (or reversed)
> >> is also popular approach.
> >
> > so going with
> >
> >       dc_12v: dc-12v-regulator {
> >       };
> >
> > i.e. doing a some-name-regulator would be an in-spec way to go?
> >
> > In this case I would definitely prefer this over doing a numbered thing.
> >
> > I.e. regulator-0 can create really hard to debug issues, when you have
> > another accidential regulator-0 for a different regulator in there, which
> > then would create some sort of merged node.
>
> I don't think such case happens frequently, because all regulators are
> usually used by something (as a phandle) thus they should have a label.
> This label should be descriptive, so if one can assign same label to
> entirely different regulators, then the same chances are that same
> descriptive node will be used.
>
> IOW, if you think such mistake with regulator names can happen, then the
> same can happen with the label...
>
> Anyway, answering the question - "dc-12v-regulator" is still not
> matching exactly the Devicetree spec recommendation, but it's okay for
> me. :)

This seems like an excellent compromise, thanks!

>
>
> Best regards,
> Krzysztof
