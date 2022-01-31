Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E59A44A3E6D
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 09:05:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241328AbiAaIFW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 03:05:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238057AbiAaIFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 03:05:19 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B954C061714
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 00:05:18 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id f22-20020a1c1f16000000b003525bf08b1eso4381751wmf.0
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 00:05:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=R+SBQZvuQCjJKBvLP1leTLpUhRdrBYluyYBZRqvLjBo=;
        b=11Oj5JJeMdOTuOsk96ZbCqZqlz9IyD99aOIMhG5Em+2J8gnX1fHNZiIKeHenHM+3nj
         mosWbfJy3QXVrfXiUsXYbWqipuZreEKc+G5LcoPK+J4ciscL8EJsJIJKobi78CayVAQJ
         U6l2NdQc5qIne127aOFtOFzUuR+r9V7FtB1rWfBtJbL+ciAuKuKDHMoBqlc/4X36tWXp
         tg9PWIb3NNDzv56ZoeUbX7AQoe30nvmUp3f4qaPZsoHexsYNcoVm/uzPrjxYdUHe+cqx
         99WlAdAnFp2YxbU0Cnqjz3eU6j+45HfHE5vrHbpM+tSkATPxz4yd8Qz9mKiOTKDIbi5+
         aKFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=R+SBQZvuQCjJKBvLP1leTLpUhRdrBYluyYBZRqvLjBo=;
        b=vH6uK8cxP4rvKQzCS0gKvbtIDi5nn0VqJ8nNo2fKOlpIKDUgA686exM+8kJxIxoUT8
         eqVQ3IVUAdih+8fTaOtI+U//Y+mBp/jRX6tGWAV/lUevTbTdSzAbLp5gPAQS/NCZwWId
         8wDlj053uFQERRx5XKGA6dg2MqdL72t1pNCghN2+1xiSGrIwdPDZR5M6gmAjZ7Bwrnyy
         H0siDqiZhJB18RKYFqdzW0F8Cmk4AEQeW+qWXDKEX11Vw1rceJQupEKTttovvBDR8RKo
         DJrvhzzNIWfzfutjkX2bn7LLuk/A19uig24GDQXIzTZBnuuTr6BZSUzvnL1O2qdfcl1U
         wyEA==
X-Gm-Message-State: AOAM531wd/MQ2M0AXPnd7IaVUqOZLc/66owzcPFpSNsNwGrVppDj9yLK
        yMopsH0m1sBblIaZECY7LCXR+VlwR6J+WA==
X-Google-Smtp-Source: ABdhPJxPlvY68Z9GPD9YGbQrcOzvI3xBdrGMW2TPOjD9Pzaj9EAABf3vJ+HFA2jD71yy6cIk3IFEhA==
X-Received: by 2002:a05:600c:a4c:: with SMTP id c12mr17174881wmq.48.1643616316946;
        Mon, 31 Jan 2022 00:05:16 -0800 (PST)
Received: from Red ([2a01:cb1d:3d5:a100:264b:feff:fe03:2806])
        by smtp.googlemail.com with ESMTPSA id n11sm9933485wms.3.2022.01.31.00.05.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 00:05:16 -0800 (PST)
Date:   Mon, 31 Jan 2022 09:05:14 +0100
From:   LABBE Corentin <clabbe@baylibre.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     miquel.raynal@bootlin.com, richard@nod.at, robh+dt@kernel.org,
        vigneshr@ti.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: mtd: drop mtd/cortina,gemini-flash.txt
Message-ID: <YfeYOsFLBeu+tLLE@Red>
References: <20220127200310.4150981-1-clabbe@baylibre.com>
 <CACRpkdY7O=KjhbeBZiokchFhSo8dTM+JAeBOTq+qkKE7-63jPw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdY7O=KjhbeBZiokchFhSo8dTM+JAeBOTq+qkKE7-63jPw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Fri, Jan 28, 2022 at 01:18:55AM +0100, Linus Walleij a écrit :
> On Thu, Jan 27, 2022 at 9:03 PM Corentin Labbe <clabbe@baylibre.com> wrote:
> 
> > Drop mtd/cortina,gemini-flash.txt since it is nearly already handled by
> > Documentation/devicetree/bindings/mtd/mtd-physmap.yaml.
> >
> > Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> 
> Thanks for fixing this Corentin!
> 
> > +      $ref: /schemas/types.yaml#/definitions/phandle
> > +      description:
> > +        Phandle to the syscom controller
> 
> syscon?
> 

Hello

I will fix it in v2.

Thanks.
