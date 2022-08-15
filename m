Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37C63593270
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 17:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbiHOPt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 11:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbiHOPtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 11:49:24 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29614E23
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 08:49:23 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id f65so6800440pgc.12
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 08:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=4dMBLF5BGokioWpGIdqPnwyyYw9hLz+LiOwDTyhLGYM=;
        b=B0ighMVJ+NYAVPFU8x6BTr5lb5NR/AjzjEU7eAfsfPnEt3pYIXUbcmoYYez0e0l7Pp
         ny64qnifhxMIP+DOU6sSV3bZxwgNRwpfFCyJIE0Ews1RcTTnIgu9SIWQba8kiqBGQUqk
         LqGK8naG4dK6AYuVuHALDa5CyOx6widol9Bm17df2gbu6LEWFAA8fXu6uKgXakVkvEXF
         6eDyLGAU3NMW2f8PnBBZ1lxA+RBx1hOEf0xntFcfXsdvIlWO3O86oCbSBKtlaYudmNXe
         GE1CbC3yn+M90oDGpbnOK8JKev+WEP8Lc7rS3jBq6DobbSzmTdjyz/GfKOU996v4TZEi
         zVlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=4dMBLF5BGokioWpGIdqPnwyyYw9hLz+LiOwDTyhLGYM=;
        b=5UrrYd7v3DhcZpVk+c2mwSTi9d4m/PxbdyiYo//yZIxrOfE1qWKqLVQxyWjbjxuoT1
         klnJsTwPDMlxpewf9KB4ybRfcWKh/GpNl2CmpbYBWmz4dcJPlTasErtgLKI1SWDv5MK6
         o6CU0QYGATKqGb3rtehIvrvrapov5aD7xzSR+xkeCi/LcUePHRCwkNaPtH6Bt5fcf0bV
         fXs9rMUfU+xzgFc4Mlkh7o/pfyTydgUdL4kC3/gRfSBgqXRfrWSgFQzSmdYVYZgTL5Ys
         hoe5gjLdNM9/X1CN1CoJRHUKl+jrERqHT4OMEWVfep+Veb3IUON82/FZPWCz1g3Q3Dwx
         gypQ==
X-Gm-Message-State: ACgBeo3D0uoIUbC6A3XwdxFmftU8WJc2/lLvJ8K+G4QkvRwPUNsDEbUw
        hvQSwsgXkr+Tb/1uCqLNmiM=
X-Google-Smtp-Source: AA6agR5Xvs+kWxMri3ik+t3PGCG0cLKnchnuxg5xumUZuPhSeNfc4YcLzC3sFkPU2PmbW1sdGYId4g==
X-Received: by 2002:a63:318a:0:b0:41c:b82a:dc6d with SMTP id x132-20020a63318a000000b0041cb82adc6dmr14473397pgx.319.1660578562631;
        Mon, 15 Aug 2022 08:49:22 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z6-20020a170903018600b0016d2db82962sm7239418plg.16.2022.08.15.08.49.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 08:49:21 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 15 Aug 2022 08:49:20 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>
Subject: Re: upstream kernel crashes
Message-ID: <20220815154920.GA4027315@roeck-us.net>
References: <20220814212610.GA3690074@roeck-us.net>
 <20220815054117-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220815054117-mutt-send-email-mst@kernel.org>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2022 at 05:43:19AM -0400, Michael S. Tsirkin wrote:
> On Sun, Aug 14, 2022 at 02:26:10PM -0700, Guenter Roeck wrote:
> > Hi all,
> > 
> > syscaller reports lots of crashes with the mainline kernel. The latest
> > I have seen, based on the current ToT, is attached. Backtraces are not
> > always the same, but this one is typical.
> > 
> > I have not tried to analyze this further.
> > 
> > Guenter
> 
> Thanks a lot for the report!
> 
> Could you please try the latest vhost tree:
> https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git linux-next
> 
> which has been reported by Andres Freund to fix a similar issue?
> 

I have now literally seen dozens of reports with syzcaller crashing
in various code locations, but we are still trying to actually reproduce
the problem. We'll respond on the revert patch once we can reproduce the
issue and thus the fix.

Thanks,
Guenter
