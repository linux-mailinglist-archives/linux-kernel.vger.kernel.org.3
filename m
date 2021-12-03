Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B717A466E82
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 01:36:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347444AbhLCAkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 19:40:08 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:44999 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230131AbhLCAkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 19:40:07 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 02F325C036D;
        Thu,  2 Dec 2021 19:36:44 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 02 Dec 2021 19:36:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm3; bh=B4da2RGPelwb1LfpGhsH0OJ0zP
        r8I/XLsfnmONYz1ik=; b=xZ5Y8ddk/Nt0+dK4i9rBUBmZnXHqF4RLJoIn51Cog0
        rnkX0xsjs4t1Di1AGXLUG7RjgESLqFJOd9O9RGp/4yhXFhiKF1JEfNvHjsmUqgB8
        Y7Yl7BQvQ8xXRtEFZim7R0O6QEmVz5hMGmVxO9QH25K77WVIUBhuLlx/tfzS8LIj
        rURMAPZ5vWzYfmqS+d0cBQv+oEYUDS1lAmXX8bEbovWrulnVnlV3m68TCTybJGo3
        F7C8ADvaQiDiR6gZogwnfnzcOwHyGmwHeVpehXkJkgfQFsYzotxgWEgm7vI4Hyx8
        M9WvLdYQVwN4Ci1zDPcXKExw46AXkM2aU4qEdD+A3FyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=B4da2RGPelwb1LfpG
        hsH0OJ0zPr8I/XLsfnmONYz1ik=; b=b3BKRM2wMWfk3h++DeItcfVrzlIbscKou
        NDV3VdoR5uIthheo771ssG2xKiPwQCKzoXOFteXZlmjkgaW20q8A7InteFq0cH31
        OPq9WnNP/iIEAUaxdWpcR65lEKb8d3ZIV6SrAYMSaVnjBuriFD2nSKG12pg4BNeY
        Z/UvqE70ZXq8ps0Tnjhhfmx+Luwr6qxaYC26eIWIiEN5kzPpRep0Qu9sOBvFnGCq
        47YAM1w98Wb/UaQfLANTEKj0wo4YbjJjJ7I2ZaA/MVo8/9IIuDG6kO5yXASkQqDp
        yabkCvBugT6z3OxA4E+aisae6rhnLlZPVAArLLpVSbO9Lu6kpKxDg==
X-ME-Sender: <xms:m2apYX81YXughWdTCscw8MZN3aGcmvPfQqiW9JYTWvzxOKqObD5DLw>
    <xme:m2apYTv9fZndWKaiBij16py5mOhVv-0vE4T0H1rpZgfxObKmrb-hWUdcNgiYykjJr
    nyG8No2z4czm5KRvT0>
X-ME-Received: <xmr:m2apYVAs7B9DXcgo0Bgz6SjmmjmN3VWy2EAgV4Kr43OE3nrHZmtlxwg07hllwN7oXw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrieeigddvgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertdertd
    dtnecuhfhrohhmpeflihgrgihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhl
    hihgohgrthdrtghomheqnecuggftrfgrthhtvghrnhephfejtdektdeuhedtieefteekve
    ffteejteefgeekveegffetvddugfeliefhtddunecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrth
    drtghomh
X-ME-Proxy: <xmx:m2apYTcqAkZjvOpvvAktQjx2nNhiO4ptVq61D9qUtt0er58zDJZ3Ug>
    <xmx:m2apYcMn0Zm53iknKS7WUtw6GLieYVEVR1ZhI658OnRQSCA-sIln5w>
    <xmx:m2apYVm8caqagjWej-0-lBZhMWTacFVJrclrdYAqoyrmzT-X8fAQcg>
    <xmx:m2apYTdMHcbfyaeyD3NY93EQNpiN5eOX7Ja940b9wpRKUwW6juLV8A>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Dec 2021 19:36:42 -0500 (EST)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     x86@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        chang.seok.bae@intel.com, linux-kernel@vger.kernel.org,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [RFC PATCH 00/10] x86: Allocate AVX512 xstate ondemand
Date:   Fri,  3 Dec 2021 00:36:26 +0000
Message-Id: <20211203003636.11417-1-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series makes allocation of AVX512 xstate buffer ondemand.
It can save some memory (~2k for a thread not using AVX512).

Also we are going to have heterogeneous processors that
only some cores support AVX512, it can be helpful when
dealing with such processors.

Patch 1~6 are some preparations.
Patch 7 moves reallocation of xstate buffer to save_fpregs_to_fpstate.
Patch 8~10 are some cleanup and enablement work.

Tested on a Skylake-X system with AVX512 intensive y-cruncher and numpy,
the performance impact seems neglectable.

Any sugguestions are welcomed.

Cheers!
---
Jiaxun Yang
Year 1 ECS Undergraduate
University of Edinburgh

Jiaxun Yang (10):
  x86/fpu: Remove duplicated declaration of __fpu_state_size_dynamic
  x86/fpu: Split fpu_xfd_enabled from fpu_state_size_dynamic
  x86/fpu: Calculate xsave state addr on fly
  x86/fpu: Remove xstate_comp_offsets cache
  x86/fpu: Cache xstate_is_aligned
  x86/fpu/xcr: Return all enabled xfeature if CPU doesn't support
  x86/fpu: Rellocate fpstate on save_fpregs_to_fpstate
  x86/fpu: Don't keep state_size in perm struct
  x86/fpu: Split out XFEATURE_MASK_KERNEL_DYNAMIC
  x86/fpu: Mark AVX512 xfeatures as kernel dynamic

 arch/x86/include/asm/fpu/types.h  |   8 -
 arch/x86/include/asm/fpu/xcr.h    |  16 +-
 arch/x86/include/asm/fpu/xstate.h |  19 +-
 arch/x86/kernel/fpu/core.c        |  21 ++-
 arch/x86/kernel/fpu/xstate.c      | 281 ++++++++++++++----------------
 arch/x86/kernel/fpu/xstate.h      |   3 +-
 6 files changed, 181 insertions(+), 167 deletions(-)

-- 
2.30.2

