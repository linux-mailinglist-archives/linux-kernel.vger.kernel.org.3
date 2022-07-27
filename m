Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC88358265B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 14:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232984AbiG0MYy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 08:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231968AbiG0MYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 08:24:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B8174BD32;
        Wed, 27 Jul 2022 05:24:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BEAF660FE1;
        Wed, 27 Jul 2022 12:24:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD540C433D7;
        Wed, 27 Jul 2022 12:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1658924681;
        bh=uY1zTBQEvp8bkm0buZfF6/zpOUaKqdhOdqdS2g7EJWY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YGcqvW73vQB/HmUnnhS0kB6h1GuVSOGSop97Aoy847aQV/5dfxYbjpH3w94NYyT1e
         PQIXbulB28Z0Q3N5IYc9kBaHobXM0CF93qqtg797p3Z5b95m7g2y0j4msxwXJlFoGx
         ct5Cit5SpuTIReI2oRKIR3Gwl5Ppw3tPxGBZeufI=
Date:   Wed, 27 Jul 2022 14:24:38 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Xin Ji <xji@analogixsemi.com>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        bliang@analogixsemi.com, qwen@analogixsemi.com,
        jli@analogixsemi.com, Dan Carpenter <dan.carpenter@oracle.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v20 2/2] usb: typec: anx7411: Add Analogix PD ANX7411
 support
Message-ID: <YuEuhp6blxomKdUA@kroah.com>
References: <20220719024704.47395-1-xji@analogixsemi.com>
 <20220719024704.47395-2-xji@analogixsemi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220719024704.47395-2-xji@analogixsemi.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 19, 2022 at 10:47:04AM +0800, Xin Ji wrote:
> Add driver for analogix ANX7411 USB Type-C DRP port controller.
> 
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

The driver is not "reported-by:" dan, he just found issues that you
resolved, right?

thanks,

greg k-h
