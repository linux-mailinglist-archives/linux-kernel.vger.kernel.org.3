Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3FE14A6D13
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 09:43:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245066AbiBBInm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 03:43:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbiBBInk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 03:43:40 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02C4AC061714
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 00:43:40 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id u14so39083322lfo.11
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 00:43:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=W/o0DXkCZCCxTE/7vikBjFOSBCTZYe2kiR9AGhJ3c3A=;
        b=P2rorSkUVfTcXxcm5GIRpKnYazbS6PiOofteDzGWd4p8vY8RmAjwCWTFipjJMgGwbJ
         ysrfeIKA+OKKd8mgWqJriSGbSYPRUGNeJeam3SFdtsphiREi0hiQqkXFgK4Wdy1W4+wE
         lfzyQz4Tlnm7Z3FUMX8viN82qcax9PiEVzDxFrAXXMD+W0/RhGki5UT6B4wbN93q5bw7
         k5Vrq1CGytUNR75Lq4D5Iz5l/gftES2eLX8m+AWiVwMEpn2T6Ew5JLJlNbXZkmN8UfZZ
         vPWruhH6sojbtvSnrh1CS81/jsyFRpEYyUS9kKlb2Yp4H15ULilQQm9iDY7qfiQEKtV0
         7Vzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=W/o0DXkCZCCxTE/7vikBjFOSBCTZYe2kiR9AGhJ3c3A=;
        b=AzEgGlg3nObNlm12LgtEemhZW6L4bFfQuOH5K2H+w2Hak0VGtMiZaVPDXMJsINAOLE
         dR45oV1X5rUMQ4DozLb6gAoN4pr0UHctojHLx234j8KYQGGmnRgfYNj3Uq/8nNgokhKu
         FNyiai8B5k32QYa250cR4mVOJXNayxIWA7WkFeGe29/pZiris500pDYkXwbX6FFGw8lU
         F3nphi7sM/75EigVaetmxy6Y3CqAJsu0ufMCNPIbkTNHlAxfzlZLazF+xg3I9EhGBRJB
         TIn9X3KoIeRK8LIKhMiz+xe7Shz+5Z2ng/CWYkoOtuFAKLKvXk+4YMYszK3XcrnmPjaP
         IOAQ==
X-Gm-Message-State: AOAM5312bY6JNAaInm03Gu4BDaXcZ7q7YFZ25KwMR26gWCj9ideySh03
        4+bj2EH60Ca/qZRCdrmxjDk=
X-Google-Smtp-Source: ABdhPJzC4lGR3Vdj+bc1GUgfbYonFJApO4J/kXpKHJ0/YoCOYTCYIo59iyTlH0TrPdK9lp0thdDcOQ==
X-Received: by 2002:a05:6512:1502:: with SMTP id bq2mr21835129lfb.551.1643791418372;
        Wed, 02 Feb 2022 00:43:38 -0800 (PST)
Received: from [192.168.50.104] (staticline-31-183-164-222.toya.net.pl. [31.183.164.222])
        by smtp.gmail.com with ESMTPSA id w22sm3111458ljh.44.2022.02.02.00.43.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 00:43:38 -0800 (PST)
Message-ID: <907c6c16d775226a58f9be4c35ec8aa006a8028e.camel@gmail.com>
Subject: Re: [PATCH] memblock: Remove unused io.h include
From:   Karolina Drobnik <karolinadrobnik@gmail.com>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>
Date:   Wed, 02 Feb 2022 09:43:37 +0100
In-Reply-To: <YflRJZV94Mx6lKAG@kernel.org>
References: <20220131121723.72395-1-karolinadrobnik@gmail.com>
         <YflRJZV94Mx6lKAG@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

Thanks for taking a look at my patch.

On Tue, 2022-02-01 at 17:26 +0200, Mike Rapoport wrote:
> As Matthew pointed out [1], many architectures put their definition
> of virt_to_phys() in asm/io.h, e.g. 
> 
> arch/powerpc/include/asm/io.h:#define virt_to_phys virt_to_phys
> arch/sh/include/asm/io.h:#define virt_to_phys(address)  ((unsigned
> long)(address))
> arch/x86/include/asm/io.h:#define virt_to_phys virt_to_phys
> 
> which means memblock needs this header for declaration of
> virt_to_phys().
> 
> Although it is included indirectly, let's keep it for now.

OK, will leave it as it is then.


Many thanks,
Karolina

