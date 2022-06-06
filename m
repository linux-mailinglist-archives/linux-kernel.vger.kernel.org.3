Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7FA853E0BD
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 08:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbiFFFy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 01:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbiFFFyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 01:54:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46AB031230
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 22:54:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C328D60E9E
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 05:54:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A29D3C385A9;
        Mon,  6 Jun 2022 05:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1654494887;
        bh=y5zL+ZQSVXvlA8S/GFXMIDb6PD6Pb5fiMny8Nd9GrJY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gnnvbi3JDZhS19D+BR//B63gt0JNvIiGmCwDj+0X4D6iqsajiVU7btW/en0sCQG1/
         39Br/XIqj2VuoFG4OxlR4qnuHTevfVppvgh8O3uye3fmzzsquUUSv2eqs94bsZcLjs
         Rbp0QQD97bSs54qxSjA7xuJFqxg/21KrNHB/I94Y=
Date:   Mon, 6 Jun 2022 07:54:44 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     nsaenz@kernel.org, bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] staging: vchiq: make vchiq_platform_init static
Message-ID: <Yp2WpCKVjLMe0qJO@kroah.com>
References: <20220525093851.59514-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220525093851.59514-1-jiapeng.chong@linux.alibaba.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 25, 2022 at 05:38:51PM +0800, Jiapeng Chong wrote:
> This symbol is not used outside of vchiq_arm.c, so marks it
> static.
> 
> Fixes the following w1 warning:

What tool is "w1"?

> 
> drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c:466:5:
> warning: no previous prototype for ‘vchiq_platform_init’
> [-Wmissing-prototypes].

See my previous comments on how to do this properly.

thanks,

greg k-h
