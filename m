Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C91B94ACA8E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 21:47:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242241AbiBGUbQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 15:31:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234251AbiBGU35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 15:29:57 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17970C0401E2;
        Mon,  7 Feb 2022 12:29:57 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id k25so45212777ejp.5;
        Mon, 07 Feb 2022 12:29:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=Uq36/CKE/ycVYZTxoYXlgWFz/oj0znO89myMVuBbsjA=;
        b=BLJbVy/Muk9/3SZFWBdIw3LB7Rriy6diLil3rL1D88f/rLVmPTZ8M5cWEH8r7VGnOS
         +E8ZBwWhtwTCrChXrY6fK/ql67Tn9MPvx/Z3YTBg3icoGxuQsJ+S5HdGPz2D6L8A4NEi
         uZ6EeGtt21xRBUxAAu6/OPKsKBsOJ0HunSqhC1wz6bkjlo4r8kpMyY81MSJ5wZ3mXl5y
         6Xdo6/IZuE8GqQIh7ayLT+1Q7MEwEnlRUVs4/xw+c7bDU/uEah575VVNewZdE/t3gLVm
         LwLbx+OJwLPjaaJ8kULa1QNsawqJjNPMlEmiklIbP86wH3nThOmDu24NXBPPrseJOuq8
         NwbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=Uq36/CKE/ycVYZTxoYXlgWFz/oj0znO89myMVuBbsjA=;
        b=MZhjwWGSuj/vCJte4ZRtxOwMLTxjFMHE1fItAWrFsWG4MKxNBF2PVsSlGrkqZtGKAb
         XNuvTwyBx0/2Rtij8H2ybOUIsz1xmcoJ5ahsAw4zsvKau6+850rC0MKICdzNfhVVH7ux
         Gt++JOSS1/pbWGAaCzVlc7RKztwWQmNJNbc3fYv/0Tm1l23fpj9PHGfeJeEznrxnCYKc
         LLMF0xg3Gur5tIWQmWMBrBMV8rJ7rbvpHGnb79CuQLVBVMmcu83I4Atz9d1ntjSOWOo8
         Q5mzHbXteKM9tfEFYneXPGQjyVUPuwNDMcDs5g40OrutcZ4EfDF6B9DCvKUegCydkW1f
         /pNw==
X-Gm-Message-State: AOAM532Qbil82J1nE12fU+Oi0FjnZZWjaT4iDiDD/ZUrvbcd/lqqooGF
        t6DvbIMMhr8XbsCOGKziyWnnttL4rkFSIA==
X-Google-Smtp-Source: ABdhPJxz7uqc45TMfjTsjZw3nOSngAHXEzBxf7rDzRghYIfwq/UBYUgULxijuRX2Fuq2NA5D+cxxiA==
X-Received: by 2002:a17:907:a40a:: with SMTP id sg10mr1177185ejc.44.1644265795587;
        Mon, 07 Feb 2022 12:29:55 -0800 (PST)
Received: from ?IPv6:2001:a61:24f7:5701:1b0:e3f1:2182:d29c? ([2001:a61:24f7:5701:1b0:e3f1:2182:d29c])
        by smtp.gmail.com with ESMTPSA id q7sm2806672eds.78.2022.02.07.12.29.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 12:29:55 -0800 (PST)
Message-ID: <e59fce3747428f30afdf77f9839910664e3e8524.camel@gmail.com>
Subject: Re: [PATCH v5 1/4] iio:frequency:admv1014: add support for ADMV1014
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@intel.com>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc:     jic23@kernel.org, robh+dt@kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 07 Feb 2022 21:29:54 +0100
In-Reply-To: <Yf7AjXsRuhFeFTpD@smile.fi.intel.com>
References: <20220131100102.15372-1-antoniu.miclaus@analog.com>
         <Yf7AjXsRuhFeFTpD@smile.fi.intel.com>
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

On Sat, 2022-02-05 at 20:23 +0200, Andy Shevchenko wrote:
> On Mon, Jan 31, 2022 at 12:00:59PM +0200, Antoniu Miclaus wrote:
> > The ADMV1014 is a silicon germanium (SiGe), wideband,
> > microwave downconverter optimized for point to point microwave
> > radio designs operating in the 24 GHz to 44 GHz frequency range.
> 
> Excellent job!
> A few comments / questions below.
> 
> ...
> 
> > +config ADMV1014
> > +       tristate "Analog Devices ADMV1014 Microwave Downconverter"
> > +       depends on SPI && COMMON_CLK && 64BIT
> 
> Why 64BIT only?
> 

Could not resist on this one... The thing is that CCF uses unsigned
long for rates and this part operates in high GHz values. That means,
as CCF stands, this cannot work on 32bit.

- Nuno Sá


