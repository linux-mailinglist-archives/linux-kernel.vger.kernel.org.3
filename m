Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0C66486AF0
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 21:14:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243604AbiAFUOi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 15:14:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbiAFUOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 15:14:37 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04FCEC061245
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 12:14:37 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id j16so3244722pll.10
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jan 2022 12:14:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iY7kaZWechPsDL3Q2mJcGuDW8q/eF7XLJPP9KZVQVwc=;
        b=KNr05I3wAGKIk2RV2Y7lMTmPYQBJlch8m8XX0o7OWe+L0TVKyIvZD1S8rJIAERnHYu
         zyvGrekWXD22/FLLNq8ZbeS10yDkiJ3tz/6LufLZY/yO6vQuIGJ3k9qvxRb0/dXrFeC9
         Z+l0BpaawmD5Ou0HPcfrTJZstZXTdcgoE7P/YgpKW9zcTUpGtTKHUFp784fc/KY6rhdv
         eEC1McorJRnQxaFvO/iI/3tyGUXMpFL1vHubhfBb3uKqrvH0Ghhd8CI/fcq0WuaYaZMh
         R5MqhowepaKmn/lyjMtUgAMI8VHRVb47pLBnfHljv23hOVi9ppF7S5oCw/AgxcH9Rik3
         GoVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iY7kaZWechPsDL3Q2mJcGuDW8q/eF7XLJPP9KZVQVwc=;
        b=Bfgqu+9TZco6KKJH5P0e9VF4uWjlMZMcTLpZ5EfZM6uwT/kxZ6SCM7ur+ZCx6Z+Y9f
         OB0+ARpLDS3YTq/jLEsXkjOIMfyzTK18A9IeA7yk0Xx86DdopYCxGrP28YgIPIybbRUV
         c8LW8WnkkBjBubUjbCd/iNdVZM6SAnuO9vudlbxmo9t+zCnMB0Gxp/A7hLv36rRC9urn
         euJi55KeH+g0BY3ygzigMw1Zbhx9+Cd7/gl+APCufEY1AGLiDj8N4JMt6Bi6LRDvQQKE
         GzsiKxv2Z3xIPRP7uG3hdojmG+bNd2efXWkhRYZPII64MZqpE1VeVYILrvaJLoVS+Dht
         845w==
X-Gm-Message-State: AOAM5326mFCvXNJ5KwFJngr8ajGF2bZSSLrPT/sqm1UFxB2m3/pwo7im
        H3lvkHK3VFGBEnqOBUM4KZA=
X-Google-Smtp-Source: ABdhPJyygoC0sktO/hQHbN0E2GrqJNnr8NvPR62/Rpv92McIKlH1hsaYEaz6rmQFd+qkok9K7LQc/A==
X-Received: by 2002:a17:902:7fc6:b0:14a:663:f359 with SMTP id t6-20020a1709027fc600b0014a0663f359mr464061plb.169.1641500076487;
        Thu, 06 Jan 2022 12:14:36 -0800 (PST)
Received: from mail.google.com (122-58-164-114-fibre.sparkbb.co.nz. [122.58.164.114])
        by smtp.gmail.com with ESMTPSA id c6sm3285512pfv.62.2022.01.06.12.14.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 12:14:35 -0800 (PST)
Date:   Fri, 7 Jan 2022 09:14:30 +1300
From:   Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
To:     Sidong Yang <realwakka@gmail.com>
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: pi433: move get version func to where all other
 functions are
Message-ID: <20220106201430.GA3416@mail.google.com>
References: <20220106093110.GA20011@mail.google.com>
 <20220106101946.GA23794@realwakka>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220106101946.GA23794@realwakka>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 06, 2022 at 10:19:46AM +0000, Sidong Yang wrote:
> > +int rf69_get_chip_version(struct spi_device *spi)
> > +{
> > +	int retval;
> > +
> > +	retval = rf69_read_reg(spi, REG_VERSION);
> > +	return retval;
> > +}
> > +
> If we don't modify retval, why don't we just return directly without
> retval?

fair point, I will change that.

> > @@ -17,6 +17,7 @@
> >  #define FIFO_SIZE	66		/* bytes */
> >  #define FIFO_THRESHOLD	15		/* bytes */
> >  
> > +int rf69_get_chip_version(struct spi_device *spi);
> IMHO, I think that we don't need to include 'chip'. Because all other
> functions in this code don't have 'chip' in function name. and version
> code seems to be more accurate representation.
> 

will change that too. Thanks for taking the time to review this patch.

thanks,

Paulo A.
