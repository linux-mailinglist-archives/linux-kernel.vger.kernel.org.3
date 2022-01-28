Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F01949F845
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 12:26:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233888AbiA1L0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 06:26:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232001AbiA1LZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 06:25:59 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A10EC061714
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 03:25:59 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id a25so8537091lji.9
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 03:25:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=C4wKr3kUoD0qp00ByG0+4AqZhVzGlqpDEcr/e4bOCyU=;
        b=N6LLCysMFVtylsQn72PUegBhokoSHmzbimPDgIAAsQ4VUuYTGlBu4voaJZG3vCYbCP
         VErVKqECb3uxdkhfxzIS2sPLMOj4ZVuRAQ04oE28hib78whlS74qMaoDy2XHK/T1bFU9
         tySH0dAqtjLDgK6Kj9pQq/PoM7b4jGQEcJMh6YOKrl3aoYm+ySnqN9baJyIJqevvdhcu
         RBxacIDNqMJCmESkVROhP7hKChC1khHXk2SR7z6HP3mJvgF6jZ63tifpta+RYPyiv6hN
         N3Rb9mQcM31cBtjckKDBwUjMsB8mDLIWy/ilf1X04AnYynjaHzWXK40GnG5m25kQPyiz
         9kTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=C4wKr3kUoD0qp00ByG0+4AqZhVzGlqpDEcr/e4bOCyU=;
        b=EWgZBB3rkm5MCuf8iSdnA8Yte3SBldtm5IOv48ZAo1X8rwF2bmDti8KPTuz8EvkB3S
         jhMCfCwoxWIsCqACbhS6vy+R/U0FVvsHFEjX3kle7FAUHYe2E3Yp8UFV2AjfoampefQ1
         P9xiROn/wdowLZPJScXm2OZvinMYS6Fm6OiX6wmJo+Jyz2SMkURkghZ238QLHfvnB95D
         PeJ6zM9B+fF8wo3jDkQIwEJeLmwqQ4mk/jihl8nB7AWz+Ns2AcPW3VdWbXaZeWmbEV7U
         fNnzvhzf4SxQ3tfZaq1toLL3i42ZF1wAQ7gR+rgyxCOLu6+qn5bZpzoPmGkxjdnWqQ65
         oAnw==
X-Gm-Message-State: AOAM533PkICwEWh65CyglqROJ1OFPbtXH1MaVKtFI1VXX0rY6p8jvmrV
        a4ijUyoDr1Y+O6he+9wl2fk=
X-Google-Smtp-Source: ABdhPJyg0XcWmH9lRsaiJiCWMt2pkQHHZ7gxACJVCdoiD3QFTkerlLSJncUdwnGrnDeVLQgB1Ry9PQ==
X-Received: by 2002:a05:651c:2102:: with SMTP id a2mr5782103ljq.72.1643369157919;
        Fri, 28 Jan 2022 03:25:57 -0800 (PST)
Received: from ?IPv6:2a00:f41:80ea:4a21:823:c5ac:f37f:2677? ([2a00:f41:80ea:4a21:823:c5ac:f37f:2677])
        by smtp.gmail.com with ESMTPSA id m2sm2500830lfh.163.2022.01.28.03.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 03:25:57 -0800 (PST)
Message-ID: <78c62135ee4bc56ae144b266ffaabe8d2afb2928.camel@gmail.com>
Subject: Re: [PATCH 10/16] memblock tests: Add skeleton of the memblock
 simulator
From:   Karolina Drobnik <karolinadrobnik@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        mike.rapoport@gmail.com, linux-kernel@vger.kernel.org
Date:   Fri, 28 Jan 2022 12:25:55 +0100
In-Reply-To: <YfKm0sx1JT+7IRSJ@casper.infradead.org>
References: <cover.1643206612.git.karolinadrobnik@gmail.com>
         <92442409bbc72476509a2ceb2e182473ac69612b.1643206612.git.karolinadrobnik@gmail.com>
         <YfKm0sx1JT+7IRSJ@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-01-27 at 14:06 +0000, Matthew Wilcox wrote:
> On Thu, Jan 27, 2022 at 02:21:28PM +0100, Karolina Drobnik wrote:
> > +# Memblock simulator requires AddressSanitizer (libasan) and
> > liburcu libraries
> 
> Stale comment?  You don't seem to actually use liburcu.

I'm using uatomic_inc and uatomic_dec in tools/lib/slab.c. But, you're
right, memblock simulator doesn't use liburcu per se but uses code that
requires it. I wasn't sure where and how to communicate it, so I added
this comment here.

