Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7184447D280
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 13:54:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244971AbhLVMyJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 07:54:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233901AbhLVMyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 07:54:08 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B01FC061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 04:54:08 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id n14so4470210wra.9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 04:54:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=QIUPDb2Al9l0PriEYRa2k7fsEcDbO0MzTz3il7SpOZ4=;
        b=awpbkn22TMyUZYnw+n+pPYfeNjmdqItYTDKxBSVCmzRL+uqHw2yNuSaZQzFo8IT+uG
         d7kH2EdfswxqFfV2FqET5quFASwdz83mFTXp/wjaumyT5iJoQA1wPRKDolldfaELmuQn
         gXAYEoPf1mXkttOSfjrwo8Ux0lj+VM14lBIEZKf/U+CYfxGQxBXp6wZCC1deBg1bRzoL
         PW3Yi3Q2JLQIBIkWFb5dYx3UxNDxaghNO98VWAe2fiKU1OQuqCPkj5F/Q9h2zf2uB8bb
         lT+D0lM5korL1n/i9LRiSkR4BAxkyBQm3bcBRkg3Cz56uM2gCU6gzZ+ICDaf0VAsWidy
         lPaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=QIUPDb2Al9l0PriEYRa2k7fsEcDbO0MzTz3il7SpOZ4=;
        b=gwH7wQizkIbqQr16REHs9Sn76pr9OqS70pS6nVZm+aq5Nki6LpAt38pJ+BHRzyQk9K
         8nD7+gU6xBmeiFrR69sukAC2uGPbVjVpGXGwzm53SORLub49ewHRd9X3fTbxlyCEvxNM
         IJUQQoojYYybs+X1RWm5lYH0XsP1QGoeuCjJ4xIPGgnXYR5nk0qIzYmqyrvcNFn+FP+P
         M5WrSH2Bve/KjIF9NZskObm1FKQ772JuFAWf6Z1k7cAWmCSIQFaScKKQV5OeNjqwf9xI
         EnszR4OP+ZaNJVBlOSMw6hOB5pk7jf29wVNU2UgLpg8L6YJPSXPHN1pntcJ8/HF9AZ8A
         dlKQ==
X-Gm-Message-State: AOAM530unwZ3y+tCU1Hm55bgwj1iu3maM6ZgnHEqsN4wkXvSjCQAggPl
        tMP8gMgxEI25u7DQNu8pXBxLQw==
X-Google-Smtp-Source: ABdhPJwZ0cIPwiohcaickHlCzeWrf8plicrIghT5eQTF8d3wUQevpwRC9KhmCWWCaIrNRPHbfdIv9A==
X-Received: by 2002:a05:6000:c6:: with SMTP id q6mr2033013wrx.181.1640177646610;
        Wed, 22 Dec 2021 04:54:06 -0800 (PST)
Received: from google.com ([2.31.167.18])
        by smtp.gmail.com with ESMTPSA id p2sm1806840wrs.112.2021.12.22.04.54.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 04:54:06 -0800 (PST)
Date:   Wed, 22 Dec 2021 12:53:59 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Frank Wunderlich <frank-w@public-files.de>
Cc:     Peter Geis <pgwipeout@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH v3] mfd: rk808: add reboot support to rk808.c
Message-ID: <YcMf56MvFv0ym7E5@google.com>
References: <20211220144654.926112-1-pgwipeout@gmail.com>
 <trinity-c54ecce4-7a39-4143-b136-f53c9b40ffd1-1640018026851@3c-app-gmx-bap45>
 <YcGU6pQqfEPBqjrO@google.com>
 <4963E4A2-63B4-48A1-BDDD-5F9D07D71598@public-files.de>
 <YcMHhJTsQMLDRRsN@google.com>
 <trinity-4d94e8dd-1499-4d5f-84c3-85075a4085dd-1640172673779@3c-app-gmx-bs44>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <trinity-4d94e8dd-1499-4d5f-84c3-85075a4085dd-1640172673779@3c-app-gmx-bs44>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Dec 2021, Frank Wunderlich wrote:

> > Gesendet: Mittwoch, 22. Dezember 2021 um 12:09 Uhr
> > Von: "Lee Jones" <lee.jones@linaro.org>
> > An: "Frank Wunderlich" <frank-w@public-files.de>
> > > Here i have squashed the change in:
> > >
> > > https://github.com/frank-w/BPI-R2-4.14/commit/06430ffcb6d58d33014fb940256de77807ed620f
> > >
> > > With the change i can compile it...
> >
> > Not sure I understand.
> >
> > Please make sure all patches you send for inclusion into the Linux
> > kernel are fully tested.  They should also be bisectable i.e. not
> > depend on patches applied *on top*.
> >
> > > But in v4 (patch is tagged as v3 too) the of_property_read_bool was dropped completely.
> > > regards Frank
> 
> only v1 was sent by me :)
> 
> v4 is compilable and works on rk809 (Bananapi r2 pro)

My comments are directed at whoever sent patches without testing.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
