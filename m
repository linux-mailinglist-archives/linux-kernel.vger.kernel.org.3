Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED8557BF3C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 22:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbiGTUe5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 16:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiGTUey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 16:34:54 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A6B34B48A;
        Wed, 20 Jul 2022 13:34:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C6AE0CE22FB;
        Wed, 20 Jul 2022 20:34:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E4C4C3411E;
        Wed, 20 Jul 2022 20:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1658349290;
        bh=5amI2+X3xNxx7qzEY33FLhbsd5G4SlT8HyQquY6/rwM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bgxYG4mJ3U2dpvoxaU50ZIl6Yje+pat4OrEwXsEtuq4mXpseFGo8RtcZ+wkFJuew9
         Ich5rjQXTtmhYEI7SHpc9hNFJl0oYzIJkyEbkUVMBbAyQyAgo1Tp5HSj2tNuI+MDDS
         hliBTgoQWgBP5m+RNMe+UCo5ck81DxT3qemZNCKY=
Date:   Wed, 20 Jul 2022 22:34:46 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Xin Gao <gaoxin@cdjrlc.com>
Cc:     balbi@kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB:do not initialise statics to 0.
Message-ID: <Ythm5o1nfv0v/zY0@kroah.com>
References: <20220720194808.8799-1-gaoxin@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220720194808.8799-1-gaoxin@cdjrlc.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 21, 2022 at 03:48:08AM +0800, Xin Gao wrote:
> do not initialise statics to 0.

Why not?

You need to be very specific in changelog texts please.

greg k-h
