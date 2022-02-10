Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E4BC4B14F2
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 19:08:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245541AbiBJSHo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 13:07:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245524AbiBJSHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 13:07:42 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14612104
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 10:07:43 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id e3so11122874wra.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 10:07:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Ps8wA06wMzyyRvvvYldgSzafMHSS0Jkhd3nDdg/VUI0=;
        b=qgtKX7cI90XzSh8yGU5pb8U4nuXSb86A7/A0/UB0O4pNWHwHVATC2Mm7zfqdwoeeYI
         C6HtYCOrkKzOeVhcp8YgeLBt3WY0UPrMENnm9Wbezh8/1y0Dsey3jB3X5UT80idzVXeN
         RLH+r1RNMMCTD+vBCWl2wGEc9d5OID0MFuxl05nRDqwxz5zlW3m55CnfQqO0zkQIYRf6
         ht7mOmPOTdIK97WB0q5n1fCw7nL5un+5ORIa4cNZcGtjg9C5F9z7OYJILQWLqGruY70Z
         dTqW6UpDAmOEeizWQyoeT3Qgy3AVlb6VnPzY2xKSCj876T83pRBQnU1qyQzg/OgVA0es
         DfsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Ps8wA06wMzyyRvvvYldgSzafMHSS0Jkhd3nDdg/VUI0=;
        b=UvJ3lQZdvcxWdFwxD2sQp87mvUxHKtb1EQK9K/Ev5weWDiBTmFsRAkHLan8Q3UkRJF
         95108AP7TbrFKTaX/3WZ89GBotZ0ofdkI0ckkyxqSrDVzLijB01lnFcmyTOZx2zrFpKu
         qpKBlrmrOieJVwRMu2xFce/rRPVjMyjdjfBWz2gwmp1I68LEUfWIzpMmz0w7RHSoN801
         BksXQlRo81UPs0zTkBN29giajMIRJ4CyXab4VjIRRNof4QyxTY9mQFLwuR2KB1HyKzrJ
         w3KuZ2JqMcX5In4CM2HFabxNaiuMwQKpa4PgK8Bau7VuldScMkbXXTn4qOZK3V1oLhjv
         d/Uw==
X-Gm-Message-State: AOAM531fqejp+HGnO+53moS/OZMXdrfVITYJirvt+sy8FMsJaxLsnObO
        7J/ZcqyQs3XngSSCL77pRMcKXD9mrTzs5g==
X-Google-Smtp-Source: ABdhPJwAfpD7TU9l8JeA/KWJM3azo7IDFeFTtPD5oWUCVfmfGMmxJBMr3krcFdE5kA+TwEgkDi0xYA==
X-Received: by 2002:a5d:47cb:: with SMTP id o11mr7241408wrc.718.1644516461647;
        Thu, 10 Feb 2022 10:07:41 -0800 (PST)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id p3sm2213001wmq.40.2022.02.10.10.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 10:07:41 -0800 (PST)
Date:   Thu, 10 Feb 2022 18:07:39 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Alistair Francis <alistair@alistair23.me>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the hwmon-staging tree
Message-ID: <YgVUawb2IFoiuqU/@google.com>
References: <20220210185123.4d39766c@canb.auug.org.au>
 <YgTRu7iLgJMymeT5@google.com>
 <af550a8a-9fd8-9292-4179-4d7b74fdacfc@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <af550a8a-9fd8-9292-4179-4d7b74fdacfc@roeck-us.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Feb 2022, Guenter Roeck wrote:

> Hi Lee,
> 
> On 2/10/22 00:50, Lee Jones wrote:
> > On Thu, 10 Feb 2022, Stephen Rothwell wrote:
> > 
> > > Hi all,
> > > 
> > > After merging the hwmon-staging tree, today's linux-next build (htmldocs)
> > > produced this warning:
> > > 
> > > Documentation/hwmon/sy7636a-hwmon.rst:4: WARNING: Title underline too short.
> > > 
> > > Kernel driver sy7636a-hwmon
> > > =========================
> > > 
> > > Introduced by commit
> > > 
> > >    de34a4053250 ("hwmon: sy7636a: Add temperature driver for sy7636a")
> > 
> > Oh wow, that's new (to me), and a little petty, no?
> > 
> > Would you like me to apply this patch to my branch Guenter?
> > 
> 
> It would be great if you can do that since you already wrote it.
> 
> > I can either send out a new PR, or let it wallow.
> > 
> Wallow is fine with me; that can go in through your branch.
> 
> Actually, I wonder if I should just drop your immutable branch from
> my tree and let it go in through your tree. The hwmon patch has my Acked-by:
> already, and there are no further dependencies, so it isn't really necessary
> for both of us to carry it. What do you think ?

That's your call to make. :)

The patch is going in, either way.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
