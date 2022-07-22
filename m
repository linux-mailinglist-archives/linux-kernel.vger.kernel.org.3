Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A25457DF2B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 12:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235022AbiGVKAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 06:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234516AbiGVKAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 06:00:13 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8734926F4
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 03:00:11 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3FE4868AFE; Fri, 22 Jul 2022 12:00:08 +0200 (CEST)
Date:   Fri, 22 Jul 2022 12:00:06 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc:     Robert Beckett <bob.beckett@collabora.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, kernel@collabora.com,
        Christoph Hellwig <hch@lst.de>,
        Thomas Hellstrom <thomas.hellstrom@intel.com>,
        Matthew Auld <matthew.auld@intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/i915: stop using swiotlb
Message-ID: <20220722100006.GC14113@lst.de>
References: <20220721174307.1085741-1-bob.beckett@collabora.com> <118ae557-a7cb-10b2-9198-2ceb92948dd7@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <118ae557-a7cb-10b2-9198-2ceb92948dd7@linux.intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 22, 2022 at 10:13:48AM +0100, Tvrtko Ursulin wrote:
> Christoph - ack from you? Also, if we merge it via the normal process it 
> will hit 5.21 only. Does that work for you?

While I'd like to kill off swiotlb_max_segment rather sooner than
later I'm fine with following the normal process.  But I don't think
there will be a 5.21 with the recent Linux versioning practice :)
