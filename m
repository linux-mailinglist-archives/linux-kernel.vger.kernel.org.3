Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49CAF48649C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 13:51:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239082AbiAFMvs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 07:51:48 -0500
Received: from mail.wizzup.org ([95.217.97.174]:45560 "EHLO wizzup.org"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229795AbiAFMvr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 07:51:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=wizzup.org;
        s=mail; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:
        Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=nxhH/ukA9KWfY1p+zkFD+7VrSnCLJzCz3XNlG4Obn3w=; b=IvmV79CkASz7lYETsk4Z/zNT3g
        +/xWGuiHSS9+cmLLkodm18hu5EMb3afWn5eZGkdOC0AliZQdFBTyv+S8r8VjJ7zJ2U2zH3keizYpF
        FuxjokRZWtSRq7MzAJndfpwSfedgi9ojTfiitiwNySC8BWlkChl+wvstWdYaJtVy9SDW0bW8t6zPx
        mr4mBP7L7548WHnXdrsnIXcUMwcjuYc3D4BGcjPCG1HWOPCDMJ1iAx0lONQBnDMfQwKwvOIY1Eu/j
        p3PEriurY3/8Ep3pG7LlHvEYCR8DXA/29WmcKjUAZzXxBMkdGXHRRESqmADXnFHvyCOzsiP44vjFz
        W86gE3/w==;
Received: from [45.83.235.159] (helo=[0.0.0.0])
        by wizzup.org with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <merlijn@wizzup.org>)
        id 1n5SF2-00046Q-S3; Thu, 06 Jan 2022 12:51:40 +0000
Subject: Re: [Openpvrsgx-devgroup] [PATCH] drm: omapdrm: Fix implicit dma_buf
 fencing
To:     Tony Lindgren <tony@atomide.com>,
        OpenPVRSGX Linux Driver Group <openpvrsgx-devgroup@letux.org>,
        Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Cc:     tomba@kernel.org, sumit.semwal@linaro.org,
        christian.koenig@amd.com, philipp@uvos.xyz, airlied@linux.ie,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        daniel@ffwll.ch, linux-omap@vger.kernel.org,
        linux-media@vger.kernel.org
References: <1641397018-29872-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
 <Yda6VhRLHw06yVst@atomide.com>
From:   Merlijn Wajer <merlijn@wizzup.org>
Message-ID: <7edd09bf-7f2c-3ffd-b3ee-c0daaf0d6e37@wizzup.org>
Date:   Thu, 6 Jan 2022 13:51:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <Yda6VhRLHw06yVst@atomide.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 06/01/2022 10:45, Tony Lindgren wrote:
> * Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com> [220105 15:38]:
>> Fix that by initializing dma_buf resv to the resv of the gem object being
>> exported.
> 
> Nice find! This also fixes my wlroots test case with termite running on
> sway where termite would only partially update when switching between
> desktops, so:
> 
> Tested-by: Tony Lindgren <tony@atomide.com>

You can also add my:

Tested-by: Merlijn Wajer <merlijn@wizzup.org>

Cheers,
Merlijn
