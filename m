Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5117E4A88A6
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 17:35:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352244AbiBCQfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 11:35:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234742AbiBCQfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 11:35:22 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DCA6C06173D
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 08:35:22 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id c19so10718440ybf.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 08:35:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oPyaAvEtdJH++WDtQsfHJFEBuo6QHijQrPaLImzUuV0=;
        b=iodhaaRiTSlJsMrQ2rysn98rztbb0JF1+3C/qdYn8eZ205G9o7D2xLCIkj1jlnAej3
         Jth01jXJ8hH08JyaRAdFEpE6PK3jaqz+CVn5H2PECYchKHpmIAZ+Nwuh5VI2vTtwZQbd
         F+ZIX47vK3Gx5IbW/GTsSIte+M+SlXKQ3vLlZMp+9vLdbynEFBsPh5m1F72Ss2QEyFKT
         FYOc5WSZ3yYzqQRZ1ojfTwAzFG43BfAO+st3XUrrL9B6DoB+//cQ45lE4D4UjvIFKRkq
         3VEFJT3f+/6DPWSmpLRco78ulXYmQymcuBBzBcbEWqI6XchkTF4E63/8daccPFOaHmr2
         4OXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oPyaAvEtdJH++WDtQsfHJFEBuo6QHijQrPaLImzUuV0=;
        b=5Jn20DjKBgTGUP9E7JXriVJDse2Fxts27bxtAC5gNXQ1SR8XpOU8P0nDnj47/U2CIM
         f5MHGEkC2b3q9mbo4JQwT3iguQvLeS1QuyWC2rUEdCiK6S3qlmYbg5bxVEM8XrAtPCVi
         HZXdwn7YF6zFW4rr5cj2BjMrxNLkK3vQekP9GfpIb6BHbLf1KOqmLXZ3D6i17YPvI9nw
         TPVN7Gmmg0nxEZlipgKDPLHlCSEGA2XceSzh06dP2zNGbYUjfdEeZGRyixaTUBHEn8MI
         jpts602lreLqqsTgPJln1ubkVpsL0LnT659YA46yJNfqML8eNuIvAR3IzHahJ2lQ7C6R
         wXtQ==
X-Gm-Message-State: AOAM532ClaBo1+LZGAfqtqzNwFzzz7B46dBPweQ++DPe7CWvft8u8USH
        LK9hlr/TK0D4t2oZpyAiF4oQejUix8tL2aqD1DPUM6p2Z6w=
X-Google-Smtp-Source: ABdhPJwPpV0qhSSOjoMf2U6ukA+nrGwkJ2vJrhfhKQI75mWoHXb0/OVQxxUCPt0pr1lBInb2g522JrAti/o5iVL3NnE=
X-Received: by 2002:a81:6686:: with SMTP id a128mr4995423ywc.541.1643906121126;
 Thu, 03 Feb 2022 08:35:21 -0800 (PST)
MIME-Version: 1.0
References: <20220202235049.8051-1-samuel@sholland.org> <20220202235049.8051-2-samuel@sholland.org>
In-Reply-To: <20220202235049.8051-2-samuel@sholland.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 3 Feb 2022 17:35:09 +0100
Message-ID: <CACRpkdbS_LZTsB8M5mJ3GGrSeYD4Eouttj1PgUGSdMAm4yp=Lg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: vendor-prefixes: Add silan vendor prefix
To:     Samuel Holland <samuel@sholland.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Denis Ciocca <denis.ciocca@st.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 3, 2022 at 12:50 AM Samuel Holland <samuel@sholland.org> wrote:

> Hangzhou Silan Microelectronics Co., Ltd. (http://www.silan.com.cn/) is
> a manufacturer of ICs, including MEMS sensors.
>
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
