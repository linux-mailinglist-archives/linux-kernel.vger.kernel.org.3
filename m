Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59D925AE375
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 10:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239592AbiIFIu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 04:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239553AbiIFIu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 04:50:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 433671E1
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 01:49:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0CBFBB8164F
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 08:49:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69793C433D6;
        Tue,  6 Sep 2022 08:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1662454159;
        bh=maF/8doVyrhITy6wMH5ABApLAJPcAaF+21+F+N5hksk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JsmDjuV5Ty55bsUm6AoQmlD8xUBf1LW1meRiRljc8NDDfXcpLyzxNaISgKEusUIsc
         aS9PC738BldYqFjYsv246tV0q/Y0NAxBeCoC22CUJFyg+wtMRHv6cGlh3Si0apDh43
         KGTBiBQPoPUbafrI+XrMQV5GjifYk4d1VmKA5TRc=
Date:   Tue, 6 Sep 2022 10:49:16 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
Cc:     linux-kernel@vger.kernel.org, kbuild-all@lists.01.org,
        lkp@intel.com
Subject: Re: [PATCH char-misc-next] misc: microchip: pci1xxxx: Include
 depends on PCI & select AUXILIARY_BUS  in the Kconfig file to resolve build
 issues.
Message-ID: <YxcJjNwL3/TxYhPc@kroah.com>
References: <20220906083555.475103-1-kumaravel.thiagarajan@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220906083555.475103-1-kumaravel.thiagarajan@microchip.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Your subject line is way too long :(


On Tue, Sep 06, 2022 at 02:05:55PM +0530, Kumaravel Thiagarajan wrote:
> Some build errors were reported by kernel test robot <lkp@intel.com> on
> the char-misc-next branch. This add-on patch will fix the errors.

You should list the errors here so that we know what they are. 

> 
> Fixes: 393fc2f5948fd340d016a9557eea6e1ac2f6c60c

As per the kernel documentation, this should be:
Fixes: 393fc2f5948f ("misc: microchip: pci1xxxx: load auxiliary bus driver for the PIO function in the multi-function endpoint of pci1xxxx device.")

Can you fix this up and send a v2?

thanks,

greg k-h
