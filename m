Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70C784F0E6D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 07:00:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377272AbiDDFAc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 01:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355325AbiDDFA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 01:00:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBE59D9B
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 21:58:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0C106B80E76
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 04:58:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 627DAC340F2;
        Mon,  4 Apr 2022 04:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649048310;
        bh=y7a1KzrMsaHOSdBHFzdNdrtAM5WIC8VqSSnGE+cL0aI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hUQrGoK8OlcdeAiWPfXxuLMDMvojF0LZQuT7Dvy6Nls4xgUsAh9QgCv2CHIguykZ5
         isYCs4v2iWMClOjBpMZtC7dNZoqvkfJIGj8QGPVeTsjF1tnVymgM5uaoNjg4J2oEi9
         bocGkMPt/N5H30C+mwCBOFsYeNkbiXoAqpvz2yFY=
Date:   Mon, 4 Apr 2022 06:58:26 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yusuf Khan <yusisamerican@gmail.com>
Cc:     linux-kernel@vger.kernel.org, jasowang@redhat.com,
        mikelley@microsoft.com, mst@redhat.com, javier@javigon.com,
        arnd@arndb.de, will@kernel.org, axboe@kernel.dk,
        Christoph Grenz <christophg+lkml@grenz-bonn.de>
Subject: Re: [PATCH v10 1/3] drivers: ddcci: add drivers for DDCCI
Message-ID: <Ykp68hTQF1a8EpTj@kroah.com>
References: <20220403230850.2986-1-yusisamerican@gmail.com>
 <20220403230850.2986-2-yusisamerican@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220403230850.2986-2-yusisamerican@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 03, 2022 at 04:08:49PM -0700, Yusuf Khan wrote:
> This patch adds the main DDCCI driver. This interfaces with I2C to allow the
> kernel to communicate with DDCCI supporting monitors, it exports a chardev
> and sysfs interface for userspace.

Where is the Documentation/ABI/ entries for the sysfs code, and where is
the userspace code that uses the chardev interface?  And why chardev?

This text says _what_ you are doing, but not _why_ you are doing it.

thanks,

greg k-h
