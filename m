Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB19598979
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 19:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345228AbiHRQ7p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 12:59:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345194AbiHRQ72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 12:59:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7603C7C1D9;
        Thu, 18 Aug 2022 09:59:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3074FB82224;
        Thu, 18 Aug 2022 16:59:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E50EC433B5;
        Thu, 18 Aug 2022 16:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1660841964;
        bh=9gzQOMNNDBydo+S49sPg2d6ZCeJYZcrV+3tVZriBYy0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qYd0eHU75pC4yIqaUAcV8odWRAExwk7RdDYpE2AV9Z/r57uU1Gtmcj+ti2CRDT+ow
         vsDqTH0ACbfxVvDqV88IT+K9enjsKIGMqt0NNYT7GCXbPMYIxuo4DKQemhflYbU5xa
         wPYR/hnwrjCgQvjYSL7gvGo2yX0oJvQFsKCU9HbY=
Date:   Thu, 18 Aug 2022 18:59:21 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Thierry GUIBERT <thierry.guibert@free.fr>
Cc:     Thierry GUIBERT <thierry.guibert@croix-rouge.fr>, oneukum@suse.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] CDC-ACM : Add Icom PMR F3400 support (0c26:0020)
Message-ID: <Yv5v6ZWsj/oSzkr+@kroah.com>
References: <20220817102440.117640-1-thierry.guibert@croix-rouge.fr>
 <Yv5U7Xw5gHSY5EH0@kroah.com>
 <67aa9041-b9c9-435f-f4a2-b453344ba779@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67aa9041-b9c9-435f-f4a2-b453344ba779@free.fr>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 18, 2022 at 06:54:15PM +0200, Thierry GUIBERT wrote:
> Hi Greg,
> 
> Do you expect me to reorder the whole structure by VendorId / ProductId ?

No.

> I can place my node after Castles VEGA 3000, but nodes "MARETRON USB100"
> "Alcatel OT-I650" and "DATECS FP-2000" are misplaced too in that case.

Just move your entry up one and that should be good enough, right?

thanks,

greg k-h
