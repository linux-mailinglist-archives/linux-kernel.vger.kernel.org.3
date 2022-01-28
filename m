Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BD1349F7D2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 12:05:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348014AbiA1LFv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 06:05:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348006AbiA1LFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 06:05:37 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2234CC061714
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 03:05:37 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id a25so8463623lji.9
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 03:05:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=W6NOesChZuwW+0urMmtMeZ98ITEecm90pqAZ1qyy3yA=;
        b=ouTGjraeJg14bd41iw0LYrvvVO9rX/SUMnntEOZL2Uy+1OGgywIb4ZUvVySFvjhMHp
         oUMUe9dS9FVyPIrQlQoVKr2LDSlWwd1/SEl8SL0qgvBVSZGyUfOrgDyGeLKUVJ32ZW+2
         uk4c+Ccpdhg6iQe7eB0ComjUHjcw5oCBztI5+59/3DC6mNhUR+zw7FDaz7XbF8IyaNai
         6Kog/OakGGDU5+o5UsroqOLduR9LtMSu0pPp4bV3IWIHCd17GLu/oOapsJxhmgoslIjW
         ST9xSZwqFl/nEsAKJr3xsbt9AS28A2TDG7OadrxJeKx7EacQlyKoQtLanDdwDd9SZuU1
         Hgbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=W6NOesChZuwW+0urMmtMeZ98ITEecm90pqAZ1qyy3yA=;
        b=Ju0St1MWghe1nvYgi6WQOvMWksoFgylXGVYXNI9KnOBAozFASQZ/4q5cKsJ238IrWT
         xB1Q5HDs3SEy0Akot9IL3D5wBZcd2FVbG42cv1SWiGqkgGR6DzMS/6qemDSQXoJULWat
         7JxO8Z7m+HCyuuR5l17P7+Ad+rbjvUxvnGoc9AiG8T1y1K8AMmhBo2yubeo5gSoLvZe+
         Gg2667Ywyrr/53GJPer8MM30RlU4dfNh2cURo+rBIcXFS/SO5Jd9x8mBfo6jsygWs4Sk
         BUMdtRSvNbps4mZzGuxQXCwzVW1SDiri4Whf3KwUglOZNxLWSl4iE+FOstN5d8CQoABt
         oXVw==
X-Gm-Message-State: AOAM531/xppc3y0rS+X1VvNO/RZ6PwcJ8276peGn+5l9lFzLv4UAxKs5
        Ol3nB8tsLhQ/pPizuq3F1rE=
X-Google-Smtp-Source: ABdhPJzLrsJjH1icU0xvOMufiM3MyvLuJ9O/dhS2MiFtuLc9k15ISguOjY5depMRiXoXpp9z4/XBFw==
X-Received: by 2002:a05:651c:23c:: with SMTP id z28mr5630107ljn.525.1643367935515;
        Fri, 28 Jan 2022 03:05:35 -0800 (PST)
Received: from [10.3.154.43] (staticline-31-183-166-172.toya.net.pl. [31.183.166.172])
        by smtp.gmail.com with ESMTPSA id q14sm746466lfm.120.2022.01.28.03.05.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 03:05:34 -0800 (PST)
Message-ID: <b40726f9c70671bbd1a4c25dad723329f38a1ee2.camel@gmail.com>
Subject: Re: [PATCH 03/16] tools/include: Add _RET_IP_ and math definitions
 to kernel.h
From:   Karolina Drobnik <karolinadrobnik@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        mike.rapoport@gmail.com, linux-kernel@vger.kernel.org
Date:   Fri, 28 Jan 2022 12:05:33 +0100
In-Reply-To: <YfKkGga3QKDwFdHJ@casper.infradead.org>
References: <cover.1643206612.git.karolinadrobnik@gmail.com>
         <5baa036aadb6436c7c36589ce591baaf827aec0b.1643206612.git.karolinadrobnik@gmail.com>
         <YfKkGga3QKDwFdHJ@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-01-27 at 13:54 +0000, Matthew Wilcox wrote:
> On Thu, Jan 27, 2022 at 02:21:21PM +0100, Karolina Drobnik wrote:
> > Add max_t, min_t and clamp functions, together with _RET_IP_
> > definition, so they can be used in testing.
> 
> Rather than adding our own definitions of min/max/clamp, have
> you considered using #include "../../../include/linux/minmax.h"?

I tried doing it in the very beginning and couldn't get it to compile.
Now, I see it's because in minmax.h we use __UNIQUE_ID, which is
undefined because of "#ifdef __KERNEL__" in include/linux/compiler.h.

> In my experience reusing this kind of "leaf" header works out
> better than duplicating it.

I like this approach as well, and I tried to use it in other memblock
headers. Still, as it's not that straightforward here, and I went for
duplication.


