Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 128A753FB20
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 12:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240942AbiFGKZP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 06:25:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240996AbiFGKZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 06:25:07 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A23405DA5A
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 03:25:06 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id a30so11620897ybj.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 03:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZHsUvtPKP5XpLfzstYmPmoxmFK2aDYzyw6bVJWhp+7I=;
        b=w00SDC/3MJW646GYiEMN9IkHITmHZKkhfjcuLzDzYEZbzPMK6bPAuyYvOK4Eh0t6Xo
         qFMKSzl934/XIWwvjx2IsSQfToG4b1iob1y8e98deJB7d4a7NTKuIeoLh/T9pi4RAIPc
         bpsYSzHzw4586HhlAGyTFP78ZNLJxpacYevbzEL/2XNetpLNOXkn9/UEJ5HopIhlcoMO
         Ii0R0+4T3UKM711c3WKc9LY/30oFRtN3nSKTHnWiK/cNU02P3784L4ahBHvkKybzW6+8
         +9vaUdei41JrR5RojV7opdw0ckmmIaWXkRgHRjWxhmOvIS90dWu/z37e+ighdkB2u8S3
         lXPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZHsUvtPKP5XpLfzstYmPmoxmFK2aDYzyw6bVJWhp+7I=;
        b=j8XtNjd1zQPFmTe+eCU41m6QAm2AV8+3BYy5StSydsg+8ndyIZARODDsUOiVv/W70N
         aJnP4dT10+qwkNTei/SfmufzpRlkMj87Vpm8+Vx+RfJy1mdMyf8lZADLBWgEpBYHsKGs
         2HcDuFrjJiXNSty8GOh1Ukw+30UnbseEB8puvLOTE/qmrjraOyjutGbMuzEn0lvcaHGE
         3RXMD/N1BPhYx1pfOdZFaf358KhxCoCDtD/SHzlM1yHcmZFWT9+FuSAZNHYmWC8KgDnH
         ZRajc7EwsRgX3JPLiJhOFnajNPaAB7ZUFmmG0qxrZvxa6jli3+g18y/GX4y/mpiwAhZC
         btbg==
X-Gm-Message-State: AOAM53060fki+o/iH582c2Lj/kEUprt6kWetudoQC2c4d/mlsioUqxCE
        t+8gi052MX6cyiYrgfiIdvVJ+pDVPYcqcuiiFou5Dg==
X-Google-Smtp-Source: ABdhPJyo75CgyMDf7Lpz7KKoFjzw977s4SnCfOO4oMpGAtz6y9q4YDvsHC9fiBLOfY9uG51R2fxL62X0UT3AYw+KmX0=
X-Received: by 2002:a25:4f03:0:b0:663:dd99:b7d2 with SMTP id
 d3-20020a254f03000000b00663dd99b7d2mr2545119ybb.490.1654597505724; Tue, 07
 Jun 2022 03:25:05 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYv7fESqpGoeKmHoJsst6wfRNMi2wQLGm+PsjbLDuDjdMQ@mail.gmail.com>
 <CA+G9fYsJThWFAxXTbAcJmjshx+oYxVVd+gMM680hS0X1z37+FQ@mail.gmail.com> <20220607162504.7fd5a92a@canb.auug.org.au>
In-Reply-To: <20220607162504.7fd5a92a@canb.auug.org.au>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 7 Jun 2022 15:54:53 +0530
Message-ID: <CA+G9fYtA3EahEGePq4nQopDvRp9LwgF93HjXSvqC94KjZmhgzA@mail.gmail.com>
Subject: Re: [next] arm64: boot failed - next-20220606
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        regressions@lists.linux.dev, lkft-triage@lists.linaro.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Raghuram Thammiraju <raghuram.thammiraju@arm.com>,
        Mark Brown <broonie@kernel.org>, Will Deacon <will@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Vasily Averin <vvs@openvz.org>,
        Qian Cai <quic_qiancai@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Tue, 7 Jun 2022 at 11:55, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi Naresh,
>
> On Tue, 7 Jun 2022 11:00:39 +0530 Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> >
> > On Mon, 6 Jun 2022 at 17:16, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> > >
> > > Linux next-20220606 arm64 boot failed. The kernel boot log is empty.
> > > I am bisecting this problem.

The bisection found the first bad commit as,

19ee3818b7c6 ("net: set proper memcg for net_init hooks allocations")


After reverting this single commit I am able to boot arm64 successfully.

- Naresh
