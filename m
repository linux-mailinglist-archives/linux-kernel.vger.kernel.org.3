Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97089476D59
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 10:27:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235295AbhLPJZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 04:25:17 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:59104 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235280AbhLPJZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 04:25:15 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 710B261CF1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 09:25:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD2B8C36AE4;
        Thu, 16 Dec 2021 09:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639646714;
        bh=ZaU5mJ2VMqWCs6Snth/lcaFh+v8kqGXkH/CcId1ma6g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PAg5f+LgWBK3bs1WTPmhfNPMuVi9gd794wAm924rGbRWw/De28B6Rx7pJ+ROC67Pz
         fEneUgrXp0lhzcTgG9+420Trav2cgzOGQ76te7Qzp7TFTSOyP0IwSqHW9houpNUNsl
         N0y+HaUNzjx8wREbM5kwPlh2xRTodTCcFSaAuIqFyMnH6MCBm1HEeEOYxAkU5ph0Y/
         SSYyasl1xzhegxgVY6+SYOYLI4DqkjwltTmxAp68hHzOV8rJDhEO+z5zMpkG2ThV0w
         Y7acgKOJBtkJSqnVZpVZzvKD0wUpyGe4U+gmilpA/vXF/SVEAoORHzUEZualq26ipn
         ZfNDXUPloLoNQ==
Date:   Thu, 16 Dec 2021 17:25:09 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Li Yang <leoyang.li@nxp.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Zhang Ying-22455 <ying.zhang22455@nxp.com>
Subject: Re: [PATCH v3 01/10] arm64: dts: lx2160a: fix scl-gpios property name
Message-ID: <20211216092508.GB4216@dragon>
References: <20211214072342.22692-1-leoyang.li@nxp.com>
 <20211214072342.22692-2-leoyang.li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211214072342.22692-2-leoyang.li@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2021 at 01:23:33AM -0600, Li Yang wrote:
> From: Zhang Ying-22455 <ying.zhang22455@nxp.com>
> 
> Fix the typo in the property name.
> 
> Fixes: d548c217c6a3c ("arm64: dts: add QorIQ LX2160A SoC support")
> Signed-off-by: Zhang Ying <ying.zhang22455@nxp.com>
> Signed-off-by: Li Yang <leoyang.li@nxp.com>

Applied, thanks!
