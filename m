Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 122BF583913
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 08:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232987AbiG1G5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 02:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234466AbiG1G5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 02:57:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8188F5F134;
        Wed, 27 Jul 2022 23:57:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 03B7CB8229C;
        Thu, 28 Jul 2022 06:57:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 485FBC433D6;
        Thu, 28 Jul 2022 06:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1658991419;
        bh=GP1D1C84ajG2qQjEpLrnllKHGFXq3JW3yVVmczSfPdw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GiAD6x9RxGPWeea6FKPNKshPe2N4zFpUMtHHtQLd8V3Uoy7hKc2K8wb0ReuYf51sN
         vmv9zziWZr+5zk3we8vVHy5wSiyZphcVnW8OxH/vUMclTgeotOj4B/jefCHgtEWjqo
         bIUIH8Xu5xVCoqCncBmXbPGvZ+SbU+aDLZa62bW8=
Date:   Thu, 28 Jul 2022 08:56:57 +0200
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Andy Guo =?utf-8?B?KOmDreWNq+aWjCk=?= <guoweibin@inspur.com>
Cc:     "b-liu@ti.com" <b-liu@ti.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: =?utf-8?B?562U5aSNOiBbdmdlci5rZXJuZWwu?=
 =?utf-8?B?b3Jn5Luj5Y+RXVJlOiBbUEFUQ0ggdjJdIHVzYjogbXVzYjogRml4IG11c2Jf?=
 =?utf-8?Q?gadget=2Ec?= rxstate may cause request->buf overflow problems
Message-ID: <YuIzOeJZ7YKe4KDZ@kroah.com>
References: <28d16ec3ed25603cdda2c5fb3fbf1470@sslemail.net>
 <YuEElC563HN5ldMu@kroah.com>
 <2c234d13d7274763b0102b83ce65b8ff@inspur.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2c234d13d7274763b0102b83ce65b8ff@inspur.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 28, 2022 at 01:14:17AM +0000, Andy Guo (郭卫斌) wrote:

As can be seen in the archives:
	https://lore.kernel.org/all/2c234d13d7274763b0102b83ce65b8ff@inspur.com/
this message could not be decoded, sorry.

Please resend in plain text format.

thanks,

greg k-h

