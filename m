Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57CC54C0AA5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 04:42:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235530AbiBWDnI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 22:43:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237640AbiBWDmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 22:42:52 -0500
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com [66.111.4.224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 509413EF1F
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 19:42:18 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id A24D2580207;
        Tue, 22 Feb 2022 22:42:17 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 22 Feb 2022 22:42:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; bh=yh5oiXgQfk3oTq
        k3JJphdKYAq5z0QRmGrTaoXUwh8dY=; b=XFQyzDyQnbr8GPgWEC0QohCixgGBA5
        QyKJv7rhS5iKSD6xvnEeucOopxsu5wDZzjlbctjyuYemdoRU1e/cITDhx1NkMP3n
        AMM6nbqXHiwYSI8lU3p/qmoyZJYYm5TTo+wie9kO19O/cLBP+PdEEqfbca60myY8
        WmxALNTIM5CIG5NScDHBlaDiS5xwwpArioYnw9ZokBV55/GZgyooEh8Eq+5Wcac/
        bSDCTCzfLv7EXrJcEZe4N2pcFjFWQaBPOVFwBttHqZ2+3/zfkkIr4pIuk6nFlyej
        wIyEZtiIsNCvIgLvFpo1XOcswLamNLhygfk59TXk4za3Td9EkfNuRlyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=yh5oiXgQfk3oTqk3JJphdKYAq5z0QRmGrTaoXUwh8
        dY=; b=KWvruJy0TUDUb0FnKQ4Jckq/i6SoiMzTAYZTh3cQ/p/Tkks+fgLOx1wj1
        jdRYFNFV4yvSuHkAMe/A3f5RTM7ajobiU9LoSSwwYWQqdBh7y3122oKcB+kdl2f2
        Ccm6Jbv3QXC6w4UNl19iM1IEnJDTv15SQkjOX4BInjYZNnly9nCdlyMq9/IYmrxk
        CRspxCW256sMqLxPhPtR8AsHRKVvJVHtN564mDe2uzoN1vX7ZS425M5wBPA78ocY
        ZCb4AmJo7eYyiqdlXMmwj1znMmbAD4djeXRe9SNTnf5XEaNpeL5IzBuAO4L5sWjC
        8VQscogV525381bV3zzPE5H+Q2BsQ==
X-ME-Sender: <xms:Ga0VYo6C868iMQD9fhmuDoKehvdBJBU1xBdrlUJpEmIyKlsWSnHxrA>
    <xme:Ga0VYp5G2Hj3NeMI9UTMXLdmh69c7hVZhzoFODd8vq93eYxYO_KK3LQyGyyGfhFs3
    jXy3XXEC4g4Eap6yw>
X-ME-Received: <xmr:Ga0VYnddkNgN5pz0x_nEnWd0I7RJs4QvWIF5IrPtKlWj9SEub5tUV-AMWIO_di8z-vQfVXkKVE6Dn03b-yIKvSehLOZZvbAQbRB_QoghDNwp7L0iJbJOJ55OsQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrkeelgdeiudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefuvfhfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpefgveffteelheffjeeukedvkedviedtheevgeefkeehueeiieeuteeu
    gfettdeggeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:Ga0VYtIhCIp61ylZRk-QWE0-2mDUXPB_l6FgFT-7gUqsl_V3zoB3JQ>
    <xmx:Ga0VYsLWtJnoWg-6sDvf9IWi0woFhwIEIm3Qb0dVuJnerfs5G2NOMA>
    <xmx:Ga0VYuxYsKIc-Tae8bqSDsbTwiKZfzSFK7gpzWyyl1srsbgBsQaoLQ>
    <xmx:Ga0VYqx-_rgsNT2bGwqtKJZAKFfHwR72ga8KOxQUjOgfpeHNwvNeGg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Feb 2022 22:42:16 -0500 (EST)
Subject: Re: [PATCH v10 12/18] phy: sun4i-usb: Rework HCI PHY (aka.
 "pmu_unk1") handling
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Ondrej Jirman <megous@megous.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, linux-phy@lists.infradead.org
References: <20220211122643.1343315-1-andre.przywara@arm.com>
 <20220211122643.1343315-13-andre.przywara@arm.com>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <40b6855b-7fac-e9bf-af9b-885d54530054@sholland.org>
Date:   Tue, 22 Feb 2022 21:42:15 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20220211122643.1343315-13-andre.przywara@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/11/22 6:26 AM, Andre Przywara wrote:
> As Icenowy pointed out, newer manuals (starting with H6) actually
> document the register block at offset 0x800 as "HCI controller and PHY
> interface", also describe the bits in our "PMU_UNK1" register.
> Let's put proper names to those "unknown" variables and symbols.
> 
> While we are at it, generalise the existing code by allowing a bitmap
> of bits to clear and set, to cover newer SoCs: The A100 and H616 use a
> different bit for the SIDDQ control.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Acked-by: Samuel Holland <samuel@sholland.org>
Tested-by: Samuel Holland <samuel@sholland.org>

Tested on D1, which also requires this patch.
