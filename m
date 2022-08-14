Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29E485925CE
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 19:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232140AbiHNRhJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 13:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiHNRhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 13:37:03 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1298115707;
        Sun, 14 Aug 2022 10:37:03 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 0C59632002E2;
        Sun, 14 Aug 2022 13:36:58 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Sun, 14 Aug 2022 13:37:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm2; t=1660498618; x=1660585018; bh=pgAKczYI46YK504LsfplQlggz
        lIabQBRUDRiVOHFmsI=; b=TqzkUy03yMVcmYimv55HdNk09kcuLbITIrek08fPk
        fo8WoIWQ3guv9zR4Jrk+bj2I6E3aFeOyi+0GSk+sQHdnMmcoYJ15KY2vkx8PZz8A
        9p2b+T0JSkEd32ra61G6wUw3P9vB+kGEhfM8JN1sVsPrip1Zq8yG9TFlR+ZBOe8r
        eRojOeXmTMpP5VqgrNgK/5TQ374W+mC9khTBzXcBygd3ygRvKg2QqI3tdV95HN+6
        zQYVpfTXpwkQojfJGtXSrnibmJ97rHN3OLkudtf5sxcy2/QlA8Ij8pfbKGCsSYMC
        G+BoAwOlZLUCUhPeF4xUAwkZQ9tjVYC1aT631gtB4qXyg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1660498618; x=1660585018; bh=pgAKczYI46YK504LsfplQlggzlIabQBRUDR
        iVOHFmsI=; b=UL0HRS3xHtAlV+xIQYl2wF/td14Yev2o/qb6s5cTEe8vjErkOFW
        0/0oEtTRiDlILgOVmr4BsFK0k1oGygp2bJ8L0BZ7RUruReMPSArhIsPKW+bLsw0A
        WQW1mczyCUnm9Wro1b0n6gzsqfQH/miliaGD5jxrP7RZJXbBAVgyJT0kQMxuS9IU
        oTU8q8gg74mGFUByEOxoDvN9REcbynDo8ffteKtKOZ8VNFyjWoFWnDcoWLABarH8
        aP5a9B2GH6CExY/AGma+lPWC4kZY0k5lj0OmQdpOHzzqnp8q8tXGIBZuDukZ0Kzi
        uu40ogA5wL2PZdXR7wNG/vNQS0sS8fAnSmw==
X-ME-Sender: <xms:uTL5YhUU1zQKXj6X3-EOwbPdosxjoHfvlpk8KiopaIPk5ilSxXVG2g>
    <xme:uTL5YhmH8LysTDaUJ-rprbu5K21qQm3Y3iv1WUkdlFEMZPtTqfypxSz0KUjI8jEgT
    ZHtFxgKqfH81Bu3AQ>
X-ME-Received: <xmr:uTL5YtZTNrxtVbRS7KkCNC5n5sAH3Y3XKuioIMs7dRy8Ppx00q8Fj5kHHOmJzdUuefdTE7J5BgFGuYa_-04EftPmVrYV0BtzhkmSXpqaB2ASloYWwMO5kN49Wy62Pc39m01m0w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehtddgudduiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeekveelhfejueelleetvdejvdeffeetgeelheeujeffhefgffefkeeh
    hffhkeekgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:uTL5YkVinxS2pXYOtL7D93H33vO_1j4krwXTPF_G75DXa8LDwfLFmQ>
    <xmx:uTL5YrmZBqS4G6lg1ZD9r9ZdeMvnm-wsFkd_qO1bGZd8VeNjyRtC2w>
    <xmx:uTL5YhdGXmoaW4pXllyD8li2VhY586tdBqrmwkZncSh3q0sYBzqxFw>
    <xmx:ujL5Ykielf9y9LbguWXM3lepKxfD-xd0ROz9pHiC13mvPY0m3U2nnQ>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 14 Aug 2022 13:36:56 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     Samuel Holland <samuel@sholland.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
Subject: [PATCH 0/4] nvmem: Support non-stride-aligned NVMEM cell data
Date:   Sun, 14 Aug 2022 12:36:51 -0500
Message-Id: <20220814173656.11856-1-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
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

The first half of this series fixes a bug in the sunxi SID driver,
emphasizing that it really does have a hardware-level stride of 4 bytes.

The remainder of the series tries to answer the question:

    How can I use nvmem_cell_read_u8() to read byte 0x2a of a NVMEM
    device that has .stride == 4?

The NVMEM cell may be at a different offset in future SoCs, so I think
it would be wrong to use nvmem_cell_read_u32() and extract the single
relevant byte in the consumer driver.

I can think of three solutions:
 1) Change the NVMEM provider driver to use .stride == 1, and fix the
    alignment inside that driver. Some other NVMEM implementations have
    taken this path. This is not ideal because it requires allocating
    an extra bounce buffer inside the driver.
 2) Extend nvmem_shift_read_buffer_in_place() to handle larger bit
    offsets. Specify a stride-aligned "reg" in the devicetree, and use
    "bits" to provide the sub-stride offset. This adds a minimal amount
    of new code, and is generic across all drivers.
 3) Do the same as #2, but also remove the alignment checks from
    nvmem_cell_info_to_nvmem_cell_entry_nodup() and have it convert
    non-stride-aligned "reg" properties to the equivalent bit_offset
    and nbits fields (and use that from nvmem_add_cells_from_of()).

Since option #3 has larger impacts on the NVMEM core, and is backward-
compatible with option #2, I have implemented option #2 in this series.


Samuel Holland (4):
  nvmem: sunxi_sid: Always use 32-bit MMIO reads
  nvmem: sunxi_sid: Drop the workaround on A64
  dt-bindings: nvmem: Allow bit offsets greater than a byte
  nvmem: core: Support reading cells with >= 8 bit offsets

 .../devicetree/bindings/nvmem/nvmem.yaml      |  2 +-
 drivers/nvmem/core.c                          | 43 +++++++++++--------
 drivers/nvmem/sunxi_sid.c                     | 23 ++++++----
 3 files changed, 40 insertions(+), 28 deletions(-)

-- 
2.35.1

