Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5514B58883B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 09:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237102AbiHCHsc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 03:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234663AbiHCHsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 03:48:24 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D2A027169;
        Wed,  3 Aug 2022 00:48:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 93839CE2229;
        Wed,  3 Aug 2022 07:48:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 504A4C433C1;
        Wed,  3 Aug 2022 07:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1659512899;
        bh=qdSXnnxizskpZg4WRUguZmVO6f41UwXj9JejJVfJm9E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ayqPP/y+3kAfvfVWOm7kH52i6PxOr+AbDyFbqgVir7Cr5qdYtIk+TGAe9KABSW90d
         8dALFca9AGk37YQeL8YoeO+CgrSI3+R0tFOuAMFOUjJIMtCiCeG3DldMZpNsn1fkvP
         tKVJ60G5ZQB3Kjhlxg8s5+EI7kYRVfjxX3ykI8hE=
Date:   Wed, 3 Aug 2022 09:48:16 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Khandelwal, Rajat" <rajat.khandelwal@intel.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Malani, Prashant" <pmalani@google.com>,
        "bleung@google.com" <bleung@google.com>,
        "andreas.noever@gmail.com" <andreas.noever@gmail.com>,
        "Jamet, Michael" <michael.jamet@intel.com>,
        "YehezkelShB@gmail.com" <YehezkelShB@gmail.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Rao, Abhijeet" <abhijeet.rao@intel.com>
Subject: Re: [PATCH] thunderbolt: Supporting wake on DP hot events behind
 TBT/USB4 routers
Message-ID: <YuooQKCYY0spcU2i@kroah.com>
References: <CO1PR11MB48353AD9FD931B1D4AD5646F969C9@CO1PR11MB4835.namprd11.prod.outlook.com>
 <CO1PR11MB48354DBE206824F26EB3D830969C9@CO1PR11MB4835.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CO1PR11MB48354DBE206824F26EB3D830969C9@CO1PR11MB4835.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 03, 2022 at 07:31:30AM +0000, Khandelwal, Rajat wrote:
> 

What did you write here?

confused,

greg k-h
