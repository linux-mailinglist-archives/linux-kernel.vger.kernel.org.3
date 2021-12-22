Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B62BC47CBB8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 04:29:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242138AbhLVD3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 22:29:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242101AbhLVD3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 22:29:37 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40053C061574;
        Tue, 21 Dec 2021 19:29:37 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id kc16so1169169qvb.3;
        Tue, 21 Dec 2021 19:29:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=abbBrp8ag7dPhueCmfwoxna61qECBNqf62+icr3Ed3I=;
        b=E6KawuNcyIIpadoWhoDRyIU2VjvqxeNTAddsR7CDc6pZDUUWSlqxFYpVLoXIVTP61v
         R5LQb8sTb10PDCv9CS0gKUSx2h/jrXisvCXxaEY1bV8m/CoaHvlcz9kqBYDxy+Y+RpD4
         v217SCWEKzGmiHN4hiSHvZ+S90qYexDSRcAwS2avfTZkyl6mQ/MkNeG1xHmR5w9vVlNW
         JZ+GXhi/qxqhhCNZTmSlEqUDKtZJOQ3/Fyru6icNw1eDC1sg49WfJ9nxGtvpvo7DdRA5
         oUkBcXjaHepEZQ4F2tau5zLPEtRhoQjLt8nglntZabNhI7IXKc8B8lNAoZwZ5FaHpEDx
         J/ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=abbBrp8ag7dPhueCmfwoxna61qECBNqf62+icr3Ed3I=;
        b=MJ5FCzN9+s4TiNeoTIn9EtL1izh+NQ/5qtR8w5e8b1QifdHW0qugRRS4TBKPG4c6hh
         kqSNJZk3y2q5awnuOJYM0rAkG3V0qgjiPcKmE5PUywkMUWF0RN334uhNLhB4dEAogK+I
         ALeY1KoK77XO8cSIsII+4IFbyAkJkzIirHqc9OT+3CK5ViLUI0hsYwZtt4vjG5DHb3ey
         LD6HF+/PWoaEnSZik/ZH7YXdXGKFY8fkx1hDhJTnfxX1h5zrSCMf4Lw+f1gvt2Pi0b9+
         yFsgbVTJMRxjq2JS89n8IfZdQUcImp8Mh8lj1WVnTEUTxG3ShBbG4dNisf9fCP27qMHp
         2Fhg==
X-Gm-Message-State: AOAM531PAEX35oGaSjjLlD1t20zSi+XfYQMBWsK4SD5ctFXa3qSHCWId
        WH5FczyjGL3S3h1TDhB1sh8ymK52bMc=
X-Google-Smtp-Source: ABdhPJwEqx2hyffNM2Ycz/Bo4IhYl4bvaQtKcwTpAuxQVruYuLst9YFjYvCo+Te5jpyoNbYStGg6RA==
X-Received: by 2002:a05:6214:230a:: with SMTP id gc10mr1045362qvb.115.1640143776440;
        Tue, 21 Dec 2021 19:29:36 -0800 (PST)
Received: from shaak (69-165-204-82.cable.teksavvy.com. [69.165.204.82])
        by smtp.gmail.com with ESMTPSA id n20sm791268qkp.65.2021.12.21.19.29.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 19:29:35 -0800 (PST)
Date:   Tue, 21 Dec 2021 22:29:33 -0500
From:   Liam Beguin <liambeguin@gmail.com>
To:     Peter Rosin <peda@axentia.se>
Cc:     jic23@kernel.org, lars@metafoo.de, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org
Subject: Re: [PATCH v10 00/14] iio: afe: add temperature rescaling support
Message-ID: <YcKbndXIQOXkA/0T@shaak>
References: <20211219223953.16074-1-liambeguin@gmail.com>
 <898286f0-170e-633d-e924-a5703de468b1@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <898286f0-170e-633d-e924-a5703de468b1@axentia.se>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Mon, Dec 20, 2021 at 10:37:26PM +0100, Peter Rosin wrote:
> Hi!
> 
> On 2021-12-19 23:39, Liam Beguin wrote:
> > Hi Jonathan, Peter,
> > 
> > I left out IIO_VAL_INT overflows for now, so that I can focus on getting
> > the rest of these changes pulled in, but I don't mind adding a patch for
> > that later on.
> > 
> > This series focuses on adding temperature rescaling support to the IIO
> > Analog Front End (AFE) driver.
> > 
> > The first few patches address minor bugs in IIO inkernel functions, and
> > prepare the AFE driver for the additional features.
> > 
> > The main changes to the AFE driver include an initial Kunit test suite,
> > support for IIO_VAL_INT_PLUS_{NANO,MICRO} scales, and support for RTDs
> > and temperature transducer sensors.
> > 
> > Thanks for your time,
> > Liam
> 
> And thanks for your time and persistence!
> 
> This now looks in good order, so for the whole series:
> 
> Reviewed-by: Peter Rosin <peda@axentia.se>

Thanks for your time (and patience ;-) on this series!

Cheers,
Liam

> Cheers,
> Peter
