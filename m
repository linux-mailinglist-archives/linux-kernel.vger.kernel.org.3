Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAC20486AEC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 21:13:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243597AbiAFUNX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 15:13:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbiAFUNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 15:13:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C6DEC061245;
        Thu,  6 Jan 2022 12:13:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D9EE361D59;
        Thu,  6 Jan 2022 20:13:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FCD6C36AE3;
        Thu,  6 Jan 2022 20:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641500000;
        bh=Sa5hK/3fl6EtdenwmTSUJ7FMQ9CLdnRum0y0IkXl1Mo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mpout7Ni8/Br/FiEA1BOnR39ReQL6WFU9Cp3SgxASfIfOznZwMWIZ2OkfuZIZRr4R
         dXQr2oiGUl9No0Wu6dtWK1+OFPQzaaXVh0zemYV4278ZoSrfF9xBmw8bCV36YOEzwC
         l9KWXCbGBhi87q0l2xqSpB30ELVWAF3146se18eTw3knzqaY3mPYd22jNulJb50U6+
         hOCy10lq6f4dwvCqk+d9u7rBF0It2eMhHW7Ve1gBTh/tqrWBwJrxFSXutMvCipqxrP
         reEO1oM3T0HAZZp9ZtVsMqQ8NIQSWpV6bgniQ9Re8LsDwg/8Tur8Shx2bmJ33AU4ee
         7qdOD5GvYbj9g==
Date:   Thu, 6 Jan 2022 21:13:16 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Robert Schlabbach" <Robert.Schlabbach@gmx.net>,
        Antti Palosaari <crope@iki.fi>, linux-media@vger.kernel.org
Subject: Re: [PATCH] media: si6157: fix a tune regression for 6.1MHz
Message-ID: <20220106211316.4025661b@coco.lan>
In-Reply-To: <71025d9c4f8d37f23cf080ee69e1d583bf320e3e.1641498239.git.mchehab@kernel.org>
References: <trinity-59d726d3-993c-43c9-9e44-5be5cdfae74d-1641493525223@3c-app-gmx-bap38>
        <71025d9c4f8d37f23cf080ee69e1d583bf320e3e.1641498239.git.mchehab@kernel.org>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu,  6 Jan 2022 20:44:29 +0100
Mauro Carvalho Chehab <mchehab@kernel.org> escreveu:

> The patch which added support for 1.7MHz and 6.1 MHz has
> two issues: there's a missing else for 1.7 and the value
> for 6.1 MHz filter is decimal 10 (0x0a).
> 
> Fix those.

Please ignore this one. I was too quick writing it: it doesn't
address all reported issues.

Regards,
Mauro
