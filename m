Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7066949C637
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 10:22:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbiAZJWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 04:22:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231487AbiAZJWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 04:22:38 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB163C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 01:22:37 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id o12so18381029lfg.12
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 01:22:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=embecosm.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=xkcY7QEiaJ3QELLMv7empbscOPwwif+Hn5rC1CgT83o=;
        b=aV07h61YphegXKSL7xAYax2+orY2J2/niHnCklIslT2oe/K2HIBSZxBhVoKM6Jc6FB
         wchXgI3XlY32V/h3wgeyiKBaOT7Ly2ljN/HOVdxTcozhZKdtympP9Qgb+Ka0ANF5WOEc
         4fyMitf76ZRloQYIg7+tuSoiAtnbkHc6Dj53PmVzwT0xcoCw2PHN+oujuLwG1YpgJPVE
         E0C6+Fsy358PnFkY1h7riXbxe5j1YUo398ycOKLinqTmgfkmz/Qzm8cn+sA1eqesj4sK
         VN4WOdAN+XtCZugW++2lgB/l1XYtQmy/UBfDSWQPPts1SqT5Y95VfldPXXl35DYqnryj
         m6ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=xkcY7QEiaJ3QELLMv7empbscOPwwif+Hn5rC1CgT83o=;
        b=ANVgZCKIQ3GB7jAls0Bg7EukIvMOnTaDSLXQJSaWiMRLQaYZW8xtdPrYwHinSYJVOY
         sbPIPFITgyAXx/fhuEi3MObyvTyPul7bL8V5kqfKDv8zz7QIlf6Z11j46PjoGlplmpj8
         XSbNyqtApXuALk/3ZTipa1MLIS96XcDyJYG7z841YJA+Xd7OQl76Pjq+pngWUZ3+rfTI
         F5dTlTsDS6jCDDj8RT16J18FhpcDd2vGT/6NrE6SVa6na+C86fS3lThYxe6FFpy3yhbZ
         v9O3Nw5MmgvOJrg48aPCBOVysY9QDdxh77DtvfzR+Yn+aCsxjQXdRavsg8sTBhcgfYtl
         GX4Q==
X-Gm-Message-State: AOAM530pER8ZZCFrCvOfFY9WCkU84pmXyPvAiqZ5hmuPW4NDx6JuJtwV
        jjrxIjGirhfmxSFU0EYVzkfElQ==
X-Google-Smtp-Source: ABdhPJzerxnNhAMQYchpetaXvqyc5iQ3ti3nWTUnJGWoFCSLGR8WXA/GAnhvbiuvJKU4fHaXwHYsCA==
X-Received: by 2002:a05:6512:39ca:: with SMTP id k10mr10567702lfu.378.1643188955759;
        Wed, 26 Jan 2022 01:22:35 -0800 (PST)
Received: from [192.168.219.3] ([78.8.192.131])
        by smtp.gmail.com with ESMTPSA id n10sm637970ljj.106.2022.01.26.01.22.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Jan 2022 01:22:35 -0800 (PST)
Date:   Wed, 26 Jan 2022 09:22:31 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@embecosm.com>
To:     Christoph Hellwig <hch@infradead.org>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH v2] tty: Partially revert the removal of the Cyclades
 public API
In-Reply-To: <Ye5vx/8CYH2zWK28@infradead.org>
Message-ID: <alpine.DEB.2.20.2201260542450.11348@tpp.orcam.me.uk>
References: <alpine.DEB.2.20.2201230148120.11348@tpp.orcam.me.uk> <Ye5vx/8CYH2zWK28@infradead.org>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Jan 2022, Christoph Hellwig wrote:

> > Fix a user API regression introduced with commit f76edd8f7ce0 ("tty: 
> > cyclades, remove this orphan"), which removed a part of the API and 
> > caused compilation errors for user programs using said part, such as 
> > GCC 9 in its libsanitizer component[1]:
> 
> This looks sensible, but a #warning might be useful to get people to
> stop including this random header.

 We have no precedent, but your suggestion seems reasonable to me, thanks.

  Maciej
