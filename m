Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12D3F476D5A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 10:27:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235303AbhLPJ0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 04:26:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235280AbhLPJ0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 04:26:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6045EC061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 01:26:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E7013B82317
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 09:26:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62F28C36AE4;
        Thu, 16 Dec 2021 09:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639646803;
        bh=R38iCDU2BP5TkHwgzbn3K8f4hWmMujmJ22xu9QwivSM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EoNjvkh9uqUKq76dtkkpgS/h89OdwUGA0C1o77g0pH2g3/DkZKVHh1sOetYQ0py7Q
         wILypGfAOEeZKRSS5uijBzm57opcKKsmYYen64O7E6Ur92weqUQxx3ms7JUJ6rMLOX
         fI5xe+ZcIkyW5l1LY8izjDHKlVFrMVbZ2ZadpE3m71Ln5d7tbSn8sPPH5nsf8kozj1
         V3ie/ejezKn4LF2vMnvDsbYC6EhhT5cIZlPS3sE32ivXZvDFkVjMuwopB+y8SZheyb
         WD19JsSOusHywvXFeSueliuw9QPeL1fIRhVYlzn/cVXZ2i9lmWoy9ue9OjZwvWqECq
         4ckCLfdzhWqtw==
Date:   Thu, 16 Dec 2021 17:26:39 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Li Yang <leoyang.li@nxp.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ioana Radulescu <ruxandra.radulescu@nxp.com>,
        Vicentiu Galanopulo <vicentiu.galanopulo@nxp.com>,
        Florin Chiculita <florinlaurentiu.chiculita@nxp.com>
Subject: Re: [PATCH v3 02/10] arm64: dts: lx2160a-rdb: Add Inphi PHY node
Message-ID: <20211216092638.GC4216@dragon>
References: <20211214072342.22692-1-leoyang.li@nxp.com>
 <20211214072342.22692-3-leoyang.li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211214072342.22692-3-leoyang.li@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2021 at 01:23:34AM -0600, Li Yang wrote:
> From: Ioana Radulescu <ruxandra.radulescu@nxp.com>
> 
> DPMAC5 and DPMAC6 are connected to 25G Inphi PHY
> 
> Signed-off-by: Vicentiu Galanopulo <vicentiu.galanopulo@nxp.com>
> Signed-off-by: Florin Chiculita <florinlaurentiu.chiculita@nxp.com>
> Signed-off-by: Ioana Radulescu <ruxandra.radulescu@nxp.com>
> Signed-off-by: Li Yang <leoyang.li@nxp.com>

Applied, thanks!
