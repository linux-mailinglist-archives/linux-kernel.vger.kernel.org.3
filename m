Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2BF3595D80
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 15:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbiHPNiE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 09:38:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233911AbiHPNiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 09:38:01 -0400
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E8D66E8B0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 06:38:00 -0700 (PDT)
Received: from fews2.riseup.net (fews2-pn.riseup.net [10.0.1.84])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mail.riseup.net", Issuer "R3" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 4M6XK25PnyzDqB1;
        Tue, 16 Aug 2022 13:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1660657079; bh=e1NAneVpie+FMvLSmWkFYcTAXo3RG8Tqm3ms4ywkUas=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=qoTVEtuiyoWct7y/0DKg619AgFoIX0pL5M1BoKEHf6fdcqr3UXw749SSCV0W2Gbfd
         toFXFjMHkzmvpK4c6Bwk8o0FxBXBWeVBarnsPpBSkHIpUgmzPKRPWED4IoVt8KL1xI
         f2yCV430SkTr/w6PO5+pZiJovYG6ETHvuGXiYIkY=
X-Riseup-User-ID: 1BAFF1A5DB19634CA94E4BD39F28FA2FE8D6237420E2EDDB661A052CFA0F22F9
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews2.riseup.net (Postfix) with ESMTPSA id 4M6XJx2Nzvz1y9N;
        Tue, 16 Aug 2022 13:37:53 +0000 (UTC)
Message-ID: <6761eeb7-eedf-c9bb-4f7f-d42e3c6e8ae4@riseup.net>
Date:   Tue, 16 Aug 2022 10:37:49 -0300
MIME-Version: 1.0
Subject: Re: [PATCH 0/3] KUnit tests for RGB888, XRGB2101010 and grayscale
Content-Language: en-US
To:     =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>,
        javierm@redhat.com
Cc:     davidgow@google.com, dlatypov@google.com, tzimmermann@suse.de,
        mripard@kernel.org, daniel@ffwll.ch, airlied@linux.ie,
        maarten.lankhorst@linux.intel.com, jani.nikula@linux.intel.com,
        isabbasso@riseup.net, magalilemes00@gmail.com,
        tales.aparecida@gmail.com, geert@linux-m68k.org,
        dri-devel@lists.freedesktop.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
References: <20220816102903.276879-1-jose.exposito89@gmail.com>
From:   =?UTF-8?Q?Ma=c3=adra_Canal?= <mairacanal@riseup.net>
In-Reply-To: <20220816102903.276879-1-jose.exposito89@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Hi José,

Tested the whole series on UML, x86, i386 and PPC. All looks fine!

Tested-by: Maíra Canal <mairacanal@riseup.net>

Best Regards,
- Maíra Canal

On 8/16/22 07:29, José Expósito wrote:
> Hello everyone,
> 
> This series is a follow up on my work adding KUnit test to the XRGB8888
> conversion functions. This time RGB888, XRGB2101010 and gray8 are added.
> 
> Best wishes,
> Jose
> 
> José Expósito (3):
>    drm/format-helper: Add KUnit tests for drm_fb_xrgb8888_to_rgb888()
>    drm/format-helper: Add KUnit tests for
>      drm_fb_xrgb8888_to_xrgb2101010()
>    drm/format-helper: Add KUnit tests for drm_fb_xrgb8888_to_gray8()
> 
>   .../gpu/drm/tests/drm_format_helper_test.c    | 190 ++++++++++++++++++
>   1 file changed, 190 insertions(+)
> 
