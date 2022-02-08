Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9C894ACFEA
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 04:54:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346492AbiBHDyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 22:54:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346495AbiBHDyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 22:54:11 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DE2CC0401EA
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 19:54:10 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id e6so16613558pfc.7
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 19:54:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CrI21+GeUa9mDY1to6AwbsA2jAr/D2vzHzn49pGgXGE=;
        b=K0rHE1yiOyGdFpo+TJrdid8OekFSu5VsJNQTBjNwo03OUwRRDY2ylwfZeW/HzWHGxU
         EUIh8KOJGBjjFgffI4DFBSOLjoAtVWJVmZ67wg10Pf7pvDZBUyvlhTDLBIQCJ3GDEP+9
         NmSA4or1ItZFOjgtaUvoRsxkhd2Z3/z72oNKRNVkdTuBVKZlo3YfQj+jCdJE2pbJYgfu
         PxduBnFGbkT7zRpXyftW1Fgo1CuIyolVhUKIa4jEZ0QgRhWd49Ba+Miw4ka9xhGS2Dpk
         vbXpkOnFxd9BNCtyTlfwGugPaeTJg0AwAE+Y6d4hozWeg8XVD/JLV075/h2XtXVFzVSn
         GNuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CrI21+GeUa9mDY1to6AwbsA2jAr/D2vzHzn49pGgXGE=;
        b=UCE8VLy0U9W00cdw9T9IAc4U5hzN7H2KbofDkbRVsgAIc/43UNRQ7ynCOjmlCjxHbf
         6S3PjSqePlQAdnmCVTb8DDPAn0P/+++8ZFWFkTRYqjdTzBnXYbCr6fxQLAgXaGkRiJtz
         sG/XzvGIAmYFnJEW2JUWIn3jXyiOC79m+nl2jXcVee8jhrMDhQ0GrygXt/WJceC0AGKx
         ZTRL6z9znPRD89OstJi/Cu3DFdARDQU9TokaK5hNE3SFRgCRyXeT9sOnlJ+kQk4OPgbw
         wWlsLWLcUsbx1s1iQJBTKzXI0Ih+bqe0PRWZ6Gi5Xga1DNbMyPrNQsobH/cfgR2DRWAm
         ng1g==
X-Gm-Message-State: AOAM532WnIl02ji/klGRM42Aa07MKCcxiddO6u5AVAqSIBj8RvzRfMTd
        qVQrfbdyVLL0d4t+LUBFwpo=
X-Google-Smtp-Source: ABdhPJwQ0TBuhP0lUeWtWFlGeE2pQ5qCQ5dYfw5E4EauEyPfAmTzQXqzFDy6qw0t6Gd5dLPUbBLpDA==
X-Received: by 2002:aa7:94a9:: with SMTP id a9mr2532139pfl.78.1644292449691;
        Mon, 07 Feb 2022 19:54:09 -0800 (PST)
Received: from mail.google.com (122-58-164-114-fibre.sparkbb.co.nz. [122.58.164.114])
        by smtp.gmail.com with ESMTPSA id p64sm9210078pga.13.2022.02.07.19.54.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 19:54:09 -0800 (PST)
Date:   Tue, 8 Feb 2022 16:54:02 +1300
From:   Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
To:     Joe Perches <joe@perches.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        gregkh@linuxfoundation.org, realwakka@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: pi433: remove need to recompile code to debug
 fifo content
Message-ID: <YgHpWpivQHcS+Eh1@mail.google.com>
References: <YgCj2P59AbFFmnbA@mail.google.com>
 <20220207100601.GF1951@kadam>
 <a630d8381cee0f543e0d77614052e1d04ab162a5.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a630d8381cee0f543e0d77614052e1d04ab162a5.camel@perches.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 07, 2022 at 02:15:47AM -0800, Joe Perches wrote:
> > > -#ifdef DEBUG_FIFO_ACCESS
> > > +	/* print content read from fifo for debugging purposes */
> > >  	for (i = 0; i < size; i++)
> > >  		dev_dbg(&spi->dev, "%d - 0x%x\n", i, local_buffer[i + 1]);
> > > -#endif
> 
> If you use
> 
> 	print_hex_dump_debug
> 
> perhaps the DEBUG_FIFO_ACCESS could be removed.
> 

Hi Joe, thanks for taking the time to review my patch.

print_hex_dump_debug is pretty convenient and straight to the point
which I do like. The only thing that I "didn't like" is the fact that 
when configuring dynamic debugging, print_hex_dump_debug only cares 
about 'p' flag and ignores all of the other flags that can be helpful
for tracking things down. 

So essentially I lose track of which function and device instance 
the message belongs to (users can have more than 1 at the same time).

But, because of your suggestion, I came across hex_dump_to_buffer()
which bridged the gap. thanks a lot :)

Would you be comfortable with the following implementation? (Dan, feel
free to chip in)

	char linebuf[FIFO_SIZE * 3] = {0};
	hex_dump_to_buffer(local_buffer + 1, size, 16, 1, linebuf,
			   ARRAY_SIZE(linebuf), false);
	dev_dbg(&spi->dev, "%s\n", linebuf);

thanks,

Paulo Almeida

