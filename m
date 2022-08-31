Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 749625A7F74
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 16:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbiHaOCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 10:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231124AbiHaOCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 10:02:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E01ED344C
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 07:02:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D89F1B820CD
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 14:02:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A993C433D6;
        Wed, 31 Aug 2022 14:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1661954534;
        bh=+CiahQqp0QDkyoEIGkSIDAtd7RUWC0BU9wfR/DtbyCI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c3Wqs090h8DCP1J6INaE6ZQehdNFJdKBKUBOuGtnpHWfgQFg2i4Yzxt/Bl83CynWH
         Kk4dhKwZQPW8K8emNRMiU7uBnJRHleWUjMaVaCqSv3dzOSFnddz5+8+ns1Rw1czO9L
         GDCMklg7hfJAVxM9DelM16W89CRFUOy6td/9a2l0=
Date:   Wed, 31 Aug 2022 16:02:11 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Xuezhi Zhang <zhangxuezhi3@gmail.com>
Cc:     abbotti@mev.co.uk, hsweeten@visionengravers.com,
        zhangxuezhi1@coolpad.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] comedi: sysfs: convert sysfs snprintf to sysfs_emit
Message-ID: <Yw9p47naEjsCWAJW@kroah.com>
References: <20220831125520.239055-1-zhangxuezhi3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220831125520.239055-1-zhangxuezhi3@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2022 at 08:55:20PM +0800, Xuezhi Zhang wrote:
> From: zhangxuezhi1 <zhangxuezhi1@coolpad.com>
> 
> Fix up all sysfs show entries to use sysfs_emit

This says "what", but not "why".

Please read the kernel documentation for how to write a good changelog
text.

> 
> Signed-off-by: Xuezhi Zhang <zhangxuezhi1@coolpad.com>
> ---
> v2: use a proper name for the Signed-off-by line.

Does not match the From: line :(


thanks,

greg k-h
