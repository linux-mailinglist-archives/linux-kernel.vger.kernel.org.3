Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA1414C64B0
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 09:17:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233576AbiB1IRq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 03:17:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbiB1IRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 03:17:44 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDE58381B7
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 00:17:06 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id s13so14066252wrb.6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 00:17:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=W4EWrovrKwniOj1aDeQhCcb/kTFjyzBYFDvE9xPTT6c=;
        b=ytZUlgBVeIjNC4P0r9W5xNvMhC/NtQaC06IzqNdSlfdi9w21ZJD6lUUuyPBbV3kHMJ
         ReSNX8i3gX0IodyN967zzpkqe1aiQO+t0Zsc6ACKWQqc+r4T/vQmbCEOpii3Yb+6RjoP
         7nM8pytviaMiIBGiot+fugobC7A3wADEbrV6P9w+yIDqI5L+79+ADaLvlsH7+MmTzLxJ
         I6coPFlefsIm5Gx2//F/q0xnnvRlHtfUZIbPrOZ+ySwIK1Zh/2rmWbfAvLUX1eaijFvr
         +RioFLmat/zUI6DZvC4oUJyDbF+tg2L5k4s+SXOf8kqtCQ9s7R2jmiqYyglub+/UBPk+
         8H7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=W4EWrovrKwniOj1aDeQhCcb/kTFjyzBYFDvE9xPTT6c=;
        b=AnVSVEiY+V6oWijnfFFuueJSk+fjCEK8umKCopk98VPAxaNdY9pKa32BuONkCBJ0lI
         J28INTcinFsCTkzfyyTjKvoZnOOKfepFnpySts5SZtMeLsTOskXmyyydsU9iHyud+noQ
         wIsbyeNHOnowfyIPcQyFEXZniov7L9UP2HLnxPeDFvIxsxxTq1DC/z8itHgRoSVi1BFg
         6Mh4n7YLjs8EiurmYuHQ1OHcil3xnhzaHkTAVKkMB0uF+FCWpE8K+xAtLsUyyuffd0ih
         JCUcNZsxQWzr0SBxcq319Ton+avYZ+GTu5WtaybRynDGEsWaUv0OqDOPijhHHOukvj83
         dCmA==
X-Gm-Message-State: AOAM530MtlUmOCh0MRAEDYncKwJdTKU6239KNqNqZ1ivTRtm5i+W//kV
        AwhrS3K+5k8xweS/lr8js61+/laPY8PRcg==
X-Google-Smtp-Source: ABdhPJwAZx+rlSBha8ANhAUaASGKtoMMJk+uo49L16UcGWjQXU3vuKONTJa/2clEF1PS1JTBTKdeCw==
X-Received: by 2002:a5d:6da6:0:b0:1ea:75c7:77f0 with SMTP id u6-20020a5d6da6000000b001ea75c777f0mr14907685wrs.566.1646036225378;
        Mon, 28 Feb 2022 00:17:05 -0800 (PST)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id c4-20020adfed84000000b001e5b8d5b8dasm14034904wro.36.2022.02.28.00.17.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 00:17:04 -0800 (PST)
Date:   Mon, 28 Feb 2022 08:17:02 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     broonie@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the mfd tree
Message-ID: <YhyE/kPA71bHsHDz@google.com>
References: <20220223165416.2359767-1-broonie@kernel.org>
 <YhZo7xnNRKz8U1Lf@google.com>
 <20220228170826.4dedaf6a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220228170826.4dedaf6a@canb.auug.org.au>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Feb 2022, Stephen Rothwell wrote:

> Hi Lee,
> 
> On Wed, 23 Feb 2022 17:03:43 +0000 Lee Jones <lee.jones@linaro.org> wrote:
> >
> > On Wed, 23 Feb 2022, broonie@kernel.org wrote:
> > 
> > > After merging the mfd tree, today's linux-next build (KCONFIG_NAME)
> > > failed like this:
> > > 
> > > /tmp/next/build/drivers/mfd/sprd-sc27xx-spi.c:255:35: error: redefinition of 'sprd_pmic_spi_ids'
> > >   255 | static const struct spi_device_id sprd_pmic_spi_ids[] = {
> > >       |                                   ^~~~~~~~~~~~~~~~~
> > > /tmp/next/build/drivers/mfd/sprd-sc27xx-spi.c:242:35: note: previous definition of 'sprd_pmic_spi_ids' was here
> > >   242 | static const struct spi_device_id sprd_pmic_spi_ids[] = {
> > >       |                                   ^~~~~~~~~~~~~~~~~
> > > 
> > > Caused by commit
> > > 
> > >   6fc90b92e9c7ef348 ("mfd: sprd: Add SPI device ID table")
> > > 
> > > I used the MFD tree from yesterday instead.  
> > 
> > Thanks.
> > 
> > Will fix for tomorrow.
> 
> I am still getting this build failure.  It is an x86_64 allmodconfig
> build.

The good news is, this is fixed locally.

The bad news is, I didn't push it to the public repo. :)

Should be fixed for tomorrow instead.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
