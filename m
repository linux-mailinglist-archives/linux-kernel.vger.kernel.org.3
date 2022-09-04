Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67FF65AC57A
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 18:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234951AbiIDQmo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 12:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234026AbiIDQmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 12:42:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10FA42ED48;
        Sun,  4 Sep 2022 09:42:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9AF7160FC7;
        Sun,  4 Sep 2022 16:42:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 048C8C433D7;
        Sun,  4 Sep 2022 16:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662309761;
        bh=8ChuowTloMweL9Beltc6M1rPKG+3cGBBuq9pf2m5xds=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XhCw7vPROTiv1ylLqVzpkz0FS+247j4xfLAIt6W+HHSPRW4ATTIHDf2j7lbC4ugQA
         TEe5Efwz5+swSap0ZduEG2BelN/CN7EfNhGhhlW6y6qh8IZI4sG2rA0k96oSL2DZNU
         9EpTURygirWFhBXO2OdbGrwF/qz1D73jjgcqC0Cw4N8TIqhWT6dFj+PmrGWBHtOPdv
         GW/UrOxBYTYEJoL4VbfRP7kXd+iQtqeU4qUy0rF8ThKNLy9D5mWZmLlYeXt1kIYV0f
         zCyoz3fPU2TKj1Ztbg2OwL1Kvbga9kiqMxGrw9+rparCNclx3DVaZvYuapIrGD3Qdi
         n6v+5OrKdpdMw==
Date:   Sun, 4 Sep 2022 17:08:31 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        kernel <kernel@axis.com>, Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/5] iio: adc: mcp320x: use device managed functions
Message-ID: <20220904170831.1c3e590f@jic23-huawei>
In-Reply-To: <CAHp75Vd=01XeLHmENOPCvv7AC6Sq-vre8fjLJKpkoJBKg+6+Xw@mail.gmail.com>
References: <20220831100506.3368103-1-vincent.whitchurch@axis.com>
        <20220831100506.3368103-5-vincent.whitchurch@axis.com>
        <CAHp75Vd=01XeLHmENOPCvv7AC6Sq-vre8fjLJKpkoJBKg+6+Xw@mail.gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Aug 2022 15:50:39 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Wed, Aug 31, 2022 at 1:05 PM Vincent Whitchurch
> <vincent.whitchurch@axis.com> wrote:
> >
> > Use devm_* functions in probe to remove some code and to make it easier
> > to add further calls to the probe function.  
> 
> devm_regulator_get_enable() ?
> 
Not yet generally available as I don't think there is a suitable immutable
branch.

So for material aimed at this cycle I'm fine with it not being used.

Jonathan

