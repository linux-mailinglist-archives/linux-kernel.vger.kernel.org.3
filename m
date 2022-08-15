Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78768592EF6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 14:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231685AbiHOMft (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 08:35:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230418AbiHOMai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 08:30:38 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF68B62F7;
        Mon, 15 Aug 2022 05:30:36 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 73D3B320085B;
        Mon, 15 Aug 2022 08:30:33 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 15 Aug 2022 08:30:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        tom-fitzhenry.me.uk; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1660566632; x=1660653032; bh=ft/HTScHUvg3VioWNZbgX4bOjJi4Bt1Y13i
        HegmHnek=; b=q7dfuxVx2GUKeLzhtNlqnZpCQrJbLCLH80JqEgpsa3si5/YXEvX
        3CdBEnfyidryKjSH+t3Zr7OOxxykaq7dolOHbuF0W1ZUgoprsRZ8aTLt8IUo495c
        L+3sPsVRA4I9qXO5o7W0FrxmvcFilgs8oGl5FPHZMKtpI8Et6sPylK20sixqFhV1
        GN3F6ufi3toiZvri37zc6qlBramJNRQTS+VMgKv/PddkB25BGJjxGNi4nzab6k5C
        XFdWQjfT+okgA4qgLY4Jvr7i7Qm6Kr/auwzrbb4MxVxpVxAA83dZvrGJ2lp5z6pc
        NOdLUe9AjxQW7m5RRu6D9OOw+D1nDEghGCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1660566632; x=1660653032; bh=ft/HTScHUvg3V
        ioWNZbgX4bOjJi4Bt1Y13iHegmHnek=; b=swrrsxKembsBRw6KX/aqCZwfKEAz8
        MSpaCspalARwXAVWWnoxOVvj1kS1Kn9DDA+cxr3oZRm5Cf9US/BB/EvKdjhMZm8G
        jO6DYAg/mhXG3dHk488fmO5KaxN54LawLARXJ2DO7EIEn20djHTwNtP+pS6h6An8
        v8QsQf8RyYFeX0fpXNHxnvA+ZXMX8OSRQKGcYIPWeg+n9LN3CzMLDIYtMfUeiee9
        o+K1tDcha6/i2FdRaySHmnmmolZPs2UrSAGmTffnbdD8ASfAz0EDQ89ALwz5216R
        LU+33nplSKDBNC53DgIAlEMsBNV/UbcOoWVgRYeGvwfSKbNltiNli037w==
X-ME-Sender: <xms:aDz6YqCUmR5Su7flga6xmmxVsfPCFxAYim6LbJXny4GTbpl16SPIFA>
    <xme:aDz6YkgkYg6Wwd_2p3lWeRWJf9yMqOpW7zM2koY-3vlgylgofcghrvY39wXNk_Uyt
    qZcQ78GsmjZ5qQRxA>
X-ME-Received: <xmr:aDz6Ytl6IiZYrKZm-s3DU1xEgDCsldmHZlSt6ZLnKGba8F9EhBjV4lLJFCxzUtqiPI7C5SRSgSMJj6_HUFeG_iC30XYFGHTmoYk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehvddgheefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffogggtgfesthekre
    dtredtjeenucfhrhhomhepvfhomhcuhfhithiihhgvnhhrhicuoehtohhmsehtohhmqdhf
    ihhtiihhvghnrhihrdhmvgdruhhkqeenucggtffrrghtthgvrhhnpedtgfetudehleejie
    eiudevhefhgfefleevvdejhfduteduheduffelfeffueehieenucevlhhushhtvghrufhi
    iigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehtohhmsehtohhmqdhfihhtiihhvg
    hnrhihrdhmvgdruhhk
X-ME-Proxy: <xmx:aDz6Yoyw_OnE3t2Ggkh3sOQEZj1rDkJ7bDZv8vjwXzUUfDMAxdNAvg>
    <xmx:aDz6YvS3iAwDvDUzsXkbXd4YdR3MjXJQEW-T15tZgl3eUxlsK1N1SA>
    <xmx:aDz6YjYnUtldjeN2A4Y1rnKb75AUQ8dc4asMhYVncJj3AcMa3Gjmjw>
    <xmx:aDz6YrpEBNmhqWEonygYqW3w5rkujwEL80uaAGrrDCmJYo3WUunWsg>
Feedback-ID: iefc945ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Aug 2022 08:30:28 -0400 (EDT)
From:   Tom Fitzhenry <tom@tom-fitzhenry.me.uk>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        heiko@sntech.de
Cc:     martijn@brixit.nl, ayufan@ayufan.eu, megi@xff.cz,
        tom@tom-fitzhenry.me.uk, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, phone-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] Add support for the Pine64 PinePhone Pro phone
Date:   Mon, 15 Aug 2022 22:30:02 +1000
Message-Id: <20220815123004.252014-1-tom@tom-fitzhenry.me.uk>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PinePhone Pro is a RK3399 based phone produced by Pine64.

Add a basic DTS for it. This is a working base that will allow myself and
others to add more nodes.

Changes since v2:
* Used rk3399-opp.dtsi (+ disabled) rather than introducing rk3399-t-opp.dtsi
* Removed superfluous comments.
* Followed DT Generic Names Recommendation
* Set 'From:' of DTS patch to be Martijn, the primary contributor to the DT.

Changes since v1:
* Simplified the DT to a minimal base.
* Introduced the RK3399-T OPPs.

Martijn Braam (1):
  arm64: dts: rockchip: Add initial support for Pine64 PinePhone Pro

Tom Fitzhenry (1):
  dt-bindings: arm: rockchip: Add PinePhone Pro bindings

 .../devicetree/bindings/arm/rockchip.yaml     |   5 +
 arch/arm64/boot/dts/rockchip/Makefile         |   1 +
 .../dts/rockchip/rk3399-pinephone-pro.dts     | 394 ++++++++++++++++++
 3 files changed, 400 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts


base-commit: 2e1170c71ec0c0fb785ce76fca7c682e930af2b8
-- 
2.37.1

