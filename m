Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95965476E76
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 11:01:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235611AbhLPKBW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 05:01:22 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:50020 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbhLPKBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 05:01:21 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9DF2F61D28
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 10:01:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C536C36AE4;
        Thu, 16 Dec 2021 10:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639648881;
        bh=uzlm97ruxwfQegjYUm+dCdfzILAzYu80si94m0oZh7o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h3RW0W3+oUahuXPbKVGM/o/lwRoOmqsy8FDZfpukGXb8GucUKodTrxOV7Jl0pHQUr
         AIGfywWYGjT8WL7k1hfXMLuZ0+Wz5s37F5q6/NJHj7fGgCulTT7PZOa81h2R9yEZaO
         Km1zULUuUglWif60LutGmCifjDY4h2Ulzgz5ZaIB/0IfAowfpLhUmG73IMe1gulxEM
         fHbH6Mnyl0UYLeb1Y3wjkbsGQGRYrPCVe4P4epAs/Z0N+dQcaO8lFlvwNuDqtQfWPL
         iO0K+hlwVePpHVGrovsHtnChNTMtK3tZGaZerrGbf0usAQT7C7MwsQKhjLC3SgalNW
         1fcMqUgr/vrFg==
Date:   Thu, 16 Dec 2021 18:01:16 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Li Yang <leoyang.li@nxp.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/8] arm64: dts: ls1028a-rdb: reorder nodes to be
 alphabetic
Message-ID: <20211216100115.GJ4216@dragon>
References: <20211214093240.23320-1-leoyang.li@nxp.com>
 <20211214093240.23320-5-leoyang.li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211214093240.23320-5-leoyang.li@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2021 at 03:32:36AM -0600, Li Yang wrote:
> Keep these overrides node in alphabetic order in order to prevent
> unnoticed duplicated nodes.
> 
> Signed-off-by: Li Yang <leoyang.li@nxp.com>

Already had a patch from Vladimir [1].  Applied rest of the series,
thanks!

Shawn

[1] https://lore.kernel.org/lkml/20211202141528.2450169-2-vladimir.oltean@nxp.com/
