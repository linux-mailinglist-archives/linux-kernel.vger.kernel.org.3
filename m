Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 512B94FECE5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 04:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231676AbiDMCaB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 22:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiDMC35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 22:29:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52EFA275E3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 19:27:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0A735B820DC
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 02:27:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55381C385A1;
        Wed, 13 Apr 2022 02:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1649816855;
        bh=SHqh02ft77KfGvJSZLpsZAh7wp0kHXgjLIkp1pQYEFI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=eaJ8xww8f0q5qGZAVjoTnMBbiJVk1fwtAEtK1ZRrcixBeYMNwJDdemtNdbcxFwEmz
         vOXJyih2SNULCgNREYAZLk3hou/0sajRHMmmuViCwlDwSTNGHTVeM06LHMkfj5miwE
         Viyzi6GkXA3a8BpaH+Hg7djhDBG0EbbW2ZgvTLos=
Date:   Tue, 12 Apr 2022 19:27:34 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org, dyoung@redhat.com, linux-mm@kvack.org
Subject: Re: [PATCH v2 0/2] x86/kexec: fix memory leak of elf header buffer
Message-Id: <20220412192734.fcda8988d189c8e2e2830b03@linux-foundation.org>
In-Reply-To: <YkWRQdp7TxV22ygO@MiWiFi-R3L-srv>
References: <20220223113225.63106-1-bhe@redhat.com>
        <YkWRQdp7TxV22ygO@MiWiFi-R3L-srv>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Mar 2022 19:32:17 +0800 Baoquan He <bhe@redhat.com> wrote:

> Hi Andrew,
> 
> On 02/23/22 at 07:32pm, Baoquan He wrote:
> > The memory leak is reported by kmemleak detector, has been existing
> > for very long time. It casue much memory loss on large machine
> > with huge memory hotplug which will trigger kdump kernel reloading
> > many times, with kexec_file_load interface.
> 
> Could you merge these two patches? Or should I ping x86 maintainers to
> take them? 

Ah, sorry, I tend to fall asleep if there's "x86" in the subject. 
Poking a sleeping Andrew is always the right thing to do.  Shall look
at them.

