Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 430B958286A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 16:18:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233570AbiG0OSV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 10:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232747AbiG0OST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 10:18:19 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEB175F88
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 07:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658931498; x=1690467498;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uoI7KelwWlQQNj5jn9w6g8Y98M8Qw8jtv+JZ13Ertiw=;
  b=SvoE0oTAwZE1BQPTry4wbzeD1QboGqpM6dLSMtAeNfex14DHGl81dGzo
   MHFC0duixznJ9FH4SW4NciqCme/1iqL7x/Hg9cIv0D8Pw0fAEjA0hQYLj
   9VHpR813eu46KvYHljlAOu8Eo0k9BadGFkGFZdVpx/lTw7LS6Zh8JIXzB
   BEYUXCBNylCgqjgqkwdIG4/d6r7+1+bd6U773C2ZZrvRWD6rdUhQ100fJ
   t4RqLFqrn/7sSkpGVQ2u14TFDxcwBAnz3AkTbsFq++cYoxFHuFIrmVO4+
   NQ5tui/h1W+EEiw0oNbpzfk+A9mpkRnYv742qLiwEjr0ckaog+OUEb4mH
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10421"; a="289008648"
X-IronPort-AV: E=Sophos;i="5.93,195,1654585200"; 
   d="scan'208";a="289008648"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2022 07:18:18 -0700
X-IronPort-AV: E=Sophos;i="5.93,195,1654585200"; 
   d="scan'208";a="628392107"
Received: from cene1-mobl.ger.corp.intel.com (HELO intel.com) ([10.252.44.151])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2022 07:18:16 -0700
Date:   Wed, 27 Jul 2022 16:18:14 +0200
From:   Andi Shyti <andi.shyti@linux.intel.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Chris Wilson <chris.p.wilson@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        intel-gfx@lists.freedesktop.org
Subject: Re: [Intel-gfx] [PATCH v3 2/6] drm/i915/gt: document
 with_intel_gt_pm_if_awake()
Message-ID: <YuFJJmo1DqZIMrLp@alfio.lan>
References: <cover.1658924372.git.mchehab@kernel.org>
 <b974905bd0f6b5308b91561cc85eeecd94f1452a.1658924372.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b974905bd0f6b5308b91561cc85eeecd94f1452a.1658924372.git.mchehab@kernel.org>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mauro,

> Add a kernel-doc markup to document this new macro.
> 
> Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
> Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>

Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>

Andi
