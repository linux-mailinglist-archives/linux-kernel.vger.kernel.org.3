Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C99FF462292
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 21:52:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234560AbhK2Uzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 15:55:36 -0500
Received: from mail-oi1-f175.google.com ([209.85.167.175]:38690 "EHLO
        mail-oi1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232320AbhK2Uxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 15:53:35 -0500
Received: by mail-oi1-f175.google.com with SMTP id r26so36935220oiw.5;
        Mon, 29 Nov 2021 12:50:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=H8Ml/qdAw6XX+Qut9YZhFk5u50M4XTPP9TNxL434DSc=;
        b=LTLZZXipYv8QERVxM3H4Kvi9ZLwy4F5wtNvjPVjAKYa0whpTY/8sepN8QMX/ro50pQ
         /HboXtN0+eQyF0C6N4TzOJ2VMnr8rQ7M6a4o2Y73IqSKToaYLoiIghVGut0yzhO0Peya
         IY75xbJxTZpEir+ZmDvpw7F7JCe4bvpAAcffcBopprStpae8HncTYcNNEk2VWn+uUlz6
         gjQED0uujL7xYe+8dT6I+kogdLlLOAarVesoTwEQG/z89fs7krNgZ0bFUQBbWT4CITmt
         SWfxCGvduiTv5N73mSbsAZplSAn8fiIZad52QI8uqY4t68PGIYdBxFC31jPIIzTsTKgk
         mVhA==
X-Gm-Message-State: AOAM533LMp9mKkbDiei+geAcdhhBbHKsnMlC0IWd0pybYjrdJe0pFSAl
        E0ICXAE3xxEb3cal6oKFEA==
X-Google-Smtp-Source: ABdhPJyVRwDlx3/XPGjTucTzmfzGI6GjKE2y9Phyi6eo8RnpQN7YPP3UkWAGTwtNJqLxfs05IoKGEQ==
X-Received: by 2002:a05:6808:178d:: with SMTP id bg13mr359419oib.171.1638219016703;
        Mon, 29 Nov 2021 12:50:16 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id q2sm2866049otg.64.2021.11.29.12.50.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 12:50:16 -0800 (PST)
Received: (nullmailer pid 585859 invoked by uid 1000);
        Mon, 29 Nov 2021 20:50:15 -0000
Date:   Mon, 29 Nov 2021 14:50:15 -0600
From:   Rob Herring <robh@kernel.org>
To:     Li Yang <leoyang.li@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 01/11] dt-bindings: qoriq-clock: add missing compatible
 for lx2160a
Message-ID: <YaU9B7HGJM1P+xt6@robh.at.kernel.org>
References: <20211110222200.6780-1-leoyang.li@nxp.com>
 <20211110222200.6780-2-leoyang.li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211110222200.6780-2-leoyang.li@nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 10, 2021 at 04:21:50PM -0600, Li Yang wrote:
> The compatbile string is already in use, fix the binding to include it.

typo

> 
> Signed-off-by: Li Yang <leoyang.li@nxp.com>
> ---
>  Documentation/devicetree/bindings/clock/qoriq-clock.txt | 1 +
>  1 file changed, 1 insertion(+)

With that fixed,

Acked-by: Rob Herring <robh@kernel.org>
