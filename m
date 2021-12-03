Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D3F6466F7D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 03:01:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377838AbhLCCFS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 21:05:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237498AbhLCCFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 21:05:17 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26F42C06174A;
        Thu,  2 Dec 2021 18:01:54 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id k4so1032570plx.8;
        Thu, 02 Dec 2021 18:01:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:cc:references:subject:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CgHkw//Tb4Y6AmT6fyrojRfq8i+wfq/8ig0B7R1qGq0=;
        b=WqTfXDq0uJeS0vGnCMHUDWO7ztA9mwrz5t4Sy3Fi5jQj1oTkZBd0+dDWx0tMH4Mej8
         /24RFxn5BBpjRNiAHUreADgdgEjQcIAMCczv+FnQHHL+1JigHSXZMiWU05IsVQ0Lg331
         TiRKC08SWY5XQUj7CshauRbld7+GaxDEhk17sDmLXlNV235NDfMFmVL9GUrSfsY3CIcm
         EIksPIbthb3IEL4XI596fiD1hpHncVMA33phs9CFIhFPf6PHsyusvPnv4Her69kICu7w
         YNqf0j4Qp0J9YEsz9fRQZfJ3UVp0Ox9SMFKmHOiB6jVWw63Zx4eNJ1P9KwVTPt8b1HSg
         xMcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:references:subject:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CgHkw//Tb4Y6AmT6fyrojRfq8i+wfq/8ig0B7R1qGq0=;
        b=2xojlMVe7jS7hG/DiGh+DEAu+avl3WHzbRjWV3Z7vvKicAn96D3OC1suY89D5g2G7J
         A4woELR3ehx3uz0QhWHOGZGsPIcLAFbW0oY8Lw68RMVOPYneT4W9Gup/x0MfU4e3YHml
         YqX71IG9pdptg1HFqJhE4exi0BrBONu02eqJN4zbH7T/JHD42ksBS00NLL1Ufo/OfDr/
         ocPU4u3/r9dS5iYArXUFO60I08oHfcRxvgMH/y2LjO5XWuJ8TzIipqj+htd3wTCXpUM8
         FpieuZ0Of0CgAS+j4hDzNPMmA64nDuJYELAu9jB8uhmtSgo+RDaBOxbzLLWM/nW7BBL5
         hADw==
X-Gm-Message-State: AOAM532Q6Q5tkEYaVFo6E9eTW5q+10q3fTIKsAwIqnm3EfhI8NDpj0dX
        lIt61f1tGYLPbt28MBnIC09d5DBf/N8=
X-Google-Smtp-Source: ABdhPJxzopgp2vGl3JQjz5WU9gs2F9jVt+3oXsxbRTc+QVkzPqRPiKtjkN+4tlJmjL6GeyQ20HZtYQ==
X-Received: by 2002:a17:902:e74a:b0:142:114c:1f1e with SMTP id p10-20020a170902e74a00b00142114c1f1emr19313839plf.78.1638496913737;
        Thu, 02 Dec 2021 18:01:53 -0800 (PST)
Received: from [192.168.11.5] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id b6sm1032370pfm.170.2021.12.02.18.01.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Dec 2021 18:01:53 -0800 (PST)
To:     Alan Stern <stern@rowland.harvard.edu>,
        Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
References: <YakjNGEBFKm9pHCw@rowland.harvard.edu>
Subject: Re: [PATCH 1/4] Docs: usb: update usb_bulk_msg receiving example
From:   Akira Yokosawa <akiyks@gmail.com>
Message-ID: <ee94a2f1-2bb5-afca-371f-48825a97641b@gmail.com>
Date:   Fri, 3 Dec 2021 11:01:49 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YakjNGEBFKm9pHCw@rowland.harvard.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 2 Dec 2021 14:49:08 -0500, Alan Stern wrote:
> On Thu, Dec 02, 2021 at 05:49:47AM +0100, Philipp Hortmann wrote:
[...]
>> Please find the full email under the link:
>> https://lore.kernel.org/linux-usb/87h7dcsohs.fsf@meer.lwn.net/T/
>> 
>> Please give me an example for the right wording. I am not a native English
>> speaker. Is the article in this case required?
> 
> Okay, now I see what's going on.  You should change it like this:
> 
> -driver. Instead we call the :c:func:`usb_bulk_msg` function, which can be used
> +driver. Instead we call `usb_bulk_msg`, which can be used
>  to send or receive data from a device without having to create urbs and
> -handle urb completion callback functions. We call the :c:func:`usb_bulk_msg`
> +handle urb completion callback functions. We call `usb_bulk_msg`,
>  giving it a buffer into which to place any data received from

Well, for function names to be caught by kernel-doc tools,
you need to say usb_bulk_msg() (without ``, with () appended).

So, the diff should look:

-driver. Instead we call the :c:func:`usb_bulk_msg` function, which can be used
+driver. Instead we call usb_bulk_msg(), which can be used
 to send or receive data from a device without having to create urbs and
-handle urb completion callback functions. We call the :c:func:`usb_bulk_msg`
+handle urb completion callback functions. We call usb_bulk_msg(),
 giving it a buffer into which to place any data received from

You can find related documentation at:

   https://www.kernel.org/doc/html/latest/doc-guide/kernel-doc.html#cross-referencing-from-restructuredtext

        Thanks, Akira

> 
> Alan Stern
