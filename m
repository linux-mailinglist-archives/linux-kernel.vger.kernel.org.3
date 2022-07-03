Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ABDA56451C
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 06:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbiGCEyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 00:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbiGCEyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 00:54:08 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1C36958F
        for <linux-kernel@vger.kernel.org>; Sat,  2 Jul 2022 21:54:07 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 396F932007F1
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 00:54:07 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Sun, 03 Jul 2022 00:54:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=anarazel.de; h=
        cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1656824046; x=1656910446; bh=hzP4xGj706
        9U91lXmyFeTas+P5ASG2vvjmDOZM1+8qQ=; b=ryqgiVF0w82qSzJrOrJ6KulNyz
        vlW8IUf3SXCDT/5ogfqsl3/3/w3A34wsRCydL5IebiGLIowCInHkNcLW0qbPEfDV
        hVWvwUCx33DSlzLK5TCnpv9QjwZlC1IdiJmncvactOF2VpmZ9NMoBq5KpLfECQho
        Yw1MdeMlhAP0H55hOKJSBXy1OPWGeeyO8JqWZHdb25tsUTZIP6l+sbXmLV4Ac8eg
        7pCOQOuVwlQUCNvKJ+mrYjUSzLfMGxcfACUIizs/nO8RqMurqCqxitC76yW54z1W
        lZrfVfNjuqbn+jDu5/LHkzp2xxZEWGXyh6VVJdxyBpbr2JUV8K++QYWTy5Kg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1656824046; x=1656910446; bh=hzP4xGj7069U91lXmyFeTas+P5AS
        G2vvjmDOZM1+8qQ=; b=iFu6TocyRTvjQ2tZD6HKLnxrpV6rZzf57U2ueI3UHWbj
        YR6IpRKnIwq4i/LmeBIcvU7PnFWkwnhiOu+fpMg6PGAa62ZbIICQP9e8vPQtml7c
        iww4NWKelIs/7PW1/7h3Tq2Qq/oy973iibh49E8VsWqB7sFS+lLx700jpl46w/sH
        qX9WybIalbZ4CLZbRR+vkadM/Qqi4JMRcadMw2xYQ7aEe5Z7m6hTPxQtz5sGOZAR
        od4myiFsXRpUI268MYigXj64Idp8ptMPFiX34FJMV2v5A6lybHTBVSYtc7W+Ae12
        a/1y8J3LqbsXGPBroGgMwZEMn85G22r778OMm84SnA==
X-ME-Sender: <xms:7iDBYoWWdJ7Up_cINO8SnjKsCAV5o79XKV1JWgURynAAazjbecLLeA>
    <xme:7iDBYsmwcZfWyAjbwpJOQ0Si4sRLV9yjtfzZLAl8vrAV2zwPswAL1HE5dN0Dqy3td
    ZjxsPWqrxBpjYV5Pw>
X-ME-Received: <xmr:7iDBYsYz6d7HLHAqRfIR8ZCED-EcjbHTbz7la8lCNQW9-z7cWE_17HdQVjbtXeuZ_GdZTiC2_fjomutl_ImKKF_Cq-fQfdOII22QH86gpYquz7evaQI2nHq0s3Nb>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudehiedgledtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesthdtre
    dttddtvdenucfhrhhomheptehnughrvghsucfhrhgvuhhnugcuoegrnhgurhgvshesrghn
    rghrrgiivghlrdguvgeqnecuggftrfgrthhtvghrnhepuedvleffteffveehiedvhedvud
    eiveekiefhledttdeiffeiieeuteeuheffteefnecuffhomhgrihhnpehsohhurhgtvgif
    rghrvgdrohhrghdpkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomheprghnughrvghssegrnhgrrhgriigvlhdruggv
X-ME-Proxy: <xmx:7iDBYnVbOiHQjLod_XpKt3h8EINK5VF-30gHEUa_AiqGgd511-k6Cg>
    <xmx:7iDBYinTI5YSoy_7NlBgXA7ZrytOyTAEs_urvEEszoP2uHlHWF5rJQ>
    <xmx:7iDBYsdaqtXzTEn2FuGJpXvrTsacMoO1Th29d2BqWuig0t9Y_VzUQQ>
    <xmx:7iDBYsTTRfbiFSqnF2iI6Xudq63FZV-uEs8MnIDIe5QwQZuGH6W2Jw>
Feedback-ID: id4a34324:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <linux-kernel@vger.kernel.org>; Sun, 3 Jul 2022 00:54:06 -0400 (EDT)
Date:   Sat, 2 Jul 2022 21:54:05 -0700
From:   Andres Freund <andres@anarazel.de>
To:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/3] tools: introduce dis-asm.h wrapper to hide
 version differences
Message-ID: <20220703045405.mg6twnmghciek4y6@awork3.anarazel.de>
References: <20220622231624.t63bkmkzphqvh3kx@alap3.anarazel.de>
 <20220703044814.892617-1-andres@anarazel.de>
 <20220703044814.892617-4-andres@anarazel.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220703044814.892617-4-andres@anarazel.de>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2022-07-02 21:48:13 -0700, Andres Freund wrote:
> binutils changed the signature of init_disassemble_info(), which now causes
> perf and bpftool to fail to compile (e.g. on debian unstable). Relevant
> binutils commit:
> https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=60a3da00bd5407f07
> 
> This just wraps init_disassemble_info(), to avoid spreading #ifdef
> DISASM_INIT_STYLED to a bunch of places. It likely is worth adding a
> wrapper for disassember(), to avoid the already existing #ifdef
> DISASM_FOUR_ARGS_SIGNATURE.
> 
> Link: http://lore.kernel.org/lkml/20220622181918.ykrs5rsnmx3og4sv@alap3.anarazel.de
> Signed-off-by: Andres Freund <andres@anarazel.de>

Argh, please disregard this version of 0002 - it's an older version that I
somehow managed to send unintentionally. I don't use git send-email often...

Greetings,

Andres Freund
