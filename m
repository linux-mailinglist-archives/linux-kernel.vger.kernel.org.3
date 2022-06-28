Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1092455DD49
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344176AbiF1J5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 05:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242126AbiF1J5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 05:57:04 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8986B2F3B1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 02:56:35 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id b26so4475959wrc.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 02:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=wdEuikmBJ/uSH2gaEIvi6i1JX85y8COTV4jZQOnGi4U=;
        b=cfb2dVd/jjGoU1t4eCnt5rrrESWEwbkhC0lfeHTO1of9IEFni0rWqIqpAFQsKsOMZr
         cEVSNbzBkar/FZAPL5hoU5+opkImmvl5nz/jICX1B+WTFpufBrE2LVeFDeadNKzNPLuV
         +wO2vdD31DkAYpdzSqbn8vCm7KJjt+QCxlu27GekjZ38d32fWHiLSjxfV8U6PPMOreRt
         a0thP9ihIChxudVCy16VlffNUDk7jfh7rcZj2kUzxc00WTVTA6OK4D/0AWJXBATRo8D1
         zFcasrwfp9a3vYAcEgEs16Lx11ojkPOOSlFqty30D8BLbRAVOYWfIIoURPE6xhFgo4u6
         W6YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=wdEuikmBJ/uSH2gaEIvi6i1JX85y8COTV4jZQOnGi4U=;
        b=w3dLrxWtZ/il/xi8EbMp6qDwFmjBcvKad5mBDRvylp40t8WDCqti6DwqErlrYyZO1N
         3B7Lo/q1soPYPMsQNRXs9lcgHyhYIwRWh2h+4xa+IQcg69+vHtkxPa5JKtmUvK8nHQq5
         0TRqthJa5521R5UkaCAYkrEefy2OctZDie8DQUWWVFl3KHVDZjxLZ3WdRntLZIZF3soP
         KOyj/WXHO44WCokqb2yJUqnG9tYeNr5boEDK1WD+SgUJN+E7s+b8hMHt1QCVCI7aUZSl
         PdnNnWKz0IVK0X8VtYLUMpX7ilSthiXOS5B8eC7ctA5R4LK4/C8+Z2E/uOKj755+gU7Z
         aJ6Q==
X-Gm-Message-State: AJIora/V3GYn2v6deKKxmWrJdDLi14Pwx1ynNYhGqIpmvDUrjo0UFJaL
        sB3saVB00GbIVuPK+T0+0mYoTg==
X-Google-Smtp-Source: AGRyM1vVbyM2jscmxsm6DHRdK1LN9fo1QpdOunf5SfxaiL+hlt17NO4DpXKHalZTtEPuYmUWZGFR5Q==
X-Received: by 2002:a05:6000:1281:b0:21b:9c01:df79 with SMTP id f1-20020a056000128100b0021b9c01df79mr16366834wrx.563.1656410194009;
        Tue, 28 Jun 2022 02:56:34 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id e29-20020a5d595d000000b0021bc663ed67sm7872623wri.56.2022.06.28.02.56.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 02:56:33 -0700 (PDT)
Date:   Tue, 28 Jun 2022 10:56:31 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v1 11/11] mfd: intel_soc_pmic_bxtwc: Fix spelling in the
 comment
Message-ID: <YrrQT8rxDFuAdzt5@google.com>
References: <20220616165823.4919-1-andriy.shevchenko@linux.intel.com>
 <20220616165823.4919-11-andriy.shevchenko@linux.intel.com>
 <Yrl5XZOgD8abd+Qm@google.com>
 <YrrL+Mil/B1Gh5VN@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YrrL+Mil/B1Gh5VN@smile.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Jun 2022, Andy Shevchenko wrote:
> On Mon, Jun 27, 2022 at 10:33:17AM +0100, Lee Jones wrote:
> > On Thu, 16 Jun 2022, Andy Shevchenko wrote:
> 
> > > -	 * There is known hw bug. Upon reset BIT 5 of register
> > > +	 * There is known HW bug. Upon reset BIT 5 of register
> > 
> > You may as well fix the grammar while you're at it.
> 
> Any suggestion from a native speaker? I can propose a few changes, but I'm
> totally unsure.

No massive changes, just:

* There is a known H/W bug. Upon reset, BIT 5 of register
           -       ---                -

> > >  	 * BXTWC_CHGR_LVL1_IRQ is 0 which is the expected value. However,
> > >  	 * later it's set to 1(masked) automatically by hardware. So we
> > > -	 * have the software workaround here to unmaksed it in order to let
> > > -	 * charger interrutp work.
> > > +	 * have the software workaround here to unmasked it in order to let
> > > +	 * charger interrupt work.

* place a software workaround here to unmask it again in order to re-enable
  -------                             ------    -----             ---------

* the charger interrupt.
  ---

Something like that.  Feel free to adapt it further as you see fit.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
