Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEC1C49F7E9
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 12:09:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244201AbiA1LJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 06:09:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348021AbiA1LI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 06:08:58 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E061C06175A
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 03:08:45 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id z20so8477153ljo.6
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 03:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=TWsCKvI4zd2Yvd/FoP0pl7cOYWslt5CbLizlPinunqQ=;
        b=RhZQGDTkI5bXthLfduiDdSZsAb07HOY2S4nSgWDXigOvqySn6wGmpzb2wrGQYa9Uji
         OUUwEmzeSkRqt6TkKfS+FJudwmZjN45xgPBARnlevRJMoktBIPQiZzeCtTK4lCbV8jGF
         cQr20sbkeInCoKb56YJuaOajI9CaAF4VWq4jKh10QyxgfAEPA2+kTL2FUaozwedF1wFN
         nd47L2s+Y8g5WzJ7WCUHAP2BDaSa6doMX5TrxFUF0mczT+S4siRmICl6vHBOgYd07LHD
         ZALrZ5BPwj56oVhP/9ez28fIUlE7osJlv08VncNv2MItzZvmlkN73pK8elR12he9uYpK
         WPMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=TWsCKvI4zd2Yvd/FoP0pl7cOYWslt5CbLizlPinunqQ=;
        b=ObqPGelm38tq6/+FUGKVTYyeAbarnJDV/bluY5jqmzbBHxZ7c5W3DGl4tsjmlgiYFh
         5evO57p6oCWuyXrfSwwix3Jrx5gfLZhPsfZ3+mUGxPPMCXTf9c5+LHjsfZMbpaaw36XN
         aveInE+sz2PiEcxMMX7qhaCf00kOePGlKa5YQz0QH2Yg5r0ko+J5SBPkOIo08iNXSG8q
         6POCGiHvVz7GCe01m/7idJHlY+ifOMz+hX7F5iJybMBhwrXqY9CIwCPntJ40H10fpD8V
         I2uCTdThjYXoV7a2/vB6jMbFrjretE0ybiwknq9GHgZojJZ2m1gnFlz6G0mnpskhNEHV
         h2/g==
X-Gm-Message-State: AOAM5307H8eRggDMs5NFKuq2GmmoeSJ5HO/fTPdE/T/onukKDgqSb+5G
        S03S/NhZE3ZT+iNQi/Aru5Y=
X-Google-Smtp-Source: ABdhPJxQdVaJeg71e3xwVwpibjLIg0VANBxt46fAilmtbumxeYl5dng1EZ8heHAX/9Ki8D9GNvpmdA==
X-Received: by 2002:a2e:7116:: with SMTP id m22mr5700534ljc.67.1643368123795;
        Fri, 28 Jan 2022 03:08:43 -0800 (PST)
Received: from [10.3.154.43] (staticline-31-183-166-172.toya.net.pl. [31.183.166.172])
        by smtp.gmail.com with ESMTPSA id u12sm1964299lfl.188.2022.01.28.03.08.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 03:08:43 -0800 (PST)
Message-ID: <885bc2ae065a6d37b1b528cec986b453c220140c.camel@gmail.com>
Subject: Re: [PATCH 04/16] tools/include: Update atomic.h header
From:   Karolina Drobnik <karolinadrobnik@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        mike.rapoport@gmail.com, linux-kernel@vger.kernel.org
Date:   Fri, 28 Jan 2022 12:08:42 +0100
In-Reply-To: <YfKkkRNTA9qCmPTW@casper.infradead.org>
References: <cover.1643206612.git.karolinadrobnik@gmail.com>
         <bbd768fa794c68cda7888182f464411aebb65b7f.1643206612.git.karolinadrobnik@gmail.com>
         <YfKkkRNTA9qCmPTW@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-01-27 at 13:56 +0000, Matthew Wilcox wrote:
> On Thu, Jan 27, 2022 at 02:21:22PM +0100, Karolina Drobnik wrote:
> > Add atomic_long_t typedef and atomic_long_set function so they
> >  can be used in testing.
> > 
> > Signed-off-by: Karolina Drobnik <karolinadrobnik@gmail.com>
> > ---
> >  tools/include/linux/atomic.h | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/tools/include/linux/atomic.h
> > b/tools/include/linux/atomic.h
> > index 00a6c4ca562b..5d2431889606 100644
> > --- a/tools/include/linux/atomic.h
> > +++ b/tools/include/linux/atomic.h
> > @@ -4,6 +4,10 @@
> >  
> >  #include <asm/atomic.h>
> >  
> > +typedef atomic_t atomic_long_t;
> 
> Given this:
> 
> typedef struct {
>         int counter;
> } atomic_t;
> 
> your definition seems wrong.  Why not add atomic_long_t to types.h,
> adjacent to atomic_t?

Hmm, that sounds like a better idea. Will do that, thank you.

