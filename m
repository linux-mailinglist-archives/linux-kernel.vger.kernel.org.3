Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91D8F4C2DD6
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 15:05:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235329AbiBXOEw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 09:04:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbiBXOEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 09:04:51 -0500
Received: from smtp.domeneshop.no (smtp.domeneshop.no [IPv6:2a01:5b40:0:3005::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9342A20E782
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 06:04:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org
        ; s=ds202112; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=In1tFsWPrLFrqNLMpx3GuPpIs5m9KwMwJez6fPga1iE=; b=BpkO8GxoEqhNunPCOAzYt6PR1/
        SOmbhli+VLn7MtqDLxOVi3SlHmSOQpdOn2CWgXV1/nQ4wfbLn+BOs7bs16b2eJzlOEcaWf/9uGJLR
        gXj5kxSXJ9/zDijlpvsHt9yivArF0dr1/83eJUP3U7Tn8yI7X6RSVBCOHV7WzoH8Db8loGXkmnNh9
        QwzIx49MiMjY6UcYAffpZ7+GWjvivfVAPRqlLst7Qtt+NkRniKjWJp7SxvbzcQP+EMBmpxNpFS4nd
        QUF+wopZlxV2NHZleVdduUg701TnxMfHJ57twpKh3UcleHexxxhy0QUpxFnfFh4a5D7egA2zb+iFC
        JTm0aAwQ==;
Received: from [2a01:799:95e:a400:cca0:57ac:c55d:a485] (port=64706)
        by smtp.domeneshop.no with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <noralf@tronnes.org>)
        id 1nNEjC-0005ye-7d; Thu, 24 Feb 2022 15:04:18 +0100
Message-ID: <af865ac6-0353-0004-dec2-f227ee8bb01d@tronnes.org>
Date:   Thu, 24 Feb 2022 15:04:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH] drm/repaper: Use format helper for xrgb8888 to monochrome
 conversion
To:     Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
References: <20220223193735.213185-1-javierm@redhat.com>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
In-Reply-To: <20220223193735.213185-1-javierm@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Den 23.02.2022 20.37, skrev Javier Martinez Canillas:
> There is now a drm_fb_xrgb8888_to_mono_reversed() helper function to do
> format conversion from XRGB8888 to reversed monochrome.
> 
> Use that helper and remove the open coded version in the repaper driver.
> 
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> ---

Tested-by: Noralf Trønnes <noralf@tronnes.org>
Reviewed-by: Noralf Trønnes <noralf@tronnes.org>

Do you have commit rights and will apply this patch?

Noralf.
