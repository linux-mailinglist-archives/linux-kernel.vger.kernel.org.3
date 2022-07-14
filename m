Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65F965747A5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 11:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237494AbiGNJBV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 05:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiGNJBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 05:01:20 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE53142AFE
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 02:01:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 6F864CE2358
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 09:01:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50FABC34114;
        Thu, 14 Jul 2022 09:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1657789275;
        bh=7sZRnnE0DwCs0sKqsHgMaCYArIlTikG5xz/c/RyDfSk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O8xZQxl53GI8p0wzkLY9V+V8/CL0QEhGLTPVP9d1diBCMqQ5gd2B9cbRZfxqf5MUE
         E3qIKudTzKpyFYB4BusZH2PanZhBaer4jUwJLS/VUiCz7OGWWeOuOR5xDGD7LDN9Vz
         Sbe9EGrfk9WYwryOh4W1vX40cTnHt6EBBcxrR0KY=
Date:   Thu, 14 Jul 2022 11:01:12 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     open list <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        lkft-triage@lists.linaro.org, Borislav Petkov <bp@suse.de>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>
Subject: Re: RETBleed: WARNING: Spectre v2 mitigation leaves CPU vulnerable
 to RETBleed attacks, data leaks possible!
Message-ID: <Ys/bWIk0F5srkkpF@kroah.com>
References: <CA+G9fYv0N0FcYRp5irO_7TpheLcUY8LRMQbcZqwEmiRTEccEjA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+G9fYv0N0FcYRp5irO_7TpheLcUY8LRMQbcZqwEmiRTEccEjA@mail.gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2022 at 02:15:07PM +0530, Naresh Kamboju wrote:
> Results from Linaro’s test farm.
> 
> We are booting the i386 kernel on an x86 machine.
> With Spectre V2 patches merged into Linux mainline we have been noticing
> RETBleed: WARNING: Spectre v2 mitigation leaves CPU vulnerable to
> RETBleed attacks, data leaks possible!

That's funny.  I don't think that's a valid combination that should be
cared about, but I'll leave it to Pawan to comment if it is something
that is "real" to be concerned for.

thanks,

greg k-h
