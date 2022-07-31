Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4EA1585F3E
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 16:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237169AbiGaOTj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 10:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbiGaOTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 10:19:36 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F3FEDEC9;
        Sun, 31 Jul 2022 07:19:36 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id g1so6722409qki.7;
        Sun, 31 Jul 2022 07:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wjhOCEjtjLfjibZ6tVUb+knW39OSGuyczB8f45t6wRA=;
        b=PN+B0TtFil8D6i80oaBJaEdn/j3r8FsfPz7APQycId4HQqUNBOCzbsFmakfxPSBvgQ
         54TMcdXBeBwXf+bqYcklHsNWY9EzcWJbnt9V6T+hNFrU23jMWa68iVdkmQGZAzA0KMb3
         uX8SnAbePvZIGcw6P9ri/4FhWe+MKY2SXUWFnJBJ9BupSHw6Ng/RkDmzsDQPcNreCaOG
         RuJkTYrxZr7jWI4fDOfburSExNNJvVpp02v3Q7YF9dc8Me2lXIuiHdMvCPTMHrIjmu5a
         EXbmoW2KbMLkSG+CxdW1rtQRORdLF1lhTEPrCxfYjDcpLuzs49GGet5cqHPq2KZoptDh
         eoPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wjhOCEjtjLfjibZ6tVUb+knW39OSGuyczB8f45t6wRA=;
        b=OurM/Ck3RKP/17hlb2f6dcsHK4RPHBtFWkj9r7LoGOLGkeb5YVGjlNJ9kI9rc7P5IU
         aXC9Y7uUDeQ9s26reLT9G/89aaWxrnwMtuB7vEk+jjRlwDaB6uNHgLlULuRHJbxeSfYy
         pH7WzXfq9lgnvcIR1M/rA3kFeZ/DJRSOU0fI3kzJKanHRXL4Pu4nassH1/b7e5JMR4w6
         XbiscztX9BsMNZ+W2/+3W0Jklf/nGuBKonBgHSt+WCv4vswVU/zL2F7pQU+Y3Du21l9g
         xLG7f3gX63Fhoi6vSXarFnjbJ6rC2C+wFzlkdyGgxu4pWnXX7/aRH0lFv2Q3y+p63tuh
         m8pA==
X-Gm-Message-State: AJIora+QXTSgHWJAXaLWydAIIdt9xNffT/PSg/AubvOxJDKKrham2yjS
        MynX9xFl+tLG/Zr62uK3zVGlV7aKgks=
X-Google-Smtp-Source: AGRyM1uyz+9/NZ1MBJd9aAa2kRIkRe472vgZq8ZwlKubB7tQTZgg2ujqxVs8t7T56MryP8fmbaOw9Q==
X-Received: by 2002:a05:620a:1929:b0:6b6:19c9:462f with SMTP id bj41-20020a05620a192900b006b619c9462fmr8600580qkb.688.1659277175066;
        Sun, 31 Jul 2022 07:19:35 -0700 (PDT)
Received: from spruce (c-71-206-142-238.hsd1.va.comcast.net. [71.206.142.238])
        by smtp.gmail.com with ESMTPSA id h23-20020ac85497000000b0031f229d4427sm5382488qtq.96.2022.07.31.07.19.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Jul 2022 07:19:34 -0700 (PDT)
Date:   Sun, 31 Jul 2022 10:19:33 -0400
From:   Joe Simmons-Talbott <joetalbott@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: Be consistent with allocation result tests.
Message-ID: <YuaPdctDFDIIVn9x@spruce>
References: <20220718020348.32047-1-joetalbott@gmail.com>
 <20220718174441.7967830c@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220718174441.7967830c@jic23-huawei>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 18, 2022 at 05:44:41PM +0100, Jonathan Cameron wrote:
> On Sun, 17 Jul 2022 22:03:48 -0400
> Joe Simmons-Talbott <joetalbott@gmail.com> wrote:
> 
> > Make both allocation result tests use the same format
> > 
> >     if (!ptr)
> > 
> > Signed-off-by: Joe Simmons-Talbott <joetalbott@gmail.com>
> If you post two patches to the list that will cause each other to not
> apply, please base one on top of the other and say so in the
> patch description.
> 
> Anyhow, fixed up and applied by hand.

I'm sorry for neglecting that and for creating extra work.  Thank you
for fixing it.

Thanks,
Joe
