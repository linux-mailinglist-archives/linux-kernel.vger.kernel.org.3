Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD5C51FF70
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 16:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237055AbiEIOXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 10:23:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236600AbiEIOXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 10:23:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33352119496
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 07:19:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E6C2FB81629
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 14:19:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C59CC385A8;
        Mon,  9 May 2022 14:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1652105946;
        bh=4qGn3+fVwMLzp2o2L0iSnbyEG8ZLLh1SAcJkQrV1hnc=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=LC7QNEF1Jus1fHw3r0qpGHITcdyew7pH8WVk94Ak+VrRhB/ZCwXFnUrdmnr/RipXs
         j0rXo7KyG8pLS156XpoKWfJm4neq5VazKt0asb0YxvQQWH4t8Zg8tk0j5jMr3GDtPE
         dqb0CPAuAqNLCUdEAn35KqbhnGTpCR37AtF3vVEM=
Date:   Mon, 9 May 2022 16:19:03 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Samuel Thibault <samuel.thibault@ens-lyon.org>,
        linux-kernel@vger.kernel.org, speakup@linux-speakup.org
Subject: Re: [PATCHv2] speakup: Generate speakupmap.h automatically
Message-ID: <Ynki154mxF+2L8WH@kroah.com>
References: <20220430003934.fkua7vwoz6heigrp@begin>
 <20220430073321.6b4lvrrt7buzh7dp@begin>
 <YnkfeyobcOOgDGkH@kroah.com>
 <20220509140705.n3eei4r5ko6bbex4@begin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220509140705.n3eei4r5ko6bbex4@begin>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 09, 2022 at 04:07:05PM +0200, Samuel Thibault wrote:
> Hello,
> 
> Greg KH, le lun. 09 mai 2022 16:04:43 +0200, a ecrit:
> > Any reason you can't add the code in utils.c into genmap.c and then
> > merge into makemapdata.c to make this a single .c file that does both
> > things?
> 
> Yes: genmap is a tool that end-users can use without needing the Linux
> source code, while makemapdata needs it.

But who will run genmap?

Also you could just put the 90 lines of code into the .h file as inline
functions to get rid of the utils.c to make it a bit simpler.

thanks,

greg k-h
