Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A9004836BA
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 19:19:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235454AbiACST1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 13:19:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbiACSTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 13:19:24 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E9E1C061761
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jan 2022 10:19:24 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id 205so30155366pfu.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jan 2022 10:19:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LZ0dil/lB+/9aGZq43MmnXBZ0loQwi9X6FTpsHaNwAQ=;
        b=UE0aMZ5Hs7cx6lxrJJauh4hefBzyBtuPtNYJpSBitWC7aVN3xTgrmP7oWEnjL9DIAm
         DuBqCrlFTr4Y3zplBiwHqaheHsq/nWGBMxc6liE4ORSQmihD5Pp+x+nHRj44U3RgRf2x
         bpDHNMttSvzw9YbRuOgIDkNTsMedalGn01Acr+asfIYXOrA1V5ZnIctJObrscsqaYAbh
         xtWcp8TeHz0QLrRJVfvxFyDGuzKfB2N2YDnfFFATtyWmCPLuUbM8FkpUXfwlHFqgw0JK
         7xuLlMy2LHogVs1cpzTC9Fai/F3cbA072j8wn3YHsEccH6Yn7Ti/VUobq7Y9gy5BSrC+
         TkoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LZ0dil/lB+/9aGZq43MmnXBZ0loQwi9X6FTpsHaNwAQ=;
        b=boSGO6dIb32MOJuG+cdHYV00NYOY2vogW5kjICjNTre9GiLpkB39H+pkynxRkFbOcx
         YUsB+0McQ89ofHg874NzD8B761CdfNKcj9Z/lxAqrn3FqxGkEdLiYq8vJ/+/gkJbrDqa
         RN1sX79etcyS53d8Aw2Rkdek0B26x0+3dVVVxXQqChdp8vp6Wd0Rqze/L+YBXC2OsuWq
         zMKDqGEM80H3FeVtA2yXWxwMesm9CVwTXHb4GZS5ZUYMyNwQ5S09rqHLn4jmc3ALzfx+
         Y3YjfRzeJYt4rHQk0Uohw4XRhX7HWVRnvG4x6mp5Ldh5Cx76loN6y/mQIhShfTV4xvl4
         Be1A==
X-Gm-Message-State: AOAM5336nVn1HMNsi3pcJxa1ajAwCKlFIPlebL4t6VLB+NemKD9etijQ
        jzNw1BQfjRh5j63/2lsS2LI=
X-Google-Smtp-Source: ABdhPJyw4jzaCqUS5VaBaaKIQ9Ww5kRCOafkU9iWkiNKXXWaYk1eACK3aw6VkKCU2EUdO/+Pr61dLA==
X-Received: by 2002:a63:3647:: with SMTP id d68mr41671695pga.500.1641233964193;
        Mon, 03 Jan 2022 10:19:24 -0800 (PST)
Received: from nlap2.localdomain ([171.78.146.184])
        by smtp.gmail.com with ESMTPSA id c18sm41805780pfl.201.2022.01.03.10.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jan 2022 10:19:23 -0800 (PST)
Date:   Mon, 3 Jan 2022 23:49:16 +0530
From:   Abdun Nihaal <abdun.nihaal@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        straube.linux@gmail.com, martin@kaiser.cx,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: r8188eu: remove unneeded ret variables
Message-ID: <20220103181916.36dkjuyfawrt3pcr@nlap2.localdomain>
References: <20211231172527.184788-1-abdun.nihaal@gmail.com>
 <YdL6CE3+CaU6xVvD@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YdL6CE3+CaU6xVvD@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Mon, Jan 03, 2022 at 02:28:40PM +0100, Greg KH wrote:
> On Fri, Dec 31, 2021 at 10:55:27PM +0530, Abdun Nihaal wrote:
> > Remove unneeded return variables in ioctl_linux.c that are initialized
> > to 0 and are not assigned after. Instead, return 0 directly.
> 
> Almost all of these should not be returning a value at all, if they can
> not fail and no one checks the values, right?

Yes. My bad. I saw that some of the functions were iw_handler functions and
had assumed that all of them were iw_handler functions.

> Please fix this up to be functions that return void, as that's the
> correct thing to do here.

Sure. I'll split it into two patches (one for iw_handler functions that
need to return int, and one for functions whose return value are not
used ) and send a v2 patchset.

Thanks,
Abdun Nihaal
