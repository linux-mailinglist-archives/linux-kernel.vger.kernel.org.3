Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45F4C488DED
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 02:07:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231128AbiAJBHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 20:07:19 -0500
Received: from mail-oi1-f182.google.com ([209.85.167.182]:40604 "EHLO
        mail-oi1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbiAJBHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 20:07:14 -0500
Received: by mail-oi1-f182.google.com with SMTP id t204so17168166oie.7;
        Sun, 09 Jan 2022 17:07:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UlweSkTNZTrzAJGc2p70+LptAtXlp0t9XP6V2iv9ICM=;
        b=M2gEeUMoWf7V+KfeLMJCz2FR6Ch9EPofJJwXGW8lzk4cfm8YNX/Gdy2cWN6peiFyGv
         +xuwMHWhm5p/W2OmR+tb4mMxPhNO/0390+GIGTfNfLlgqE7anOcvNKeAgJlEXT27X9nA
         g7hiQWElSe1LpgIR9COFUJB5S21mjQlFAHSeXXtXqjfStHvrluZYcdRnK1b+nZWCR5JX
         CvZtYjRm1ft1USwA2gbRHO+nkVJn0ROfej4vZiQpUeoNQkEORLNC/6efwZtaUDrzifPU
         BjtBHeBm25B92ywPVEgJYQmZWOXm2zpqq1j7DlRqDA3eb8BByD4W1KlyfNDUwrya7b8Z
         GRYw==
X-Gm-Message-State: AOAM5336i/jD6ulO88fj5GDFBuUZNUsztI7TtDJL5CNXCjQ0b5fwN/NY
        PkV9U12x0Hi3iC3w/OgfYg==
X-Google-Smtp-Source: ABdhPJzzYBJXScaxxMihWhgF0KC0UyjXWNAPg5RbME3wxP4ZznBn3bgWgJwz+TCTjnBCYXGc/zGdyQ==
X-Received: by 2002:a05:6808:618:: with SMTP id y24mr1662056oih.83.1641776833287;
        Sun, 09 Jan 2022 17:07:13 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id x13sm1050665oof.19.2022.01.09.17.07.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jan 2022 17:07:12 -0800 (PST)
Received: (nullmailer pid 3964402 invoked by uid 1000);
        Mon, 10 Jan 2022 01:07:11 -0000
Date:   Sun, 9 Jan 2022 19:07:11 -0600
From:   Rob Herring <robh@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] dt-bindings: iio/magnetometer: yamaha,yas530: Fix
 invalid 'interrupts' in example
Message-ID: <YduGv06pFgG31KKf@robh.at.kernel.org>
References: <20220106182518.1435497-4-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220106182518.1435497-4-robh@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 06 Jan 2022 12:25:12 -0600, Rob Herring wrote:
> 'interrupts' does not take a phandle, so remove it in the example.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/iio/magnetometer/yamaha,yas530.yaml     | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks!
