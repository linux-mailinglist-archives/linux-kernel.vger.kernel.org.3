Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6F64F778C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 09:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241804AbiDGHeD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 03:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234761AbiDGHeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 03:34:01 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1298541BF
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 00:32:02 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 149EB32009E5;
        Thu,  7 Apr 2022 03:32:00 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 07 Apr 2022 03:32:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=A2uzp1VB6qZPb9v+8
        i65Ac3fQAGNJ0BYUHWC15GyxfQ=; b=OUk4rI03fHtv6kIgxgfmeIX3tHzmfemxg
        KFBHtlRVYjKaCgH6ekKV0jrMbRkICFT0WPfLCsHaDk62uaR8xXs4TUOew/O3lVI7
        3RBy9IC/rMNEboLdPBzMTrQgppSrq22KmyoeUfKtnLWvlP1sWlKam2motp6imT5A
        RflsV5/zRNAt452+QimRdT2EXbtlRs226T/kjlspQgVOrsOv0faPdxg+25++LOyf
        8GYlIGALKnUxrFwAy8TR0qh2td26Q9Ii+PC9YYpt3TBeNE9ytyYx2DQvHd/W6FjN
        8tAX+mTKKQALdHelQw7cKwSeWXDyiInqajol1yq7HbyZkXMHaYgMw==
X-ME-Sender: <xms:bpNOYszjB3nKKKA0xMPFOHdihootxN1s9LBteo1H2-xOURBxeObI2g>
    <xme:bpNOYgRiC88WpcWZ5KPc2kKgtXaQ157ck0VCHxWuykXVUvdbEJ5k2PIGgYOqQxxK9
    9pZ2ojYcdttEuvPiZ4>
X-ME-Received: <xmr:bpNOYuWr-Cz9BxR2rbcTcP_wTadj_etgKPwfGmv_s6ZwjY4ZfJSkEC9pICbgrFlLLjnU4rPkaJWI07K-dZDI1-hfxlkjR1LvONE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudejjedguddvvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvufgjkfhfgggtsehttdertddttddvnecuhfhrohhmpefhihhnnhcu
    vfhhrghinhcuoehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgqeenucggtffrrg
    htthgvrhhnpeffudfhgeefvdeitedugfelueegheekkeefveffhfeiveetledvhfdtveff
    teeuudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hfthhhrghinheslhhinhhugidqmheikehkrdhorhhg
X-ME-Proxy: <xmx:bpNOYqhaUOIh_7ORD6SOs3eKYlST4yOp3aHFbcXlDdnU11FDZKJJaA>
    <xmx:bpNOYuBNzQzOHRum7i7F15freBvK3Nc1-ksfI81iTwXmcvztZSzNNg>
    <xmx:bpNOYrIEyHJVR_o3Mu-H61HRX5v6AcJ4_ixmNuNdtHIYrjUDInnP2A>
    <xmx:b5NOYq1X7lewgIgPuglWsbZfAXyTy1yACogGCfWDLM3658WyLIeAqg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Apr 2022 03:31:56 -0400 (EDT)
Date:   Thu, 7 Apr 2022 17:31:03 +1000 (AEST)
From:   Finn Thain <fthain@linux-m68k.org>
To:     Randy Dunlap <rdunlap@infradead.org>
cc:     linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] macintosh: fix via-pmu and via-cuda build errors
In-Reply-To: <20220407023700.7216-1-rdunlap@infradead.org>
Message-ID: <7ddb26a1-be89-813f-8dcc-4bebaf8f5636@linux-m68k.org>
References: <20220407023700.7216-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Apr 2022, Randy Dunlap wrote:

> When CONFIG_RTC_CLASS is not set, rtc_tm_to_time64() is not defined.
> 
> ...
> 
> m68k-linux-ld: drivers/macintosh/via-pmu.o: in function `pmu_set_rtc_time':
> drivers/macintosh/via-pmu.c:1758: undefined reference to `rtc_tm_to_time64'
> m68k-linux-ld: drivers/macintosh/via-cuda.o: in function `cuda_set_rtc_time':
> drivers/macintosh/via-cuda.c:797: undefined reference to `rtc_tm_to_time64'
> 
> ...
> This is a big hammer type of patch. We could possibly do (a) some
> conditional code blocks for RTC_CLASS 

rtc_tm_to_time64() call sites also appear in several other files without 
conditionals:

arch/powerpc/kernel/time.c
arch/powerpc/platforms/8xx/m8xx_setup.c
arch/powerpc/platforms/maple/time.c
arch/powerpc/platforms/powermac/time.c

Why not use mktime64() instead? That seems to be a common pattern for this 
kind of thing (without needing conditional code).
