Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FE51568EAE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 18:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234019AbiGFQLD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 12:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234002AbiGFQK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 12:10:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B5FF1F626;
        Wed,  6 Jul 2022 09:10:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5FE12B81DA5;
        Wed,  6 Jul 2022 16:10:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1757DC341C8;
        Wed,  6 Jul 2022 16:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657123856;
        bh=RBP9aI9AIOYbwy74w1vs7z6dw7VqfGFJFry8/KWE/LE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lw1GA5OTfAm3jM8sFOu8TuMl7X6BtOsatGPobPce9Zy4yTFbiIx9eZjs1A9RFIyw/
         wg3/BWjsHCVaFVqeIlZc8KFEokupOZfgbIJqOCkuj0RIPBi9+MZeqlG0kLD21xq6Er
         MBpGbHP2PDco4O4xUWo6api14lmQ4jFHJ2c9W7H9Ve9V3o1DeYLvaERdU0hJHwtTf/
         07v+RiYuYgLwPQUBi4rPPbDmqD2GIvnsSrAX6lbYfs2dHAzLZOva51qmXhnyzVj2M1
         Kqw+khrx8w5FUQMu04hKZYjx5vQQ/w9YIufJBfEcJW2fUmI31wCeKwCe8H0KJUGNRB
         TgUus5CbBq5JQ==
Date:   Wed, 6 Jul 2022 17:10:50 +0100
From:   Will Deacon <will@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Sebastian Ene <sebastianene@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        maz@kernel.org, vdonnefort@google.com,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v9 2/2] misc: Add a mechanism to detect stalls on guest
 vCPUs
Message-ID: <20220706161048.GA3204@willie-the-truck>
References: <20220701144013.1085272-1-sebastianene@google.com>
 <20220701144013.1085272-3-sebastianene@google.com>
 <20220706152101.GA3003@willie-the-truck>
 <YsWvNsK/hTc4sxo4@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YsWvNsK/hTc4sxo4@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 06, 2022 at 05:50:14PM +0200, Greg Kroah-Hartman wrote:
> On Wed, Jul 06, 2022 at 04:21:01PM +0100, Will Deacon wrote:
> > > +MODULE_LICENSE("GPL");
> > 
> > This needs to be "GPL v2".
> 
> Nope, that is what this is saying, please see the huge comment in
> include/linux/module.h right above MODULE_LICENSE().  So all is good
> here.

Thanks, I stand corrected, although I personally still find it clearer to
spell it out!

Will
