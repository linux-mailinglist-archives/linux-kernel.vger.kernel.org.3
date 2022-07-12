Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7318E57150F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 10:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232455AbiGLIuB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 04:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbiGLIt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 04:49:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8198E29815;
        Tue, 12 Jul 2022 01:49:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2BEC4B81799;
        Tue, 12 Jul 2022 08:49:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E687EC3411C;
        Tue, 12 Jul 2022 08:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1657615796;
        bh=kIk0r7AQwrDga68KddU5WpBEK3G39Nsu/zaM7hT5210=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CVfHjXHdzMRCi9/zKPVyrmqj/X5pKi2syA314PoAFLRDbrP8prSTG2gz4ZEntTSme
         pmEkOzq/I3IwF2lqedTfqMM/0klV88CNuf3rLHgxOu6GzHXnjqNTVMH85nSxU4tj2P
         ZrQyxDpUUZVsc7tMpNF0ipmFgaDeCA/cZ27RcNjU=
Date:   Tue, 12 Jul 2022 10:49:48 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Xin Ji <xji@analogixsemi.com>, bliang@analogixsemi.com,
        qwen@analogixsemi.com, jli@analogixsemi.com,
        kernel test robot <lkp@intel.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v15 3/3] usb: typec: anx7411: Add Analogix PD ANX7411
 support
Message-ID: <Ys01rHaCvXTjqKu/@kroah.com>
References: <20220712064111.2782861-1-xji@analogixsemi.com>
 <20220712064111.2782861-3-xji@analogixsemi.com>
 <Ys0xdDVzO2czw6mh@kuha.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ys0xdDVzO2czw6mh@kuha.fi.intel.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2022 at 11:31:48AM +0300, Heikki Krogerus wrote:
> Tue, Jul 12, 2022 at 02:41:11PM +0800, Xin Ji kirjoitti:
> > Add driver for analogix ANX7411 USB Type-C DRP port controller.
> > 
> > Reported-by: kernel test robot <lkp@intel.com>
> 
> As this is a new driver, I'm not sure that Reported-by tag is
> appropriate. At least it's a bit confusing. In any case:

It's very confusing and wrong and needs to be removed before I can take
it :(
