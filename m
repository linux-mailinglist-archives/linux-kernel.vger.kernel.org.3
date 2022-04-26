Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A32B450FD67
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 14:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350107AbiDZMpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 08:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350127AbiDZMpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 08:45:09 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD7B1177D7B;
        Tue, 26 Apr 2022 05:42:02 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 4A1575C0181;
        Tue, 26 Apr 2022 08:42:02 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 26 Apr 2022 08:42:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1650976922; x=
        1651063322; bh=5TNW38hCxzg7WdlOn392YteiUTV/VdH0KTzWM27AcVY=; b=g
        t08gYX90pYbZNX6tjcFV7cgHjXpzedU1rLS4HxGGlhWFsegpEIROPyawCu+SnKLy
        zV84QyVutHBcwxWiJUL76lnNyGlqJFCuj8floaQPBr8/8SmrFyzZSWJ+PhzsnSKo
        gpuUz5w1CZjkLxXFV8u1cbSd5B14KsAN2QlWgf4mzOUm9Q1GoD1MrBMyTpbO7kYz
        FY3yUqqDeIYQCIRwa4Qcw2/F4M8j7XirB91D65p+xFQRB8yGa4CnNIfiMwXYqDOr
        Fy2/ESkq3emcBXlcS5STsWn0/i5FgcYFQGwcolqPZCqEITZwYdn0I0d7ay0qcMS/
        Ov6fZqM9gZWAryNxMnpqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1650976922; x=1651063322; bh=5TNW38hCxzg7W
        dlOn392YteiUTV/VdH0KTzWM27AcVY=; b=GNh+w+lCSix8oM9nkRW65iHOBYK2M
        EllR4hRgKIkY7L1yOm5fNVfAeDOnpG2hTkg07IgTsj45quE3eqrlwekKaMdH12fQ
        z8KEgBPJNEZCxlsMnRnRuLWrP7elis6XfwPrb6ntBJbdeMs/LqYl8izxjDObCNR5
        HVRVUy7Y6tQw2usjCga8SVQuJNlLq/BWnKX5Xw2Am4HXTLMpAss3BKVlvm3/txNm
        5MJ/4ITbACjXwNPvRBY9oZPuYrF10JnvJ9+FXCYaDDIaakmQexKXCAr6If8ZbJBv
        LS/zb7SyfhoBj9UFo3wlBDK3jxdwCe3gyQNR1x8xZSm6Nz0JslVaTkyBQ==
X-ME-Sender: <xms:muhnYgI5Xef0aAl5SxJyKIdtzxUggtlhJvOf8nKB6Pbk09msoIhZkA>
    <xme:muhnYgIut9Vw6k0sEcuJW5UmNje3fu1pY-WKK3XmUv3hI-i3K4vXNhP7lSUhgiTbs
    a7sbFsuPEH236seyMY>
X-ME-Received: <xmr:muhnYgu7jK9gTyvGQDQYhv6DCzMaeuBdB0alOtkRsHjdNHUY5h4rkBH0h4uxjruL6hnLLOnL2Bd2p6vBiw7KCKUw8632JPTr7NTpjzc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudefgdehvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpeeuieeggffhffffieefheduieeuvdetgeeufeffvefgtedvffehheekffev
    udefieenucevlhhushhtvghrufhiiigvpeefnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:muhnYtbx_msdtKCwJnZmX9gPWNnB8yIr87ayKOpFla7JQgTm7Dm6Ig>
    <xmx:muhnYnYAX8rLUirTRgpWkOjMlDZuVlsyo-mxywbU_DzRWXHmrSjC-Q>
    <xmx:muhnYpDSi8Zyqdw3gPILEls_zBH1c7N0sO0RYxIkbEA6qnnVFxEdUA>
    <xmx:muhnYrR6z-uJQj7_FsXh6emIMZeTiArjuoY3tllUpMVTMBvnwG4QPQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Apr 2022 08:42:01 -0400 (EDT)
From:   Maxime Ripard <maxime@cerno.tech>
To:     Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <mripard@kernel.org>,
        Samuel Holland <samuel@sholland.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     Maxime Ripard <maxime@cerno.tech>, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-sunxi@lists.linux.dev, Daniel Vetter <daniel@ffwll.ch>,
        devicetree@vger.kernel.org
Subject: Re: (subset) [PATCH v3 10/14] drm/sun4i: csc: Add support for the new MMIO layout
Date:   Tue, 26 Apr 2022 14:41:39 +0200
Message-Id: <165097689886.514433.4736876690350493557.b4-ty@cerno.tech>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220424162633.12369-11-samuel@sholland.org>
References: <20220424162633.12369-1-samuel@sholland.org> <20220424162633.12369-11-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Apr 2022 11:26:28 -0500, Samuel Holland wrote:
> D1 changes the MMIO offsets for the CSC blocks in the first mixer. The
> mixers' ccsc property is used as an index into the ccsc_base array. Use
> an enumeration to describe this index, and add the new set of offsets.
> 
> 

Applied to drm/drm-misc (drm-misc-next).

Thanks!
Maxime
