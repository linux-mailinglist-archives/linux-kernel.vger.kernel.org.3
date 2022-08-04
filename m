Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90BD058A351
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 00:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240033AbiHDWf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 18:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234746AbiHDWf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 18:35:58 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB2266267
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 15:35:56 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id b21-20020a05600c4e1500b003a32bc8612fso509492wmq.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 15:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=GjhcCM6pqUfDNnBpeTBTrm5a2+uQw6A9z6WoPf0/fPw=;
        b=t8yThKZC3eE9v7bQ67YqGuHSMxvZqH2fBBRFYDhtuEoV1F3JD0O1o14QmFYgIsm6CP
         uSkYNSebUa2MyO+wnGTok5JA0h2tHKmQue4gPHuUC2Bkhbwg0nS+YQzqUVnl/gCzgo+B
         uiQg609+1qsh74kxhOTfp6eNHne0Nt3pDlJELke/yiGsJtssYyPH14Esvecg02IVVXGO
         T5fa9tdb90W431J+9vmvF6VhqxwitQ4E/yWEJ/inpw1aLrmETElvnrehnfVgdqpVKqEq
         uWf9/4Smth4kO6EmaGVKqcBax9qjfeXjyawh/EGCnkUPrS48lmhaitTYjaOVaxu8dhff
         ip0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=GjhcCM6pqUfDNnBpeTBTrm5a2+uQw6A9z6WoPf0/fPw=;
        b=uYyIja9NiU3RXkpdD/yJkpTbPEhRKe6zHrEoajNWBucouEgMbfMCrp5sB8zv0btIrD
         H8z2WKl1XcmOu3WTzf/w/8q8/t+BCZdbAFYARW3/yGXbyOwCHwLqQqkrNQSt9BWm8sao
         UbwbnvcRhQOycvQsWt1Z6PEZlIzVoRYQcKdKCdSHv7B8hedXHp7mX6/AVlUg4yqKDfrn
         7fjixUJdocAgHDW9xir6zPVbhHZ9U2xxbXxwUv28KV/pMnBrN6nf2RVl9ooKKkVzOKsr
         UagvS70UwQh4GxXr6FlOX4XL3V9RLqkQ0UjBTfkjfyoWDIezYQKM9ngHQWfczl+Kos4I
         XvTA==
X-Gm-Message-State: ACgBeo37tKhtsq358SkTYfI6tndcFWgkCn165P83Ex2oVrjpuzAX3bxt
        NCVaQtpCRS0QEGSdmPEc7LapMw==
X-Google-Smtp-Source: AA6agR4IdWEIrrj7cqAiF+rraowt3BssE45/V3N60GXpNXoJWEahPJtx2WjbCwON5R4BvPQCqN8dhA==
X-Received: by 2002:a05:600c:49a4:b0:3a5:fa7:18ef with SMTP id h36-20020a05600c49a400b003a50fa718efmr2665854wmp.156.1659652555540;
        Thu, 04 Aug 2022 15:35:55 -0700 (PDT)
Received: from equinox (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0::2])
        by smtp.gmail.com with ESMTPSA id n21-20020a05600c3b9500b003a2d6c623f3sm7619306wms.19.2022.08.04.15.35.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 15:35:54 -0700 (PDT)
Date:   Thu, 4 Aug 2022 23:35:52 +0100
From:   Phillip Potter <phil@philpotter.co.uk>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        paskripkin@gmail.com, straube.linux@gmail.com, martin@kaiser.cx,
        abdun.nihaal@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: r8188eu: convert rtw_p2p_enable to correct
 error code semantics
Message-ID: <YuxJyETZ3KM4uaoH@equinox>
References: <20220802234408.930-1-phil@philpotter.co.uk>
 <20220803121108.GC3438@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220803121108.GC3438@kadam>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 03, 2022 at 03:11:08PM +0300, Dan Carpenter wrote:
> On Wed, Aug 03, 2022 at 12:44:08AM +0100, Phillip Potter wrote:
> > Convert the rtw_p2p_enable function to use correct error code semantics
> > rather than _SUCCESS/_FAIL, and also make sure we allow these to be
> > passed through properly in the one caller where we actually check the
> > code, rtw_wext_p2p_enable.
> > 
> > This change moves these functions to a clearer 'return 0;' style at the
> > end of the function, and in the case of errors now returns ret instead
> > of jumping to the end of the function, so that these can still be passed
> > through but without using a goto to jump to a single return statement at
> > the end which is less clear.
> > 
> > This change moves the driver slowly closer to using standard error code
> > semantics everywhere.
> > 
> > Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
> 
> Looks good.  Thanks!
> 
> Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> regards,
> dan carpenter
> 

Thanks for the review Dan, much appreciated.

Regards,
Phil
