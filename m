Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F129467664
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 12:31:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244548AbhLCLfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 06:35:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351834AbhLCLfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 06:35:03 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49386C06173E;
        Fri,  3 Dec 2021 03:31:39 -0800 (PST)
Received: from [192.168.1.111] (91-156-85-209.elisa-laajakaista.fi [91.156.85.209])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id DADBDA59;
        Fri,  3 Dec 2021 12:31:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1638531097;
        bh=g8VewkLNxgeqY0smuXrNzqSj4mXm3H/LbBl7zwaAQYU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=fRElAeNUoBPHNS2iI77y5XbCquTnFJoiWQpcWqzZxUrproMCVbG5oA3aMAUFLE9Sq
         Gv2tEwqkydBYu7dd925D1IqImSiAHEDMsah2CmDw0FegLtiKNHTsOZV1mi/UmeO1bc
         PXPnd6znk9vzIPuUaTk8gY7IWPFbFu3eyDIAleHU=
Subject: Re: [PATCH v7 0/9] drm/omap: Add virtual-planes support
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, khilman@baylibre.com
References: <20211117141928.771082-1-narmstrong@baylibre.com>
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Message-ID: <bab2b84a-ebef-ec69-187f-745e739079eb@ideasonboard.com>
Date:   Fri, 3 Dec 2021 13:31:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211117141928.771082-1-narmstrong@baylibre.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/11/2021 16:19, Neil Armstrong wrote:
> This patchset is the follow-up the v4 patchset from Benoit Parrot at [1].
> 
> This patch series adds virtual-plane support to omapdrm driver to allow the use
> of display wider than 2048 pixels.
> 
> In order to do so we introduce the concept of hw_overlay which can then be
> dynamically allocated to a plane. When the requested output width exceed what
> be supported by one overlay a second is then allocated if possible to handle
> display wider then 2048.
> 
> This series replaces an earlier series which was DT based and using statically
> allocated resources.
> 
> This implementation is inspired from the work done in msm/disp/mdp5
> driver.

I think this looks good. I'll apply this to my work tree to see if I see 
any issues during my daily work, and if not, I'll push to drm-misc-next.

Have you tested this with other platforms than x15? I'm mostly thinking 
about omap3/4, as the DSS is somewhat different on those platforms.

  Tomi
