Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 486C94A786F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 20:02:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346829AbiBBTC1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 14:02:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231486AbiBBTC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 14:02:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9E94C061714
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 11:02:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ADFEAB83227
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 19:02:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78BC2C004E1;
        Wed,  2 Feb 2022 19:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1643828543;
        bh=/Jtpj7sodBwvmHNcLBzPmzFliYRbeH3bskBck+uIsJQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KagLHaWQW36IKvncSgzqC6fyuWpfqDbWRu3E9UPt7b6MCkpe4dy7qiXuSEIsZeT6A
         quQmv/jDI78kGn8vyClRndW0IkqQnCnCyvELkmGQ1GXt8/57WArjyIiAa8bmrpTuJ1
         +dL8jardrslBrPdPVFI59EejIh9HBjlLjZz4cw+w=
Date:   Wed, 2 Feb 2022 20:02:19 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jordy Zomer <jordy@pwning.systems>
Cc:     linux-kernel@vger.kernel.org, Oded Gabbay <ogabbay@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Ofir Bitton <obitton@habana.ai>,
        Dani Liberman <dliberman@habana.ai>,
        Omer Shpigelman <oshpigelman@habana.ai>,
        Sagiv Ozeri <sozeri@habana.ai>,
        Yuri Nudelman <ynudelman@habana.ai>,
        farah kassabri <fkassabri@habana.ai>,
        Koby Elbaz <kelbaz@habana.ai>
Subject: Re: [PATCHv2] habanalabs: fix potential spectre v1 gadgets
Message-ID: <YfrVOylHQYqjiWJ5@kroah.com>
References: <CAFCwf12QygXk=8WbH9qDhyyqKY6ZGVCUSJM93viQ0armc8dgfg@mail.gmail.com>
 <20220202171931.3525220-1-jordy@pwning.systems>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220202171931.3525220-1-jordy@pwning.systems>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 02, 2022 at 06:19:24PM +0100, Jordy Zomer wrote:
> It appears like nr could be a Spectre v1 gadget as it's supplied by a
> user and used as an array index. Prevent the contents
> of kernel memory from being leaked to userspace via speculative
> execution by using array_index_nospec.

Can you wrap your lines in a standard way?


> 
> Thanks for noticing Oded, made the changes.

This line should not be in the changelog :(

thanks,

greg k-h
