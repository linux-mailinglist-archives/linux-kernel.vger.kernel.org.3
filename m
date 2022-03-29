Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D8AC4EB556
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 23:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234533AbiC2Vfk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 17:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234386AbiC2Vfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 17:35:38 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE611E6154
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 14:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648589634; x=1680125634;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tHyJpMSgREeaX7Il6lUt/mc24/CfgD9AxcBykZQ1fFA=;
  b=W6ird+ntVHeCGxOmqm/TUXKNPjg4h5rutM7/bgpxTmBjhqdrVNNh5P4Y
   zp2Eyz3EEeZZwM2VlWZh3H+nSK9Om2wbzPMCG8Uy2uiTq68vIxz6Pr4cG
   HDsdXhR4l9V0MJvVmnN6mOVR3/dZTOTDpiTxV+BdnvPHizNcWuehcJSeL
   JFvko7ayaI4XB7wNtyb89D7MC1o8TECiEPUmTTVwCyzYMAa32//7WXAM4
   m2WwDMFfQ5kz1F9j4tHFiVtcJZUshe51yHlR+y+/1w5v6v0Tr0P1J+izn
   BNHqZXAR431nhTxt45AhJsYlcpN5/ehmH5UiwsH2XVI/kc0DvHM5+8JTk
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10301"; a="259352575"
X-IronPort-AV: E=Sophos;i="5.90,220,1643702400"; 
   d="scan'208";a="259352575"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2022 14:33:54 -0700
X-IronPort-AV: E=Sophos;i="5.90,220,1643702400"; 
   d="scan'208";a="585750705"
Received: from alison-desk.jf.intel.com (HELO alison-desk) ([10.54.74.41])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2022 14:33:54 -0700
Date:   Tue, 29 Mar 2022 14:36:19 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Sevinj Aghayeva <sevinj.aghayeva@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Fabio Aiuto <fabioaiuto83@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Muhammad Usama Anjum <musamaanjum@gmail.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev
Subject: Re: [PATCH] staging: rtl8723bs: Remove redundant else branches.
Message-ID: <20220329213619.GA1171634@alison-desk>
References: <20220329140904.GA3566@ubuntu>
 <20220329200053.GA1170989@alison-desk>
 <CAMWRUK4ti6QxA4JWbG_XwZHwQwWUKYu+HvVHvEBX-k82oaEP6g@mail.gmail.com>
 <20220329212426.GA1171538@alison-desk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220329212426.GA1171538@alison-desk>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

snip

On Tue, Mar 29, 2022 at 02:24:26PM -0700, Alison Schofield wrote:
> On Tue, Mar 29, 2022 at 01:59:52PM -0700, Sevinj Aghayeva wrote:
> > 
> > That one has already landed. Is it okay if I send v2 just for this patch?
> 
> Did you see it applied already?
> 

I see Greg took a couple that I wanted to send for rework.
BTW - if it was really something *wrong* I would ask you to send
another patch,  but since it's just style, let's just apply the
learning to the next one.

Thanks!
Alison

