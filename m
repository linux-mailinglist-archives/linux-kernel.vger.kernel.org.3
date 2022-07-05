Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB6A756609E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 03:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233846AbiGEBSH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 21:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbiGEBSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 21:18:06 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 528A8EE26;
        Mon,  4 Jul 2022 18:18:05 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id B37BB5C0094;
        Mon,  4 Jul 2022 21:18:04 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 04 Jul 2022 21:18:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1656983884; x=
        1657070284; bh=Sk9QQFJcxfXSeJ2XPtaUQUAAr87102miVxmg3rA5Sgo=; b=s
        MTSaO2pL0fZM3HhE22QWq/o7TRtdnx8XE39c1cLFwXn2h4CqNKiW9M8W2b0EqsL1
        5caR46cwhnW3NEbmtl9D0TSgIETnmZqBCiBDtifOzTmN+0y7KPOB3NeE90o++EJ4
        Q7a20OuU47YWrhK9Ev/FwF9hkAx3Tz5ouV5Ze5I3HclDGrlLF6UA+5zLmi6o+SZG
        aoonbDF9BZ64ewZatfkWS45WMdHg8JtccxDdDrgTPSDhUrhykpic27JepBPwLx7L
        teosFHUusbqjXpmxDLJVIeDXdu6pZPdmzwnBEmXDWZTdn5CYsg1F/ElRJdBXIuAG
        2EXfrGlu/AtcwMf3f9uWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1656983884; x=
        1657070284; bh=Sk9QQFJcxfXSeJ2XPtaUQUAAr87102miVxmg3rA5Sgo=; b=t
        JJy4HHY+mASug7G4/lh63tzi/FT7K9cjnh4VAkSPPzYUwZS916TiqUbON/BIt8tP
        jH1969hoAJfSbtXDlleY9o65TtpFylzNRnapNGkmYBrOFyf/rpFsijZGv566r1BL
        tygfsvlUaCsyHRdCq5JqjsC6Li33DXIt7qaDPo7BSo8/pQYsjwwWJtdN0JmRS+ZP
        JA8bzAG6QTS2E4ArBVBlf6JQrCwwkKAD8QTYOuRgy6SuErKb7EAvho5fbTY88mIJ
        j5qfVdkFS5pH5/kPF9EMkiqziANgwCW8q9o/3GxvctQGmkR/0Fnpi6kAdz1ocIiG
        z6+3z6XJV9IHAbp/VakSA==
X-ME-Sender: <xms:TJHDYh7E-hR__bRilTSpOwW_71VnmKy6VTsAikD6tbd_3T7sitVCyA>
    <xme:TJHDYu6QllKVcqErN3zrXRtE8gzieTi8evKOZ9JB3Q71IXq7TcJl4LByItzxLU-9g
    7kIhQ5zJlwQmXOihA>
X-ME-Received: <xmr:TJHDYofhGWfC3LJ8OAcdJ7O4FnISzjaDHLl9KvYYOlITwIME4VsoWW87qdRsSASoYLY8Ktu2yhxJzIcqIeE6Rpxym6UbrDAmijKrE7CRh3pXzWGs__UEMAFzeA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudeitddggedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepuffvvehfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    ggtffrrghtthgvrhhnpefftdevkedvgeekueeutefgteffieelvedukeeuhfehledvhfei
    tdehudfhudehhfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:TJHDYqK8-2VZRfz9WKEZSTDbpuLldfKUHPNc0yYsB7Lm4IJKDYXCAA>
    <xmx:TJHDYlKhRDVXrAJloptFSarBZ6eUe0HyKj5ck4UsjdmHqLv3W3DShA>
    <xmx:TJHDYjz4pqvFBFyAlTyD3s99iQmt0k5MgeEGjPsw28DhddwMRuLmAA>
    <xmx:TJHDYuVJ4TJ8O130AX7PeCHPMFwP4L9PrfZeEdhssVoyAvjPxZs6TQ>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Jul 2022 21:18:03 -0400 (EDT)
Subject: Re: [PATCH v12 4/7] dt-bindings: pinctrl: sunxi: allow vcc-pi-supply
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org
References: <20220701112453.2310722-1-andre.przywara@arm.com>
 <20220701112453.2310722-5-andre.przywara@arm.com>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <3c172483-66bd-bb2e-9f52-68208b4c2bfb@sholland.org>
Date:   Mon, 4 Jul 2022 20:18:03 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20220701112453.2310722-5-andre.przywara@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/1/22 6:24 AM, Andre Przywara wrote:
> The Allwinner H616 SoC contains a VCC_PI pin, which supplies the voltage
> for GPIO port I.
> Extend the range of supply port names to include vcc-pi-supply to cover
> that.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Acked-by: Samuel Holland <samuel@sholland.org>
