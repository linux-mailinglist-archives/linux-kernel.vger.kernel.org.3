Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B15348CBBD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 20:17:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344832AbiALTRp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 14:17:45 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:37224 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344337AbiALTRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 14:17:43 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: alyssa)
        with ESMTPSA id C4AE51F453CE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1642015062;
        bh=Nm673CquIpUd7DH5oIeAGKy8gWnmmyZi5gLKio0coZc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M1NlySwXi9Mq46LTnbHlmU9+w5h9UFGwD/GT5S0E1nauO/9fTiAntg+rRVLqTRgcL
         bZ8L+P8HK5KjNnMmBqFHe4HF4u6dagvron5FRj0znfZx0KZnnfhFvCZwW23JXcuEJN
         no3XTJbFwfTyBoBOouG7XY4fmZfKpjywAtYbY9YBV2m+Ei+ieLgmxs7F3dWMKMilyB
         yj10+IErprgb6H1yn9eBHj0HFYG1HhLDCxZnjcu7v5v35hvpFRRhl0iIn64+xcQ66M
         0xYEXZgYNRZKhF0N6755n2MqTn68u6wBe//DK9ej9sKy6m2I5bDq621lSlKOMI9HFo
         KiBtKuFsuXhqA==
Date:   Wed, 12 Jan 2022 14:17:34 -0500
From:   Alyssa Rosenzweig <alyssa@collabora.com>
To:     Steven Price <steven.price@arm.com>
Cc:     Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        dri-devel@lists.freedesktop.org, Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] drm/panfrost: Remove features meant for userspace
Message-ID: <Yd8pTt2Bu/hITgva@maud>
References: <20220109170920.2921-1-alyssa.rosenzweig@collabora.com>
 <20220109170920.2921-2-alyssa.rosenzweig@collabora.com>
 <c13f9381-120b-e891-bdda-86cfec39b31f@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c13f9381-120b-e891-bdda-86cfec39b31f@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> (although it's a good thing kbase never did this cleanup - it's a useful
> source of public information ;) )

Haha, yes. Actually, kbase did do the clean up recently (Valhall era
kbase, I guess). To be fair, I still don't know what some of these were,
like "T7xx pairing rules"... Presumably something dreadfully
Midgard-compiler specific.
