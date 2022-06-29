Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E79FB55F63D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 08:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231406AbiF2GJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 02:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231858AbiF2GIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 02:08:35 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65B811E3C5;
        Tue, 28 Jun 2022 23:08:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 9A1E0CE2303;
        Wed, 29 Jun 2022 06:08:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B49F0C34114;
        Wed, 29 Jun 2022 06:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1656482910;
        bh=vJY9q7y2S/D/f1k4JQ1UNKjNcETLJ7Ea5lvJFwixXcM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t+n+4qZ8lVWLh0wsCMRqutBzJ3k8I0W8IaAYmRwFM0J6WXFwdIkM8Oy6j72kkB5uJ
         7hII79WIDEVmACHyzWjlXxpMCZChGpCQf4bnwcAeyS1Pa3WUqz8iW7RQzrVDC7qadP
         9RP4J1KYG+HrtyKj2/y0LecLOIsT5drXFKhEXMuk=
Date:   Wed, 29 Jun 2022 08:08:27 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jeremy Linton <jeremy.linton@arm.com>
Cc:     linux-serial@vger.kernel.org, andriy.shevchenko@linux.intel.com,
        jirislaby@kernel.org, miquel.raynal@bootlin.com,
        phil.edworthy@renesas.com, kernel@esmil.dk,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] Revert "serial: 8250: dw: Move the USR register to
 pdata"
Message-ID: <YrvsW7RmHRr5zbS3@kroah.com>
References: <20220629000232.3440704-1-jeremy.linton@arm.com>
 <20220629000232.3440704-2-jeremy.linton@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220629000232.3440704-2-jeremy.linton@arm.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2022 at 07:02:31PM -0500, Jeremy Linton wrote:
> pdata is only setup by DT machines, leaving ACPI machines
> with null pdata. Since I don't know the exact mapping of
> ACPI ID's to dw 8250 variations I can't add pdata to them
> without possibly breaking something. As such the simplest
> fix here is probably just to revert this commit.
> 
> This reverts commit ffd381445eac2aa624e49bab5a811451e8351008.
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>

Didn't checkpatch complain that you need a blank line before your
signed-off-by line?

thanks,

greg k-h
