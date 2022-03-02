Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F08E04CA053
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 10:08:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240345AbiCBJIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 04:08:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237615AbiCBJIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 04:08:40 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19EED3C4A6
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 01:07:57 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id e6so1111706pgn.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 01:07:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1PWpW0/h9OxoVQDD4bcapW45oUiOIoSzLo/G9Alzs/Y=;
        b=pgS/2ILaQVPmaJz+WJHQzLFwqqv+8A1VadcG0oZ7PYnR5ejErAfMdQ5WhphVNL2nfG
         lsP2YTYOxLGMh8377eApzdWoRnp55gO6JSE89klyaPmv7Q8mHMbIHjX9kMdTanImTj8t
         v77fCB3vizLHenOLuW18U8W6si/XmbW8ZiV0TGgj64tAEfpxtGSy2gIDiYXXtJYBxeyl
         HXrHCrNgFcm1iE96pQk0OtbVR97Bp+km2WP9Ek4huCSRuHUAx7cNLjmnnqmcALEJOOVm
         E+JsmRlIsZsnLzBN0FXKWwPP1HtR+Ork+Ff1J9HfjbOnjyJKtF1GSbQmQi/27xdH5BPv
         +Cfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1PWpW0/h9OxoVQDD4bcapW45oUiOIoSzLo/G9Alzs/Y=;
        b=EiwdAfA3rlzyM4XjTJfb4ssh2qlt+w2+QtBwN/m1Iqjve3+J5gEmEaBRjlCYgcPfEV
         Z2tNLfrevrdKFoFIRqOQeiPfMYt6Uu0P6Ldc/S8jz7jSlEai7wrNgP69xJkFFnrwBLNA
         0+N8pAmJVfyJeP+ZkzmMtRdEC00gjGrhw8r57bkSCqTUHYGEd7U8NncoHQ4xRWvETp+t
         jXrtb2D2E2t4TOv5TMN2K44kkksGm5ikBXYipr8kKI0YTyHZ4uhiNN9JAXQe8puu+aVF
         1f566cyc7OJTS4GgShho03eAtxE9ve3c+MFgRj2cizR9hObJgY8K/EKgmurI2vUybFep
         y+kA==
X-Gm-Message-State: AOAM532FR5FQmq+6lWbHiJ3iOObqTbrPOzEVMiR8lDF2xSgne0zDteiA
        VdNWctyQy3z8+9fXpFUerCY=
X-Google-Smtp-Source: ABdhPJxrQCSZtHY8+DQpXNBiO/RuiHOgAmhGZKQi+kRGtC01oBdy94Jbjub5iSh501Tf4U7hUpg5RA==
X-Received: by 2002:a05:6a00:198b:b0:4f4:22f3:2fbb with SMTP id d11-20020a056a00198b00b004f422f32fbbmr10755169pfl.20.1646212077441;
        Wed, 02 Mar 2022 01:07:57 -0800 (PST)
Received: from mail.google.com (122-58-164-114-fibre.sparkbb.co.nz. [122.58.164.114])
        by smtp.gmail.com with ESMTPSA id g7-20020a056a000b8700b004e1bed5c3bfsm20339062pfj.68.2022.03.02.01.07.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 01:07:56 -0800 (PST)
Date:   Wed, 2 Mar 2022 22:07:51 +1300
From:   Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     gregkh@linuxfoundation.org, realwakka@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: pi433: remove rf69_get_flag function resolving
 enum conflict
Message-ID: <Yh8z5zWfpVKWNYpQ@mail.google.com>
References: <Yhla4a1Clpguoo2h@mail.google.com>
 <20220228063238.GA2794@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220228063238.GA2794@kadam>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 28, 2022 at 09:32:38AM +0300, Dan Carpenter wrote:
> Looks good.
> 
> Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>
> 

Thanks for reviewing my patch Dan.

> >  4 files changed, 4 insertions(+), 69 deletions(-)
> 
> You don't really need to write a long commit message for a commit which
> deletes 69 - 4 = 65 lines.  Just say "Remove pointless rf69_get_flag()
> function and call rf69_read_reg() directly.  This cleanup removes 65
> lines of code and it more obvious to read."
>

Thanks for the feedback. I swear I don't do that on purpose ... I have always
struggled to be succint tbh. It's just something I'm actively working on...

> > -						  rf69_get_flag(dev->spi,
> > -								rssi_exceeded_threshold));
> > +						  rf69_read_reg(spi, REG_IRQFLAGS1)
> > +						  & MASK_IRQFLAGS1_RSSI);
> 
> The & character should go on the first line.
> 
> 						  rf69_read_reg(spi, REG_IRQFLAGS1) &
> 						  MASK_IRQFLAGS1_RSSI);
> 
> But that can be done in a follow on patch if you want.  Or you can
> leave it as-is.
> 

Noted. this patch was already merged into the staging-testing. I will
send another one fixing it.

Best regards,

Paulo Almeida
