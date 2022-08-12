Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB2875911E8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 16:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239044AbiHLOGj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 10:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238950AbiHLOGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 10:06:36 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C2B375FF9
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 07:06:34 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id w28so811993qtc.7
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 07:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kudzu-us.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=ouy6vInqjOuz0vON38F/9ZVgEROJ+pAfxQ3Xfc7ddkg=;
        b=nN7o6VbUrD2euA5asES6oC0ESP8MD6MSuhee2Bv96GQwNScLi+uKVlW6t++DiGBXhp
         5FUcM8rIr4sFFJosr4UPORf4jkLCdGKbbJ2Cob24ZASB2m126YhMmHFoEyFPHR7oiJ4A
         h/bI1SDYCqaU/IG1nBRqkDQStl/BV6TsmHZG/QlVPk2sPC0JjIGeDWPceT34zEWwu+O/
         hTlQM1WfvNPOCcrbtzpJAd3LO9C5JBu1onKsn7ibBDq4weQl/27OiqBlyWoofA4Vtzg0
         48behcqeWzfUrrcs0T7ALc31JzS75u9+9DounHwXrpDcz/WM+HPPErdNi2ZbFvVdOo5t
         1E4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=ouy6vInqjOuz0vON38F/9ZVgEROJ+pAfxQ3Xfc7ddkg=;
        b=0IsS5arUYfF1XkwE3LgkXlO8cGQPk6e2wt9/hPZ9lvHLOzvkjtjnxE3OK03npxE7vB
         xtO/aRij2B357DQB7U/ZBKmdhta3dTWWuqAX6mNKCMDYrxXM2Hi6IIGEjfW6XnLv/klq
         3MCEatQyYkJkhtWPI48Z7Q84gC0V+Q3Axz6v1leWPAZ79ohwn/uyZ8/WAugcEbVrvDRy
         6fTmbAwESMBGR+bB4VQ1pmrMdrpR2OUnWiKRTdLODaHM9fGMtrqWEEqtTbO2ZGNyh4Yj
         mgE5yCeYKAh8Ygo2iQwr6LSXCgg19YFap1IxG8f/C2HvvSyfq/PqKktlH0sDFlqpUveq
         Px8w==
X-Gm-Message-State: ACgBeo2SPOvIfDdPjr1N4doYX5FSeSjpkSNtEW+MAE9dHkaAwT7d+bhx
        VWWKAb7oKYD1JxYhJ6RNUZ/XHg==
X-Google-Smtp-Source: AA6agR5Wj9EamNRRPyGVGgGdafT7LxzQMoP311pXlxa6vuCJBrA4zpgoHglHkZhBeW+fXCtQRrnYbg==
X-Received: by 2002:a05:622a:214:b0:342:f97c:1706 with SMTP id b20-20020a05622a021400b00342f97c1706mr3577905qtx.291.1660313193066;
        Fri, 12 Aug 2022 07:06:33 -0700 (PDT)
Received: from kudzu.us ([2605:a601:a608:5600::59])
        by smtp.gmail.com with ESMTPSA id i4-20020ac85c04000000b0034301298d30sm1851681qti.38.2022.08.12.07.06.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Aug 2022 07:06:32 -0700 (PDT)
Date:   Fri, 12 Aug 2022 10:06:30 -0400
From:   Jon Mason <jdmason@kudzu.us>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Ren Zhijie <renzhijie2@huawei.com>,
        Randy Dunlap <rdunlap@infradead.org>, kishon@ti.com,
        lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com,
        Frank.Li@nxp.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] PCI: endpoint: Fix Kconfig dependency
Message-ID: <YvZeZu+xl1qDCljD@kudzu.us>
References: <cdaf434f-90d5-696f-2a60-5946ecefcf0b@huawei.com>
 <20220715212411.GA1192563@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220715212411.GA1192563@bhelgaas>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 15, 2022 at 04:24:11PM -0500, Bjorn Helgaas wrote:
> On Sat, Jul 09, 2022 at 10:50:53AM +0800, Ren Zhijie wrote:
> > Hi, Bjorn and jon
> > 
> > Just a friendly ping ...
> > 
> > Is this patch be merged or squashed?
> 
> Jon has to take care of this because I don't have the VNTB patches in
> my tree.

Sorry for the extremely long delay in response.  This series is in my
ntb branch and will be in my pull request for v5.20 which should be
going out later today.

Thanks,
Jon

> 
> > > > > > >   drivers/pci/endpoint/functions/Kconfig | 1 +
> > > > > > >   1 file changed, 1 insertion(+)
> > > > > > > 
> > > > > > > diff --git a/drivers/pci/endpoint/functions/Kconfig b/drivers/pci/endpoint/functions/Kconfig
> > > > > > > index 362555b024e8..9beee4f0f4ee 100644
> > > > > > > --- a/drivers/pci/endpoint/functions/Kconfig
> > > > > > > +++ b/drivers/pci/endpoint/functions/Kconfig
> > > > > > > @@ -29,6 +29,7 @@ config PCI_EPF_NTB
> > > > > > >   config PCI_EPF_VNTB
> > > > > > >           tristate "PCI Endpoint NTB driver"
> > > > > > >           depends on PCI_ENDPOINT
> > > > > > > +        depends on NTB
> > > > > > >           select CONFIGFS_FS
> > > > > > >           help
> > > > > > >             Select this configuration option to enable the Non-Transparent
