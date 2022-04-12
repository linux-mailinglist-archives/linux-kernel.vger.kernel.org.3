Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BBF24FE669
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 18:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356255AbiDLRBa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 13:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350604AbiDLRB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 13:01:28 -0400
X-Greylist: delayed 397 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 12 Apr 2022 09:59:09 PDT
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7B3CCC5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 09:59:08 -0700 (PDT)
Received: from fews1.riseup.net (fews1-pn.riseup.net [10.0.1.83])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mail.riseup.net", Issuer "R3" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 4KdBbf3jHxzDrNK;
        Tue, 12 Apr 2022 09:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1649782350; bh=mqIkrmMc3bt9SF6MVOjnFO/Z9nRa+OeF8I4cZ4B5EqM=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=SQnwxSdFaRv0TpSyDqeAtShH/Crkg4pUtCFYAMnJ1ElyLjqNaZripECStyfCMgKFG
         vp/udeHjSlEsLCBwyRULLhVZ2+WKPwPFVGcPbrwczGTJPXQiSzWJ73SZ5MmTDHTH3c
         642ut0tljgwH1GS6+vCt9ZHFU9cxlWvxuDThVirA=
X-Riseup-User-ID: 326DD260AC5C707B7ABD8D7E28AE5FD39250B3D2E2B8BE61D0BE289715F30496
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews1.riseup.net (Postfix) with ESMTPSA id 4KdBbb3Bw1z5vLq;
        Tue, 12 Apr 2022 09:52:27 -0700 (PDT)
Message-ID: <166f88cd-80aa-ea6c-9503-f15ba7b8da89@riseup.net>
Date:   Tue, 12 Apr 2022 13:52:24 -0300
MIME-Version: 1.0
Subject: Re: [PATCH 1/1] drm/vkms: check plane_composer->map[0] before using
 it
Content-Language: en-US
To:     Tales Lelo da Aparecida <tales.aparecida@gmail.com>,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Melissa Wen <melissa.srw@gmail.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20220411233801.36297-1-tales.aparecida@gmail.com>
 <20220411233801.36297-2-tales.aparecida@gmail.com>
From:   =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@riseup.net>
In-Reply-To: <20220411233801.36297-2-tales.aparecida@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tales,

Às 20:38 de 11/04/22, Tales Lelo da Aparecida escreveu:
> Fix a copypasta error, which resulted in checking repeatedly if the
> primary_composer->map[0] was null, instead of checking each
> plane_composer while composing planes.
> 
> Signed-off-by: Tales Lelo da Aparecida <tales.aparecida@gmail.com>

Reviewed-by: André Almeida <andrealmeid@riseup.net>
