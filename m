Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4E1C4B8F3A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 18:34:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235846AbiBPRen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 12:34:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237182AbiBPRej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 12:34:39 -0500
Received: from relay5.hostedemail.com (relay5.hostedemail.com [64.99.140.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B524722F760
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 09:34:24 -0800 (PST)
Received: from omf12.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay11.hostedemail.com (Postfix) with ESMTP id B2D3B80A78;
        Wed, 16 Feb 2022 17:34:23 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf12.hostedemail.com (Postfix) with ESMTPA id E78A81D;
        Wed, 16 Feb 2022 17:34:03 +0000 (UTC)
Message-ID: <ddfd57341988c3728c0b3dde5cf8712b9c1646be.camel@perches.com>
Subject: Please remove patch "scripts/checkpatch.pl: remove _deferred and
 _deferred_once false warning" from mm
From:   Joe Perches <joe@perches.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Maninder Singh <maninder1.s@samsung.com>,
        Vaneet Narang <v.narang@samsung.com>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Wed, 16 Feb 2022 09:34:21 -0800
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: E78A81D
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Stat-Signature: occyf1oagmss1njre83uhfsq4xpfo4fo
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/sR1ASeMlVoLIxOOPRtlcPyTnPbaKOV8w=
X-HE-Tag: 1645032843-375644
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It needs some rework.

It emits UNNECESSARY_KERN_LEVEL messages on perfectly acceptable uses
like:

	dev_printk(KERN_DEBUG "foo", ...)



