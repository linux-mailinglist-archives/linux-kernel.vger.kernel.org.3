Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F0435A9776
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 14:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233286AbiIAMzm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 08:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233048AbiIAMzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 08:55:38 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 670D452FFA
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 05:55:37 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id CDCA35C00E5;
        Thu,  1 Sep 2022 08:55:34 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 01 Sep 2022 08:55:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1662036934; x=
        1662123334; bh=yCxLNBFGSZRqkuML/VFgGHBhSSM6CHEUn/5kwqQufZ0=; b=J
        x4GRMiXMqZhv/vKd2o8BiWANJJLYz3WKd5QGf4csZpCG9cZO16EX1zqY87aHLdI2
        FFGE/vkG771KuFIJmItNzvjB6KN4JcJwLZYdKQe6/1wyFUsJsVhI1+lBT9IQVqCi
        qwVOn30fzyVWlD/u3m7HLpJl7YbnAXm5nx37Yi6Z39+9OQFelcnu6kQnY5s6Caqy
        rq97aMut+ZGgdtQptWC1oTKnreJAJ5BxaWXCSh2kmBkCTnyuhPwrbDjq2EwBUVrP
        hL5BHjM5wlUV77BPr3ZIv8OftM6K7XMJyXNBrFPZUZcRGsBbFdT+37M8KqgXQABT
        3onWHgyg5ws4IwKP2dNOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1662036934; x=
        1662123334; bh=yCxLNBFGSZRqkuML/VFgGHBhSSM6CHEUn/5kwqQufZ0=; b=m
        /zcrSii3w5zxhxGrHJs9ZSB5nW8pWOEtE0Gyg3Ti9KJry8F4gm/df2KiCq8RbNST
        qR8hxXMt6wZEe3FnyMDTzCvUUIi2f6sQGkGxi0FeG4RBfMAY4sgNlxX66RHMDYJV
        9LHORQls0jTD/Hy3MPAez+cXmI6f0b4nwdVu8mHAkEtWFAR69VHBgSSovv1E4+sb
        qftjpbx0ap7hYGhadVT6yKVkFBcIFeeMpQnaFR9DTBnhqKGNQpDK2v77rWlUXQ84
        ixh0tu2LcohohcJtopU9gj9zGSKl8wg47yVTPEbhAWKzVXGrBhgnsGxJiobjTl5Q
        OErJq1f9vEDSIiW+VUUzA==
X-ME-Sender: <xms:xasQY56YKaVeQSZb4R9QR7a1cqFXpQAuuqlugbf8jVOXfpl9o_M6rQ>
    <xme:xasQY24Lcq9nN73OiJzu4j6KeHeRGoiYQjfRe9a68APWF1oGOTG84cGXv5O3es0SV
    L1BD9WCug32RAwhAsg>
X-ME-Received: <xmr:xasQYwcKnA7o2XqO61TEsWxwoGV0hgujtKrbwTiQA1PkYqwYFiiA7n-poQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdekkedgiedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtqhertddttddunecuhfhrohhmpeforgig
    ihhmvgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrf
    grthhtvghrnhepjeevffdtheevvdefveffffejkedtgfekvdeigfefhfefgfethfejjeei
    geeiueegnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgv
    tghh
X-ME-Proxy: <xmx:xasQYyL7yf5VlA9wkzwyiarB6LMEGN-PKYap4Hy0tfsofCw9O2ORVg>
    <xmx:xasQY9I9PC-ai-noPPo2elUUeitGBgYFhANVpQqttGWMd_l1Xn80SQ>
    <xmx:xasQY7yar9bCbiW5nVT4qpBruzAi6scphs7r5-CB_NuB1Kbh04omoQ>
    <xmx:xqsQYyBOc9Bij0OydqDC35tEBX0XpqmYBwkRczuGiv0SkoQdkcdBWA>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Sep 2022 08:55:32 -0400 (EDT)
Date:   Thu, 1 Sep 2022 14:55:30 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     =?utf-8?B?TWHDrXJh?= Canal <mairacanal@riseup.net>
Cc:     Isabella Basso <isabbasso@riseup.net>, magalilemes00@gmail.com,
        tales.aparecida@gmail.com, mwen@igalia.com, andrealmeid@riseup.net,
        siqueirajordao@riseup.net, Trevor Woerner <twoerner@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Javier Martinez Canillas <javierm@redhat.com>,
        David Gow <davidgow@google.com>, brendanhiggins@google.com,
        Arthur Grillo <arthur.grillo@usp.br>,
        michal.winiarski@intel.com,
        =?utf-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        kunit-dev@googlegroups.com
Subject: Re: [PATCH v2 2/2] drm/tests: Change "igt_" prefix to "test_drm_"
Message-ID: <20220901125530.b56s4zisnkfuigvc@houat>
References: <20220901124210.591994-1-mairacanal@riseup.net>
 <20220901124210.591994-2-mairacanal@riseup.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220901124210.591994-2-mairacanal@riseup.net>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Sep 01, 2022 at 09:42:10AM -0300, Ma=EDra Canal wrote:
> With the introduction of KUnit, IGT is no longer the only option to run
> the DRM unit tests, as the tests can be run through kunit-tool or on
> real hardware with CONFIG_KUNIT.
>=20
> Therefore, remove the "igt_" prefix from the tests and replace it with
> the "test_drm_" prefix, making the tests' names independent from the tool
> used.
>=20
> Signed-off-by: Ma=EDra Canal <mairacanal@riseup.net>
>
> ---
> v1 -> v2: https://lore.kernel.org/dri-devel/20220830211603.191734-1-maira=
canal@riseup.net/
> - Change "drm_" prefix to "test_drm_", as "drm_" can be a bit confusing (=
Jani Nikula).

I appreciate it's a bit of a bikeshed but I disagree with this. The
majority of the kunit tests already out there start with the framework
name, including *all* the examples in the kunit doc. Plus, it's fairly
obvious that it's a test, kunit is only about running tests in the first
place.

Maxime
