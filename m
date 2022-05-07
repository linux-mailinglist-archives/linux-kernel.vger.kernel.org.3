Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCFCB51E8E3
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 19:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446727AbiEGRWM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 13:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245209AbiEGRWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 13:22:07 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 422D126118
        for <linux-kernel@vger.kernel.org>; Sat,  7 May 2022 10:18:20 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id bo5so8799005pfb.4
        for <linux-kernel@vger.kernel.org>; Sat, 07 May 2022 10:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eKNedDDZfJ4ci5b7bFFqS85iYr1ECe/8cGsLZUJPlMU=;
        b=OunbZzN9WxFNeLIyIWFxffNjd70Cv2S8fskn+yi3F/zqKhfW9VTmAVBh2EOwpDTKs0
         i7JdXP207AWKuPuMr4sSrZ6J0xM34xHkOJIVYVb8OLmkP4rBOEjkaYWi9HagX8wvjJcu
         DZVToWU/ZfhoHgCwW4X7JSc6pJG/vANOBgfhs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eKNedDDZfJ4ci5b7bFFqS85iYr1ECe/8cGsLZUJPlMU=;
        b=cxSyvK7bx9WXKMlilYDybv44NGMb93XBbuRae8iULUL9lD7rDrfA3Nv3oi7SHMr7AD
         77TVYBZsZlpdrhkkDEJ86VOAXmTuyl6CbKXWeRDRGueJjhneuR2eiUJINIF6AUxxdjH3
         s1iaLY0UOFGX0lxUWZCYgPZhGUxDzZBwRcr0nNOLGB20RTdDx+rUKI1rA0InwBhvxa+0
         ov3twj/OlRbnTdnKvizAC/Nvhdqu+OHWnJ3PK1xTUCStiR7r6tRdmWw82TtL9GEBHRfi
         FiL/2amSycddd4cq3tGT0Y3G1ulPmbRo4b6G72GITTlZmuivFRgRDXQZ6458KYoyoEpA
         Pq6Q==
X-Gm-Message-State: AOAM533hC2pT9xTk0Od5t0r9peUbMBj/r5Y8f23XCsjUQjEtVVC+bN/d
        C0g3/ZFDqYqVjTidxR3YMv/X/H5h5hIYjA==
X-Google-Smtp-Source: ABdhPJzZud4xEczlEpaWj6i0hJdD2WC6JoekhZsoal2NcPjLhS9Axq5tyLRHzLkzraChV7ItFkPPIA==
X-Received: by 2002:a05:6a00:23ce:b0:50d:823f:981 with SMTP id g14-20020a056a0023ce00b0050d823f0981mr8861123pfc.10.1651943899731;
        Sat, 07 May 2022 10:18:19 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c6-20020a170902724600b0015e8d4eb2e6sm3839174pll.304.2022.05.07.10.18.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 May 2022 10:18:19 -0700 (PDT)
Date:   Sat, 7 May 2022 10:18:18 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the kspp tree
Message-ID: <202205071017.A93125B0E@keescook>
References: <20220505174025.07cc9967@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220505174025.07cc9967@canb.auug.org.au>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 05, 2022 at 05:40:25PM +1000, Stephen Rothwell wrote:
> After merging the kspp tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
> 
> [...]
> 
> Caused by commit
> 
>   f4cfacd92972 ("lkdtm/stackleak: rework boundary management")
> 
> or maybe commit
> 
>   cbe7edb47d3c ("stackleak: rework stack low bound handling")
> 
> CONFIG_GCC_PLUGIN_STACKLEAK is not set for this build.
> 
> I have used the kspp tree from next-20220504 for today.

Thanks! Sorry for the glitch; Mark's fix should be visible now.

-- 
Kees Cook
