Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADA504BDFA7
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:50:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378575AbiBUO4W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 09:56:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378482AbiBUO4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 09:56:15 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DD09205F8;
        Mon, 21 Feb 2022 06:55:51 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 22A6C5C00EE;
        Mon, 21 Feb 2022 09:55:49 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 21 Feb 2022 09:55:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm1; bh=JGbkcex9y9YUBKi+GNxGiILoS3G1VFSFax2+98z2bK0=; b=WPgTg
        bU/6VX4eRi1RavCz9qNrf/MnNOYkFVdzGXIc+mr0u+ZsL9X1DOuGAvkjfpTNbYwX
        gzz1cjoqX4EHHUBLgjRASH/jx/nchpAZGWS+FyjfppQioxoCc3z4XBAOp6GwUtSc
        /BveZXXkc+DEqzaC2zLMaiDnj9fJrhCk+C+TWQ3JQaWPipeUd3z1y6w8He5H/syR
        KaqwOSUySMB8gqWSgHW6uTEhcMWWtU8+h5KKt4AkgvBc6hCpJo0MF8y7YwVXgcOs
        yj2vD4I5KE+lpytCNWsaRF4b/TMBz0+P+3VWUYqgiotWbnDqSN4KhnaxmRexqr45
        K70xrK1Zshy5xV6+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:message-id:mime-version:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; bh=JGbkcex9y9YUBKi+GNxGiILoS3G1V
        FSFax2+98z2bK0=; b=BMxB3A5H0zwMzKjHbXlT3/q5G0tSV/ROBoApgHH3AEkJ4
        ve9tMZGdzWpUDefgR2aFyxbkQpISqvdqu+iiJLrIgriLz1iShbakECi9Z1ADnEPP
        PDBXOAIJR5BaBJwRG0Iin245v78izjyJsjqVquNMU/1QgL5hMEUm+7MPshJBEjrP
        i12t5UDF5g2Q2Q5xCPos1Z6GdijwWgOv3BjcczK4OtPqgMhmgUYNxERkTNJMD+gF
        h6+f04N5tkiuewZ5XrgF0l9NMzL1BmxVBVqjusX61X86H8bh7jz3oX7dSjNArknF
        TkuxgCcZygPyXa9aY3xs4+rt5u6bEe0TCmf6+AAFw==
X-ME-Sender: <xms:9KcTYhFMSS1qvMhQDw1MJQ7bgUe0LlpBWOg7tVyYzaLk2aeTYUBA4A>
    <xme:9KcTYmXFLkjpMDjroN0ApEX3HjNiPQGC2Jk7d8K58H-ynbe-12lktw3odOr0KfDLG
    ppGVm_hfcWWdTqEeew>
X-ME-Received: <xmr:9KcTYjIiv0dUI8s--ShDi6cGlbt4n5bt4IBzckqBZ6XIS4hVXOFi04A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrkeeigdeikecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertdertd
    dtnecuhfhrohhmpeflihgrgihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhl
    hihgohgrthdrtghomheqnecuggftrfgrthhtvghrnhephfejtdektdeuhedtieefteekve
    ffteejteefgeekveegffetvddugfeliefhtddunecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrth
    drtghomh
X-ME-Proxy: <xmx:9KcTYnHnFWya_pb4nYz1iQK68INpUnjXEvs1ptchGHUyNhO_sf71IQ>
    <xmx:9KcTYnXVskn-O1P1lKpj-ckFykPIG2rC9rFKSfYC0Ay2y9_mRafwMw>
    <xmx:9KcTYiOdrstGF_Q6UD9L0KYch9-zrcpGyeWPoAH1dH_6fI3RmO_P5Q>
    <xmx:9acTYtyaUEoA6XYhFUu_nycHAlgwfQovGVfhQZdy4V-kP5Tk0QrZBA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Feb 2022 09:55:47 -0500 (EST)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, chenhuacai@kernel.org,
        tsbogend@alpha.franken.de, macro@orcam.me.uk,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [RFC PATCH 0/3] MIPS: Chaos of barrier misuses
Date:   Mon, 21 Feb 2022 14:55:28 +0000
Message-Id: <20220221145531.10479-1-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series clears the chaos of barrier misuse.
In prepration of light weight barrier series.

Jiaxun Yang (3):
  MIPS: Loongson64: Clearify IO barriers
  MIPS: io.h use barrier terminology from asm-generic
  MIPS: io.h: Remove barriers before MMIO accessors for CPU without WB

 arch/mips/Kconfig          |  1 -
 arch/mips/include/asm/io.h | 25 ++++++++++++++++++++-----
 2 files changed, 20 insertions(+), 6 deletions(-)

-- 
2.35.1

