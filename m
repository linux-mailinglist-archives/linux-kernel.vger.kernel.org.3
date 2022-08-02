Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC1B587D29
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 15:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236773AbiHBNdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 09:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232569AbiHBNdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 09:33:45 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F36F9183A0
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 06:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Fwo6WykRfnhHjnEk1i7dDohr9Ek6DQruaBKzVUzk+jI=; b=O6KPrWVLyPLkUhm3jXsG0AyY5c
        HeiblfKLHksQE0XuCVJqKU3DhNq9lM1GlVQH3e3C1olABLSkCRmkMrxyMQpFYPSzrozW8u00TONpx
        NVHnYoMElNL2ZPB/jyE7zINl4QU3yEoRVt9YaSM8Jdg9AZW1U7viOlILUfEtGv9XISQTorJGNHx1t
        RQGHnBDaQFBwTDhtW5BzWKXgADazX5dAvcLBBWsVEjkzu036X9vMF6hSF9BGPNseKzWJASrrchhjk
        4Cv9s9KJ7lb8zOToX5+F9Dusvfn2HzHCGcJG4S1Xi4PVlacp08NHK5+1J0ioRkk+LZdRx6xij01Mn
        KxlGXQbg==;
Received: from [187.34.27.134] (helo=[192.168.15.109])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1oIs1k-00Ehs8-8s; Tue, 02 Aug 2022 15:33:40 +0200
Message-ID: <a6dbbd10-9638-bd1b-9a68-17c79cadca3d@igalia.com>
Date:   Tue, 2 Aug 2022 10:33:21 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] drm/amd/display: remove DML Makefile duplicate lines
Content-Language: en-US
To:     Magali Lemes <magalilemes00@gmail.com>, harry.wentland@amd.com,
        sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com,
        alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@linux.ie, daniel@ffwll.ch
Cc:     siqueirajordao@riseup.net, tales.aparecida@gmail.com,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        mwen@igalia.com, mairacanal@riseup.net,
        dri-devel@lists.freedesktop.org, isabbasso@riseup.net,
        andrealmeid@riseup.net
References: <20220802120406.88845-1-magalilemes00@gmail.com>
From:   =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <20220802120406.88845-1-magalilemes00@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Às 09:04 de 02/08/22, Magali Lemes escreveu:
> There are two identical CFLAGS entries for "display_mode_vba_20.o", so
> remove one of them. Also, as there's already an entry for
> "display_mode_lib.o" CFLAGS, regardless of CONFIG_DRM_AMD_DC_DCN being
> defined or not, remove the one entry between CONFIG_DRM_AMD_DC_DCN ifdef
> guards.
> 
> Signed-off-by: Magali Lemes <magalilemes00@gmail.com>
> ---

Reviewed-by: André Almeida <andrealmeid@igalia.com>
