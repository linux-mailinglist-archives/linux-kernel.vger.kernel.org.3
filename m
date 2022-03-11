Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D42DB4D5886
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 03:59:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345839AbiCKDAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 22:00:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345827AbiCKDAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 22:00:40 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49D817004D;
        Thu, 10 Mar 2022 18:59:38 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id m22so7038144pja.0;
        Thu, 10 Mar 2022 18:59:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VYFJmAOCt1LNDKMHVWahmkT0goGGy64AMi6EKgFrqns=;
        b=TCef/OxLetrhWbc+zfTGNDz3WmcBcI/deIXGM7Nb5+kFYvuODAYS7NQXUhil5OhBoL
         /37/GWuqJxGuMowJIcapqxhOZvRAgdu8L/2R8h/l8fULX5HTY/yc29MSM0MxSRN6Bvtt
         8IJGNOHG0X1gUHgbzpdm3Vtlt6uIBxNk1+16/iQ9/Wh//bo5YQRqOL83XV6v55z0IvZx
         ZzJEkxm1SIf3qE70d7UJAlRQEPHeXe497IHUYxuR64jYbBMfaF8FoP39xVSKDSL6EC95
         H1El9kYo/LZ3MRzuD+LdDI4Omosf2ZphmY3CqiROyL8c11zK5vynVdsGQyaVxdGBOWLV
         7xBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VYFJmAOCt1LNDKMHVWahmkT0goGGy64AMi6EKgFrqns=;
        b=ZBYiWPtEgCexh984EBRIlsgw+dadGd5U7smGWqyQ0Hgf8a+gZ93mN0NxrWRIMWVtoi
         prPat84MAgJNt/rc8O/S8uLw3RcMykBiYFl9r5I94H4EUTDaghO9jYFWpmykevAV6KUk
         icL81J5LM1dtk3c/G/Pc1ajTwlz544esjUPlVqo8yrswL49cqxPK7zGZCUMAutieTDqJ
         A0dnEoTT7iK1Xx5IxPlNLDlMY//EPJNdDqr2V8vZjKGm9CBoIzPRLqPuvCXVuk3e7RMU
         71JrjS8g3209tPZU0mCCW/U1RRzsvL01Ckl9+3h2AUuTPDo13mZwRj43Ti2WzK/2CSCw
         7fQQ==
X-Gm-Message-State: AOAM530DR8Qg4JPPWRgU4f5fxA8GUoxjyWOsMQ7UdvH0NV3gQC9Z4uei
        GPYwtdWJRtIhpubCG+7bVFg=
X-Google-Smtp-Source: ABdhPJzu/jLxtGnpHi58S1frsZWk7bV6Dcdfkqv5F8HQQpQlxxy0vEh/Uk12gQbE2L+5UM5dGzfKrA==
X-Received: by 2002:a17:90a:cf06:b0:1bf:68ec:a274 with SMTP id h6-20020a17090acf0600b001bf68eca274mr8395259pju.151.1646967577861;
        Thu, 10 Mar 2022 18:59:37 -0800 (PST)
Received: from 9a2d8922b8f1 ([122.161.53.68])
        by smtp.gmail.com with ESMTPSA id ic6-20020a17090b414600b001bf691499e4sm10879230pjb.33.2022.03.10.18.59.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 18:59:37 -0800 (PST)
Date:   Fri, 11 Mar 2022 08:29:32 +0530
From:   Kuldeep Singh <singh.kuldeep87k@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Chanho Min <chanho.min@lge.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH 0/2] Make DTs compliant with bindings
Message-ID: <20220311025932.GD54098@9a2d8922b8f1>
References: <20220309182403.12968-1-singh.kuldeep87k@gmail.com>
 <CAL_Jsq+k+ridWTkdy4xwTC7VxUTU8tu+Q2BA9kbQVA222PWvZw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+k+ridWTkdy4xwTC7VxUTU8tu+Q2BA9kbQVA222PWvZw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 10, 2022 at 05:18:51PM -0600, Rob Herring wrote:
> On Wed, Mar 9, 2022 at 12:24 PM Kuldeep Singh
> <singh.kuldeep87k@gmail.com> wrote:
> >
> > These patches are an attempt to fix DTs which are not in compliant with
> > pl022 binding.
> > LG1312, LG1313 and amd seattle platforms require fix in clock
> > properties.
> > https://lore.kernel.org/linux-spi/20220309171847.5345-1-singh.kuldeep87k@gmail.com/T/#u
> >
> > Based on git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git,
> > master.
> > Rob, could you please help in picking these patches as git tree is not
> > specified in MAINTAINERS.
> 
> I don't take dts files. Resend to soc@kernel.org asking them to apply.

Thanks for mentioning. I will resend this series to appropriate list.

> 
> >
> > Kuldeep Singh (2):
> >   arm64: dts: lg131x: Update spi clock properties
> >   arm64: dts: seattle: Update spi node properties
> 
> Acked-by: Rob Herring <robh@kernel.org>

Thanks for reviewing it.

> 
> >
> >  arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi | 8 ++++----
> >  arch/arm64/boot/dts/lg/lg1312.dtsi           | 8 ++++----
> >  arch/arm64/boot/dts/lg/lg1313.dtsi           | 8 ++++----
> >  3 files changed, 12 insertions(+), 12 deletions(-)
> >
> > --
> > 2.25.1
> >
