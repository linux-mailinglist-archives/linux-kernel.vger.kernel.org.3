Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98B624F791C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 10:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235227AbiDGIKG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 04:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243185AbiDGIIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 04:08:53 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E940613FA4
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 01:06:54 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 82B3868AFE; Thu,  7 Apr 2022 10:06:51 +0200 (CEST)
Date:   Thu, 7 Apr 2022 10:06:51 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Zhi Wang <zhi.wang.linux@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        Zhi Wang <zhi.a.wang@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Vivi Rodrigo <rodrigo.vivi@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>
Subject: Re: [PATCH v9 1/3] i915/gvt: Separate the MMIO tracking table from
 GVT-g
Message-ID: <20220407080651.GA16455@lst.de>
References: <20220407071945.72148-1-zhi.a.wang@intel.com> <20220407071945.72148-2-zhi.a.wang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220407071945.72148-2-zhi.a.wang@intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The whole series looks good and works fine on by Kaby Lake Thinkpad:

Reviewed-by: Christoph Hellwig <hch@lst.de>
Tested-by: Christoph Hellwig <hch@lst.de>
