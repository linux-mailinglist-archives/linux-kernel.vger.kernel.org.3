Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91AFF535146
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 17:17:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347885AbiEZPRC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 11:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244656AbiEZPRA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 11:17:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9945506DE
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 08:16:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8667CB820F0
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 15:16:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0DFCC385A9;
        Thu, 26 May 2022 15:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653578216;
        bh=1Tou2tLbfn7Lh14Zv+RUlwo/lxFPvMTes+8NP5tIEq0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PT/uqmDNvbczVjYz/yXsis2XYeRsPcAYNO3NTbI6tkcKaAWhjuOlAYBjUcGurhcJ4
         ffyNEnrWQUIvOEtbyTFWb46cU9v5qlngWoRLpuHm0pZX1H4NG30UarMGtu5ffzWOv/
         6HTRieaGjdcZra+I+qIIJtkVAJD/GT2fAVV/BECkbHZO7e/npuFCh4ut0K3J+Wlp3F
         Z2Y9u/HqKiGIs8uZfCkjjQRcLFZrmsfg1ZYeeECs4nl2cI+NbysA16nLjelaNrPm9Z
         WpXvk48VqmOQWj8sVOilJgPzqyCxxf60IkekDRCFeP3OVc81ESaV2yBgNgtb6VB6Oo
         e3PDBE3I7tK7g==
Date:   Thu, 26 May 2022 08:16:54 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        jpoimboe@redhat.com, linux-kernel@vger.kernel.org,
        elver@google.com, jbaron@akamai.com, rostedt@goodmis.org,
        ardb@kernel.org
Subject: Re: [PATCH 7/7] context_tracking: Always inline empty stubs
Message-ID: <20220526151654.k3mxzp5so25we7y3@treble>
References: <20220526105252.440440893@infradead.org>
 <20220526105958.134113388@infradead.org>
 <20220526150206.rqdiyouxmkdgm2jq@treble>
 <Yo+YfEWLiCVekG5l@FVFF77S0Q05N.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yo+YfEWLiCVekG5l@FVFF77S0Q05N.cambridge.arm.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 26, 2022 at 04:10:52PM +0100, Mark Rutland wrote:
> On Thu, May 26, 2022 at 08:02:06AM -0700, Josh Poimboeuf wrote:
> > On Thu, May 26, 2022 at 12:52:59PM +0200, Peter Zijlstra wrote:
> > > Because GCC is seriously challenged..
> > 
> > Or are these CONFIG_DEBUG_SECTION_MISMATCH?
> 
> Does it matter?

Yes, because I believe the only thing this option is good for is
creating a bunch of useless '__always_inline' patches:

  https://lore.kernel.org/all/7fad83ecde03540e65677959034315f8fbb3755e.1649434832.git.jpoimboe@redhat.com/

-- 
Josh
