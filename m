Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDBFB4E2382
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 10:43:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345973AbiCUJo7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 05:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345310AbiCUJo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 05:44:58 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E33B2BF0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 02:43:29 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 380C25C01BA;
        Mon, 21 Mar 2022 05:43:27 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 21 Mar 2022 05:43:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=4al7ncrz2EH9krhtX
        ccZlRXvPxg+S/0nxXh5Rkoyq/M=; b=P35PEYaP2EwbX9hvyT4jsC0kp/JO8pqeP
        rUr2NY/8BGi6bp8vSLfTUyTXOtSNWxIOxXxi6LHiVW68HIxCfmZfmi/2PR7enyr0
        rG0ZRsAgBVP3AcUF7T7MOuwpVY/cRHa/eCoDDDQwBRpImR/YkxSjWdwABxivoSUY
        pmjWzRcikPX+xTFCOdlvkxUkKQeDxepsZZ37et8YF1Ale2vAsrkpRUGVC5n56H9O
        t5PdsbYYazDHfYBj3d/3KvsrRH8n/C47uQBBaFM7Iy2K2RFTIQnJhqs9gpBhrClq
        xQejmuGRroH1t436tPDeFtwZyXpVCws3OFEa3Qc45mIj4AzVIkUgQ==
X-ME-Sender: <xms:vkg4YrGBynEALIXSL7jOsr7MsHkdf2I1qWJ-_4jNxPJy5mTzTe-d1w>
    <xme:vkg4YoVa4Lga-SXbvrJO-pPP7krF6p0ikywnyh-qSJVP05DBv2TS5UYpcHmgKE9t2
    qmd04MnYySpOA8Nrj0>
X-ME-Received: <xmr:vkg4YtJg1ggBGJ7U2AgUuc_3HmLNnJyz5DE5lntZjpTUEnBm-KnSG-0VIn5qaXu5YsRv9qvr8ZzP7HZzO4jknzOqFSweoRJQEaE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudegfedgtdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffujgfkfhggtgesthdtredttddtvdenucfhrhhomhephfhinhhnucfv
    hhgrihhnuceofhhthhgrihhnsehlihhnuhigqdhmieekkhdrohhrgheqnecuggftrfgrth
    htvghrnhepffduhfegfedvieetudfgleeugeehkeekfeevfffhieevteelvdfhtdevffet
    uedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepfh
    hthhgrihhnsehlihhnuhigqdhmieekkhdrohhrgh
X-ME-Proxy: <xmx:v0g4YpFRvwC5RggmTyKAAOFii9uBxblmQgP8lPBHWZmAPSptfTFpQg>
    <xmx:v0g4YhXFrWDlKoonCGVoOjqFjjf-Ny0xOGyGVmbrJgJodq4Cs3O7Gw>
    <xmx:v0g4YkNkUK9fptAP5E-dSuo_bVSKQNmGFcjlISESbJCpCPdSvLdcAg>
    <xmx:v0g4YgeenuCLGwD77GtrV0uwr4PQpY6qohtdjdx7O0KrIvbfBbeB9Q>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Mar 2022 05:43:25 -0400 (EDT)
Date:   Mon, 21 Mar 2022 20:43:30 +1100 (AEDT)
From:   Finn Thain <fthain@linux-m68k.org>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc:     Randy Dunlap <rdunlap@infradead.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Subject: [PATCH] macintosh/via-pmu: Avoid compiler
 warnings when CONFIG_PROC_FS is disabled
In-Reply-To: <bb3b2229213f5feaff12e731b7537d03705e15d5.1647854173.git.fthain@linux-m68k.org>
Message-ID: <50b3865d-f23d-c4c2-2f41-7ec51cdb9e9a@linux-m68k.org>
References: <bb3b2229213f5feaff12e731b7537d03705e15d5.1647854173.git.fthain@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Please disregard. I'll send v2 with corrected commit log entry.
