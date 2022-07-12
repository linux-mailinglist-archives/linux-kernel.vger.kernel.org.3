Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDEE5571933
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 13:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232258AbiGLL5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 07:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232877AbiGLL4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 07:56:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 410E16579;
        Tue, 12 Jul 2022 04:56:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D0550614D0;
        Tue, 12 Jul 2022 11:56:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E06CC341C8;
        Tue, 12 Jul 2022 11:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657626983;
        bh=sTgpa8yb5NBVgBKJ3F3ICP80lhhEaKHKz4stmsQzTKk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PEfQISUutF10zVz4P4i5ZcxYPKigcKjXlILwcGp5bRGqqAzLCcflNezQNIVgLYOBD
         a5MuriW79ZOMG+jCxbRiKb6hrgnD1vudqqA1rfkf1MPtwgmxd0JliHhb0ILAj/y5j3
         178/p52AO3KquDOb3CZNxB+cElw3L9xfz9b/AUDPeezvOu09CiUaCDi8MuhrbU+0+l
         l8C4VnEXP2Xxgy6qcZYcTOl/u1Javon5pYKr6dlwfDM+VaaoIgcpVWy57lF+dCqUgY
         6YTjcDk8pa43efBUS4LCv9jEt/lv1q19v5VZwm5Sv3mqAr6tR0DQcQsI7bsQe+NJQD
         F5geQwjCpUk5Q==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 77A6B40088; Tue, 12 Jul 2022 08:56:20 -0300 (-03)
Date:   Tue, 12 Jul 2022 08:56:20 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     German Gomez <german.gomez@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH v2 1/1] perf test: Add test for branch stack sampling
Message-ID: <Ys1hZFdQeE4WbBS3@kernel.org>
References: <20220705150511.473919-1-german.gomez@arm.com>
 <20220705150511.473919-2-german.gomez@arm.com>
 <CAM9d7chzi9h+w5n_dXwAVwAgh-UyEQveVBh4ZenU60gUTDfrTg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7chzi9h+w5n_dXwAVwAgh-UyEQveVBh4ZenU60gUTDfrTg@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Jul 08, 2022 at 01:31:43PM -0700, Namhyung Kim escreveu:
> Hello,
> 
> On Tue, Jul 5, 2022 at 8:05 AM German Gomez <german.gomez@arm.com> wrote:
> >
> > Add a self test for branch stack sampling, to check that we get the
> > expected branch types, and filters behave as expected.
> >
> > Suggested-by: Anshuman Khandual <anshuman.khandual@arm.com>
> > Signed-off-by: German Gomez <german.gomez@arm.com>
> 
> Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks, applied.

- Arnaldo

