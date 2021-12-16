Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41E154772CF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 14:13:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237333AbhLPNNE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 08:13:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234006AbhLPNND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 08:13:03 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A5D8C061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 05:13:03 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id d38so5222807lfv.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 05:13:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kempniu.pl; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=TTm8GDC4Ya1PnbACyYGyhr5iQAG0ULNVOO0jsio4rZA=;
        b=LRF3n/UsXcvgYxnMDNjPCEQyCZZNwivRd85ly2TdObMHNqqGTns7dbzWyPwzRBlQFb
         QCDk41nadEpWjrI4wp032SHMe3qQfQYdM054C8FnTb23Efy06FdaDulVp6BEKy2KVI22
         K6HE5/GPuxI0lDW3XWd6wpwayKpYsJmaSb3Xo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=TTm8GDC4Ya1PnbACyYGyhr5iQAG0ULNVOO0jsio4rZA=;
        b=zRkgh//zUYetN2hmSDmLLqKIbZKwFSN8CB3Qv32yFo8SD2UhJYbPph1btUiNGDkOOp
         0RL6sZPYL0UhV5Yhu8WpaBdZD7BUuBgTIOKBykHNUAHEvCLBq2qzsG43dj2LtUbngVOT
         rl9W8e8t6BDg7P26aOUXPztOovmwFB5zbRKd49f+r8XvJ7VrYmuHr+oPAEM50+1LjF86
         NEq10m68wIxArfcRDVwbCJnA+qS9UTthta0pEHL2qWttHOEw6Yx5Z1O4MuREjhurdkK9
         4ghSK8Um60EAdDh2U5vERwxg/Cj0uWhnpE5E4E/jQvQb9ypW7ze+D1dWOezatYo7kKNG
         nHNg==
X-Gm-Message-State: AOAM531zlc+qGNkzsHZL/88dKp2NKiTeN0iIcg4W3CbqMZRGy0n/yIMC
        udrD21rL4zgImKPTgZWG/E7+uA==
X-Google-Smtp-Source: ABdhPJy+TNijK7bNcSDi7if8DIwmcY9LfrlMb+6eVRT6hbFkqwSfWgTNIO6c7CeMuqkWfbTvfrFt1A==
X-Received: by 2002:a05:6512:ba8:: with SMTP id b40mr14989002lfv.114.1639660381435;
        Thu, 16 Dec 2021 05:13:01 -0800 (PST)
Received: from larwa.hq.kempniu.pl ([2001:470:64df:111::e02])
        by smtp.gmail.com with ESMTPSA id z23sm1125746ljn.23.2021.12.16.05.13.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 05:13:01 -0800 (PST)
Date:   Thu, 16 Dec 2021 14:12:58 +0100
From:   =?utf-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>
To:     Boris Brezillon <boris.brezillon@collabora.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] mtdchar: add MEMREAD ioctl
Message-ID: <Ybs7WrAQTat5Gsjg@larwa.hq.kempniu.pl>
References: <20211216083418.13512-1-kernel@kempniu.pl>
 <20211216112456.327298dd@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211216112456.327298dd@collabora.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Splitting patch 1 and 5 means you have an incompatible ABI change
> between those 2 commits, thus breaking bisectability. I'd recommend
> putting patches 2-4 first and squashing patch 1 and 5 in a single
> commit placed at the end of the series. The other options would be to
> add a way to extend ioctls in a backward compatible way (the DRM
> subsystem does that by filling the unspecified part of the struct with
> zeros, and relying on the fact that 0 values always implies 'default
> behavior' when the struct is extended [1]).

Ack, thanks.  I will follow your recommendation in v3 and in the
meantime the existing split should make it easier to follow how v2
extends v1 with ECC statistics handling.

-- 
Best regards,
Michał Kępień
