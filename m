Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4152F50FD4F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 14:41:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350074AbiDZMo5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 08:44:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350072AbiDZMoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 08:44:54 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC49F178587;
        Tue, 26 Apr 2022 05:41:47 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 25CC35C0180;
        Tue, 26 Apr 2022 08:41:47 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 26 Apr 2022 08:41:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1650976907; x=
        1651063307; bh=q/w98oBVrmeEdvbsmXzVbdkehd1o5c9xHI8LrfGqFDg=; b=K
        /Llh8Vptf43/f4mPDCzvtCcliR/1YwObVTrwWHZ4qum7E+0wP/1w+H6Yuvb4nYA3
        IWiKPAYRTTScWuwpLJP1AmJLHoAEeFCBRyE7WBWfne3FzFeB+PLk9fcsSDoPKffS
        bHbLIpqlp3gR4d62dbNUbYHAI3ddN3/RDwAgMCGY7053OoI1aKbR5YXTwxAcS+v9
        Y9OceKAUPmJ4Jd4W2Ja3GCl+z8L5JMi0ahDlgfaRT9ZjVKa1IkNvMQGefbVtHVBw
        kA2WINOmPdzflpQU5ZltsoKwJ/vyzSw0YPqDwkU+JX6uioElibvqhrBNQwZaIxfp
        lRYjcnLpFtx+C1hsdQylA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1650976907; x=1651063307; bh=q/w98oBVrmeEd
        vbsmXzVbdkehd1o5c9xHI8LrfGqFDg=; b=hxwcEmMd0PRJxBLpMbxG4eF7yQ+IT
        t3Sk2KwRy73jJHRC8LzZnRnk1tnE3XYSrdKbInjN4bc2NvcZk1eQ3/3wuxnT2nSU
        BrZBE29wEj7w6edqCTagCCoTrFAePF2ssuwPhUbU1TsKFCcSw1252LFuXTqPqATR
        YrnINA/21Px7PU9PUaoYCjssAznHOeDPsLe5YrxzqAfWChAJfdy0SnO2FrFP+xr8
        YWWkKPOrYNNAlIg63S3C7/asGjALsxYAFdIc5Vb3MVzxgGkGPcw7dhi/im0g7tGn
        qgq6RP7/GwAHM5Mk0tFiaNrd9HbRU7z4mCDnE+2dwgfazyro6ysn0obWQ==
X-ME-Sender: <xms:iuhnYhKd0RAENZYFtnjO530cedU92-RbsPve7ZM36em8YIEmiwBdXQ>
    <xme:iuhnYtIo7CyUfnVIW4sYwRlADB63CqGpo33myQrzOekKNfnNXGbfIg3zTbQSdqIeG
    ONPn02MrDZfs2JjTf4>
X-ME-Received: <xmr:iuhnYptlMgIuCR3t4ihrwMGWPyb9WfYRMFobSHDiQvgipDqpYVmoor3bj_jL51FVh0K4jilH0usEYLde61arFBQUUeqVr4I8EOy_MGg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudefgdehvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpeeuieeggffhffffieefheduieeuvdetgeeufeffvefgtedvffehheekffev
    udefieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:iuhnYibxhZAdgi8qaGyInAOd_xdBsqlSaqPGv8KyPMFDP6K1PqMJ2g>
    <xmx:iuhnYoaV-17DxZmyANyTN34vel3kq8N_FjJ-WO5z9U5-DaNc2sBYVw>
    <xmx:iuhnYmCq4wUZqcEqFqPEchg-cA6Tvs0p4XzZsB1-tl65wPJjNZi2AQ>
    <xmx:i-hnYorKTUSOQLpbNg7_l9L8wiHM_XoCjvalmWraI1ZhdluBR72opw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Apr 2022 08:41:46 -0400 (EDT)
From:   Maxime Ripard <maxime@cerno.tech>
To:     Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <mripard@kernel.org>,
        Samuel Holland <samuel@sholland.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     Maxime Ripard <maxime@cerno.tech>, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-sunxi@lists.linux.dev, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>
Subject: Re: (subset) [PATCH v3 01/14] dt-bindings: display: Separate clock item lists by compatible
Date:   Tue, 26 Apr 2022 14:41:31 +0200
Message-Id: <165097689885.514433.2090850997592209113.b4-ty@cerno.tech>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220424162633.12369-2-samuel@sholland.org>
References: <20220424162633.12369-1-samuel@sholland.org> <20220424162633.12369-2-samuel@sholland.org>
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

On Sun, 24 Apr 2022 11:26:19 -0500, Samuel Holland wrote:
> So far, the binding and driver have relied on the fact that the H6
> clocks are both a prefix and a subset of the R40 clocks. This allows
> them to share the clocks/clock-names items and the clock-output-names
> order between the hardware variants.
> 
> However, the D1 hardware has TCON TV0 and DSI, but no TCON TV1. This
> cannot be supported by the existing scheme because it puts a gap in the
> middle of the item lists. To prepare for adding D1 support, use separate
> lists for variants with different combinations of clocks.
> 
> [...]

Applied to drm/drm-misc (drm-misc-next).

Thanks!
Maxime
