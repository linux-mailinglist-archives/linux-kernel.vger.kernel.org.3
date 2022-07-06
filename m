Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F6EC5690B8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 19:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233479AbiGFRf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 13:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232032AbiGFRf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 13:35:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D76EF1AF2C;
        Wed,  6 Jul 2022 10:35:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 858F8B81E67;
        Wed,  6 Jul 2022 17:35:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAE81C3411C;
        Wed,  6 Jul 2022 17:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1657128955;
        bh=6ynoMbQXFNIScYnjumKAJ6N545ZU828F4IhKiPE9fyA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YJSavBUJWDm153lqRDuFqJbuMvjNAnAhzS8vTOheHjx52BLYzvbbGNriDCgTCmpIp
         YyJluBX5HXGN4F74l4jCFzPj1OjfhVy7EBWgtQ/H7mUQmnh+LiPZHen7XSRyVkkcGX
         159t5DU5rqe0OFAHCZzn6knq4BhyMFcIEuPcVLns=
Date:   Wed, 6 Jul 2022 19:35:52 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Will Deacon <will@kernel.org>
Cc:     Sebastian Ene <sebastianene@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        maz@kernel.org, vdonnefort@google.com,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v9 2/2] misc: Add a mechanism to detect stalls on guest
 vCPUs
Message-ID: <YsXH+BMwrdFqi2ml@kroah.com>
References: <20220701144013.1085272-1-sebastianene@google.com>
 <20220701144013.1085272-3-sebastianene@google.com>
 <20220706152101.GA3003@willie-the-truck>
 <YsWvNsK/hTc4sxo4@kroah.com>
 <20220706161048.GA3204@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220706161048.GA3204@willie-the-truck>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 06, 2022 at 05:10:50PM +0100, Will Deacon wrote:
> On Wed, Jul 06, 2022 at 05:50:14PM +0200, Greg Kroah-Hartman wrote:
> > On Wed, Jul 06, 2022 at 04:21:01PM +0100, Will Deacon wrote:
> > > > +MODULE_LICENSE("GPL");
> > > 
> > > This needs to be "GPL v2".
> > 
> > Nope, that is what this is saying, please see the huge comment in
> > include/linux/module.h right above MODULE_LICENSE().  So all is good
> > here.
> 
> Thanks, I stand corrected, although I personally still find it clearer to
> spell it out!

I totally agree, but there is no "you must do this" directive here :)
