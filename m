Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06C2F50AC46
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 01:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442693AbiDUXrq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 19:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442741AbiDUXri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 19:47:38 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D044142EC7
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 16:44:46 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id b7so7130142plh.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 16:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Xb/o1YoXSro4rOpc/9fDNjy0WQI2db6K4zofA5onjWE=;
        b=fbBS9qslB4mC4FEqVvu+uErZXwLjKCng4BXLZFBxGTgyHo+5Ou/a86ZV88oAlcJHxF
         CGakfLnXzRRf+QVcu0f/HUje5/q4SFlRtm2gMQj9xAJaHiYl4JowiwyTHu+TAfnd1MRH
         yFq4vCLGWren79EmvXzHAt+n+vzo6N3jK4oeHxucBQ3x5Lj/F3qs8RIDFQIkQom1mGUq
         dSbxu6S/rNdBNe9ZqRlWRAteTTlGbGnWxtgzmehIixwRuOrineCykxEF9ohdLi2C5M60
         2hBbQPvnSFFv9XLx2LAp89CTxDVu54ZmDCUj2vGpJi28+nlNCLO13SOdGRhjS6k4PvtO
         34HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Xb/o1YoXSro4rOpc/9fDNjy0WQI2db6K4zofA5onjWE=;
        b=j4oIA9OfXd/W59a8D0dIbdlJhrcnJEQPMtaxlcW79xsVAV/vsVymG/NzrsqimYQTs7
         /xQ6nql7vYufWiMlfdG8Pl1SpjaK62IGMCbi06DE+tcURkd61NmS/oHLXPbdalCWvDxm
         HhC/61T1fIDJE9LAudZIb75pjpUw3XqQ98eQhlunYxbOlrfULdKggt/jHL2wAE6G/4iT
         x1iAuoKPUKpd68BvKXLN+2Fzj8vISxiI73Ix9nxiWe2UaDpl+zF9R+7z3iSQqwSC9u41
         STHVixZN51eNUAQPO5h0o5DDfWFueJkPpCaFKAoaAiECZ34hzv5B+c/3JUknYFYU/+wH
         8SoQ==
X-Gm-Message-State: AOAM532VJQ+Cfo0FirdCFOVVnPUu8zXE/qiPyTsHAOZuh+jbyV/vy+Y6
        PNIXjuhD6hyIfG8puShTFqc=
X-Google-Smtp-Source: ABdhPJxkwDxhATvNMv4TbI7vaKOXz9suZHw82pJjsBVJzLyfCEoi+E2Wd576UIhZCC6VrS7cmeGYYg==
X-Received: by 2002:a17:902:c613:b0:159:9f9:85ec with SMTP id r19-20020a170902c61300b0015909f985ecmr1856237plr.67.1650584686188;
        Thu, 21 Apr 2022 16:44:46 -0700 (PDT)
Received: from ArchDesktop ([14.100.36.163])
        by smtp.gmail.com with ESMTPSA id y190-20020a62cec7000000b0050adbfee09asm212056pfg.187.2022.04.21.16.44.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 16:44:45 -0700 (PDT)
Date:   Fri, 22 Apr 2022 07:44:42 +0800
From:   Solomon Tan <wjsota@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk
Subject: Re: [PATCH] staging: r8188eu: use in-kernel ieee channel
Message-ID: <YmHsannu/vcKX9Kk@ArchDesktop>
References: <20220421015811.2745-1-wjsota@gmail.com>
 <20220421170010.GD2462@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220421170010.GD2462@kadam>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 08:00:10PM +0300, Dan Carpenter wrote:
> On Thu, Apr 21, 2022 at 09:58:12AM +0800, Solomon Tan wrote:
> > The rtw_ieee80211_channel structure just duplicates the in-kernel
> > ieee80211_channel structure
> 
> When you say that they are duplicates, I expected them to be the same
> but they're not at all.  ieee80211_channel has a bunch more struct
> members.
> 
> I don't really have a problem with the change necessarily but the commit
> message should not have mislead me.

Sorry about that. I will amend the commit message and send it as v2.
Thank you for the review.

> 
> regards,
> dan carpenter
> 

Cheers,
Solomon
