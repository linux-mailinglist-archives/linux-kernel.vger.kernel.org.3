Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CFDD55D5A6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245191AbiF1F5A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 01:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbiF1F45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 01:56:57 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3ACF128E05;
        Mon, 27 Jun 2022 22:56:57 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id BC7AA8106;
        Tue, 28 Jun 2022 05:51:44 +0000 (UTC)
Date:   Tue, 28 Jun 2022 08:56:55 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Peng Wu <wupeng58@huawei.com>
Cc:     linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        liwei391@huawei.com
Subject: Re: [PATCH] bus: ti-sysc: Add missing of_node_put() in
 sysc_add_named_clock_from_child()
Message-ID: <YrqYJ4B86cjYZGE7@atomide.com>
References: <20220620093107.73809-1-wupeng58@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220620093107.73809-1-wupeng58@huawei.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Peng Wu <wupeng58@huawei.com> [220620 12:32]:
> of_get_next_available_child() returns a node pointer with refcount
> incremented, we should use of_node_put() on it when not need anymore.
> Add missing of_node_put() to avoid refcount leak.

Thanks applying into omap-for-v5.20/ti-sysc.

Tony
