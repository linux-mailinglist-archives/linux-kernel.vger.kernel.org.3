Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A4A3501742
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 17:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357062AbiDNPZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 11:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347965AbiDNOBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 10:01:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E1863BBCD
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 06:57:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B42AFB829A6
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 13:57:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE3D5C385AB;
        Thu, 14 Apr 2022 13:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649944644;
        bh=0qaZLey80GwRxkbnpELNNiiu04Z1tGmUnvBYVBn6HLo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RkJwBjEPV04YrtZCp+NB0wsr+vR3Yyui3vsao0OEAesgcZ7S5YaL1G9kU7+BRz8eG
         hnU7Q41bkx9pSsGPe+xSLyCqg6EwC+mA9czIPVmBSEveBXYp553m4i5INTL+iNL0jr
         MQUMviaf2RkOG2kuluKkCQNmX4JZ4v6A2WFUK99M=
Date:   Thu, 14 Apr 2022 15:19:27 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jani Nikula <jani.nikula@intel.com>
Cc:     linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Lucas De Marchi <lucas.demarchi@intel.com>
Subject: Re: [PATCH 0/1] add support for enum module parameters
Message-ID: <YlgfXxjefuxiXjtC@kroah.com>
References: <20220414123033.654198-1-jani.nikula@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220414123033.654198-1-jani.nikula@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2022 at 03:30:32PM +0300, Jani Nikula wrote:
> Hey, I've sent this before, ages ago, but haven't really followed
> through with it. I still think it would be useful for many scenarios
> where a plain number is a clumsy interface for a module param.
> 
> Thoughts?

We should not be adding new module parameters anyway (they operate on
code, not data/devices), so what would this be used for?

thanks,

greg k-h
