Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FDB547FC18
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 12:08:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236298AbhL0LIB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 06:08:01 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:36694 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233404AbhL0LIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 06:08:00 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8D5F860F15;
        Mon, 27 Dec 2021 11:08:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23712C36AEA;
        Mon, 27 Dec 2021 11:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640603280;
        bh=lGd8HHkcDZEOoSy237CO/NUiA+Tb3WGAEboNDpfIehI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tk29EfKd9Ez996/BKIIiTsX7pMjITL5y/OgAOG0XZKGWEBoqhQpKzLDcaNZnJzVs0
         c5CyGuY+QFf3qwFyArs2Dnze14B8mONCDxouymFWUS9pO35FoWY/VwMrb60cP9l4Py
         VmFO8+TTYpP1f1yJxMYqSc++xzfDq58NaIeUQlpsBVOFsosVRSCB5dD9mKBQ8gnQcu
         1WLl3fVwt7e3nW0KLIY2GuPwxq0BEkoSbwrorAKQlkHYU2EqpspwAWWnsErWDCfuOL
         LygSKg3RifaqNO+XYBdqZCzNeVIf85YYM197FRlXgU4lTCP4MPso9HpO8cqUk2sU+5
         NWmC01vKU6cFA==
Date:   Mon, 27 Dec 2021 16:37:56 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Swapnil Jakhade <sjakhade@cadence.com>
Cc:     kishon@ti.com, robh+dt@kernel.org, p.zabel@pengutronix.de,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, mparab@cadence.com, a-govindraju@ti.com
Subject: Re: [PATCH v4 00/15] PHY: Add support for multilink configurations
 in Cadence Sierra PHY driver
Message-ID: <YcmejF/Xs+RfnTQC@matsya>
References: <20211223060137.9252-1-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211223060137.9252-1-sjakhade@cadence.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-12-21, 07:01, Swapnil Jakhade wrote:
> Cadence Sierra PHY is a multiprotocol PHY supporting different multilink
> PHY configurations. This patch series extends functionality of Sierra PHY
> driver by adding features like support for multilink multiprotocol
> configurations, derived reference clock etc.
> 
> The changes have been validated on TI J721E platform.

Applied, thanks

-- 
~Vinod
