Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50B62497E4D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 12:52:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237873AbiAXLwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 06:52:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbiAXLwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 06:52:17 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B938C06173B;
        Mon, 24 Jan 2022 03:52:17 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id me13so20721957ejb.12;
        Mon, 24 Jan 2022 03:52:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to;
        bh=ceCSyU7fASa5GTymNA02V7kuqZM9w8U8c0D+G8e9jww=;
        b=OCo2nYoX0JK8n+YvCKLuGsN1jObJL82iSZM3g7Jwq3dGjYaL3mWT6hNCF6mptXcuNk
         yr75SnXWaTxuoA+2Hb0ObTjBxv0LvisHZ8uz+4PQEsRgjT1tvxK/9UjsgnvOlkf7Vn0t
         8Ylo6UsNLCxtUW3RfdKfw9Gbn+TqqXoV+aXrkqR03LD4IDSwve0hSwfPuxnKM6WOy7AP
         +NemZ+e8UsAFuUFUaBoKHd3vXhCbQFEqxa3lbNtN6h8kx05VrqLe8pzLaFqb9emVQha1
         GIuDA7pysfVTT5Y7rnOqlSm9Zlc0X2iWofk/Xnqio66BC4qHnQpb1FiN62xXVqXWhPNc
         fwAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=ceCSyU7fASa5GTymNA02V7kuqZM9w8U8c0D+G8e9jww=;
        b=OWwgI315Mwdojs63SZnmHafgQrEgLEfNYRJkEZDtawkGO8EoqOsF6SUvod3Q7r8dx6
         IlHwN8PalTzifZn5xt/T1tJ40j+FDOlwrHEJnGiKfe5TIMOR3hedUXwXy8imgibRtCdm
         lLWp0d3IySvPT4cJhTulVRN1ny8UR+Miu0IwVulKLnBcYvyg6/dFgz8ujE70vabYeQtU
         BSnWaAnwAY6ki5oJXZbd7Z3/RY/J06/EkyZFDoe8u5kpTJrPZMzYriYBnOGPTmDKW/kG
         t1yIMo7xyKKvSGbtdxPCr0XnnTJw7PucCGBX1llLq9BXv3sDfrQkNhwywRLd/1nM3YTu
         TOzA==
X-Gm-Message-State: AOAM531QmljCYgyfBdncTPy5MostRGTMdjAYLrhc71FcRaUAFVB5N2ii
        tuklJeTu/O3IRhVz0fkkFfQ=
X-Google-Smtp-Source: ABdhPJzBjxvI1hDwYJnuPde+oHeeqifmDTmR4W4Iw1olBfkvE5fjkNI7RBgdi6hJBsFacAdCbXCGzA==
X-Received: by 2002:a17:906:26cb:: with SMTP id u11mr12641873ejc.630.1643025135851;
        Mon, 24 Jan 2022 03:52:15 -0800 (PST)
Received: from Ansuel-xps. (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.gmail.com with ESMTPSA id op20sm4813663ejb.68.2022.01.24.03.52.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 03:52:15 -0800 (PST)
Message-ID: <61ee92ef.1c69fb81.95ef3.4aa6@mx.google.com>
X-Google-Original-Message-ID: <Ye6S7A7HKNIOdIQl@Ansuel-xps.>
Date:   Mon, 24 Jan 2022 12:52:12 +0100
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Boris Brezillon <boris.brezillon@collabora.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Fixes tags need some work in the mtd-fixes tree
References: <20220124072800.14c492a5@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220124072800.14c492a5@canb.auug.org.au>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2022 at 07:28:00AM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> In commit
> 
>   2b3d77cb5ce3 ("mtd: parsers: qcom: Fix kernel panic on skipped partition")
> 
> Fixes tag
> 
>   Fixes: 803eb12 ("mtd: parsers: Add Qcom SMEM parser")
> 
> has these problem(s):
> 
>   - SHA1 should be at least 12 digits long
>     Can be fixed in the futrure by setting core.abbrev to 12 (or more)
>     or (for git v2.11 or later) just making sure it is not set (or set to
>     "auto").
> 
> In commit
> 
>   7815173a7ccb ("mtd: rawnand: ingenic: Fix missing put_device in ingenic_ecc_get")
> 
> Fixes tag
> 
>   Fixes: 15de8c6 ("mtd: rawnand: ingenic: Separate top-level and SoC specific code")
> 
> has these problem(s):
> 
>   - SHA1 should be at least 12 digits long
>     Can be fixed in the futrure by setting core.abbrev to 12 (or more)
>     or (for git v2.11 or later) just making sure it is not set (or set to
>     "auto").
> 
> -- 
> Cheers,
> Stephen Rothwell

Hi, sorry for the mistake. I wrongly copied the Fixes tag from a prev
commit. Should I resend the series with the correct fixes? 

-- 
	Ansuel
