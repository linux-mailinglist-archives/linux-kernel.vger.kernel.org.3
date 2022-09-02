Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 153545AA961
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 10:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235711AbiIBIEf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 04:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235703AbiIBIEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 04:04:33 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 921FABC13B
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 01:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662105870; x=1693641870;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=ryxTvjqPtRJ1iLn6tKKvj0lZz/JErC3NEAnjqxZHNG4=;
  b=XQMpdkznsS67WbHzVreIqCH8ItBdV+PTgw/xj03f9NjVd5qZcO1cfLJ1
   FMhBQoh0cPIB2jOEQaOr7Bqf9hd+SxZk8LBKzsnbXOVAeWDWjBj5om7Qz
   xd4gw5fI9JqHjHMfSSOyTeeQQplZ/XjBQ18wHp4VHOtSStwX23gu6gDz5
   q4dOh9gkQBh9/ATcjGMtAbEyZsm6QS4Cqv7j5YfOXPYBQDTP84nAeHCr3
   NBTtAu0dmLpsA2kCO2h29Ee2JYpbfYt36chadnL4VVNm+gIwPlEJLWA3K
   PV4Z2OPJOdvjdaYUM4KL73sebsaM6JF3wzSh8cQRfADaJ7wOBV0AOcZFt
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10457"; a="322085961"
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; 
   d="scan'208";a="322085961"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2022 01:04:30 -0700
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; 
   d="scan'208";a="674255907"
Received: from svandene-mobl.ger.corp.intel.com (HELO localhost) ([10.252.55.245])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2022 01:04:25 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     =?utf-8?Q?Ma=C3=ADra?= Canal <mairacanal@riseup.net>,
        Maxime Ripard <maxime@cerno.tech>
Cc:     Isabella Basso <isabbasso@riseup.net>, magalilemes00@gmail.com,
        tales.aparecida@gmail.com, mwen@igalia.com, andrealmeid@riseup.net,
        siqueirajordao@riseup.net, Trevor Woerner <twoerner@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Javier Martinez Canillas <javierm@redhat.com>,
        David Gow <davidgow@google.com>, brendanhiggins@google.com,
        Arthur Grillo <arthur.grillo@usp.br>,
        michal.winiarski@intel.com,
        =?utf-8?Q?Jos=C3=A9_Exp=C3=B3sito?= <jose.exposito89@gmail.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        kunit-dev@googlegroups.com
Subject: Re: [PATCH v2 2/2] drm/tests: Change "igt_" prefix to "test_drm_"
In-Reply-To: <04aeba53-793c-3196-3137-915f0640dc2a@riseup.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20220901124210.591994-1-mairacanal@riseup.net>
 <20220901124210.591994-2-mairacanal@riseup.net>
 <20220901125530.b56s4zisnkfuigvc@houat>
 <04aeba53-793c-3196-3137-915f0640dc2a@riseup.net>
Date:   Fri, 02 Sep 2022 11:04:14 +0300
Message-ID: <87h71qfbi9.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 01 Sep 2022, Ma=C3=ADra Canal <mairacanal@riseup.net> wrote:
> Hi Maxime,
>
> On 9/1/22 09:55, Maxime Ripard wrote:
>> Hi,
>>=20
>> On Thu, Sep 01, 2022 at 09:42:10AM -0300, Ma=C3=ADra Canal wrote:
>>> With the introduction of KUnit, IGT is no longer the only option to run
>>> the DRM unit tests, as the tests can be run through kunit-tool or on
>>> real hardware with CONFIG_KUNIT.
>>>
>>> Therefore, remove the "igt_" prefix from the tests and replace it with
>>> the "test_drm_" prefix, making the tests' names independent from the to=
ol
>>> used.
>>>
>>> Signed-off-by: Ma=C3=ADra Canal <mairacanal@riseup.net>
>>>
>>> ---
>>> v1 -> v2: https://lore.kernel.org/dri-devel/20220830211603.191734-1-mai=
racanal@riseup.net/
>>> - Change "drm_" prefix to "test_drm_", as "drm_" can be a bit confusing=
 (Jani Nikula).
>>=20
>> I appreciate it's a bit of a bikeshed but I disagree with this. The
>> majority of the kunit tests already out there start with the framework
>> name, including *all* the examples in the kunit doc. Plus, it's fairly
>> obvious that it's a test, kunit is only about running tests in the first
>> place.
>
> Would it be better to keep it as "drm_"?

That's not "keeping". That's renaming igt to drm.

> Currently, I don't think it is appropriate to hold the "igt_" prefix, as
> the tests are not IGT exclusive, but I don't have a strong opinion on
> using the "drm_" or the "test_drm" prefixes.

I repeat my stance that "drm_" alone is confusing. For the reason alone
that it pollutes the code tagging tools, mixing actual drm_ types and
functions with unit test functions.

BR,
Jani.



>
> Best Regards,
> - Ma=C3=ADra Canal
>
>>=20
>> Maxime
>>=20

--=20
Jani Nikula, Intel Open Source Graphics Center
