Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC0D5AA31B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 00:33:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233598AbiIAWdc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 18:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233057AbiIAWda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 18:33:30 -0400
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A723BC64
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 15:33:29 -0700 (PDT)
Received: from fews1.riseup.net (fews1-pn.riseup.net [10.0.1.83])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mail.riseup.net", Issuer "R3" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 4MJbRX4RfqzDqTD;
        Thu,  1 Sep 2022 22:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1662071609; bh=vFOW28U7e2tmiwu+hjUzu0rmnJAQnKcUXDY+PUL93FA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=bjL2tfuvdZwU5me4+LwChwaZ4tR3xFknXrbL8wlri/Yu5A4d0tYsX/jLRPRRsWeYL
         +uoiLRPVbiRn5TeD40hxN1K/IQhbYe715525dnHUhz1gSc2HKFCqAepCBa0Kpzgree
         9DvN7ZvPaT2oV58dcBXUKFUO2PhFL8kyeucLyoPg=
X-Riseup-User-ID: 1041B213356A975CFCF07C5A2FA5585F2A3B2C49FBA60EE30A8D0728AC31891F
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews1.riseup.net (Postfix) with ESMTPSA id 4MJbRP4PJgz5vXJ;
        Thu,  1 Sep 2022 22:33:20 +0000 (UTC)
Message-ID: <04aeba53-793c-3196-3137-915f0640dc2a@riseup.net>
Date:   Thu, 1 Sep 2022 19:33:18 -0300
MIME-Version: 1.0
Subject: Re: [PATCH v2 2/2] drm/tests: Change "igt_" prefix to "test_drm_"
Content-Language: en-US
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Isabella Basso <isabbasso@riseup.net>, magalilemes00@gmail.com,
        tales.aparecida@gmail.com, mwen@igalia.com, andrealmeid@riseup.net,
        siqueirajordao@riseup.net, Trevor Woerner <twoerner@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Javier Martinez Canillas <javierm@redhat.com>,
        David Gow <davidgow@google.com>, brendanhiggins@google.com,
        Arthur Grillo <arthur.grillo@usp.br>,
        michal.winiarski@intel.com,
        =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        kunit-dev@googlegroups.com
References: <20220901124210.591994-1-mairacanal@riseup.net>
 <20220901124210.591994-2-mairacanal@riseup.net>
 <20220901125530.b56s4zisnkfuigvc@houat>
From:   =?UTF-8?Q?Ma=c3=adra_Canal?= <mairacanal@riseup.net>
In-Reply-To: <20220901125530.b56s4zisnkfuigvc@houat>
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

Hi Maxime,

On 9/1/22 09:55, Maxime Ripard wrote:
> Hi,
> 
> On Thu, Sep 01, 2022 at 09:42:10AM -0300, Maíra Canal wrote:
>> With the introduction of KUnit, IGT is no longer the only option to run
>> the DRM unit tests, as the tests can be run through kunit-tool or on
>> real hardware with CONFIG_KUNIT.
>>
>> Therefore, remove the "igt_" prefix from the tests and replace it with
>> the "test_drm_" prefix, making the tests' names independent from the tool
>> used.
>>
>> Signed-off-by: Maíra Canal <mairacanal@riseup.net>
>>
>> ---
>> v1 -> v2: https://lore.kernel.org/dri-devel/20220830211603.191734-1-mairacanal@riseup.net/
>> - Change "drm_" prefix to "test_drm_", as "drm_" can be a bit confusing (Jani Nikula).
> 
> I appreciate it's a bit of a bikeshed but I disagree with this. The
> majority of the kunit tests already out there start with the framework
> name, including *all* the examples in the kunit doc. Plus, it's fairly
> obvious that it's a test, kunit is only about running tests in the first
> place.

Would it be better to keep it as "drm_"?

Currently, I don't think it is appropriate to hold the "igt_" prefix, as
the tests are not IGT exclusive, but I don't have a strong opinion on
using the "drm_" or the "test_drm" prefixes.

Best Regards,
- Maíra Canal

> 
> Maxime
> 
