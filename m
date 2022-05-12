Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45D42524BF4
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 13:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353396AbiELLpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 07:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351802AbiELLpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 07:45:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24738200F6B;
        Thu, 12 May 2022 04:45:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A5E0961EB4;
        Thu, 12 May 2022 11:45:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80E8EC385B8;
        Thu, 12 May 2022 11:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1652355930;
        bh=KnyscJaCd02whKn+o6uMKbEt+ZJNKobwRDPjtf2a4/M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vSBWZBv9srcO1hrocZTU5SjYRrDgcNvzMz0EuSc6/RI6xomx/QzJb6W9TVtGSi3Zy
         Q3caeGu+ZpqEh6Dv0I+QY0koV93CZ5Vm0zs5heB8HhDh9gKcbfLtKiGnD6itqdTTcm
         0qSjpx1ZC/yn7yV2kbg6i3hKQ+ARGeyUJyiR/c88=
Date:   Thu, 12 May 2022 13:45:26 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Georgi Djakov <djakov@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] interconnect fix for 5.18-rc
Message-ID: <YnzzVvyqfIGjfJsr@kroah.com>
References: <20220506085923.23816-1-djakov@kernel.org>
 <445dd693-f797-c4f9-3bf9-04185a54286d@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <445dd693-f797-c4f9-3bf9-04185a54286d@kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2022 at 12:58:29PM +0300, Georgi Djakov wrote:
> On 6.05.22 11:59, Georgi Djakov wrote:
> > Hello Greg,
> > 
> > This pull request contains one more fix for the current cycle. The
> > details are in the signed tag. It has been in linux-next during the
> > last few days. Please pull into char-misc-linus when possible.
> > 
> 
> Hello Greg,
> 
> I was wondering if this got missed or is it in your mail queue? Please
> let me know in case anything is required from my side.

Still in my queue, sorry, will get to it "soon"...
