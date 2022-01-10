Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FFEC488D94
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 01:56:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237633AbiAJA4e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 19:56:34 -0500
Received: from mail-ot1-f52.google.com ([209.85.210.52]:36769 "EHLO
        mail-ot1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232114AbiAJA4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 19:56:32 -0500
Received: by mail-ot1-f52.google.com with SMTP id s21-20020a05683004d500b0058f585672efso13587596otd.3;
        Sun, 09 Jan 2022 16:56:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8dmC09EiRPoAEtD5j7hv6yre/JW8aQu59sHFW+QrEpg=;
        b=ksdrY7CV+bOq+p5X1iRfFiOmffrbCZcUVCfVEvOnNTLCupmmmR1klW8v2447sHe29Y
         LL3UuyOS6w1GEpCczV/p5ip7xtDV6e8MJgGLe181PhlzXYaJoQNA4LrJJzRSPNDCtCXP
         GKJB4Y6OWmRlLzNZiSgovjNi5gfntFGHlpFCLAYvwObRf+f/3h9enZas6gKj+1skmDk8
         +ijzmME47p4PWLK0Mg5GL1ay7actbpvd6t1X5Ti1VbV20KIvMSeO1CrOf4tzdtrPqVe5
         EIDw0j9HJ31Qm6C7vhUFAcP2jmEV9v979dE/8E9NjSbEKGDOFW23DpBBMmk+UrkYedv0
         gxzA==
X-Gm-Message-State: AOAM5324RUGLgh+ItndA03Oei4/Pdoua1Xv5x95jELERsjLN6KQV4jLZ
        MAxyFgSg44KLDgSG2rYplQ==
X-Google-Smtp-Source: ABdhPJyJ2SijgS3bWm2elHfdJ984rDl5g4FQIsaX+vfPHIpNe+6toryIbLDyunrUMSVRL1HMrGXXCQ==
X-Received: by 2002:a9d:7295:: with SMTP id t21mr14116494otj.230.1641776192088;
        Sun, 09 Jan 2022 16:56:32 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id 5sm955286oip.17.2022.01.09.16.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jan 2022 16:56:31 -0800 (PST)
Received: (nullmailer pid 3946821 invoked by uid 1000);
        Mon, 10 Jan 2022 00:56:30 -0000
Date:   Sun, 9 Jan 2022 18:56:30 -0600
From:   Rob Herring <robh@kernel.org>
To:     Qin Jian <qinjian@cqplus1.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, tglx@linutronix.de,
        maz@kernel.org, p.zabel@pengutronix.de, linux@armlinux.org.uk,
        broonie@kernel.org, arnd@arndb.de, stefan.wahren@i2se.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        wells.lu@sunplus.com
Subject: Re: [PATCH v7 01/10] dt-bindings: vendor-prefixes: Add Sunplus
Message-ID: <YduEPlMoAR9KXoaa@robh.at.kernel.org>
References: <cover.1640154492.git.qinjian@cqplus1.com>
 <2e74a1339a5ea54d92fdc4d1998a2b169e23b82b.1640154492.git.qinjian@cqplus1.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e74a1339a5ea54d92fdc4d1998a2b169e23b82b.1640154492.git.qinjian@cqplus1.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 22, 2021 at 03:05:57PM +0800, Qin Jian wrote:
> Add vendor prefix for Sunplus Technology Co., Ltd. (http://www.sunplus.com)
> 
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Qin Jian <qinjian@cqplus1.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)

As this one is a dependency for other series, applied for 5.17.

Rob
