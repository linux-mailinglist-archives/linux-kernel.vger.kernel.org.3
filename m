Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A28A754EE87
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 02:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379441AbiFQAmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 20:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbiFQAmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 20:42:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89D145FF23
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 17:42:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 009FD619F4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 00:42:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51544C34114;
        Fri, 17 Jun 2022 00:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655426531;
        bh=/+H3CqAWQnTcOrsHH9iU7Vvwsx/IawiHyKBRRlhRNBI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dRl3RvG382qDULYeHocragd9tn4WoMnHltJ5V6Lcq9pMqhgHPBeE6vsStnq5rRbE3
         nUFOwhMKU5oxovKG+nqqsqsJLnewKLIq32zXmAQeQNnrKIf7gvUKDLynZi+qUIO/Y2
         CjSZ0H2xr6Hq3Lg7nzxFYjBWpEfKy3ccvsY1IhDRS/lLX3Bi+8+E8kCmhUrFbbZR/n
         u+nrFhrAAPMsG2lzxLRwURftQusgvWaYLwMltbs0mZzK/iVO8GbGASifad6X8iDf8B
         8c0U2hCSQdEzveCqCM1QNLNo49bU1wmLQAPB3LzW/mU/hQQRMhDUojhHTqHNOb2I9N
         uSvNoYP1qLscQ==
Date:   Thu, 16 Jun 2022 17:42:10 -0700
From:   Vinod Koul <vkoul@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Ferry Toth <ftoth@exalondelft.nl>
Subject: Re: [PATCH v1 1/1] phy: ti: tusb1210: Don't check for write errors
 when powering on
Message-ID: <YqvN4nMvVNq7fW3V@matsya>
References: <20220613160848.82746-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220613160848.82746-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13-06-22, 19:08, Andy Shevchenko wrote:
> On some platforms, like Intel Merrifield, the writing values during power on
> may timeout:
> 
>    tusb1210 dwc3.0.auto.ulpi: error -110 writing val 0x41 to reg 0x80
>    phy phy-dwc3.0.auto.ulpi.0: phy poweron failed --> -110
>    dwc3 dwc3.0.auto: error -ETIMEDOUT: failed to initialize core
>    dwc3: probe of dwc3.0.auto failed with error -110
> 
> which effectively fails the probe of the USB controller.
> Drop the check as it was before the culprit commit (see Fixes tag).

Applied, thanks

-- 
~Vinod
