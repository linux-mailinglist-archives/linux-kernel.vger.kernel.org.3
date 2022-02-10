Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFC304B0819
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 09:27:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237334AbiBJI0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 03:26:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237267AbiBJI0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 03:26:23 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED50109E;
        Thu, 10 Feb 2022 00:26:24 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id y3so13484705ejf.2;
        Thu, 10 Feb 2022 00:26:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=yMHDyZywBQd4qMNkOk8QdP2+6QiKb0trxcrPY+YQbc4=;
        b=njgqt5Nj5PmminE0N6pUUfw9Lfk2kRzztnY5MzbS4OAamt4Ex61GJBcWaWTHZqnR60
         NPVyuZSsGMMksKLVbbnkVga3AwAiFM381T8penb0vHzc0xfk+x4GBTD3EoHzYoaDLPge
         cNK5S4F54gPZ0JDk4BOUVOjC9iL2UuBwVCSWHkexnogkx20jZdhgj7DSVibOZbbStq99
         /PlLs1jXH50MMx37dZpwHbtzVSoYqJ5ZHX7dLDv08Kv+fQU6/KoXcxgsbdVnHJrNPFwU
         MxOuicrLyUag7gFEk9+bA5KIGDHhXVIruUEc7IP+lKJRLrhjvkc+cmiChBtGQSIM6Wo7
         j1cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=yMHDyZywBQd4qMNkOk8QdP2+6QiKb0trxcrPY+YQbc4=;
        b=Ksancc8GKT11G+0w4c4EsGhvHtrhafI3saCQh1QoJ+/cFoAuo1m4R9ntnQjSP0ZPao
         Tyy/W2f+2vXBCQgmMTwvhPw3Agxe22IU6FwEbdRjr1vNxl6xuHVR31i0r7uoyVFZgguG
         pNZ758KC8i3gn5V3+Z8Yj1jxuER0iELrPcbelkBUbtlpSlMHScX+SxSPB0bdxXmsWv/p
         JzpSmf6q0H9Fgxy+/Oht45yRLLQq+N3IGzqQajE8JT/BhHLQZXbA/TcpaAolBDIeker0
         W8JKt9BKUA34mqFvNB+jf2MWMZdogFn65fZQo6tLeL1NKgYzvhVZBwIN2Z+SeBdHAQyC
         +bzA==
X-Gm-Message-State: AOAM533+B5B1xxlTBKWadfU3Em+nlx7AEE5PvDgIUOE0IkWj27XFjiHA
        I0SBb7IiPK/B8KSMxs0QWOY=
X-Google-Smtp-Source: ABdhPJy2aJBdHEv7yXFSHSWwQi9rBTIFJ3j4Ilx4K+6p/rvSfIY2fclFlF8scT3AreCRJkaecWgQLQ==
X-Received: by 2002:a17:907:7207:: with SMTP id dr7mr5412184ejc.500.1644481583146;
        Thu, 10 Feb 2022 00:26:23 -0800 (PST)
Received: from ?IPv6:2001:a61:259f:9401:c29b:34d:c30:c5de? ([2001:a61:259f:9401:c29b:34d:c30:c5de])
        by smtp.gmail.com with ESMTPSA id t8sm3573172eji.94.2022.02.10.00.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 00:26:22 -0800 (PST)
Message-ID: <9cd8a336ed31eaf6bea2ad53f185abac22dc8474.camel@gmail.com>
Subject: Re: [PATCH v5 1/4] iio:frequency:admv1014: add support for ADMV1014
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     Antoniu Miclaus <antoniu.miclaus@analog.com>, jic23@kernel.org,
        robh+dt@kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 10 Feb 2022 09:26:21 +0100
In-Reply-To: <YgOtN+wha+j3ZFIO@smile.fi.intel.com>
References: <20220131100102.15372-1-antoniu.miclaus@analog.com>
         <Yf7AjXsRuhFeFTpD@smile.fi.intel.com>
         <e59fce3747428f30afdf77f9839910664e3e8524.camel@gmail.com>
         <YgOtN+wha+j3ZFIO@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.3 (3.42.3-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-02-09 at 14:01 +0200, Andy Shevchenko wrote:
> On Mon, Feb 07, 2022 at 09:29:54PM +0100, Nuno Sá wrote:
> > On Sat, 2022-02-05 at 20:23 +0200, Andy Shevchenko wrote:
> > > On Mon, Jan 31, 2022 at 12:00:59PM +0200, Antoniu Miclaus wrote:
> > > > The ADMV1014 is a silicon germanium (SiGe), wideband,
> > > > microwave downconverter optimized for point to point microwave
> > > > radio designs operating in the 24 GHz to 44 GHz frequency
> > > > range.
> > > 
> > > Excellent job!
> > > A few comments / questions below.
> > > 
> > > ...
> > > 
> > > > +config ADMV1014
> > > > +       tristate "Analog Devices ADMV1014 Microwave
> > > > Downconverter"
> > > > +       depends on SPI && COMMON_CLK && 64BIT
> > > 
> > > Why 64BIT only?
> > 
> > Could not resist on this one... The thing is that CCF uses unsigned
> > long for rates and this part operates in high GHz values. That
> > means,
> > as CCF stands, this cannot work on 32bit.
> 
> I read it a bit differently, i.e. CCF has a bug that needs to be
> addressed.
> 

Totally agreed...

However, this can be something that might take time
to support in CCF (I definetly have plans to send a RFC to, at least,
start the discussion around this) so I guess we can already support
this device like this. I believe this is somethig straight to remove
as soon as CCF works in 32bit archs for high speed devices...

- Nuno Sá
