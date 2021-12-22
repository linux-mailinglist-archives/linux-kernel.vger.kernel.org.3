Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9919647D5C3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 18:22:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239878AbhLVRVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 12:21:53 -0500
Received: from mail-qk1-f180.google.com ([209.85.222.180]:38679 "EHLO
        mail-qk1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbhLVRVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 12:21:53 -0500
Received: by mail-qk1-f180.google.com with SMTP id i187so851787qkf.5;
        Wed, 22 Dec 2021 09:21:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MexS1t6Qqh/KdsNJigub55XgBZ03BUc3tBRzKTDQORo=;
        b=JLri2spfCgOMCdwjj6D+3wc2zYuL1vXqvg39v6tIWSiQfTIx2nDagNoPQe4DLFSn2k
         VaT6eq9b3sIP1pqvQZPFVrA6hh3OSiYdFparA04SILNaVljrI1mvqwI0KQLnDdUndIBV
         E5qDGO8RYkCF+tViDMmmHQ0vvPS7sS2ABqcu3rxQb2ipaAFPXAr8R4Gu6ZXygNCmiSch
         GQ+S7TI5L4/Q+r5HVBgUuI8me/OWFAIC55pgPpcNKiwxhiaqxt87x5Fm7YO6lNcJ5q7H
         OQQxTs2owZrnMOiyNNHJ7loPRDQE4bEqMomUfq6jGGtHolAQ1zhHHcFixXa7ss0Juhxo
         7FhQ==
X-Gm-Message-State: AOAM533LZHFfAE0lSAf5adNzqj8wK2gTM5PS4FWIaDjAD3VwBOmo0lyb
        LieGeqSyrTIdFPd2ytp7CA==
X-Google-Smtp-Source: ABdhPJzGAqaSdtRKN9e72cQ4NmxZX6tcVJ3EEq/Axv8dZhtMPyW2pM4mR12cwr+x1dxFfPbEXW8ZWA==
X-Received: by 2002:a37:9a94:: with SMTP id c142mr2687136qke.117.1640193712258;
        Wed, 22 Dec 2021 09:21:52 -0800 (PST)
Received: from robh.at.kernel.org ([24.55.105.145])
        by smtp.gmail.com with ESMTPSA id h3sm2391174qko.78.2021.12.22.09.21.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 09:21:51 -0800 (PST)
Received: (nullmailer pid 2353796 invoked by uid 1000);
        Wed, 22 Dec 2021 17:21:50 -0000
Date:   Wed, 22 Dec 2021 13:21:50 -0400
From:   Rob Herring <robh@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Maxime Ripard <maxime@cerno.tech>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH] dt-bindings: arm,cci-400: Drop the PL330 from example
Message-ID: <YcNerhflH9vsq1D0@robh.at.kernel.org>
References: <20211217170803.3147777-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211217170803.3147777-1-robh@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Dec 2021 11:08:03 -0600, Rob Herring wrote:
> The PL330 was commented out because its binding wasn't converted to a
> schema. With the binding converted, the example now needs several updates.
> However, while it's possible that the PL330 has a 'cci-control-port', there
> aren't any platforms upstream which do. So rather than allowing
> 'cci-control-port' in the PL330 binding, let's just drop the example.
> 
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/arm/arm,cci-400.yaml | 10 ----------
>  1 file changed, 10 deletions(-)
> 

Applied, thanks!
