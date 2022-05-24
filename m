Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AFDF532CB2
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 16:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238487AbiEXO5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 10:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231920AbiEXO5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 10:57:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D4C235267;
        Tue, 24 May 2022 07:57:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B5C7FB8198C;
        Tue, 24 May 2022 14:57:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CD1AC34113;
        Tue, 24 May 2022 14:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1653404231;
        bh=rzeh8+TxZeOcseVWv6enLskwiRfggDzxj5xpLS7RZKs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n8WlceN3LFOktQz4IUPVQTshB6KLasXD2X76kI5yypqHQe/1sKLVoHO/HvUL73kqJ
         cbLZXdicCxwFZA6G9lo9qFRGDXn6Tm9bHxMZ0P/x+VgMNV5VqzZZYrkvYR7jbC9kJV
         vIAgneOdrFav9JTbLBG2KDWsqUjhVazw5Ot5bAAY=
Date:   Tue, 24 May 2022 16:57:08 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Artur Bujdoso <artur.bujdoso@gmail.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: octeon-usb: move driver out of staging
Message-ID: <YozyRE8OTy2CsD3E@kroah.com>
References: <YozxWT9veRJloyDD@crux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YozxWT9veRJloyDD@crux>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 24, 2022 at 04:53:13PM +0200, Artur Bujdoso wrote:
> The code is sparse clean and as you replied 8th Apr the original
> is fine, checkpatch has only warnings.

I think you need a better changelog than this, as it would not make much
sense in the tree for forever like this, right?

thanks,

greg k-h
