Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 379BB509E42
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 13:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388723AbiDULL5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 07:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388757AbiDULLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 07:11:47 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B7D832D1FC;
        Thu, 21 Apr 2022 04:08:57 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id B247D8106;
        Thu, 21 Apr 2022 11:06:05 +0000 (UTC)
Date:   Thu, 21 Apr 2022 14:08:55 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Gireesh.Hiremath@in.bosch.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-omap@vger.kernel.org, robh+dt@kernel.org,
        bcousson@baylibre.com, sjoerd.simons@collabora.co.uk,
        VinayKumar.Shettar@in.bosch.com,
        Govindaraji.Sivanantham@in.bosch.com, anaclaudia.dias@de.bosch.com
Subject: Re: [PATCH 00/15] am335x, guardian: update board specific dts changes
Message-ID: <YmE7R3eVO6070X5H@atomide.com>
References: <20220325100613.1494-1-Gireesh.Hiremath@in.bosch.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220325100613.1494-1-Gireesh.Hiremath@in.bosch.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Gireesh.Hiremath@in.bosch.com <Gireesh.Hiremath@in.bosch.com> [220325 12:04]:
> From: Gireesh Hiremath <Gireesh.Hiremath@in.bosch.com>
> 
> update guardian device tree

Thanks applying into omap-for-v5.19/dt.

Few ideas for future though.

Not sure how you handle the nand partition table changes.. Seems the partition
values in the devicetree should not change in general.

The node names in devicetree should not use "_" but "-" instead. And the node
names should be general like you mostly already have. Anyways, we have a lot
of these especially for pinctrl, but we may want to clean them up eventually.
Just FYI.

Regards,

Tony
