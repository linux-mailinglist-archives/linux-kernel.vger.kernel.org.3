Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B1DB468E3F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 01:17:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241528AbhLFAUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 19:20:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbhLFAUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 19:20:50 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2ABEC061751;
        Sun,  5 Dec 2021 16:17:22 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id x6so35786939edr.5;
        Sun, 05 Dec 2021 16:17:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=s3HKMGEG5d0zvdC9tbh3iHmILRZTQYYdRkSzqA0Q3sE=;
        b=SeBfitmLKbF+N5ZF5kNTFCX8e2Wa4azVOVnLY4ULbyIqDKUJW4cJQ2fDKnrhSXBWOA
         hcY/iAumyW8NjSXXV4JeN1+dEgr70BKtDyQNrqi+hDyCHN1hzlhi5LOhFwFhA8EI75iW
         yF0yfYyEFs8nH+0+b+jZr2bvLYyf6bt5DSMg/gTxm+8CjfZ5ReteSBKPA3/Ye88btIrm
         VFGv6H+9ha14Eb3KrvR9zs61DXyrknCFy9h7iyqMIYJCDw9BDnjIZeBIfUYynuS0za6K
         NqVCP6yKKUZOidYlP6UPxlgBpfu6YF8t4hUPTTh6GC9w3QTIuaos4DBN3XUEYs7exQlF
         po5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=s3HKMGEG5d0zvdC9tbh3iHmILRZTQYYdRkSzqA0Q3sE=;
        b=ENjAOkcrwTdm9I/lbvdonZc30f3wSZ4B/VYiW+xCcq6m+zkUu5OnKx7luyZCvl3tPK
         sBh8drFGPY5F7JzF6QOn1sADb4xQLbFcaldEDAlevor1lAp9YwIZQh9u4x2hFnJhAI2J
         S/UvCijGNyeTdCpTlgddRevNwiNqPzcfAVNR2ot5q/AzjTbljKc84QLMx/FPsJ2MZ9SX
         M2oeWB13T66cF9TLOx1aTDROQgLGIKEt3lhViX3+vR25/kaqBDwjugKPrdsGJ3H4mhoI
         VX3uhjI6ZZna/EtanaHjG58VNb6Ycv9OirfsX4o77Vay/mDizAsnVIjbqPbfI+94b4zB
         tS3g==
X-Gm-Message-State: AOAM53329tl5Nv5gyVtaQK2xE9Sm83cXUVXsCSpIxeMmatlPOk+1ZpOq
        wn28WdljhDYACL2RowFJzEE=
X-Google-Smtp-Source: ABdhPJxYZkl0oU3wqebA615YqXjh5Aj1yUGYeu2W970Fk6wI21pQUl6YRfYjVqhx4iaiwKCeU6x7wg==
X-Received: by 2002:a05:6402:1e95:: with SMTP id f21mr50627591edf.139.1638749841387;
        Sun, 05 Dec 2021 16:17:21 -0800 (PST)
Received: from ?IPv6:2a02:ab88:368f:2080:eab:126a:947d:3008? ([2a02:ab88:368f:2080:eab:126a:947d:3008])
        by smtp.gmail.com with ESMTPSA id c7sm5972664ejd.91.2021.12.05.16.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Dec 2021 16:17:20 -0800 (PST)
Message-ID: <1c9c3ae978c58c42e3e597706edea04760a94318.camel@gmail.com>
Subject: Re: [PATCH v3 7/7] arm64: dts: exynos: Add initial device tree
 support for Exynos7885 SoC
From:   David Virag <virag.david003@gmail.com>
To:     David Virag <virag.david003@gmail.com>
Cc:     Sam Protsenko <semen.protsenko@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Date:   Mon, 06 Dec 2021 01:16:37 +0100
In-Reply-To: <20211205230804.202292-8-virag.david003@gmail.com>
References: <20211205230804.202292-1-virag.david003@gmail.com>
         <20211205230804.202292-8-virag.david003@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-12-06 at 00:08 +0100, David Virag wrote:
> Add initial Exynos7885 device tree nodes with dts for the Samsung
> Galaxy
> A8 (2018), a.k.a. "jackpotlte", with model number "SM-A530F".
> Currently this includes some clock support, UART support, and I2C
> nodes.
> 
> Signed-off-by: David Virag <virag.david003@gmail.com>
> ---
> Changes in v2:
>   - Remove address-cells, and size-cells from dts, since they are
>     already in the dtsi.
>   - Lower case hex in memory node
>   - Fix node names with underscore instead of hyphen
>   - Fix line breaks
>   - Fix "-key" missing from gpio keys node names
>   - Use the form without "key" in gpio key labels on all keys
>   - Suffix pin configuration node names with "-pins"

Kind of forgot to do that in pinctrl_top and a few places where
substitution didn't work because of a missing space. Will wait for some
comments before fixing that to avoid too many versions. Should have
checked that better.
