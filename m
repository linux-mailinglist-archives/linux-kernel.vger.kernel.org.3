Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7BBC49E5FF
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 16:25:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237491AbiA0PZz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 10:25:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237456AbiA0PZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 10:25:53 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0542FC061714
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 07:25:53 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id c9so2743251plg.11
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 07:25:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Hl5Rk2h8NJCWW0VFl+C3irZs+qSV5wYi8KmhJScU8tk=;
        b=c8lMEUYM+dRiUYpbdqKO1Q//jt0JNcNlD2yPeDJIaH9uQkBAuzR7Bmz0kXdTDpkoCN
         ArvbZCD2lAsJBPvTHIF6OSUydkSW+gItlLd7exlgij1vLS+DDgZqXH8sbHdHDPqoESvC
         kA7/LIDJsBOaPHWyNLvFHlgZngDu4eJqXvGBQhp9vdAwLeqChxIwa8JyBMNXwEyXSOAK
         +3guYmwWsxTtGt277nSzcYejLHWhcDmQv1UNqDFcXNLmMa+rhQtwLEnts4fNGYdOZChb
         Ir9lhQOpEfGvcQ31RLDi0eocjB5WXhtnKOcpuh0DpWWJeDSf/lRSNOXWxYyFQopB+CU6
         gF0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Hl5Rk2h8NJCWW0VFl+C3irZs+qSV5wYi8KmhJScU8tk=;
        b=bKJTYaB3H0mkKH97M9PUE1mFCBYq+qUnmuPRfB8DssChSgQtfrBoJBhT+09Ld8xOl9
         fPYfuvNKDjRhR9okivP6pUgyPM0zroN3yxgddOlA+Ao8fqzOdy/o7dP/I0xurqyjrCN2
         1U5cssf33MD98RUKHPv6crm7TOdgCsp64CPsgiaaGtITSN58lVk6SyIJ4AR3wDmQGgBE
         r+semXY1T7FOHE2Lia2lqk4JDk/gC2XQ09v1wx6zJ3pxh+qbabnzrFZAO9CzY+dp5YH8
         xOvLW4hqqXpcCbMblkhiTO0O5zbihjo3fElvfO2BVWYt+Q6Jh7I5Uy5AHxZJpUExf7aP
         9BjA==
X-Gm-Message-State: AOAM533EUjE7WuFG8SCQhYRsNQhc9UO+8A39vhdZ8lHLXt1HjNURI+75
        sWJETx7kUcDPjwmXa2B/+RJCUj3yQxXOBgN7
X-Google-Smtp-Source: ABdhPJxW8qeKfu0/CnjPVqAOxEPwR+OnwxVn7KG8VndsZdI5dYrES/h9MkjpcRZzHNHXA0QmMbTj/Q==
X-Received: by 2002:a17:90a:2e87:: with SMTP id r7mr4683596pjd.61.1643297151307;
        Thu, 27 Jan 2022 07:25:51 -0800 (PST)
Received: from nlap2 ([171.78.146.184])
        by smtp.gmail.com with ESMTPSA id l2sm6073915pfc.183.2022.01.27.07.25.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 07:25:50 -0800 (PST)
Date:   Thu, 27 Jan 2022 20:55:43 +0530
From:   Abdun Nihaal <abdun.nihaal@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        straube.linux@gmail.com, martin@kaiser.cx,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] staging: r8188eu: remove unneeded ret variables
Message-ID: <20220127152543.ttvp7gj5bzpuvr3p@nlap2>
References: <cover.1641551261.git.abdun.nihaal@gmail.com>
 <c9c24c13d2823ccaadbbce33613d1242531dbe86.1641551261.git.abdun.nihaal@gmail.com>
 <YfATARBq6FJ2e3HE@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YfATARBq6FJ2e3HE@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Greg,

On Tue, Jan 25, 2022 at 04:10:57PM +0100, Greg KH wrote:
> Many, if not most, of these functions should either be having their
> return value checked, or be void functions as no one checks their return
> value and they can not fail.  Please split this up and look at each
> function to determine which is is and how to fix it up properly.  Just
> returning 0 all the time is not the correct thing to do all the time.
> 
> One example would be rtw_p2p_get_status()  It can not fail, so why does
> it return anything?

Thanks for reviewing the patches.

I had split the changes in a way that the first patch removes the
unneeded return variables and the second patch converts the functions
(changed by the first patch) whose return values are not used, to return
void.

But yes, I now think, it is better to just convert the functions
whose return values are not used, directly to return void instead of
first removing the unneeded return variable and then converting
to return void.

I'll resend this as a single patch.

Thanks,
Abdun Nihaal
