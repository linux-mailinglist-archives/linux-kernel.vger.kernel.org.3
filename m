Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0ADC4A685B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 00:06:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242736AbiBAXGX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 18:06:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiBAXGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 18:06:22 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A7C9C061714
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 15:06:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=kzu0F19ot5U0CXhXpGsmgOBzGIvXF/v3Q09a87bCxyg=; b=gn26cEa6UIdLY+OV4ubyeB3cTC
        dJFg+fK25DZPXMP4goFy6z7Nr43CK/m7omd6BGcKlwIVnpMxy5XBOf6kWKS1ORRDdWCFttoyOurqp
        DotbZsXvUmIVn372SV+1EyMXd8B6kgejxV27J0FwYZVu683UT3IUsOfs/XIxw/NgLi6eMkZKXka+2
        iWGjxry/nEnAq4KOHhF9zASJUztmI+7+smaxr3EKNgeomwmUC2Fvxhb0k68Zjw6PiHXKrlWpdpX9B
        KKMHvIsC0y1v3Cd/ZCwvtcVebfrxkwS0c/oTRBG6JAHxcUXB8ONX3Nd4zNUPm/PSzyYsiOYrJzAhG
        H4V+TBKg==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nF2Dy-0060mV-Uw; Tue, 01 Feb 2022 23:06:11 +0000
Message-ID: <9bab4777-3034-b789-fdf6-ca8d7e6a8c35@infradead.org>
Date:   Tue, 1 Feb 2022 15:06:04 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: Kconfig CONFIG_FB dependency regression
Content-Language: en-US
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Kees Cook <keescook@chromium.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Arnd Bergmann <arnd@kernel.org>
Cc:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        Bing Yuan <Bing.Yuan@synopsys.com>,
        John Youn <John.Youn@synopsys.com>
References: <6fc4a81f-1a13-bff9-7b2e-d5bec382cb42@synopsys.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <6fc4a81f-1a13-bff9-7b2e-d5bec382cb42@synopsys.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/1/22 15:01, Thinh Nguyen wrote:
> Hi,
> 
> One of our test setups is unable to boot (stuck at initramfs). Git
> bisection points to the commit below:
> 
> f611b1e7624c ("drm: Avoid circular dependencies for CONFIG_FB")
> 
> Reverting this patch resolves the issue. This issue persists in mainline
> also. Unfortunately there isn't any meaningful log. Hopefully someone
> can give some insight as to what could be the issue and revert/fix this
> issue.

Hi,
Did you enable DRM_FBDEV_EMULATION?
Please provide the failing .config file.

-- 
~Randy
