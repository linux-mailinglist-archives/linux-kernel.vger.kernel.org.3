Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AABC8572E19
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 08:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231821AbiGMGYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 02:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230396AbiGMGYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 02:24:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28674CC031;
        Tue, 12 Jul 2022 23:24:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B594661B43;
        Wed, 13 Jul 2022 06:24:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 257A7C34114;
        Wed, 13 Jul 2022 06:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657693476;
        bh=4QV+fojvD4ODIndXUpLxA74GNFP8uOGResBP9oas6zU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f5IyPK5rpSyByuTR5N6fSZAhhuqjR7AQy+xSNE5nIqJxmf2VQ6OoxG1teTB0d754E
         55nhOvdHOr0MeJkpxBVqWYffF+q2dxzli4hPsMDlNV44UA/cbIGLCtJkI72WV0g1+n
         Est0tIH78bYwdJXiJ9xUWsmy51l7Rm6xmEZI4M5MU6NN37qOViBitMzUR64iIkL/o+
         xJMJTioY0zF9i5yvabrmxCCpPVd8ZMPU/Q5EiWBwAkVud8WzLMoiE8/WvPO6t2M8l5
         mWyk0GPQy0kZOY7mgDj2sXcTA76VkrOkGkW8ntzQRTbXlGGNN2xynk/7/JTg13nxsj
         /2a2QSCzwCR7A==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oBVna-0007cX-5c; Wed, 13 Jul 2022 08:24:38 +0200
Date:   Wed, 13 Jul 2022 08:24:38 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Lucien Buchmann <lucien.buchmann@gmx.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: serial: ftdi_sio: add Belimo PCI ids
Message-ID: <Ys5lJnOB2n7y+Wbw@hovoldconsulting.com>
References: <20220625001744.28055-1-lucien.buchmann@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220625001744.28055-1-lucien.buchmann@gmx.net>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 25, 2022 at 02:17:44AM +0200, Lucien Buchmann wrote:
> Those two product ids are known.
> 
> Signed-off-by: Lucien Buchmann <lucien.buchmann@gmx.net>

Now applied after replacing "PCI" with "device" in Subject, thanks.

Johan
