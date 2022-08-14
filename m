Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E4BA592683
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 23:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240126AbiHNVU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 17:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239893AbiHNVUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 17:20:42 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C0E8A452
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 14:20:39 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1660512037;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=FvNfa4GGVQeSr4adHB015Sx32Zz0/Fu4+8DOW8Je4dA=;
        b=hW9ag5f/Ww9qiTeVIKa0fmxZcAv/bBjqsV/lo76HdUN+fWiNf6OxsKWuotobpjefPYk4eu
        Q8+hkTsjQMRaRm4ZwQ00pXEIHT3Pj0tQFqlHzgpnJGjBOrgg/pmLqNXNaiLh3QEAas6N/q
        um+BtrjRTnqDNdiOjkI6kuLnqiH1IIU=
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: Printbufs v6
Date:   Sun, 14 Aug 2022 17:19:39 -0400
Message-Id: <20220814212011.1727798-1-kent.overstreet@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Andrew, here's the final patch series:

v5 mailing:
https://lore.kernel.org/all/20220808024128.3219082-1-willy@infradead.org/

Changes since v5:
 - Add myself to MAINTAINERS for printbuf.[ch]
 - Move seq_buf to kernel/tracing instead of deleting it and drop the tracing
   patch, per Steven Rostedt
 - Fix commit message on prt_path, per Al Viro
 - Fix prt_u64_minwidth to pad with spaces instead of 0s, reported by bcachefs
   users

Cheers!


