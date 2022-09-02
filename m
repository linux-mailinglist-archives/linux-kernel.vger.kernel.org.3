Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEFB15AB16B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 15:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236173AbiIBNau (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 09:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236343AbiIBNaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 09:30:19 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 980B213FE37
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 06:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662124177; x=1693660177;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=Dmk810uUIC5pea3YjGIuO/qqCH1zu8nwNivf+g80rEo=;
  b=W3Nhijf0bcPDKYW4OrTUHTmo8rMbNJCLLK7b4Jgz740b23QCXBfPpX3D
   jfCYF0VqI6lQXTbt1VsAhDAM9RB8G70qNpqYgKkdXgczhlublEa2JULt1
   IJLBkpTjqxjiRwAecjj/SHCmwwlxDH0fe2L+eASSFNGh8L4ZZRkQdtVDC
   +dc4LSt4VByHKf96pj9zrHRP0H7R5Vqd0Zyfnj3w5ELUm0P36rt3O7Z9F
   MuFblM7zDEIb2DyAIUT3N8g4Rpfoj4f0nHLLW7DG3arGorVFRi9Q3MlDf
   9S+AcS//Qu6q/SIPXaGgzLpF10roG2aHAVCHzDC6F+NooOy5gtMz85vir
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10457"; a="282960735"
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; 
   d="scan'208";a="282960735"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2022 06:03:36 -0700
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; 
   d="scan'208";a="674347042"
Received: from svandene-mobl.ger.corp.intel.com (HELO localhost) ([10.252.55.245])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2022 06:03:31 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     =?utf-8?Q?Ma=C3=ADra?= Canal <mairacanal@riseup.net>,
        Isabella Basso <isabbasso@riseup.net>, magalilemes00@gmail.com,
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
In-Reply-To: <20220902123400.5ljgc7z6zw34d64m@houat>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20220901124210.591994-1-mairacanal@riseup.net>
 <20220901124210.591994-2-mairacanal@riseup.net>
 <20220901125530.b56s4zisnkfuigvc@houat>
 <04aeba53-793c-3196-3137-915f0640dc2a@riseup.net>
 <87h71qfbi9.fsf@intel.com> <20220902123400.5ljgc7z6zw34d64m@houat>
Date:   Fri, 02 Sep 2022 16:03:20 +0300
Message-ID: <87mtbidj3b.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 02 Sep 2022, Maxime Ripard <maxime@cerno.tech> wrote:
> On Fri, Sep 02, 2022 at 11:04:14AM +0300, Jani Nikula wrote:
>> On Thu, 01 Sep 2022, Ma=C3=ADra Canal <mairacanal@riseup.net> wrote:
>> > Hi Maxime,
>> >
>> > On 9/1/22 09:55, Maxime Ripard wrote:
>> >> Hi,
>> >>=20
>> >> On Thu, Sep 01, 2022 at 09:42:10AM -0300, Ma=C3=ADra Canal wrote:
>> >>> With the introduction of KUnit, IGT is no longer the only option to =
run
>> >>> the DRM unit tests, as the tests can be run through kunit-tool or on
>> >>> real hardware with CONFIG_KUNIT.
>> >>>
>> >>> Therefore, remove the "igt_" prefix from the tests and replace it wi=
th
>> >>> the "test_drm_" prefix, making the tests' names independent from the=
 tool
>> >>> used.
>> >>>
>> >>> Signed-off-by: Ma=C3=ADra Canal <mairacanal@riseup.net>
>> >>>
>> >>> ---
>> >>> v1 -> v2: https://lore.kernel.org/dri-devel/20220830211603.191734-1-=
mairacanal@riseup.net/
>> >>> - Change "drm_" prefix to "test_drm_", as "drm_" can be a bit confus=
ing (Jani Nikula).
>> >>=20
>> >> I appreciate it's a bit of a bikeshed but I disagree with this. The
>> >> majority of the kunit tests already out there start with the framework
>> >> name, including *all* the examples in the kunit doc. Plus, it's fairly
>> >> obvious that it's a test, kunit is only about running tests in the fi=
rst
>> >> place.
>> >
>> > Would it be better to keep it as "drm_"?
>>=20
>> That's not "keeping". That's renaming igt to drm.
>
> Well, there's like half the tests that are prefixed with drm, the other
> with igt, so it's both really
>
>> > Currently, I don't think it is appropriate to hold the "igt_" prefix, =
as
>> > the tests are not IGT exclusive, but I don't have a strong opinion on
>> > using the "drm_" or the "test_drm" prefixes.
>>=20
>> I repeat my stance that "drm_" alone is confusing.
>
> What are you confusing it with?
>
>> For the reason alone that it pollutes the code tagging tools, mixing
>> actual drm_ types and functions with unit test functions.
>
> I don't get it, I'm sorry. All these functions are static and not part
> of any API, so I can't see how it would pollute a code tagging tool. Or
> at least, not more than any driver does.
>
> And we're part of a larger project here, it's about consistency with the
> rest of the ecosystem.

Okay, so I'm just going to explain what I mean, but say "whatever" right
after and move on.

For example, drm_buddy_test.c includes drm_buddy.h so with the igt_ ->
drm_ rename none of the test functions may clash with the drm_buddy_
prefixed existing functions. Ditto for all tests similarly.

For example drm_buddy_alloc_range() as a name sounds like something that
allocs a range, not something that tests range allocation. On the other
hand, you have drm_buddy_alloc_blocks() which is actually a real
drm_buddy function, not a test. What would you call a test that tests
that? Here, we end up with names that are all prefixed drm_buddy and you
won't know what's the actual function and what's the test unless you
look it up.

I use code tagging that I can use for finding and completing
e.g. functions. Currently I have the following completions, for
igt_buddy_ and drm_buddy_, respectively:

Possible completions are:
igt_buddy_alloc_limit 	igt_buddy_alloc_optimistic 	igt_buddy_alloc_patholog=
ical
igt_buddy_alloc_pessimistic 	igt_buddy_alloc_range 	igt_buddy_alloc_smoke

Possible completions are:
drm_buddy_alloc_blocks 	drm_buddy_block 	drm_buddy_block_is_allocated 	drm_=
buddy_block_is_free
drm_buddy_block_is_split 	drm_buddy_block_offset 	drm_buddy_block_order 	dr=
m_buddy_block_print
drm_buddy_block_size 	drm_buddy_block_state 	drm_buddy_block_trim 	drm_budd=
y_fini
drm_buddy_free_block 	drm_buddy_free_list 	drm_buddy_init 	drm_buddy_init_t=
est
drm_buddy_module_exit 	drm_buddy_module_init 	drm_buddy_print

With the patch at hand, they'll all be lumped under drm_buddy_
completions, and some of them will be actual drm buddy functions and
some not.

I just find it a very odd convention to name the tests in a way that's
indistinguishable from the real things. Even *within* drm_buddy_test.c
where you read the test code. Because currently you do have calls to
igt_buddy_ prefixed functions from other igt_buddy_ prefixed functions,
along with the drm_buddy_ prefixed calls. I think it's just going to be
a mess.

/rant

Whatever. Moving on.


BR,
Jani.


--=20
Jani Nikula, Intel Open Source Graphics Center
