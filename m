Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D99050F9C1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 12:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348280AbiDZKKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 06:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348802AbiDZKJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 06:09:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4AF11EF99F
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 02:31:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1C740B81D1C
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 09:31:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EA17C385A0;
        Tue, 26 Apr 2022 09:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1650965483;
        bh=trwF575pYSLNdADLXboEnkiFT7sbPelL37v2hFvpbzI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N5QQluvliT4xXWHkl4HwQKbaHVwIHco1MakflFU6x+4jNj9VjicqIx6vWpaCTg1Cl
         PuGKGfXFRhGaoLccBOJia/W+0zDcs+feKYFvuCRX2iGVY2PSoe9yeb3F1hNM9BDmYj
         JxXTf/LN6aAxJc/Pi9fKZ7V0lnqsYGADy0eX5P4o=
Date:   Tue, 26 Apr 2022 11:31:20 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc:     Forest Bond <forest@alittletooquiet.net>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] staging: vt6655: Replace two VNSvInPortD with
 ioread64_lo_hi
Message-ID: <Yme76Pxt0y0GxFEx@kroah.com>
References: <cover.1650784817.git.philipp.g.hortmann@gmail.com>
 <db5ba681cea27de815b172f8b93a8fd1efa30e99.1650784817.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db5ba681cea27de815b172f8b93a8fd1efa30e99.1650784817.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 24, 2022 at 09:44:22AM +0200, Philipp Hortmann wrote:
> Replace two macros VNSvInPortD (32 Bit reads) with one ioread64_lo_hi.

I would stick to the 2 reads just to ensure that it works properly.

thanks,

greg k-h
