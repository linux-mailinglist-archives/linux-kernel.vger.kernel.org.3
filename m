Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64AA9564515
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 06:49:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231750AbiGCEso (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 00:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbiGCEsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 00:48:20 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A494D6B
        for <linux-kernel@vger.kernel.org>; Sat,  2 Jul 2022 21:48:17 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 0088D3200901;
        Sun,  3 Jul 2022 00:48:15 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Sun, 03 Jul 2022 00:48:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=anarazel.de; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1656823695; x=1656910095; bh=8z
        hhLjJ89Qw5KLPBoM2NWX+z2yUV9FRU26MVhOWZvb0=; b=FShGDMdahrDjiEPIwF
        jVQwZBnmhxwI+RNwrmf/n7TzocoKR62qY/LBRf1gX24BvI9WhY6Tn6xQY6bBpgie
        90A1nLlL6ecW7hx6cb1BMcHjqnK2hRb6E37xerO/q4Dd06us9zg1xC3GHS53H24G
        a25SpG4E+7IPKtAGth7uSTQ8DEZKBQq0JhKPlBDuNqkWg/NPOE7mJDdz1hhwiVcY
        /W5ZanyQil5DkS0QIYNiMiNY/PipefJ90GEWcw6G95PQuQYBF9bsTpkezL4sclA5
        fKX12BmMXHi4RBfMYElwgvmwuFAlWwC1PpenTZYkPF9+/qW6upb1XltUDrujRG/E
        uJUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1656823695; x=1656910095; bh=8zhhLjJ89Qw5K
        LPBoM2NWX+z2yUV9FRU26MVhOWZvb0=; b=hUB290MqM2JiQRKvBax6qf6BCXfw0
        XLep+6Aoq+zBUqQxyIkha0zBx+I+PcG9/M+kuufZtUIiBisqIl7qxvcjwOvgfBGM
        9R+XV3iWdpp2tZGAPYjS05UrnXQG6BcwWqYgBJKzKZZBe7AmzDRW2bTsbEAfM5G9
        X9vYxqEGVVatnpbxHckjQ3jobCSlvernMkvZVCET+BVVfBHKZZXgfR551AGhj0L+
        qT1NyXfNjhn6O/eedo7DTv7y8TNe3M7fbiOfRLAzShR7cmPuIgld5Wn8DB2lC4BV
        /MUpDX0xnxoBd2JXpDbI5G9JaSOe2WwQ54yqT0x9MXief2JT6iDEsM23A==
X-ME-Sender: <xms:jx_BYtcyLH90y7xmVm26vvlzeqhUdpgKx3H89XfTj0AEqisUc9nBEg>
    <xme:jx_BYrPrqHMUeG5I48MkzMgNg6bEzEbEoEpj2Qm57KAP9hH9uHltke1KzKcSneTPd
    JwToNTNJBhsuU2Npg>
X-ME-Received: <xmr:jx_BYmiFE30qDrVZNbSiIV7SgKgNi9zN8-oT0fy6NdmzuUPxeEkyx_-RTzSk2XiFtaJrNbuCiosRj7hhKlgQYOhsEq1YD_dTqPVGdr6pVlA4RVok4Tkx3pG1ZuKB>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudehiedgkeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomheptehnughr
    vghsucfhrhgvuhhnugcuoegrnhgurhgvshesrghnrghrrgiivghlrdguvgeqnecuggftrf
    grthhtvghrnhepteduuefhtdeuudejfefgteeivdeuheeiueelueehgffgvdefgfehgeel
    geehvddtnecuffhomhgrihhnpehsohhurhgtvgifrghrvgdrohhrghenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrnhgurhgvshesrghnrghr
    rgiivghlrdguvg
X-ME-Proxy: <xmx:jx_BYm-p7jvPCGHNWTfzQlTJx3iBhJM_DcQfMj90FBN8k9gb2Zk-JA>
    <xmx:jx_BYpuib6GAt08P-rtHiVRoJoITnUmF1GVd2iMW0erh49nnssonCw>
    <xmx:jx_BYlEaatqcdKoQOGifagKP8-dKaGGaK9ct3l6j9QGvqmFy_CXouA>
    <xmx:jx_BYhIZYxA_SIVNk0kd1nZ5tdmKVzsrHLeKdbo5cZkF6zkPlbY-6A>
Feedback-ID: id4a34324:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 3 Jul 2022 00:48:15 -0400 (EDT)
From:   Andres Freund <andres@anarazel.de>
To:     linux-kernel@vger.kernel.org
Cc:     Quentin Monnet <quentin@isovalent.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>
Subject: [PATCH v1 0/3] tools: fix compilation failure caused by init_disassemble_info API changes
Date:   Sat,  2 Jul 2022 21:48:10 -0700
Message-Id: <20220703044814.892617-1-andres@anarazel.de>
X-Mailer: git-send-email 2.35.1.677.gabf474a5dd
In-Reply-To: <20220622231624.t63bkmkzphqvh3kx@alap3.anarazel.de>
References: <20220622231624.t63bkmkzphqvh3kx@alap3.anarazel.de>
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

binutils changed the signature of init_disassemble_info(), which now causes
compilation failures for tools/{perf,bpf} on e.g. debian unstable. Relevant
binutils commit:
https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=60a3da00bd5407f07

I first fixed this without introducing the compat header, as suggested by
Quentin, but I thought the amount of repeated boilerplate was a bit too
much. So instead I introduced a compat header to wrap the API changes. Even
tools/bpf/bpftool/jit_disasm.c, which needs its own callbacks for json, imo
looks nicer this way.

I'm not regular contributor, so it very well might be my procedures are a
bit off...

I wasn't sure whether the split of the commits conforms with the kernel
habits should the changes to tools/bpf and tools/perf be split into
separate commits?

Nor was I sure if I the right [number of] people to CC?

WRT the feature test: Not sure what the point of the -DPACKAGE='"perf"' is,
nor why tools/perf/Makefile.config sets some LDFLAGS/CFLAGS that are also
in feature/Makefile and why -ldl isn't needed in the other places. But...

Andres Freund (3):
  tools build: add feature test for init_disassemble_info API changes
  tools: add dis-asm-compat.h to centralize handling of version
    differences
  tools: Use tools/dis-asm-compat.h to fix compilation errors with new
    binutils

To: bpf@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Quentin Monnet <quentin@isovalent.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>

 tools/bpf/Makefile                            |  7 ++-
 tools/bpf/bpf_jit_disasm.c                    |  5 +-
 tools/bpf/bpftool/Makefile                    |  7 ++-
 tools/bpf/bpftool/jit_disasm.c                | 40 +++++++++++---
 tools/build/Makefile.feature                  |  4 +-
 tools/build/feature/Makefile                  |  4 ++
 tools/build/feature/test-all.c                |  4 ++
 .../feature/test-disassembler-init-styled.c   | 13 +++++
 tools/include/tools/dis-asm-compat.h          | 53 +++++++++++++++++++
 tools/perf/Makefile.config                    |  8 +++
 tools/perf/util/annotate.c                    |  7 +--
 11 files changed, 135 insertions(+), 17 deletions(-)
 create mode 100644 tools/build/feature/test-disassembler-init-styled.c
 create mode 100644 tools/include/tools/dis-asm-compat.h

-- 
2.35.1.677.gabf474a5dd

