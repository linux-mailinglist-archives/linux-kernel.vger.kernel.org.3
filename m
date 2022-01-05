Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBBDD484D44
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 06:10:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236185AbiAEFKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 00:10:47 -0500
Received: from box.trvn.ru ([194.87.146.52]:40353 "EHLO box.trvn.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232448AbiAEFKr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 00:10:47 -0500
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id 53095403F4;
        Wed,  5 Jan 2022 10:10:42 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1641359443; bh=viEaMU43NGKgfhxi+YoGuWp9iDZfP0psKjUGoHbDMPk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=azHBU5xzOQpuEcOIHgaXFUz2tLSlqIB+0k6A1TAe5DZ9WOnib06td1iXdli4z/dno
         jAMTSf/nD1sivc/b81F1ptq5LNA6oZfk/bsa81sGBMSlf0r+FYP4TxPikskB40KQz8
         MnblIfqQedE8YGF9ITmJtRNlZwbUHV3uDqfNkwVZqNap8K6TBnjkW/EyVcYKf04Bra
         TdHWiDgBsiyzcrmPnzof9RVy0n+ypzoks7WtJrhNTYeYHK5Y5ksz/TecptjClvCqst
         91UtQxTEpG/fYNSyEoUuw7UXj2x6k+Z1OVQ+qI2XAj26DAjClGt1BD+0+41nN6dpKA
         uTnzJV2g39tUg==
MIME-Version: 1.0
Date:   Wed, 05 Jan 2022 10:10:41 +0500
From:   Nikita Travkin <nikita@trvn.ru>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        Michael.Srba@seznam.cz, broonie@kernel.org,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        phone-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH 0/6] Add touch-keys support to the Zinitix touch driver
In-Reply-To: <CACRpkdaumfXijp_QGU8hL9TTmFYBNaaBe+_fuc1hCJnA_CfWNw@mail.gmail.com>
References: <20211027181350.91630-1-nikita@trvn.ru>
 <CACRpkdaumfXijp_QGU8hL9TTmFYBNaaBe+_fuc1hCJnA_CfWNw@mail.gmail.com>
Message-ID: <f20420dbaa8fbf667b701ab51aba9720@trvn.ru>
X-Sender: nikita@trvn.ru
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Walleij писал(а) 05.01.2022 02:04:
> Hi Nikita,
> 
> On Wed, Oct 27, 2021 at 8:15 PM Nikita Travkin <nikita@trvn.ru> wrote:
> 
>> This series adds support for the touch-keys that can be present on some
>> touchscreen configurations, adds the compatible for bt532 and fixes a
>> small race condition bug in the driver probe function.
> 
> This appears unaddressed since October?
> I see there are just some small nits in patch 5 & 6 to fix, then
> it is finished.
> 

Hi, I was planning to include the fix for the message reporting
to the next version as well but then I got rather low on time
and could never finish that bit. As it seem to only affect my
device, there was not really much stopping me from submitting
a next version without that fix other than my "irrational
perfectionism" which I should probably learn to recognize better...

> Do you have time to pick it up for kernel v5.17 instead?
> Make sure to collect all Reviewed-by on this series.
> 

I will try to submit a new version with review fixes and
tags shortly.

Thanks,
Nikita

> Yours,
> Linus Walleij
