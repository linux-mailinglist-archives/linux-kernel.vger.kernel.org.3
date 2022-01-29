Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B11C4A2D95
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 11:21:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233909AbiA2KUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 05:20:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbiA2KUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 05:20:12 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56BF4C061714
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 02:20:12 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id o64so8910785pjo.2
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 02:20:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eNsBUeSPBs0Qx4jcu0B26Fmmisvc82tqbPd5SR7juWw=;
        b=PO6ZuNzqPth2Ll5QiIIVzIuXypGKRintUdfijuI4Q3ax8D0X9bnCQa+lRPa8PJJVzz
         Nrnot9GwYozCGu+i+AakNEHNI0U6nYXjdc1lmKDVfiH2KaDhIm0fRrXVhP3VjBJ0fLh2
         qScsbySfuLmCg4Htow+98kU4NCNM7qtbU2LkjhJbhtEM5xBt4g9tYGnIsZB/cl1Yhy2h
         0YKyoeKHxb9iWDPdoCjCWO/SWAu9IlZAzu1s/IRM0WmKe2Tn9wTkLGmwBkUfgVKXnmKb
         8kv2GJVroz/TZYyNVRoUmFh2VFe4jH/GpPr09gdelU29raOHfmBQlq5s1vF6tF8sv1tq
         JTJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eNsBUeSPBs0Qx4jcu0B26Fmmisvc82tqbPd5SR7juWw=;
        b=ArPGlM8MMlTmjGhq080ciBA8VfnFPcMPDjgQvKIpWrX0i1BVuEw4yUL4ZbE6Oph3mM
         jSaJ8YvAJtGHE/GNkauzaLnwk6ScH7ztzK9s3pTnd0uhHMQDWwtFP0yCqvyoJOnhg77C
         LHWgPGgVignYTpDKqA9VGcK1hmzaf5wOUs6lHj+yzm/WRkUxsoliW00ZfbH159/too/Z
         tbXq/adGTK6TQn3+sVJWr4ncASEC/Bd/B2kAe6jXFzEObEWnKPdAmw8IjK+3JTi0i7pF
         8/ab+4jS2bq9eV6NiyGW5DDPvQYogMXrnArOXyD7uWRcawPktYGIvYG/XZbeNX4iRHIN
         zxnA==
X-Gm-Message-State: AOAM533LbrO2Lav4BJIH/zqtnvj0iYpkHbTeUWBSZG/VddgjHbRKXnjs
        MZ2pCZCRYuKtR1CrVKnmIhI=
X-Google-Smtp-Source: ABdhPJz8lNeovR2tijhKSePiGxzOcKkGdCrx5jTEU0R+kIZq2KeNdlh1xfxdG38Qp5rLn5lE9CYEoQ==
X-Received: by 2002:a17:902:bd0a:: with SMTP id p10mr12779367pls.159.1643451611733;
        Sat, 29 Jan 2022 02:20:11 -0800 (PST)
Received: from nlap2 ([171.78.146.184])
        by smtp.gmail.com with ESMTPSA id h6sm12312606pfc.96.2022.01.29.02.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jan 2022 02:20:10 -0800 (PST)
Date:   Sat, 29 Jan 2022 15:50:04 +0530
From:   Abdun Nihaal <abdun.nihaal@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        straube.linux@gmail.com, martin@kaiser.cx,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] staging: r8188eu: remove unneeded ret variables
Message-ID: <20220129102004.im7dcq5gbuyqlw4o@nlap2>
References: <cover.1641551261.git.abdun.nihaal@gmail.com>
 <c9c24c13d2823ccaadbbce33613d1242531dbe86.1641551261.git.abdun.nihaal@gmail.com>
 <YfATARBq6FJ2e3HE@kroah.com>
 <20220127152543.ttvp7gj5bzpuvr3p@nlap2>
 <YfK/aOgEqftXuj1S@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YfK/aOgEqftXuj1S@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 04:51:04PM +0100, Greg KH wrote:
> A single patch per function you are changing is a good idea.  Do not mix
> them all together, would you want to review something like that?
> 
> Always remember that you want to make changes obvious and simple to
> review.

Got it. I'll split the changes, as single patch per function.

Thanks,
Abdun Nihaal
