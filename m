Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEBFF477654
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 16:48:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238699AbhLPPsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 10:48:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232576AbhLPPsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 10:48:14 -0500
Received: from smtp.domeneshop.no (smtp.domeneshop.no [IPv6:2a01:5b40:0:3005::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3B5FC061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 07:48:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org
        ; s=ds202112; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=KXiEKf2xUWckvnPILapcYIfUW0A0jk3g75kfYQ33+WI=; b=HY+CthniHIqLkMnU6kzPLMqTai
        FCqDX2qWIYcctfxg5MRm+A/NEZmCLXQqmcr0BFYt+4Pd5EropYPtGlfBKmLLh7EgatviLwoqs82fw
        tvldeZpQ84am0d7652c5/qn4RkQ/a2wm/rnPHmMMtjff2A86gtWurR4BFIeR8fvXAd03kQO/czQ43
        UsR2gcnkjNyhvOdhEDjpXuK92wCigjJfPyjPwiYlMRb2+LoBbIJ0Gqmb5U4YAdA3h4EiXP0w6L8RO
        Xyaf56tAy+TCxiYoteVHR6lKAvi2fTiHMIaeS0Hag3CRDZEgHmD2RlA/a0OhW5VcFOUDW5F305i0N
        uGV0H23w==;
Received: from 211.81-166-168.customer.lyse.net ([81.166.168.211]:55330 helo=[192.168.10.61])
        by smtp.domeneshop.no with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <noralf@tronnes.org>)
        id 1mxszM-0002M1-OW; Thu, 16 Dec 2021 16:48:12 +0100
Message-ID: <4a37d0ed-f252-69c5-6139-f4c704e89dbd@tronnes.org>
Date:   Thu, 16 Dec 2021 16:48:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 53/60] drm/repaper: Add support for the nomodeset kernel
 parameter
To:     Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20211215010008.2545520-1-javierm@redhat.com>
 <20211215010008.2545520-54-javierm@redhat.com>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
In-Reply-To: <20211215010008.2545520-54-javierm@redhat.com>
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
