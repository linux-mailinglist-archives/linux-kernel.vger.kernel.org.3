Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66448477653
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 16:48:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238688AbhLPPsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 10:48:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238712AbhLPPsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 10:48:06 -0500
Received: from smtp.domeneshop.no (smtp.domeneshop.no [IPv6:2a01:5b40:0:3005::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 346E6C061751
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 07:48:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org
        ; s=ds202112; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=KXiEKf2xUWckvnPILapcYIfUW0A0jk3g75kfYQ33+WI=; b=iOdPinnKHUQGAxH7NJau9pD5LX
        ZKpQM9Q5DWVbTfAosblqtw2Aw+MqjT87KqBCjTrikUOpgoIKIyZVgnR8ubfD35bnWl1bKsX5LIpGk
        FEVODEdP9u51nss8lcT51bvCT9DeAjX3ek1LOMdMroTqulBC1O863EZWsvVfyq2kYAbTQrVQSz24X
        C1tU0jiLyXFbG+qhV8qJpJpWk4gZZEojTMuDmlC9aPMqeaxdJMafqmGZZWJP35C5VALwwaaxHF51X
        joyGcYObSYbtGtp30v38RlKuiCpF651Cxyxg3dMKYJwFftshYaXsKjFbwlsfHD4ycCDzD9XMEFAUA
        d/ESjX1g==;
Received: from 211.81-166-168.customer.lyse.net ([81.166.168.211]:55324 helo=[192.168.10.61])
        by smtp.domeneshop.no with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <noralf@tronnes.org>)
        id 1mxszE-0002Ee-3a; Thu, 16 Dec 2021 16:48:04 +0100
Message-ID: <7c86cfd8-100f-4a79-5709-2d175cb2b276@tronnes.org>
Date:   Thu, 16 Dec 2021 16:48:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 52/60] drm/mi0283qt: Add support for the nomodeset kernel
 parameter
To:     Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20211215010008.2545520-1-javierm@redhat.com>
 <20211215010008.2545520-53-javierm@redhat.com>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
In-Reply-To: <20211215010008.2545520-53-javierm@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Den 15.12.2021 02.00, skrev Javier Martinez Canillas:
> According to disable Documentation/admin-guide/kernel-parameters.txt, this
> parameter can be used to disable kernel modesetting.
> 
> DRM drivers will not perform display-mode changes or accelerated rendering
> and only the systewm system framebuffer will be available if it was set-up.
> 
> But only a few DRM drivers currently check for nomodeset, make this driver
> to also support the command line parameter.
> 
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> ---

Acked-by: Noralf Trønnes <noralf@tronnes.org>
