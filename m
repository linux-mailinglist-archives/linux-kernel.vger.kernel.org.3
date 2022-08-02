Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 154DA587D23
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 15:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236671AbiHBNcH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 09:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233142AbiHBNcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 09:32:00 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D232A17A8C
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 06:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=mp0CGMiBXy71SpOOQFY30cTJ8g7bkqqErkbWltubfWk=; b=Y858Ago0qi8B6ZL2PlN7IP2Gfq
        G4d4bDgG62Q8qKbUVqJpnL+xuuUB3uhSn6aKWIKw3dA3fgxrW8T+74mlbBOqf7rN7HAb0rmNuBvTi
        1+MMuo5Yu2ATZeLQbqnwy60ff5tLFv4ovWDUOI32BSgskSyWuMNbIu/FTEHq47EUnju2rUXzSOKfx
        CHR+4RRGiui2U42IJpqHJfiTfo1VSPdRQfZPx3rvUL9ZK6WbSXMPRGv2mEVOOf0S0lvFy1z/aVWFm
        uC8Xth80fQdzOma6u2ir6yCuGdyNnKdJus7Qkr+0kbjq2DE+54mDWaWUvoBOaZ403mGHNjjYpWhn3
        PsPNL+fw==;
Received: from [187.34.27.134] (helo=[192.168.15.109])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1oIrzx-00EhoP-Kq; Tue, 02 Aug 2022 15:31:49 +0200
Message-ID: <7069d082-f508-af3a-8098-081e59a4e41f@igalia.com>
Date:   Tue, 2 Aug 2022 10:31:30 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 1/3] drm/amd/display: make variables static
Content-Language: en-US
To:     Magali Lemes <magalilemes00@gmail.com>
Cc:     siqueirajordao@riseup.net, sunpeng.li@amd.com,
        alexander.deucher@amd.com, Rodrigo.Siqueira@amd.com,
        harry.wentland@amd.com, tales.aparecida@gmail.com,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        mairacanal@riseup.net, dri-devel@lists.freedesktop.org,
        isabbasso@riseup.net, andrealmeid@riseup.net,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@linux.ie,
        daniel@ffwll.ch, alex.hung@amd.com, mwen@igalia.com
References: <20220730010700.1824647-1-magalilemes00@gmail.com>
From:   =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <20220730010700.1824647-1-magalilemes00@gmail.com>
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



Às 22:06 de 29/07/22, Magali Lemes escreveu:
> As "dcn3_1_soc", "dcn3_15_soc", and "dcn3_16_soc" are not used outside
> of their corresponding "dcn3*_fpu.c", make them static and remove their
> extern declaration.
> 
> Fixes: 26f4712aedbd ("drm/amd/display: move FPU related code from dcn31 to dml/dcn31 folder")
> Fixes: fa896297b31b ("drm/amd/display: move FPU related code from dcn315 to dml/dcn31 folder")
> Fixes: 3f8951cc123f ("drm/amd/display: move FPU related code from dcn316 to dml/dcn31 folder")
> Signed-off-by: Magali Lemes <magalilemes00@gmail.com>
> Reviewed-by: Maíra Canal <mairacanal@riseup.net>
> Reviewed-by: Melissa Wen <mwen@igalia.com>
> ---

Series is Reviewed-by: André Almeida <andrealmeid@igalia.com>
