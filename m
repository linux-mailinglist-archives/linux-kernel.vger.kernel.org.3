Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61E02528D9B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 21:02:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345239AbiEPTCC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 15:02:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345238AbiEPTCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 15:02:00 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 883C71AD83
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 12:01:59 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id l16so19771465oil.6
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 12:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2YwGLCuXXdxzRprrcHdq2r25grm4OfvgiyP5rpgD0WM=;
        b=f+c98yS52pFFzSziGTdh4U0utkDNkPrkyJ3jaPgino5h2ry6JhDNmX1+ByFNrJuLID
         EicG9R+0V6WMX8WRh68G9zeTHPmAq4OhWwbiqGDmb1VVFcLGil2JD8CrMRkJ/EY4J81p
         3gutEtWkh2Ul6LsBR7K/VN34qFPB8qVQuaO6rqfJfWypv0BTIZp88CYo4bR/IFtZrJS8
         obKLBK7nxOuWfbQaGa9765nxoNpouqMIwiXwYYLb5qelHkTB89ykAuvxT6rbK3aCeqqq
         QPsvB9sKTuH3GXaUzpFCDDM7/q5VMMovItVJC5D0OSwuBB+ctbPpiQMMSFUh9enh80N/
         rrzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=2YwGLCuXXdxzRprrcHdq2r25grm4OfvgiyP5rpgD0WM=;
        b=eTLZFIh+1fzIvJZQbMKxReNtHsDiY+wUyvQK4QIGWkfMMyVIaT13JJts/DznrCxYf1
         04R70c17szhu2zoKHs6Gcpl5jI182JgC+/dqs+oX1xFOU0ktTdgmiKVnSQ3actE2JRqN
         WzUXRREK37YujatAJYoGbbc0fbguhLpMbNH8XvEjJnuSyM2vBNF3u0GC3pg4htLOlujL
         oyUp7Z+zg5IP03ciXwpV+6g+sc4+2wIpP+rh/RQkhYyPXTDvlUfgWOuf6wXRFr5hUcvE
         WmZ+73kdcnsbe3YWZ59KFjvujjkPHeNZL+YYgl8nAgCCJzvtU2PVth4mcmS2n3esx+z0
         WEiQ==
X-Gm-Message-State: AOAM532iNNfisqsIc20Hxo7YrwpU9IpgJn7l7ll+vWNjWdNcNG22ZCpz
        8SgX3moQ9PPK+ey3jR5eeQQcSECn5NxO9w==
X-Google-Smtp-Source: ABdhPJwHKYJsUSxKUb+hfA4SZ+e/ATq0yLrdxUsdIDqCmOFioSLRPzG8JMhEChZDZDKZN9cT3QYxRQ==
X-Received: by 2002:a05:6808:1809:b0:326:4e31:9965 with SMTP id bh9-20020a056808180900b003264e319965mr13791224oib.223.1652727718853;
        Mon, 16 May 2022 12:01:58 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t18-20020a056870609200b000f1952c6bc1sm2621280oae.31.2022.05.16.12.01.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 12:01:57 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 16 May 2022 12:01:56 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.18-rc7
Message-ID: <20220516190156.GA3246860@roeck-us.net>
References: <CAHk-=wg2eVUN0a1E5UnBF1ziGaU1yrMJtnFPg4R78O=FcRDqnA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wg2eVUN0a1E5UnBF1ziGaU1yrMJtnFPg4R78O=FcRDqnA@mail.gmail.com>
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

On Sun, May 15, 2022 at 06:15:42PM -0700, Linus Torvalds wrote:
> So things continue to be fairly calm, and as such this is likely the
> last rc before 5.18 unless something bad happens next week.
> 
> All the stats here look normal, with the bulk of it being random
> driver updates (network drivers, gpu, usb, etc).
> 
> There's a few filesystem fixes, some core networking, and some code
> kernel stuff. And some selftest updates.
> 
> Sortlog appended, nothing really stands out (the most exciting thing
> last week was literally that Andrew has started using git, which will
> make my life easier, but that doesn't affect the *code*)
> 
> Please give it one last week of testing, so that we'll have a nice
> solid 5.18 release.
> 

Build results:
	total: 151 pass: 151 fail: 0
Qemu test results:
	total: 489 pass: 489 fail: 0

Guenter
