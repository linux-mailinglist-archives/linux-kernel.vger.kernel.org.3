Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B4FF568E58
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 17:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233570AbiGFPw0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 11:52:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233270AbiGFPwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 11:52:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 536152A978;
        Wed,  6 Jul 2022 08:50:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E27866204E;
        Wed,  6 Jul 2022 15:50:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4981C341C8;
        Wed,  6 Jul 2022 15:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1657122617;
        bh=NzR8o5tZZ69UTTBSZ6y0xtg8tOkhb8XZfQlNb2BRH3Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J1XfEx47HBZ4Mml6K06p55YspZnx9BRxvp0NlUIZ3gtpylKB7/aUwYRA+3PL3/N7i
         zuAaG2lCz2uMLYC0I6I+2rvCzwgj/3Dn0RzGLuxTaVuuo0pgQlqCXqQ/NJYvuMFrae
         U78bl8OHADxlS4+yokj4Co+DoEAcf85mcKAyfWWc=
Date:   Wed, 6 Jul 2022 17:50:14 +0200
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
Message-ID: <YsWvNsK/hTc4sxo4@kroah.com>
References: <20220701144013.1085272-1-sebastianene@google.com>
 <20220701144013.1085272-3-sebastianene@google.com>
 <20220706152101.GA3003@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220706152101.GA3003@willie-the-truck>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 06, 2022 at 04:21:01PM +0100, Will Deacon wrote:
> > +MODULE_LICENSE("GPL");
> 
> This needs to be "GPL v2".

Nope, that is what this is saying, please see the huge comment in
include/linux/module.h right above MODULE_LICENSE().  So all is good
here.

thanks,

greg k-h
