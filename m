Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC6A55DB48
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244642AbiF1FKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 01:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244388AbiF1FKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 01:10:18 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7C2BF9FCF;
        Mon, 27 Jun 2022 22:10:17 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id E87538106;
        Tue, 28 Jun 2022 05:05:04 +0000 (UTC)
Date:   Tue, 28 Jun 2022 08:10:15 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Paul Walmsley <paul@pwsan.com>,
        Russell King <linux@armlinux.org.uk>,
        Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <santosh.shilimkar@ti.com>,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: omap2: Fix refcount leak in omap3xxx_prm_late_init
Message-ID: <YrqNN6dAISFGbcaO@atomide.com>
References: <20220526073724.21169-1-linmq006@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220526073724.21169-1-linmq006@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Miaoqian Lin <linmq006@gmail.com> [220526 10:33]:
> of_find_matching_node() returns a node pointer with refcount
> incremented, we should use of_node_put() on it when not need anymore.
> Add missing of_node_put() to avoid refcount leak.

Thanks applying into omap-for-v5.10/soc.

Tony
